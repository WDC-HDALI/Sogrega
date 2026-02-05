
codeunit 50000 "WDC Sales Subscribers"
//*************Documentation***************************
//WDC01  CHG  22/08/2024  Create this current object
//WDC02  HG   30/10/2024  Change the description in Invoice Lines

{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReleaseSalesDoc, '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    var
        lSalesLine: record "Sales Line";
        Err01: TextConst FRA = 'Code magasin %1 doit commencer par une valeur similaire au site code  %2- ', ENU = 'Location Code %1 must start with a value similar to the site code  %2-';
    begin
        SalesHeader.TestField("Shortcut Dimension 1 Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterSalesInvLineInsert, '', false, false)]
    local procedure OnAfterSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSuppressed: Boolean; var SalesHeader: Record "Sales Header"; var TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; PreviewMode: Boolean)
    Var
        lsalesSetup: Record "Sales & Receivables Setup";
    begin
        lsalesSetup.GET;
        if lsalesSetup."Controle Qty to invoice" then
            if (SalesInvLine.Type = SalesInvLine.Type::Item) and (SalesInvLine."No." <> '') then
                if SalesInvLine.Quantity = 0 then
                    Error('La quantité de la ligne %1 ne peut pas être égale à 0', SalesInvLine."Line No.");
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", OnBeforeValidateLocationCode, '', false, false)]

    local procedure OnBeforeValidateLocationCode(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        Err01: TextConst FRA = 'Location Code %1 doit commencer par une valeur similaire aux site code  %2- ', ENU = 'Location Code %1 must start with a value similar to the site code  %2-';
        lSalesLine: Record "Sales Line";
    begin
        if SalesHeader."Location Code" <> '' then
            if (CopyStr(SalesHeader."Location Code", 1, 2) <> SalesHeader."Shortcut Dimension 1 Code") then
                Error(Err01, SalesHeader."Location Code", SalesHeader."Shortcut Dimension 1 Code");
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", OnBeforeValidateShortcutDimCode, '', false, false)]
    local procedure OnBeforeValidateShortcutDimCode(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    var
        lSalesLine: Record "Sales Line";
    begin
        if lsalesLine.get(SalesHeader."Document Type", SalesHeader."No.") then
            lsalesLine."Shortcut Dimension 1 Code" := SalesHeader."Shortcut Dimension 1 Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnCodeOnAfterCheck, '', false, false)]
    local procedure OnCodeOnAfterCheck(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var LinesWereModified: Boolean)
    var
        Err01: TextConst FRA = 'Code magasin dans ligne commande  %1 doit commencer par une valeur similaire au site code  %2- ', ENU = 'Location Code %1 must start with a value similar to the site code  %2-';
        Err02: TextConst FRA = 'Code magasin dans ligne commande  %1 doit avoir la même valeur que code magasin dans l''entête  %2', ENU = 'Location Code %1 have similar  value to the Header';
        Err03: TextConst FRA = 'Site Code doit avoir la même valeur pour les lignes et l''entete. ', ENU = 'Site code should include the same value for the lines and the header.';

    begin
        if SalesLine."Shortcut Dimension 1 Code" <> SalesHeader."Shortcut Dimension 1 Code" then
            Error(Err03);
        if SalesLine."Location Code" <> '' then begin
            if (CopyStr(SalesLine."Location Code", 1, 2) <> SalesLine."Shortcut Dimension 1 Code") OR (CopyStr(SalesLine."Location Code", 1, 2) <> SalesHeader."Shortcut Dimension 1 Code") then
                Error(Err01, SalesLine."Location Code", SalesHeader."Shortcut Dimension 1 Code");
            if SalesHeader."Location Code" <> '' then
                if SalesLine."Location Code" <> SalesHeader."Location Code" then
                    Error(Err02, SalesLine."Location Code", SalesHeader."Location Code");
        end;
    end;
    //<<WDC02
    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine', '', false, false)]
    local procedure OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line"; var NextLineNo: Integer; var Handled: Boolean)
    var
        lSalesHeader: Record "Sales Header";
        text001: Label ' BCC: %1';
    begin
        lSalesHeader.GET(lSalesHeader."Document Type"::Order, SalesShptLine."Order No.");
        SalesLine.Description := '';
        SalesLine.Description := StrSubstNo(text001, lSalesHeader."External Document No.");
    end;
    //>>WDC02
}