namespace SogregaDev.SogregaDev;

using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Sales.Customer;

xmlport 50002 "WDC import Sanlorenzo "
{
    CaptionML = FRA = 'import commande "Sanlorenzo" ', ENU = 'import "Sanlorenzo" Order';
    Direction = Import;
    Format = VariableText;
    TextEncoding = UTF8;
    FieldDelimiter = '"';
    FieldSeparator = ';';
    UseRequestPage = false;


    schema
    {
        textelement(Root)
        {
            tableelement(SalesLine; "Sales Line")
            {
                XmlName = 'Importcommande';
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;

                textelement(CustomerNo)
                {
                }
                textelement(SiteCode)
                {
                }
                textelement(CustOrderNo)
                {
                }
                textelement(CustLineNo)
                {
                }
                textelement(ItemRefCode)
                {
                }
                textelement(Quantity)
                {
                }
                textelement(RequestedDeliveryDate)
                {
                }
                textelement(PromisedDeliveryDate)
                {
                }
                textelement(Matricule)
                {
                }
                textelement(Description)
                {
                }
                textelement(UnitPrice)
                {
                }
                trigger OnAfterInsertRecord()
                var
                    lsalesheader: record "Sales Header";
                    lsalesline: record "Sales Line";
                    oldsalesline: record "Sales Line";
                    lReleaseSalesDocument: Codeunit "Release Sales Document";
                    vCustLineNo: Integer;
                    vQuantity: Decimal;
                    vUnitPrice: Decimal;
                    vRequestedDeliveryDate: date;
                    vPromisedDeliveryDate: date;
                    lItemreference: record "Item Reference";
                begin
                    SalesandReceivablesSetup.Get();
                    Progress.Update(1, CustOrderNo);
                    Progress.Update(2, CustLineNo);
                    indexline += 1;
                    lsalesheader.reset();
                    lsalesheader.SetCurrentKey("Sell-to Customer No.", "External Document No.");
                    lsalesheader.SetRange("Sell-to Customer No.", CustomerNo);
                    lsalesheader.SetRange("External Document No.", CustOrderNo);
                    lsalesheader.SetRange("Document Type", lsalesheader."Document Type"::Order);
                    if not lsalesheader.FindSet() then begin
                        lsalesheader.init();
                        lsalesheader."Document Type" := lsalesheader."Document Type"::Order;
                        lsalesheader.Validate("Sell-to Customer No.", CustomerNo);
                        lsalesheader."External Document No." := CustOrderNo;
                        lsalesheader.Insert(true);
                        lsalesheader.validate("Shortcut Dimension 1 Code", SiteCode);
                        //ajout code magasin
                        // if SiteCode = SalesandReceivablesSetup."Site Code Bouargoub" then
                        //     lsalesheader."Location Code" := SalesandReceivablesSetup."Location Code Bouargoub";
                        // if SiteCode = SalesandReceivablesSetup."Site code Menzel Jmil" then
                        //     lsalesheader."Location Code" := SalesandReceivablesSetup."Location code Menzel Jmil";
                        //
                        lsalesheader.modify;
                    end;
                    if lsalesheader.Status = lsalesheader.Status::Released then
                        lReleaseSalesDocument.PerformManualReopen(lsalesheader);
                    Evaluate(vCustLineNo, CustLineNo);
                    Evaluate(vUnitPrice, UnitPrice);
                    evaluate(vQuantity, Quantity);
                    Evaluate(vRequestedDeliveryDate, RequestedDeliveryDate);
                    Evaluate(vPromisedDeliveryDate, PromisedDeliveryDate);
                    lsalesline.reset();
                    lsalesline.SetRange("Document Type", lsalesline."Document Type"::Order);
                    lsalesline.SetRange("Document No.", lsalesheader."No.");
                    lsalesline.SetRange("Cust. Order No.", CustOrderNo);
                    lsalesline.SetRange("Cust. Line No.", vCustLineNo);
                    if lsalesline.findset() then begin
                        if oldsalesline.get(oldsalesline."Document Type"::Order, lsalesline."Document No.", lsalesline."Line No.") then begin
                            lItemreference.reset();
                            lItemreference.SetRange("Reference Type", lItemreference."Reference Type"::Customer);
                            lItemreference.SetRange("Reference No.", ItemRefCode);
                            if not lItemreference.FindSet() then
                                error(err03, ItemRefCode, indexline);
                            oldsalesline.Type := oldsalesline.Type::Item;
                            oldsalesline.validate("Item Reference No.", ItemRefCode);
                            oldsalesline.matricule := Matricule;
                            if SiteCode = SalesandReceivablesSetup."Site Code Bouargoub" then
                                oldsalesline.validate("Location Code", SalesandReceivablesSetup."Location Code Bouargoub");
                            if SiteCode = SalesandReceivablesSetup."Site code Menzel Jmil" then
                                oldsalesline.validate("Location Code", SalesandReceivablesSetup."Location code Menzel Jmil");
                            //oldsalesline.Description := Description;
                            oldsalesline.Validate(Quantity, vQuantity);
                            if oldsalesline."Unit Price" <> vUnitPrice then
                                error(err02, vUnitPrice, ItemRefCode, CustOrderNo, vCustLineNo, oldsalesline."Unit Price");
                            oldsalesline.Validate("Requested Delivery Date", vRequestedDeliveryDate);
                            oldsalesline.Validate("Promised Delivery Date", vPromisedDeliveryDate);
                            oldsalesline.modify(true);
                            modifiedCounter += 1
                        end;
                    end
                    else begin
                        lsalesline.init();
                        lsalesline."Document No." := lsalesheader."No.";
                        lsalesline."Document Type" := lsalesline."Document Type"::Order;
                        lsalesline.Type := lsalesline.type::Item;
                        lsalesline."Line No." := GetLineNo(lsalesheader."No.");
                        lItemreference.reset();
                        lItemreference.SetRange("Reference Type", lItemreference."Reference Type"::Customer);
                        lItemreference.SetRange("Reference No.", ItemRefCode);
                        if not lItemreference.FindSet() then
                            error(err03, ItemRefCode, indexline);
                        lsalesline.validate("Item Reference No.", ItemRefCode);
                        lsalesline."Cust. Order No." := CustOrderNo;
                        lsalesline."Cust. Line No." := vCustLineNo;
                        lsalesline.matricule := Matricule;
                        if SiteCode = SalesandReceivablesSetup."Site Code Bouargoub" then
                            lsalesline.validate("Location Code", SalesandReceivablesSetup."Location Code Bouargoub");
                        if SiteCode = SalesandReceivablesSetup."Site code Menzel Jmil" then
                            lsalesline.validate("Location Code", SalesandReceivablesSetup."Location code Menzel Jmil");
                        // if lsalesline.Description = '' then
                        //     lsalesline.Description := Description;
                        if lsalesline."Unit Price" = 0 then
                            lsalesline.validate("Unit Price", vUnitPrice)
                        else
                            if lsalesline."Unit Price" <> vUnitPrice then
                                error(err02, vUnitPrice, ItemRefCode, CustOrderNo, vCustLineNo, lsalesline."Unit Price");
                        lsalesline.Validate(Quantity, vQuantity);
                        lsalesline.Validate("Requested Delivery Date", vRequestedDeliveryDate);
                        lsalesline.Validate("Promised Delivery Date", vPromisedDeliveryDate);
                        lsalesline.insert(true);
                        Counter += 1;
                    end;
                    lsalesheader.PerformManualRelease();
                    //lsalesheader.modify(true);
                    //lReleaseSalesDocument.run(lsalesheader)
                end;
            }
        }
    }


    trigger OnPreXmlPort()

    var
        myInt: Integer;
    begin
        if not Dialog.Confirm(text01) then
            error(err04);
        Counter := 0;
        modifiedCounter := 0;
        indexline := 0;
        ProgressMsg := 'Importation en cours...\' +
                        'commande client N°:......#1######################\' +
                        'Ligne Client N°:......#2######################\';
        Progress.OPEN(ProgressMsg);

    end;

    trigger OnPostXmlPort()
    var
        Text001: Text;
    begin
        Progress.Close();
        Text001 := '';
        if Counter > 0 then
            Text001 += StrSubstNo('%1 lignes vente  ont été ajoutés.\', Counter);
        if modifiedCounter > 0 then
            Text001 += StrSubstNo('%1 Lignes vente ont été modifiées.', modifiedCounter);
        Message(Text001);
    end;



    procedure GetLineNo(pOrderNo: code[20]): Integer
    var
        lsaleseLine: record "Sales Line";
    begin
        lsaleseLine.reset();
        lsaleseLine.SetRange("Document No.", pOrderNo);
        lsaleseLine.SetRange("Document Type", lsaleseLine."Document Type"::Order);
        if lsaleseLine.Count() = 0 then
            exit(10000)
        else
            if lsaleseLine.FindLast() then
                exit(lsaleseLine."Line No." + 10000);
    end;

    var
        VCustomerNo: code[20];
        err01: TextConst FRA = 'Vous devez spécifier le N° du client ', ENU = 'You must specify the customer number';
        err03: TextConst FRA = 'Réference article %1 n''existe pas , ligne N° %2 du fichier ne peut pas étre importé !', ENU = 'The article reference %1 does not exist, line No. %2 of the file cannot be imported !';
        err04: TextConst FRA = 'Opération annulé', ENU = 'Operation canceled';
        text01: textconst FRA = 'Cette importation peut engendrer des modifications des lignes existant , voulez-vous continuer ?', ENU = 'This import could cause changes to existing lines. Would you want to continue ?';
        err02: TextConst FRA = 'le prix vente importé %1 de la réference article %2 pour la commande %3 et le Numéro du ligne %4 est different de celui dans le systeme %5', ENU = 'the imported sales price %1 of the item reference %2 for order %3 and the line number %4 is different from that in the system %5';
        Counter: Integer;
        modifiedCounter: Integer;
        Progress: Dialog;
        ProgressMsg: text;
        answer: Boolean;
        indexline: Integer;
        SalesandReceivablesSetup: record "Sales & Receivables Setup";


}
