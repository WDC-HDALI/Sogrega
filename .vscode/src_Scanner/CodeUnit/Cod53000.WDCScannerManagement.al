namespace sogrega.sogrega;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Tracking;
using System.Text;
using Microsoft.Warehouse.Tracking;
using Microsoft.Warehouse.History;
using Microsoft.Inventory.Ledger;
using Microsoft.Warehouse.Document;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Posting;
using Microsoft.Inventory.Journal;
using Microsoft.Purchases.Vendor;
//***************Documentation**********************
//WDC01  WDC.HG  06/09/2025 Create current object : Scanner flux
//WDC02  WDC.HG  06/11/2025  add function to location transfer process
codeunit 53000 "WDC Scanner Management"
{
    procedure CheckPurchaseOrderStatuts(PurchaseOrderNo: Code[20])
    var
        PurchaseHeader: Record "Purchase Header";
        vendor: record Vendor;
        err01: TextConst ENU = 'Purchase order "%1" could not be found.', FRA = 'La commande achat "%1" est introuvable.';
        err02: TextConst ENU = 'Purchase order "%1" is not released. Current status: %2. Please release the order before proceeding.', FRA = 'La commande achat "%1" n''est pas lancée. Son statut actuel est : %2. Veuillez lancer cette commande pour continuer.';
        err03: TextConst ENU = 'This purchase order cannot be processed because the affected supplier "%1" is currently blocked.', FRA = 'Cette commande d''achat ne peut être traitée car le fournisseur concerné "%1" est actuellement bloqué';
    begin
        if not PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrderNo) then
            Error(err01, PurchaseOrderNo);

        if PurchaseHeader.Status <> PurchaseHeader.Status::Released then
            Error(err02, PurchaseOrderNo, Format(PurchaseHeader.Status));
        vendor.reset();
        if vendor.get(PurchaseHeader."Buy-from Vendor No.") then
            if vendor.Blocked = vendor.Blocked::All then
                error(err03, vendor."No.")
    end;

    procedure CheckItemReceptionValidation(PurchaseOrderNo: Code[20]; LineNo: Integer)
    var
        PurchLine: Record "Purchase Line";
        Item: Record Item;
        err01: TextConst ENU = 'Item "%1" is currently blocked.', FRA = 'L''article "%1" est actuellement bloqué.';
        err02: TextConst ENU = 'Item "%1" is not an inventory item.', FRA = 'L''article "%1" n''est pas de type stock.';
        err03: TextConst ENU = 'Item "%1" has already been totally received.', FRA = 'L''article "%1" a déjà été totalement reçu.';

    begin
        if PurchLine.get(PurchLine."Document Type"::Order, PurchaseOrderNo, LineNo) then begin
            if item.get(PurchLine."No.") then begin
                if Item.Blocked = true then
                    Error(err01, Item."No.");
                if item.Type <> item.type::Inventory then
                    Error(err02, Item."No.");
            end;
            if PurchLine."Outstanding Quantity" = 0 then
                Error(err03, Item."No.");
        end;
    end;


    procedure IsItemLotTracked(ItemNo: Code[20]): Boolean
    var
        Item: Record Item;
    begin
        Item.reset();
        if Item.Get(ItemNo) then begin
            if item."Item Tracking Code" = 'LOT' then
                exit(true)
            else
                exit(false)
        end
    end;

    procedure checkQuantityToReceive(PurchaseOrderNo: Code[20]; LineNo: Integer; PQuantityToReceive: Decimal)
    var
        lpurchaseLine: record "Purchase Line";
        err01: TextConst ENU = 'The quantity to be received must be greater than zero.', FRA = 'La quantité à réceptionner doit être supérieure à zéro.';
        Err02: TextConst ENU = 'The quantity entered cannot exceed the outstanding quantity %1', FRA = 'La quantité que vous avez saisie est supérieure à la quantité restante à recevoir %1';

    begin
        lpurchaseLine.reset();
        if lpurchaseLine.get(lpurchaseLine."Document Type"::Order, PurchaseOrderNo, LineNo) then
            if PQuantityToReceive <= 0 then
                Error(err01);
        if PQuantityToReceive > lpurchaseLine."Outstanding Quantity" then
            error(Err02, lpurchaseLine."Outstanding Quantity")


    end;

    procedure CheckExpirationDate(pDate: Date)
    var
        err01: TextConst ENU = 'The expiration date must be later than the current date %1 .',
                                               FRA = 'La date d''expiration doit être supérieure à la date courrante %1 .';
    begin
        if pDate <= WORKDATE then
            Error(err01, Format(WORKDATE, 0, '<Day,2>/<Month,2>/<Year4>'));
    end;
    //<<WDC02
    procedure ItemVerification(pItemNo: Code[20]): Boolean
    var
        Item: Record Item;
        err01: TextConst ENU = 'Item "%1" is currently blocked.', FRA = 'L''article "%1" est actuellement bloqué.';
        err02: TextConst ENU = 'Item "%1" is not an inventory item.', FRA = 'L''article "%1" n''est pas de type stock.';
    begin
        Item.reset();
        if Item.Get(pItemNo) then begin
            if Item.Blocked = true then
                Error(err01, Item."No.");
            if item.Type <> item.type::Inventory then
                Error(err02, Item."No.");

        end
    end;
    //<<WDC02
    //***********validationWarehouseReceipt*******************************
    [TryFunction]
    procedure CreateAndPostWarehouseReceipt(pPurchaseOrder: code[20]; pLineNo: integer; pLotNo: code[50]; pExpiryDate: Date; pQtyTotalToRecieve: Decimal; pLabelNo: Integer; pQtyPar: Decimal; pVendorBl: code[35])
    var
        lPurchHeader: Record "Purchase Header";
        lPurchLine: Record "Purchase Line";
        lWhseReceiptHeader: Record "Warehouse Receipt Header";
        lWhseReceiptLine: Record "Warehouse Receipt Line";
        lWhsePostReceipt: Codeunit "Whse.-Post Receipt";
        lTrackingSpec: Record "Tracking Specification";
        lReceptionScanBuffer: record "Reception Scan Buffer";
        lPostedWhseReceiptHeader: record "Posted Whse. Receipt Header";
        lReceiptNo: code[20];
        err01: TextConst ENU = 'Receipt validation failed.', FRA = 'La validation de la réception a échoué.';
        i: Integer;
        zpl: text;
        ScanLabel: report "WDC Scan Label";
        ltext001: TextConst ENU = 'Warehouse receipt %1 has been validated as a posted warehouse receipt %2.', FRA = 'La réception entrepôt %1 a été validée en une réception entrepôt enregistrée %2.';

    begin
        lPurchLine.reset();
        if not lPurchLine.get(lPurchLine."Document Type"::order, pPurchaseOrder, pLineNo) then
            error('Purchase line not found');

        lWhseReceiptHeader.Init();
        lWhseReceiptHeader."Location Code" := lPurchLine."Location Code";
        lWhseReceiptHeader."Vendor Shipment No." := pVendorBl;
        lWhseReceiptHeader.Insert(true);
        lReceiptNo := lWhseReceiptHeader."No.";
        lWhseReceiptLine.Init();
        lWhseReceiptLine."No." := lWhseReceiptHeader."No.";
        lWhseReceiptLine."Source Type" := 39;
        lWhseReceiptLine."Source Subtype" := 1;
        lWhseReceiptLine."Source Document" := lWhseReceiptLine."Source Document"::"Purchase Order";
        lWhseReceiptLine.validate("Source No.", pPurchaseOrder);
        lWhseReceiptLine.validate("Source Line No.", pLineNo);
        lWhseReceiptLine.validate("Location Code", lPurchLine."Location Code");
        lWhseReceiptLine.validate("Item No.", lPurchLine."No.");
        lWhseReceiptLine.Validate("Variant Code", lPurchLine."Variant Code");
        lWhseReceiptLine.Description := lPurchLine.Description;
        lWhseReceiptLine."Unit of Measure Code" := lPurchLine."Unit of Measure Code";
        lWhseReceiptLine.validate(lWhseReceiptLine.Quantity, pQtyTotalToRecieve);
        lWhseReceiptLine.validate("Qty. to Receive", pQtyTotalToRecieve);
        lWhseReceiptLine."No. of Labels To Scan" := PLabelNo;
        lWhseReceiptLine."Qty Par" := pQtyPar;
        lWhseReceiptLine.Insert();
        if (pLotNo <> '') and (pExpiryDate <> 0D) then begin
            InsertReceiptLot(pPurchaseOrder, pLineNo, pLotNo, pExpiryDate, pQtyTotalToRecieve);
        end;
        lWhsePostReceipt.Run(lWhseReceiptLine);
        lPostedWhseReceiptHeader.reset();
        lPostedWhseReceiptHeader.SetRange("Whse. Receipt No.", lReceiptNo);
        if lPostedWhseReceiptHeader.FindLast() then begin
            lReceptionScanBuffer.init();
            lReceptionScanBuffer."Entry No." := lReceptionScanBuffer.GetNextEntryNo();
            lReceptionScanBuffer."Document Type" := lReceptionScanBuffer."Document Type"::Reception;
            lReceptionScanBuffer."Document No." := pPurchaseOrder;
            lReceptionScanBuffer."Vendor Shipment No." := pVendorBl;
            lReceptionScanBuffer."Line No." := pLineNo;
            lReceptionScanBuffer."User ID" := UserId;
            lReceptionScanBuffer."Item No." := lPurchLine."No.";
            lReceptionScanBuffer."Site Code" := lPurchLine."Shortcut Dimension 1 Code";
            lReceptionScanBuffer."Location Code" := lPurchLine."Location Code";
            lReceptionScanBuffer."Quantity to Receive" := pQtyTotalToRecieve;
            lReceptionScanBuffer."Qty Par" := pQtyPar;
            lReceptionScanBuffer."No. of Labels" := pLabelNo;
            lReceptionScanBuffer."Lot No." := pLotNo;
            lReceptionScanBuffer."Variante Code" := lPurchLine."Variant Code";
            lReceptionScanBuffer."Expiry Date" := pExpiryDate;
            lReceptionScanBuffer."Posted Reception No." := lPostedWhseReceiptHeader."No.";
            lReceptionScanBuffer."Is Validated" := true;
            lReceptionScanBuffer.insert(true);
            ScanLabel.SetTableView(lPostedWhseReceiptHeader);
            for i := 1 to lReceptionScanBuffer."No. of Labels" do begin
                report.RunModal(report::"WDC Scan Label", false, false, lPostedWhseReceiptHeader);
            end
        end
    end;

    procedure InsertReceiptLot(pPurchaseOrder: code[20]; pLineNo: integer; pLotNo: code[50]; pExpiryDate: Date; pQtyTotalToRecieve: Decimal)
    var
        ReserEntry: Record "Reservation Entry";
        lPurchLine: Record "Purchase Line";

    begin
        lPurchLine.reset();
        if lPurchLine.get(lPurchLine."Document Type"::order, pPurchaseOrder, pLineNo) then begin
            ReserEntry.init();
            ReserEntry."Entry No." := ReserEntry.GetLastEntryNo() + 1;
            ReserEntry."Item No." := lPurchLine."No.";
            ReserEntry.validate("Variant Code", lPurchLine."Variant Code");
            ReserEntry."Location Code" := lPurchLine."Location Code";
            ReserEntry.validate("Quantity (Base)", pQtyTotalToRecieve);
            ReserEntry.Validate(Quantity, pQtyTotalToRecieve);
            ReserEntry."Reservation Status" := ReserEntry."Reservation Status"::Surplus;
            ReserEntry."Creation Date" := WorkDate();
            ReserEntry."Source Type" := 39;
            ReserEntry."Source Subtype" := 1;
            ReserEntry."Source ID" := lPurchLine."Document No.";
            ReserEntry."Source Ref. No." := lPurchLine."Line No.";
            ReserEntry.validate("Lot No.", pLotNo);
            ReserEntry."Expected Receipt Date" := lPurchLine."Expected Receipt Date";
            ReserEntry.Positive := true;
            ReserEntry."Item Tracking" := ReserEntry."Item Tracking"::"Lot No.";
            ReserEntry."Expiration Date" := pExpiryDate;
            ReserEntry.Insert(true);
        end;
    end;

    procedure CheckConflictReception(POrderNo: Code[20]; PLineNo: Integer)
    var
        ScanBuffer: Record "Reception Scan Buffer";
        err01: TextConst ENU = 'The Line %1 Of The Order %2 Is Currently Being Processed By Another User.',
                                FRA = 'La ligne %1 de la commande %2 est en cours de traitement par un autre utilisateur.';

    begin
        ScanBuffer.Reset();
        ScanBuffer.SetRange("Document Type", ScanBuffer."Document Type"::Reception);
        ScanBuffer.SetRange("Document No.", POrderNo);
        ScanBuffer.SetRange("Line No.", PLineNo);
        ScanBuffer.SetRange("Is Validated", false);
        if ScanBuffer.FindSet() then
            Error(err01, PLineNo, POrderNo);
    end;
    //**********************validation Transfert Magasin*********************
    procedure CheckItemStockAvailability(pItemNo: code[20]; pFromLocation: code[10]; pLotNo: code[50]; pVariantCode: code[10]; PQuantity: Decimal)
    var
        lItemLedgerEntry: record "Item Ledger Entry";
        lAvailableLotQtyByItem: Decimal;
        lErr01: TextConst ENU = 'Stock unavailable for item %1 in location %2', FRA = 'Stock indisponible pour l''article %1 dans le magasin %2';
        lErr02: TextConst ENU = 'Stock unavailable for item %1 with variant %2', FRA = 'Stock indisponible pour l''article %1 avec la variante %2';
        lErr03: TextConst ENU = 'Stock unavailable for item %1 in lot %2', FRA = 'Stock indisponible pour l''article %1 dans le lot %2';
        lErr04: TextConst ENU = 'The quantity entered cannot exceed the item Inventory %1', FRA = 'La quantité que vous avez saisie est supérieure au stock de l''article  %1';
    begin
        lItemLedgerEntry.reset();
        lItemLedgerEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        lItemLedgerEntry.setrange("Item No.", pItemNo);
        lItemLedgerEntry.SetRange(Open, true);
        lItemLedgerEntry.setrange("Location Code", pFromLocation);
        if pLotNo <> '' then
            lItemLedgerEntry.setrange("Lot No.", pLotNo);
        if pVariantCode <> '' then
            lItemLedgerEntry.SetRange("Variant Code", pVariantCode);
        if not lItemLedgerEntry.findset() then begin
            if (pLotNo = '') and (pVariantCode = '') then
                Error(lerr01, pItemNo, pFromLocation)
            else
                if pVariantCode <> '' then
                    error(lErr02, pItemNo, pVariantCode)
                else if pLotNo <> '' then
                    Error(lerr03, pItemNo, pLotNo);
        end;

        repeat
            lAvailableLotQtyByItem += lItemLedgerEntry."Remaining Quantity";
        until lItemLedgerEntry.Next() = 0;
        if lAvailableLotQtyByItem < PQuantity then
            error(lErr04, lAvailableLotQtyByItem);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Management", OnBeforeTempHandlingSpecificationInsert, '', false, false)]
    local procedure OnBeforeTempHandlingSpecificationInsert(var TempTrackingSpecification: Record "Tracking Specification" temporary; ReservationEntry: Record "Reservation Entry"; var ItemTrackingCode: Record "Item Tracking Code"; var EntriesExist: Boolean)
    begin
        if TempTrackingSpecification."Expiration Date" <> 0D then
            TempTrackingSpecification."New Expiration Date" := TempTrackingSpecification."Expiration Date"
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", OnBeforeAddToGlobalRecordSet, '', false, false)]
    local procedure OnBeforeAddToGlobalRecordSet(var TrackingSpecification: Record "Tracking Specification"; EntriesExist: Boolean; CurrentSignFactor: Integer; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    begin
        if TrackingSpecification."Expiration Date" <> 0D then
            TrackingSpecification."New Expiration Date" := TrackingSpecification."Expiration Date";
    end;

    procedure ClearBatch(pBatchName: Code[10])
    var
        lItemJournalLine: record "Item Journal Line";
    begin
        lItemJournalLine.Reset();
        lItemJournalLine.SetRange("Journal Batch Name", pBatchName);
        lItemJournalLine.setrange(IsScanned, false);
        lItemJournalLine.DeleteAll();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnPostLinesOnAfterPostLine, '', false, false)]
    local procedure OnPostLinesOnAfterPostLine(var ItemJournalLine: Record "Item Journal Line"; var SuppressCommit: Boolean)

    var
        lLocationTransfertScan: record "Location Transfert Scan ";
        lItemJournalBatch: Record "Item Journal Batch";
    begin
        if lItemJournalBatch.get('TRANSFERT', ItemJournalLine."Journal Batch Name") then
            if lItemJournalBatch."Scanner Sheet" = true then begin
                if (ItemJournalLine.IsScanned = true) and (ItemJournalLine."Applied Scan Entry No." <> 0) then begin
                    lLocationTransfertScan.reset();
                    if lLocationTransfertScan.get(ItemJournalLine."Applied Scan Entry No.") then begin
                        lLocationTransfertScan.IsValidated := true;
                        lLocationTransfertScan."Inserted to Journal" := false;
                        lLocationTransfertScan.Modify()
                    end
                end;
            end
    end;

    procedure InitInventoryScanFromJournal(var pItemJournalLine: Record "Item Journal Line")
    var
        ItemJournalLine: Record "Item Journal Line";
        Item: Record Item;
    begin
        ItemJournalLine.Reset();
        ItemJournalLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Item No.", "Location Code", "Variant Code");
        ItemJournalLine.SetRange("Journal Template Name", pItemJournalLine."Journal Template Name");
        ItemJournalLine.SetRange("Journal Batch Name", pItemJournalLine."Journal Batch Name");
        ItemJournalLine.SetRange("Location Code", pItemJournalLine."Location Code");
        ItemJournalLine.setrange("Document No.", pItemJournalLine."Document No.");
        //ItemJournalLine.SetFilter("Variant Code", '%1', '');
        repeat
            if Item.Get(ItemJournalLine."Item No.") then begin
                if Item."Item Tracking Code" = '' then begin
                    //if ItemJournalLine."Variant Code" = '' then
                    InsertNoLotItem(ItemJournalLine);
                    ItemJournalLine."Is Inventory Inserted" := true;
                    ItemJournalLine.modify(true);
                end
                else begin
                    //if ItemJournalLine."Variant Code" = '' then
                    InsertLotItem(ItemJournalLine);
                    ItemJournalLine."Is Inventory Inserted" := true;
                    ItemJournalLine.modify(true);
                end;

            end;

        until ItemJournalLine.Next() = 0;
    end;

    procedure InsertNoLotItem(pItemJnlLine: Record "Item Journal Line")
    var
        InventoryScanBuffer: Record "Inventory Scan Buffer";
        item: record item;
    begin
        InventoryScanBuffer.Init();
        InventoryScanBuffer."Entry No." := InventoryScanBuffer.GetNextEntryNo();
        InventoryScanBuffer."Journal Template Name" := pItemJnlLine."Journal Template Name";
        InventoryScanBuffer."Journal Batch Name" := pItemJnlLine."Journal Batch Name";
        InventoryScanBuffer."Journal Line No." := pItemJnlLine."Line No.";
        InventoryScanBuffer."Document No." := pItemJnlLine."Document No.";
        InventoryScanBuffer."Item No." := pItemJnlLine."Item No.";
        InventoryScanBuffer."Variant Code" := pItemJnlLine."Variant Code";//HG.VARIANTE
        if item.get(InventoryScanBuffer."Item No.") then
            InventoryScanBuffer.Description := item.Description;
        InventoryScanBuffer."Location Code" := pItemJnlLine."Location Code";
        InventoryScanBuffer.Inventory := pItemJnlLine."Qty. (Calculated)";
        InventoryScanBuffer.validate("Scanned Inventory", 0);
        InventoryScanBuffer."Inventory Date" := pItemJnlLine."Posting Date";
        InventoryScanBuffer."USERID " := UserId;
        // if IsVariantItem(pItemJnlLine."Item No.") then
        //     InventoryScanBuffer."Variant Item" := true;
        InventoryScanBuffer.Insert(true);
    end;

    procedure InsertLotItem(pItemJnlLine: Record "Item Journal Line")
    var
        lItemLedgerEntry: Record "Item Ledger Entry";
        lInventoryScanBuffer: Record "Inventory Scan Buffer";
    begin
        lItemLedgerEntry.reset();
        lItemLedgerEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        lItemLedgerEntry.SetRange("Item No.", pItemJnlLine."Item No.");
        lItemLedgerEntry.setrange("Variant Code", pItemJnlLine."Variant Code");
        lItemLedgerEntry.SetRange(Open, true);
        lItemLedgerEntry.SetRange("Location Code", pItemJnlLine."Location Code");
        lItemLedgerEntry.SetFilter("Lot No.", '<>%1', '');
        if lItemLedgerEntry.FindSet() then
            repeat
                AddLotToInventoryScanBuffer(pItemJnlLine, lItemLedgerEntry."Lot No.", lItemLedgerEntry."Expiration Date", lItemLedgerEntry."Remaining Quantity");
            until lItemLedgerEntry.Next() = 0;
    end;

    local procedure AddLotToInventoryScanBuffer(pItemJnlLine: Record "Item Journal Line"; pLotNo: Code[50]; pExpiryDate: date; Qty: Decimal)
    var
        lInventoryScanBuffer: Record "Inventory Scan Buffer";
        item: record item;
    begin
        lInventoryScanBuffer.Reset();
        lInventoryScanBuffer.SetRange("Document No.", pItemJnlLine."Document No.");
        lInventoryScanBuffer.setrange("Journal Template Name", pItemJnlLine."Journal Template Name");
        lInventoryScanBuffer.setrange("Journal Batch Name", pItemJnlLine."Journal Batch Name");
        lInventoryScanBuffer.SetRange("Journal Line No.", pItemJnlLine."Line No.");
        lInventoryScanBuffer.SetRange("Item No.", pItemJnlLine."Item No.");
        lInventoryScanBuffer.SetRange("Location Code", pItemJnlLine."Location Code");
        lInventoryScanBuffer.setrange("Variant Code", pItemJnlLine."Variant Code");
        lInventoryScanBuffer.SetRange("Lot No.", pLotNo);
        if lInventoryScanBuffer.FindFirst() then begin
            lInventoryScanBuffer.Inventory += Qty;
            lInventoryScanBuffer.validate("Scanned Inventory", 0);
            lInventoryScanBuffer.Modify(true);
        end else begin
            lInventoryScanBuffer.Init();
            lInventoryScanBuffer."Entry No." := lInventoryScanBuffer.GetNextEntryNo();
            lInventoryScanBuffer."Journal Template Name" := pItemJnlLine."Journal Template Name";
            lInventoryScanBuffer."Journal Batch Name" := pItemJnlLine."Journal Batch Name";
            lInventoryScanBuffer."Journal Line No." := pItemJnlLine."Line No.";
            lInventoryScanBuffer."Document No." := pItemJnlLine."Document No.";
            lInventoryScanBuffer."Item No." := pItemJnlLine."Item No.";
            lInventoryScanBuffer."Variant Code" := pItemJnlLine."Variant Code";
            if item.get(lInventoryScanBuffer."Item No.") then
                lInventoryScanBuffer.Description := item.Description;
            lInventoryScanBuffer."Location Code" := pItemJnlLine."Location Code";
            lInventoryScanBuffer."Lot No." := pLotNo;
            lInventoryScanBuffer."Expiry Date" := pExpiryDate;
            lInventoryScanBuffer.Inventory := Qty;
            lInventoryScanBuffer.validate("Scanned Inventory", 0);
            lInventoryScanBuffer."Inventory Date" := pItemJnlLine."Posting Date";
            lInventoryScanBuffer."USERID " := UserId;
            // if IsVariantItem(pItemJnlLine."Item No.") then
            //     lInventoryScanBuffer."Variant Item" := true;
            lInventoryScanBuffer.Insert(true);

        end;
    end;

    procedure CanInitializeInventory(pBatchName: Code[10]; pLocation: Code[10]; pDocumentNo: code[20]): Boolean
    var
        ItemJnlLine: Record "Item Journal Line";
    begin
        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", 'INVENTAIRE');
        ItemJnlLine.SetRange("Journal Batch Name", pBatchName);
        ItemJnlLine.setrange("Document No.", pDocumentNo);
        ItemJnlLine.SetRange("Location Code", pLocation);
        //ItemJnlLine.SetFilter("Variant Code", '%1', '');
        ItemJnlLine.SetRange("Is Inventory Inserted", false);
        exit(not ItemJnlLine.IsEmpty());
    end;

    procedure NotInitializedBatch(pBatchName: Code[10]; pLocation: Code[10]; pDocumentNo: code[20]): Boolean
    var
        ItemJnlLine: Record "Item Journal Line";
    begin
        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", 'INVENTAIRE');
        ItemJnlLine.SetRange("Journal Batch Name", pBatchName);
        ItemJnlLine.setrange("Document No.", pDocumentNo);
        ItemJnlLine.SetRange("Location Code", pLocation);
        //ItemJnlLine.SetFilter("Variant Code", '%1', '');
        ItemJnlLine.SetRange("Is Inventory Inserted", true);
        exit(ItemJnlLine.IsEmpty());
    end;

    procedure DeleteInventoryScanBuffer(pItemJournalLine: Record "Item Journal Line")
    var
        InventoryScanBuffer: Record "Inventory Scan Buffer";
    begin
        InventoryScanBuffer.Reset();
        InventoryScanBuffer.SetRange("Journal Template Name", pItemJournalLine."Journal Template Name");
        InventoryScanBuffer.SetRange("Journal Batch Name", pItemJournalLine."Journal Batch Name");
        InventoryScanBuffer.SetRange("Location Code", pItemJournalLine."Location Code");
        InventoryScanBuffer.SetRange("Document No.", pItemJournalLine."Document No.");
        InventoryScanBuffer.DeleteAll();
    end;

    procedure ResetInventoryInserted(pItemJournalLine: Record "Item Journal Line")
    var
        ItemJournalLine: Record "Item Journal Line";
    begin
        ItemJournalLine.Reset();
        ItemJournalLine.SetRange("Journal Template Name", pItemJournalLine."Journal Template Name");
        ItemJournalLine.SetRange("Journal Batch Name", pItemJournalLine."Journal Batch Name");
        ItemJournalLine.SetRange("Location Code", pItemJournalLine."Location Code");
        ItemJournalLine.SetRange("Document No.", pItemJournalLine."Document No.");
        if ItemJournalLine.FindSet() then
            repeat
                ItemJournalLine."Is Inventory Inserted" := false;
                ItemJournalLine.Modify();
            until ItemJournalLine.Next() = 0;
    end;
    //

    procedure NoScannedInventory(pBatchName: Code[10]; pLocation: Code[10]): Boolean
    var
        InventoryScanBuf: Record "Inventory Scan Buffer";
    begin
        InventoryScanBuf.Reset();
        InventoryScanBuf.setrange("Journal Template Name", 'INVENTAIRE');
        InventoryScanBuf.SetRange("Journal Batch Name", pBatchName);
        InventoryScanBuf.SetRange("Location Code", pLocation);
        InventoryScanBuf.SetRange("is Scanned ", true);
        exit(not InventoryScanBuf.FindSet());
    end;

    procedure IsVariantItem(pItemNo: code[20]): Boolean
    var
        lItemVariant: record "Item Variant";
    begin
        lItemVariant.reset();
        lItemVariant.SetCurrentKey("Item No.", "Code");
        lItemVariant.setrange("Item No.", pItemNo);
        exit(lItemVariant.FindSet())
    end;
}






