
codeunit 50001 "WDC Purchasers Subscribers"

//*************Documentation***************************
//WDC01  CHG  22/08/2024  Create this current object
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnBeforeReleasePurchaseDoc, '', false, false)]
    local procedure OnBeforeReleasePurchaseDoc(purchaseHeader: Record "purchase Header"; PreviewMode: Boolean)
    var
        Err01: TextConst FRA = 'Location Code %1 doit avoir une valeur similaire à %2 ', ENU = 'You cannot enter payment type cash twice';
    begin
        purchaseHeader.TestField("Shortcut Dimension 1 Code");
        if purchaseHeader."Location Code" <> '' then
            if CopyStr(purchaseHeader."Location Code", 1, 2) <> purchaseHeader."Shortcut Dimension 1 Code" then
                Error(Err01, purchaseHeader."Location Code", purchaseHeader."Shortcut Dimension 1 Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, CODEUNIT::"Purch.-Get Receipt", OnAfterInsertInvoiceLineFromReceiptLine, '', false, false)]
    local procedure OnAfterInsertInvoiceLineFromReceiptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchLine: Record "Purchase Line"; PurchRcptLine2: Record "Purch. Rcpt. Line"; TransferLine: Boolean)
    begin
        if UserSetup.get(UserId) then
            If UserSetup."Site Code" <> '' then begin
                PurchLine.Validate("Shortcut Dimension 1 Code", UserSetup."Site Code");
                PurchLine.Modify();
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnCodeOnCheckPurchLineLocationCode, '', false, false)]
    local procedure OnCodeOnCheckPurchLineLocationCode(var PurchaseLine: Record "Purchase Line")
    var
        Err04: TextConst FRA = 'Centre de coût de la ligne N° %1 ne doit pas être vide';
    begin
        if PurchaseLine."Shortcut Dimension 2 Code" = '' then
            Error(Err04, PurchaseLine."Line No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnCodeOnAfterCheck, '', false, false)]
    local procedure OnCodeOnAfterCheck(PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; var LinesWereModified: Boolean)
    var
        Err01: TextConst FRA = 'Site Code doit avoir la même valeur pour les lignes et l''entete. ', ENU = 'Site code should include the same value for the lines and the header.';
        Err02: TextConst FRA = 'Location Code %1 doit avoir une valeur similaire à %2 ', ENU = 'You cannot enter payment type cash twice';
        Err03: TextConst FRA = 'Code magasin dans ligne commande  %1 doit avoir la même valeur que code magasin dans l''entête  %2', ENU = 'Location Code %1 have similar  value to the Header';
        Err04: TextConst FRA = 'Centre de coût de la ligne N° %1 ne doit pas être vide';
    begin
        // if PurchaseLine."Shortcut Dimension 1 Code" <> PurchaseHeader."Shortcut Dimension 1 Code" then
        //     Error(Err01); //Commenté par la demande de Marouen
        if PurchaseLine."Location Code" <> '' then
            if (CopyStr(PurchaseLine."Location Code", 1, 2) <> PurchaseLine."Shortcut Dimension 1 Code") then
                Error(Err02, PurchaseLine."Location Code", PurchaseLine."Shortcut Dimension 1 Code");
        if PurchaseHeader."Location Code" <> '' then
            if PurchaseHeader."Location Code" <> PurchaseLine."Location Code" then
                error(Err03, PurchaseLine."Location Code", PurchaseHeader."Location Code");
    end;

    [EventSubscriber(ObjectType::Table, database::"Purchase Header", OnBeforeValidateShortcutDimCode, '', false, false)]
    local procedure OnBeforeValidateShortcutDimCode(var PurchaseHeader: Record "Purchase Header"; var xPurchaseHeader: Record "Purchase Header"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        lPurchLine: Record "Purchase Line";
    begin
        if lPurchLine.get(PurchaseHeader."Document Type", PurchaseHeader."No.") then
            lPurchLine."Shortcut Dimension 1 Code" := PurchaseHeader."Shortcut Dimension 1 Code";
    end;


    [EventSubscriber(ObjectType::Table, database::"Purchase Header", OnBeforeValidateLocationCode, '', false, false)]

    local procedure OnBeforeValidateLocationCode(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        Err01: TextConst FRA = 'Location Code %1 doit commencer par une valeur similaire aux site code  %2- ', ENU = 'Location Code %1 must start with a value similar to the site code  %2-';
    begin
        if PurchaseHeader."Location Code" <> '' then
            if (CopyStr(PurchaseHeader."Location Code", 1, 2) <> PurchaseHeader."Shortcut Dimension 1 Code") then
                Error(Err01, PurchaseHeader."Location Code", PurchaseHeader."Shortcut Dimension 1 Code");
    end;


    var
        UserSetup: Record "User Setup";
}