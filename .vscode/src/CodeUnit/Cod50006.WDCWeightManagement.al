namespace sogrega.sogrega;
using Microsoft.Manufacturing.Document;
using System.IO;
using Microsoft.Manufacturing.Setup;
using System.Security.Authentication;
using System.Security.User;
using Microsoft.Inventory.Journal;
//**************Documentation*************
//WDC01  WDC.HG  26/04/2026  Create Current Object : Import Weight from Onedrive 
codeunit 50006 "WDC Weight Management"
{
    procedure ImportPoidsLine(var ItemJnlLine: Record "Item Journal Line")
    var
        CSVText: Text;
        Poids: Decimal;
        ProductionOrder: record "Production Order";
        Err01: TextConst ENU = 'Make sure you enter the production order number first.', FRA = 'Assurez-vous de saisir le numéro OF en premier.';
        Text01: textconst ENU = 'Imported weight: %1', FRA = 'Poids importé : %1';
        ItemJournalLineLoop: record "Item Journal Line";
    begin
        if not CheckUserPermission() then
            Error(PermissionError);
        if ItemJnlLine."Order No." = '' then
            Error(Err01);
        if ProductionOrder.get(ProductionOrder.Status::Released, ItemJnlLine."Order No.") then begin
            CSVText := GetCSVFromSharePoint(ItemJnlLine."Order No.");
            Poids := GetPoidsFromCSV(CSVText, ProductionOrder."No.", ProductionOrder."Reference No.");
            if Poids <> 0 then begin
                ItemJournalLineLoop.reset();
                ItemJournalLineLoop.setrange("Journal Template Name", ItemJnlLine."Journal Template Name");
                ItemJournalLineLoop.setrange("Journal Batch Name", ItemJnlLine."Journal Batch Name");
                ItemJournalLineLoop.SetRange("Entry Type", ItemJnlLine."Entry Type");
                ItemJournalLineLoop.SetRange("Order No.", ItemJnlLine."Order No.");
                if ItemJournalLineLoop.FindSet() then
                    repeat
                        ItemJournalLineLoop.Validate("Net Weight", Poids);
                        ItemJournalLineLoop."Weight Imported From Scale" := true; //AddManuelEnty
                        ItemJournalLineLoop.Modify();
                    until ItemJournalLineLoop.Next() = 0;
                Message(Text01, Poids);
            end
        end
    end;

    procedure GetCSVFromSharePoint(OFNo: Code[20]): Text
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Token: Text;
        Url: Text;
        ContentTxt: Text;
        ProdSetup: record "Manufacturing Setup";
    begin
        ProdSetup.Get();
        Token := GetAccessToken();
        Url :=
                   'https://graph.microsoft.com/v1.0/drives/' + ProdSetup."Drive ID" +
           '/root:/BC-IMPORT/OF/' + OFNo + '.csv:/content';
        Client.DefaultRequestHeaders().Add('Authorization', 'Bearer ' + Token);
        Client.DefaultRequestHeaders().Add('Accept', 'text/plain');
        if not Client.Get(Url, Response) then
            Error('Erreur appel SharePoint');
        if not Response.IsSuccessStatusCode() then
            Error('Aucun fichier de pesée trouvé pour OF %1', OFNo);//a modifier
        Response.Content().ReadAs(ContentTxt);
        exit(ContentTxt);
    end;

    procedure GetPoidsFromCSV(CSVText: Text; pOFNo: Code[20]; pItemRef: Code[20]): Decimal
    var
        fields: List of [Text];
        Poids: Decimal;
        err01: TextConst ENU = 'OF inconsistency: imported value into the file = %1, expected value = %2.', FRA = 'Incohérence OF : valeur importée dans le fichier  = %1, valeur attendue = %2.';
        err02: TextConst ENU = 'Incorrect article: %1', FRA = 'Article incorrect: %1';
        err03: TextConst ENU = 'Invalid weight: %1', FRA = 'Poids invalide: %1';
        err04: TextConst ENU = 'Weight must be > 0', FRA = 'Poids doit être > 0';
    begin
        Fields := CSVText.Split(';');
        if Fields.Get(2) <> pOFNo then
            Error(err01, fields.get(2), pOFNo);
        if Fields.Get(4) <> pItemRef then
            Error(err02, Fields.Get(4));
        if not Evaluate(Poids, Fields.Get(7)) then
            Error(err03, Fields.Get(7));
        if Poids <= 0 then
            Error(err04);
        exit(Poids);
    end;

    local procedure GetAccessToken(): Text
    var
        Client: HttpClient;
        Content: HttpContent;
        Response: HttpResponseMessage;
        Json: JsonObject;
        Token: Text;
        jsontoken: JsonToken;
        Body: Text;
        Headers: HttpHeaders;
        ResponseTxt: Text;
        Err01: TextConst ENU = 'Token not found', FRA = 'Token non trouvé';
        prodSetup: record "Manufacturing Setup";
    begin
        prodSetup.Get();
        Body :=
          'client_id=' + prodSetup."Client ID" +
          '&scope=https://graph.microsoft.com/.default' +
          '&client_secret=' + prodSetup."Client Secret" +
          '&grant_type=client_credentials';
        Content.WriteFrom(Body);
        Content.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/x-www-form-urlencoded');
        Client.Post(
          'https://login.microsoftonline.com/' + Prodsetup."Tenant ID" + '/oauth2/v2.0/token',
          Content,
          Response);

        Response.Content().ReadAs(ResponseTxt);
        if not Json.ReadFrom(ResponseTxt) then
            Error(ResponseTxt);
        if not Json.Get('access_token', JsonToken) then
            Error(Err01);
        Token := JsonToken.AsValue().AsText();
        exit(Token);
    end;

    procedure MoveFileToArchive(OFNo: Code[20])
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        Token: Text;
        Url: Text;
        ResponseTxt: Text;
        Json: JsonObject;
        JsonToken: JsonToken;
        FileId: Text;
        Body: Text;
        Headers: HttpHeaders;
        Content: HttpContent;
        Err01: TextConst ENU = 'Graph (GET) call error', FRA = 'Erreur d''appel Graph (GET)';
        Err02: TextConst ENU = 'Weighing file not found for OF %1', FRA = 'Fichier de pesée introuvable pour OF %1';
        Err03: TextConst ENU = 'File retrieval error (%1)', FRA = 'Erreur de récupération du fichier (%1)';
        Err04: TextConst ENU = 'Invalid JSON response', FRA = 'Réponse JSON invalide';
        Err05: TextConst ENU = 'Graph (PATCH) call error', FRA = 'Erreur appel Graph (PATCH)';
        Err06: TextConst ENU = 'File move error (%1)', FRA = 'Erreur déplacement fichier (%1)';
        ProdSetup: record "Manufacturing Setup";



    begin
        ProdSetup.get();
        Token := GetAccessToken();
        Url :=
                 'https://graph.microsoft.com/v1.0/drives/' + ProdSetup."Drive ID" +
          '/root:/BC-IMPORT/OF/' + OFNo + '.csv';


        Client.DefaultRequestHeaders().Clear();
        Client.DefaultRequestHeaders().Add('Authorization', 'Bearer ' + Token);

        if not Client.Get(Url, Response) then
            Error(Err01);
        if Response.HttpStatusCode() = 404 then
            Error(Err02, OFNo);
        if not Response.IsSuccessStatusCode() then
            Error(Err03, Response.HttpStatusCode());
        Response.Content().ReadAs(ResponseTxt);
        if not Json.ReadFrom(ResponseTxt) then
            Error(Err04);
        Json.Get('id', JsonToken);
        FileId := JsonToken.AsValue().AsText();
        Url :=
         'https://graph.microsoft.com/v1.0/drives/' + ProdSetup."Drive ID" +
         '/items/' + FileId;

        Body :=
          '{' +
          '"parentReference": {' +
          '"path": "/drive/root:/' + 'BC-IMPORT/Archive' + '"' +
          '}' +
          '}';
        Client.DefaultRequestHeaders().Clear();
        Client.DefaultRequestHeaders().Add('Authorization', 'Bearer ' + Token);
        Content.WriteFrom(Body);
        Content.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/json');
        if not client.Patch(Url, Content, Response) then
            Error(Err05);
        if not Response.IsSuccessStatusCode() then
            Error(Err06, Response.HttpStatusCode());
    end;

    local procedure CheckUserPermission(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then
            exit(UserSetup."Allow Weight Import");

    end;

    var
        PermissionError: TextConst ENU = 'You are not authorized to import weights.', FRA = 'Vous n''êtes pas autorisé à importer des poids de produit fini.';

}


