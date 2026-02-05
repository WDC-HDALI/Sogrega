
codeunit 50002 "WDC Whse Subscribers"

//*************Documentation***************************
//WDC01  HD  26/08/2024 copy Matricule in sales document during the whse shp post 
//WDC02  CHG  13/09/2024  test fields lors de lancement d'expédition 
//WDC03  HG   29/08/2025 ADD "Customer No." field 

{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnBeforeSalesLineModify, '', false, false)]
    local procedure OnBeforeSalesLineModify(var SalesLine: Record "Sales Line"; var WarehouseShipmentLine: Record "Warehouse Shipment Line"; var ModifyLine: Boolean; Invoice: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
    begin
        SalesLine.Matricule := WarehouseShipmentLine.Matricule;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", OnBeforePostedWhseShptHeaderInsert, '', false, false)]
    local procedure OnBeforePostedWhseShptHeaderInsert(var PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
    begin
        PostedWhseShipmentHeader."Packing Type" := WarehouseShipmentHeader."Packing Type";
        PostedWhseShipmentHeader."Gross Weight" := WarehouseShipmentHeader."Gross Weight";
        PostedWhseShipmentHeader."Net Weight" := WarehouseShipmentHeader."Net Weight";
        PostedWhseShipmentHeader."Number of Packages" := WarehouseShipmentHeader."Number of Packages";
        PostedWhseShipmentHeader."Customer No." := WarehouseShipmentHeader."Customer No."; //<<WDC03
    end;

    [EventSubscriber(ObjectType::Table, database::"Warehouse Shipment Header", OnAfterOnInsert, '', false, false)]
    local procedure OnAfterOnInsert(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var xWarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        UserSetup: record "User Setup";
    begin
        if UserSetup.get(UserId) then
            If UserSetup."Default shp Location Code" <> '' then
                WarehouseShipmentHeader."Location Code" := UserSetup."Default Shp Location Code";
    end;

    [EventSubscriber(ObjectType::Table, database::"Warehouse Receipt Header", OnAfterOnInsert, '', false, false)]
    local procedure OnAfterOnInsertRcpt(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var xWarehouseReceiptHeader: Record "Warehouse Receipt Header"; Location: Record Location)
    var
        UserSetup: record "User Setup";
    begin
        if UserSetup.get(UserId) then
            If UserSetup."Default receipt Location Code" <> '' then
                WarehouseReceiptHeader."Location Code" := UserSetup."Default receipt Location Code";
    end;


    //<<WDC02
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Shipment Release", OnBeforeCheckWhseShptLinesNotEmpty, '', false, false)]
    local procedure OnBeforeCheckWhseShptLinesNotEmpty(WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var WarehouseShipmentLine: Record "Warehouse Shipment Line"; var IsHandled: Boolean)
    begin
        WarehouseShipmentHeader.TestField("Gross Weight");
        WarehouseShipmentHeader.TestField("Net Weight");
        WarehouseShipmentHeader.TestField("Number of Packages");
        WarehouseShipmentHeader.TestField("Packing Type");

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Shipment Release", OnAfterTestWhseShptLine, '', false, false)]
    local procedure OnAfterTestWhseShptLine(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    begin
        WarehouseShipmentLine.TestField(Matricule);
    end;
    //>>WDC02


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment (Yes/No)", OnBeforeConfirmWhseShipmentPost, '', false, false)]

    local procedure OnBeforeConfirmWhseShipmentPost(var WhseShptLine: Record "Warehouse Shipment Line"; var HideDialog: Boolean; var Invoice: Boolean; var IsPosted: Boolean; var Selection: Integer)
    var
        lWarehouseShipmentHeader: Record "Warehouse Shipment Header";
    begin
        if lWarehouseShipmentHeader.Get(WhseShptLine."No.") then begin
            lWarehouseShipmentHeader.TestField("Gross Weight");
            lWarehouseShipmentHeader.TestField("Net Weight");
            lWarehouseShipmentHeader.TestField("Number of Packages");
            lWarehouseShipmentHeader.TestField("Packing Type");

        end;
        WhseShptLine.TestField(Matricule);

    end;
    //<<Net weight
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeApplyItemLedgEntry, '', false, false)]
    local procedure OnBeforeApplyItemLedgEntry(var ItemLedgEntry: Record "Item Ledger Entry"; var OldItemLedgEntry: Record "Item Ledger Entry"; var ValueEntry: Record "Value Entry"; CausedByTransfer: Boolean; var Handled: Boolean; ItemJnlLine: Record "Item Journal Line"; var ItemApplnEntryNo: Integer)
    begin
        ItemLedgEntry."Net Weight" := ItemJnlLine."Net Weight";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", OnAfterCheckItemJnlLine, '', false, false)]

    local procedure OnAfterCheckItemJnlLine(var ItemJnlLine: Record "Item Journal Line"; CalledFromInvtPutawayPick: Boolean; CalledFromAdjustment: Boolean)
    Var
        ltext001: TextConst ENU = 'Please enter the net weight on all lines of item %1 ',
                            FRA = 'Veuillez saisir le poids net sur toutes les lignes de l''article %1 ';
        ltext002: TextConst ENU = 'Output quantity of item %1 must be 1 on all lines',
                            FRA = 'La quantité de production de l''article %1 doit être égale à 1 sur toutes les lignes';
        lManufacturingSetup: Record "Manufacturing Setup";
    begin
        lManufacturingSetup.Get();
        if lManufacturingSetup."Mandatory Output Weight" then begin

            if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Output then begin
                if ItemJnlLine."Journal Batch Name" <> '' then Begin
                    if ItemJnlLine."Net Weight" = 0 then
                        Error(ltext001, ItemJnlLine."Item No.", ItemJnlLine."Line No.");
                    if ItemJnlLine.Quantity <> 1 then
                        Error(ltext002, ItemJnlLine."Item No.");
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Item Journal Line", OnAfterValidateEvent, "Item No.", false, false)]
    local procedure OnAfterValidateItemNo(Rec: Record "Item Journal Line")
    Var
        lManufacturingSetup: Record "Manufacturing Setup";
    begin
        lManufacturingSetup.Get();
        if lManufacturingSetup."Mandatory Output Weight" then begin
            if Rec."Entry Type" = Rec."Entry Type"::Output then
                Rec.Validate(Quantity, 1);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Output Jnl.-Expl. Route", OnAfterInsertItemJnlLine, '', false, false)]
    local procedure OnAfterInsertItemJnlLine(var ItemJournalLine: Record "Item Journal Line")
    var
        lManufacturingSetup: Record "Manufacturing Setup";
    begin
        lManufacturingSetup.Get();
        if lManufacturingSetup."Mandatory Output Weight" then begin
            ItemJournalLine.Validate("Output Quantity", 1);
            ItemJournalLine.Modify();
        end;
    end;
    //<<WDC04
    [EventSubscriber(ObjectType::Table, database::"Warehouse Receipt Line", OnAfterInitQtyToReceive, '', false, false)]
    local procedure OnAfterInitQtyToReceive(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; CurrentFieldNo: Integer)
    begin
        if WarehouseReceiptLine."Source Document" = WarehouseReceiptLine."Source Document"::"Purchase Order" then
            WarehouseReceiptLine.validate("Qty. to Receive", 0);
    end;

    //<<WDC04



}