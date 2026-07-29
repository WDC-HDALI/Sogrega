namespace sogrega.sogrega;

using Microsoft.Inventory.Counting.Journal;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Tracking;

pageextension 53001 "Phys Inventory Journal " extends "Phys. Inventory Journal"
{
    layout
    {
        addlast(Control1)
        {
            field("Is Inventory Inserted"; Rec."Is Inventory Inserted")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("From Scan"; Rec."From Scan")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Phys. Inventory"; Rec."Phys. Inventory")
            {
                ApplicationArea = all;
                Editable = true;
            }
        }
        addafter("Qty Checked")
        {
            field("Is Imported"; Rec."Is Imported")
            {
                StyleExpr = NotImportedIndicator;
                ApplicationArea = all;
                Editable = false;
            }

        }
    }
    actions
    {
        addlast(Processing)
        {

            action(InitScanBuffer)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Reinitialize Scan Items', FRA = 'Réinitialiser les éléments à scanner';
                Image = CreateLinesFromJob;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ShowIsImported;
                trigger OnAction()
                var
                    ScanMgt: Codeunit "WDC Scanner Management";
                    text01: TextConst ENU = 'Scan items have been successfully reinitialized.',
                                      FRA = 'Les éléments à scanner ont été réinitialisés avec succès.';
                    ConfirmText01: TextConst ENU = 'This will delete all existing scanned data and rebuild it. Continue?',
                                            FRA = 'Cette action supprimera toutes les données scannées existantes et les reconstruira. Continuer ?';
                begin
                    if not Confirm(ConfirmText01, false) then
                        exit;
                    scanMgt.DeleteInventoryScanBuffer(Rec);
                    ScanMgt.ResetInventoryInserted(Rec);
                    ScanMgt.InitInventoryScanFromJournal(Rec);
                    CurrPage.update(false);
                    Message(text01);
                end;
            }
            action(ViewScanLines)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'View Scanned Lines', FRA = 'Voir Lignes scannées';
                Image = AllLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ShowIsImported;
                trigger OnAction()
                var
                    InventoryScanBuffer: Record "Inventory Scan Buffer";
                begin
                    InventoryScanBuffer.Reset();
                    InventoryScanBuffer.SetRange("Journal Template Name", Rec."Journal Template Name");
                    InventoryScanBuffer.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    InventoryScanBuffer.SetRange("Location Code", rec."Location Code");
                    InventoryScanBuffer.setrange("Document NO.", rec."Document No.");
                    Page.Run(Page::"WDC Inventory Scan Line", InventoryScanBuffer);
                end;
            }
            action(ImportScanLines)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Import Scan Lines', FRA = 'Import lignes scannées';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ShowIsImported;
                trigger OnAction()
                var
                    text01: TextConst ENU = 'Import completed successfully.', FRA = 'Import terminé avec succès.';
                begin
                    ImportScannedInventoryLines(Rec."Journal Batch Name", Rec."Location Code", rec."Document No.");
                    IsInventoryImported := true;
                    Message(text01);
                end;
            }
        }
    }

    procedure ImportScannedInventoryLines(pBatchName: Code[10]; pLocation: Code[10]; pDocumentNo: code[20])
    var
        InventoryScanBuf: Record "Inventory Scan Buffer";
        p: page 392;
        ItemJournalLine: record "Item Journal Line";
        ScannMgt: Codeunit "WDC Scanner Management";
        err01: TextConst FRA = 'Les éléments du scanner sur la feuille %1 n''ont pas été initialisés.', ENU = 'The scanner elements on sheet %1 have not been initialized.';
        err02: TextConst FRA = 'No scanned inventory lines to import.', ENU = 'Aucune ligne inventaire scannée à importer.';
    begin
        if ScannMgt.CanInitializeInventory(pBatchName, pLocation, pDocumentNo) then
            error(err01, pBatchName);
        if ScannMgt.NoScannedInventory(pBatchName, pLocation) then
            Error(err02);
        InventoryScanBuf.reset();
        InventoryScanBuf.setrange("Journal Template Name", 'INVENTAIRE');
        InventoryScanBuf.SetRange("Journal Batch Name", pBatchName);
        InventoryScanBuf.SetRange("Document NO.", pDocumentNo);
        InventoryScanBuf.SetRange("Location Code", pLocation);
        InventoryScanBuf.SetRange("Is Imported", false);
        //InventoryScanBuf.setrange("Variant Item", false);
        if InventoryScanBuf.FindSet() then
            repeat
                if InventoryScanBuf."Lot No." = '' then
                    ProcessNoTrackingItem(InventoryScanBuf)
                else begin
                    ItemJournalLine.reset();
                    ItemJournalLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Item No.", "Location Code", "Variant Code");
                    ItemJournalLine.SetRange("Journal Template Name", InventoryScanBuf."Journal Template Name");
                    ItemJournalLine.SetRange("Journal Batch Name", InventoryScanBuf."Journal Batch Name");
                    ItemJournalLine.setrange("Document No.", InventoryScanBuf."Document NO.");
                    ItemJournalLine.setrange("Item No.", InventoryScanBuf."Item No.");
                    ItemJournalLine.SetRange("Variant Code", InventoryScanBuf."Variant Code");
                    if ItemJournalLine.FindSet() then begin
                        if not ItemJournalLine."Is Imported" = true then begin
                            ResetItemBeforeReimport(InventoryScanBuf);
                            ProcessTrackingItem(InventoryScanBuf);
                            //CurrPage.Update(false);
                        end
                    end
                    else
                        InsertZeroCountLine(InventoryScanBuf);
                end;
                InventoryScanBuf."Is Imported" := true;
                InventoryScanBuf.modify();
            until InventoryScanBuf.next() = 0;
        CurrPage.Update(false);
    end;

    procedure ProcessNoTrackingItem(pScanBuf: Record "Inventory Scan Buffer")
    var
        ItemJournalLine: record "Item Journal Line";
    begin
        if pScanBuf.InsertedFromScan = false then begin
            if ItemJournalLine.get(pScanBuf."Journal Template Name", pScanBuf."Journal Batch Name", pScanBuf."Journal Line No.") then begin
                if pScanBuf."Qty Diff." <> 0 then begin
                    if ItemJournalLine."Qty. (Calculated)" = 0 then
                        ItemJournalLine.validate("Phys. Inventory", true);
                    ItemJournalLine.validate("Qty. (Phys. Inventory)", pScanBuf."Scanned Inventory");
                end;
                ItemJournalLine.validate("Qty. (Phys. Inventory)", pScanBuf."Scanned Inventory");
                ItemJournalLine."Is Imported" := true;
                ItemJournalLine.modify(true);
            end
        end
        else
            InsertZeroCountLine(pScanBuf);
    end;

    procedure ProcessTrackingItem(pScanBuf: Record "Inventory Scan Buffer")
    var
        ItemJnlLine: Record "Item Journal Line";
        LotScanBuf: Record "Inventory Scan Buffer";
        TotalScannedQty: Decimal;
        PosDiff: Decimal;
        NegDiff: Decimal;
        SystemQty: Decimal;
        DiffQTY: Decimal;
    begin
        TotalScannedQty := 0;
        PosDiff := 0;
        NegDiff := 0;
        DiffQTY := 0;
        ItemJnlLine.reset();
        ItemJnlLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Item No.", "Location Code", "Variant Code");
        ItemJnlLine.SetRange("Journal Template Name", pScanBuf."Journal Template Name");
        ItemJnlLine.SetRange("Journal Batch Name", pScanBuf."Journal Batch Name");
        ItemJnlLine.setrange("Document No.", pScanBuf."Document NO.");
        ItemJnlLine.setrange("Item No.", pScanBuf."Item No.");
        ItemJnlLine.SetRange("Variant Code", pScanBuf."Variant Code");
        if ItemJnlLine.FindSet() then begin
            LotScanBuf.Reset();
            LotScanBuf.SetRange("Journal Template Name", 'INVENTAIRE');
            LotScanBuf.SetRange("Journal Batch Name", pScanBuf."Journal Batch Name");
            LotScanBuf.SetRange("Location Code", pScanBuf."Location Code");
            LotScanBuf.SetRange("Document NO.", pScanBuf."Document NO.");
            LotScanBuf.SetRange("Item No.", pScanBuf."Item No.");
            LotScanBuf.SetRange("Variant Code", pScanBuf."Variant Code");
            LotScanBuf.SetFilter("Qty Diff.", '<>%1', 0);
            if LotScanBuf.FindSet() then
                repeat
                    if LotScanBuf."Qty Diff." > 0 then
                        PosDiff += LotScanBuf."Qty Diff."
                    else
                        NegDiff += Abs(LotScanBuf."Qty Diff.");
                until LotScanBuf.Next() = 0;
            if NegDiff <> 0 then begin
                DiffQTY := ItemJnlLine."Qty. (Calculated)" - NegDiff;
                ItemJnlLine.Validate("Qty. (Phys. Inventory)", DiffQTY);
                ItemJnlLine.Modify(true);
                HandleNegativeLotDifference(ItemJnlLine);
                ItemJnlLine."Is Imported" := true;
                ItemJnlLine.modify(true);
                //CurrPage.Update(false);
                if PosDiff <> 0 then begin
                    InsertPositiveDiffLine(ItemJnlLine, PosDiff);
                    //CurrPage.Update(false);
                end
            end
            else begin
                DiffQTY := ItemJnlLine."Qty. (Calculated)" + PosDiff;
                ItemJnlLine.Validate("Qty. (Phys. Inventory)", DiffQTY);
                ItemJnlLine.Modify(true);
                HandlePositiveLotDifference(ItemJnlLine);
                ItemJnlLine."Is Imported" := true;
                ItemJnlLine.modify(true);
                //CurrPage.Update(false);
            end;
        end;
    end;

    procedure HandleNegativeLotDifference(pItemJnlLine: record "Item Journal Line")
    var
        lReservationEntry: record "Reservation Entry";
        lInventoryScanBuffer: record "Inventory Scan Buffer";
    begin
        lInventoryScanBuffer.Reset();
        lInventoryScanBuffer.SetRange("Journal Template Name", 'INVENTAIRE');
        lInventoryScanBuffer.SetRange("Journal Batch Name", pItemJnlLine."Journal Batch Name");
        lInventoryScanBuffer.SetRange("Location Code", pItemJnlLine."Location Code");
        lInventoryScanBuffer.setrange("Document NO.", pItemJnlLine."Document No.");
        lInventoryScanBuffer.SetRange("Item No.", pItemJnlLine."Item No.");
        lInventoryScanBuffer.SetRange("Variant Code", pItemJnlLine."Variant Code");
        lInventoryScanBuffer.SetFilter("Qty Diff.", '<%1', 0);
        if lInventoryScanBuffer.FindSet() then
            repeat
                lReservationEntry.INIT;
                lReservationEntry."Entry No." := lReservationEntry.GetLastEntryNo() + 1;
                lReservationEntry.VALIDATE("Source ID", 'INVENTAIRE');
                lReservationEntry.VALIDATE("Source Batch Name", lInventoryScanBuffer."Journal Batch Name");
                lReservationEntry.VALIDATE("Item No.", lInventoryScanBuffer."Item No.");
                lReservationEntry.VALIDATE("Location Code", lInventoryScanBuffer."Location Code");
                lReservationEntry."Item Tracking" := lReservationEntry."Item Tracking"::"Lot No.";
                lReservationEntry.VALIDATE("Lot No.", lInventoryScanBuffer."Lot No.");
                lReservationEntry.validate("Expiration Date", lInventoryScanBuffer."Expiry Date");
                lReservationEntry."New Lot No." := lInventoryScanBuffer."Lot No.";
                lReservationEntry."New Expiration Date" := lInventoryScanBuffer."Expiry Date";
                lReservationEntry."Variant Code" := lInventoryScanBuffer."Variant Code";
                lReservationEntry.VALIDATE("Source Type", 83);
                lReservationEntry.VALIDATE("Source Ref. No.", lInventoryScanBuffer."Journal Line No.");
                lReservationEntry."Reservation Status" := lReservationEntry."Reservation Status"::Prospect;
                lReservationEntry.VALIDATE("Creation Date", WORKDATE);
                lReservationEntry."Expected Receipt Date" := WORKDATE;
                lReservationEntry."Created By" := USERID;
                lReservationEntry.Positive := FALSE;
                lReservationEntry.VALIDATE("Source Subtype", 3);
                lReservationEntry.Validate("Quantity (Base)", -abs(lInventoryScanBuffer."Qty Diff."));
                lReservationEntry.insert(true);
            until lInventoryScanBuffer.next() = 0;
    end;

    procedure HandlePositiveLotDifference(pItemJnlLine: record "Item Journal Line")
    var
        lReservationEntry: record "Reservation Entry";
        lInventoryScanBuffer: record "Inventory Scan Buffer";
    begin
        lInventoryScanBuffer.Reset();
        lInventoryScanBuffer.SetRange("Journal Template Name", 'INVENTAIRE');
        lInventoryScanBuffer.SetRange("Journal Batch Name", pItemJnlLine."Journal Batch Name");
        lInventoryScanBuffer.SetRange("Location Code", pItemJnlLine."Location Code");
        lInventoryScanBuffer.setrange("Document NO.", pItemJnlLine."Document No.");
        lInventoryScanBuffer.SetRange("Item No.", pItemJnlLine."Item No.");
        lInventoryScanBuffer.SetRange("Variant Code", pItemJnlLine."Variant Code");
        lInventoryScanBuffer.SetFilter("Qty Diff.", '>%1', 0);
        if lInventoryScanBuffer.FindSet() then
            repeat
                lReservationEntry.INIT;
                lReservationEntry."Entry No." := lReservationEntry.GetLastEntryNo() + 1;
                lReservationEntry.VALIDATE("Source ID", 'INVENTAIRE');
                lReservationEntry.VALIDATE("Source Batch Name", lInventoryScanBuffer."Journal Batch Name");
                lReservationEntry.VALIDATE("Item No.", lInventoryScanBuffer."Item No.");
                lReservationEntry.VALIDATE("Location Code", lInventoryScanBuffer."Location Code");
                lReservationEntry."Item Tracking" := lReservationEntry."Item Tracking"::"Lot No.";
                lReservationEntry.VALIDATE("Lot No.", lInventoryScanBuffer."Lot No.");
                lReservationEntry.validate("Expiration Date", lInventoryScanBuffer."Expiry Date");
                lReservationEntry."New Lot No." := lInventoryScanBuffer."Lot No.";
                lReservationEntry."New Expiration Date" := lInventoryScanBuffer."Expiry Date";
                lReservationEntry."Variant Code" := lInventoryScanBuffer."Variant Code";
                lReservationEntry.VALIDATE("Source Type", 83);
                lReservationEntry.VALIDATE("Source Ref. No.", pItemJnlLine."Line No.");
                lReservationEntry."Reservation Status" := lReservationEntry."Reservation Status"::Prospect;
                lReservationEntry.VALIDATE("Creation Date", WORKDATE);
                lReservationEntry."Expected Receipt Date" := WORKDATE;
                lReservationEntry."Created By" := USERID;
                lReservationEntry.Positive := TRUE;
                lReservationEntry.VALIDATE("Source Subtype", 2);
                lReservationEntry.Validate("Quantity (Base)", abs(lInventoryScanBuffer."Qty Diff."));
                lReservationEntry.insert(true);
            until lInventoryScanBuffer.next() = 0;
    end;

    procedure InsertPositiveDiffLine(pItemJnlLine: record "Item Journal Line"; pPhyQty: decimal)
    var
        ItemJournalLine: record "Item Journal Line";
    begin
        ItemJournalLine.Init();
        ItemJournalLine."Journal Template Name" := pItemJnlLine."Journal Template Name";
        ItemJournalLine."Journal Batch Name" := pItemJnlLine."Journal Batch Name";
        ItemJournalLine."Document No." := pItemJnlLine."Document NO.";
        ItemJournalLine."Line No." := GetNextLineNo(pItemJnlLine."Journal Template Name", pItemJnlLine."Journal Batch Name", pItemJnlLine."Document NO.");
        ItemJournalLine.Validate("Item No.", pItemJnlLine."Item No.");
        ItemJournalLine.Validate("Location Code", pItemJnlLine."Location Code");
        ItemJournalLine.validate("Phys. Inventory", true);
        ItemJournalLine.Validate("Qty. (Phys. Inventory)", pPhyQty);
        ItemJournalLine."Variant Code" := pItemJnlLine."Variant Code";
        ItemJournalLine."Document No." := pItemJnlLine."Document NO.";
        ItemJournalLine."Posting Date" := pItemJnlLine."Posting Date";
        ItemJournalLine."Is Inventory Inserted" := true;
        ItemJournalLine."From Scan" := true;
        ItemJournalLine."Inventory correction" := true;
        if ItemJournalLine.Insert(true) then begin
            HandlePositiveLotDifference(ItemJournalLine);
            ItemJournalLine."Is Imported" := true;
            ItemJournalLine.modify(true);
        end;
    end;

    procedure InsertZeroCountLine(pScanBuf: Record "Inventory Scan Buffer")
    var
        ItemJournalLine: record "Item Journal Line";
    begin
        ItemJournalLine.Init();
        ItemJournalLine."Journal Template Name" := pScanBuf."Journal Template Name";
        ItemJournalLine."Journal Batch Name" := pScanBuf."Journal Batch Name";
        ItemJournalLine."Document No." := pScanBuf."Document NO.";
        ItemJournalLine."Line No." := GetNextLineNo(pScanBuf."Journal Template Name", pScanBuf."Journal Batch Name", pScanBuf."Document NO.");
        ItemJournalLine.Validate("Item No.", pScanBuf."Item No.");
        ItemJournalLine.Validate("Location Code", pScanBuf."Location Code");
        ItemJournalLine.validate("Phys. Inventory", true);
        ItemJournalLine.Validate("Qty. (Phys. Inventory)", pScanBuf."Scanned Inventory");
        ItemJournalLine."Document No." := pScanBuf."Document NO.";
        ItemJournalLine."Posting Date" := pScanBuf."Inventory Date";
        ItemJournalLine."Is Inventory Inserted" := true;
        ItemJournalLine."From Scan" := true;
        ItemJournalLine."Variant Code" := pScanBuf."Variant Code";
        if ItemJournalLine.Insert(true) then begin
            if pScanBuf."Lot No." <> '' then
                InsertZeroCountTrackingLine(ItemJournalLine, pScanBuf."Lot No.", pScanBuf."Expiry Date", pScanBuf."Variant Code");
            ItemJournalLine."Is Imported" := true;
            ItemJournalLine.modify(true);
            CurrPage.Update(false);
            //pScanBuf."Journal Line No." := ItemJournalLine."Line No.";
        end;
    end;

    procedure InsertZeroCountTrackingLine(pItemJournalLine: Record "Item Journal Line"; pLotNo: code[50]; pExpiryDate: date; pVariantCode: code[10])
    var
        lReservationEntry: record "Reservation Entry";
    begin
        lReservationEntry.INIT;
        lReservationEntry."Entry No." := lReservationEntry.GetLastEntryNo() + 1;
        lReservationEntry.VALIDATE("Source ID", 'INVENTAIRE');
        lReservationEntry.VALIDATE("Source Batch Name", pItemJournalLine."Journal Batch Name");
        lReservationEntry.VALIDATE("Item No.", pItemJournalLine."Item No.");
        lReservationEntry.VALIDATE("Location Code", pItemJournalLine."Location Code");
        lReservationEntry."Item Tracking" := lReservationEntry."Item Tracking"::"Lot No.";
        lReservationEntry.VALIDATE("Lot No.", pLotNo);
        lReservationEntry.validate("Expiration Date", pExpiryDate);
        lReservationEntry."New Lot No." := pLotNo;
        lReservationEntry."New Expiration Date" := pExpiryDate;
        lReservationEntry."Variant Code" := pVariantCode;
        lReservationEntry.VALIDATE("Source Type", 83);
        lReservationEntry.VALIDATE("Source Ref. No.", pItemJournalLine."Line No.");
        lReservationEntry."Reservation Status" := lReservationEntry."Reservation Status"::Prospect;
        lReservationEntry.VALIDATE("Creation Date", WORKDATE);
        lReservationEntry."Expected Receipt Date" := WORKDATE;
        lReservationEntry."Created By" := USERID;
        lReservationEntry.Positive := TRUE;
        lReservationEntry.VALIDATE("Source Subtype", 2);
        lReservationEntry.Validate("Quantity (Base)", pItemJournalLine."Qty. (Phys. Inventory)");
        lReservationEntry.insert(true);
    end;

    procedure ResetItemBeforeReimport(pScanInventoryBuffer: record "Inventory Scan Buffer")
    var
        lItemJournalLine: Record "Item Journal Line";
        lReservationEntry: Record "Reservation Entry";
    begin
        lReservationEntry.Reset();
        lReservationEntry.setrange("Source ID", pScanInventoryBuffer."Journal Template Name");
        lReservationEntry.setrange("Source Batch Name", pScanInventoryBuffer."Journal Batch Name");
        lReservationEntry.setrange("Item No.", pScanInventoryBuffer."Item No.");
        lReservationEntry.setrange("Location Code", pScanInventoryBuffer."Location Code");
        lReservationEntry.SetRange("Variant Code", pScanInventoryBuffer."Variant Code");
        if lReservationEntry.FindSet() then
            lReservationEntry.DeleteAll();
        lItemJournalLine.Reset();
        lItemJournalLine.SetRange("Journal Template Name", pScanInventoryBuffer."Journal Template Name");
        lItemJournalLine.SetRange("Journal Batch Name", pScanInventoryBuffer."Journal Batch Name");
        lItemJournalLine.SetRange("Location Code", pScanInventoryBuffer."Location Code");
        lItemJournalLine.SetRange("Item No.", pScanInventoryBuffer."Item No.");
        lItemJournalLine.SetRange("Variant Code", pScanInventoryBuffer."Variant Code");
        lItemJournalLine.SetFilter("Is Imported", '%1', false);
        lItemJournalLine.SetFilter("From Scan", '%1', true);
        lItemJournalLine.SetFilter("Inventory correction", '%1', true);
        if lItemJournalLine.FindSet() then
            lItemJournalLine.DeleteAll();
    end;


    procedure GetNextLineNo(pJournalBatchTemplate: code[10]; pJournalBatchName: code[10]; pJournalDocumentNo: code[20]): integer
    var
        lItemJournalLine: record "Item Journal Line";
    begin
        lItemJournalLine.reset();
        lItemJournalLine.setrange("Journal Template Name", pJournalBatchTemplate);
        lItemJournalLine.setrange("Journal Batch Name", pJournalBatchName);
        lItemJournalLine.SetRange("Document No.", pJournalDocumentNo);
        if lItemJournalLine.FindLast() then
            exit(lItemJournalLine."Line No." + 10000)
        else
            exit(10000)
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UpdateInventoryVisibility();
        CurrPage.update(false);
    end;

    trigger OnOpenPage()
    begin
        UpdateInventoryVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateInventoryVisibility();
    end;

    procedure UpdateInventoryVisibility()
    var
        ItemJournalBatch: Record "Item Journal Batch";
    begin
        ShowIsImported := false;

        if ItemJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then
            if ItemJournalBatch."Scanner Inventory sheet" then begin
                ShowIsImported := true;
            end;
    end;

    var
        NotImportedIndicator: text;
        IsInventoryImported: Boolean;
        ShowIsImported: Boolean;




}

