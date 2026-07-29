namespace sogrega.sogrega;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Ledger;

page 53007 "WDC Scan inventory Lines"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Inventory Scan Lines', FRA = 'Scan lignes inventaire';
    PageType = Document;


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                ShowCaption = false;
                field(InventoryBatchNameBatchName; InventoryBatchName)
                {
                    ApplicationArea = all;
                    editable = false;
                    CaptionML = ENU = 'Inventory Batch Name', FRA = 'Nom Feuille d''inventaire';



                }
                field(InventoryLocation; InventoryLocation)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Captionml = ENU = 'Location Code', FRA = 'Code magasin';

                }
                field(ItemNo; ItemNo)
                {
                    ApplicationArea = all;
                    TableRelation = Item."No.";
                    Captionml = ENU = 'Item No.', FRA = 'N° article';
                    trigger OnValidate()
                    var
                        lScannerManagement: Codeunit "WDC Scanner Management";
                    begin
                        Showvariante := lScannerManagement.IsVariantItem(ItemNo);
                        showlotNo := lScannerManagement.IsItemLotTracked(ItemNo);

                    end;
                }
                group(variant)
                {
                    Visible = Showvariante;
                    ShowCaption = false;
                    field(VariantCode; VariantCode)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Variant Code', FRA = 'code variante';

                    }
                }

                group(Lot)
                {
                    Visible = ShowLotNo;
                    ShowCaption = false;

                    field(LotNo; LotNo)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
                        trigger onvalidate()
                        var
                        begin
                            ExpiryDate := GetLotAssociatedExpiryDate(ItemNo, LotNo, InventoryLocation);
                            if ExpiryDate <> 0D then
                                ExipryDateFromLot := true
                            else
                                ExipryDateFromLot := false;
                        end;

                    }
                    field(ExpiryDate; ExpiryDate)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Expiry Date', FRA = 'Date d''expiration';
                        Editable = not ExipryDateFromLot;
                    }
                }
                field(ScannedQuantity; ScannedQuantity)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Scanned Quantity', FRA = 'Quantité scannée';
                    trigger OnValidate()
                    var
                        lScannerManagement: Codeunit "WDC Scanner Management";
                        lerr01: textConst ENU = 'The scanned quantity must be greater than zero.', FRA = 'La quantité scannée doit être supérieure à zéro.';
                        lerr02: textConst ENU = 'You must first scan the item number ', FRA = 'vous devez d''abord scanner  le n° d''article ';
                        lerr03: textConst ENU = 'You must specify the lot associated with this item.', FRA = 'Vous devez spécifier le numéro de lot associé à cet article.';
                        lerr04: textConst ENU = 'You must specify the Expiry date for the lot associated with this item.', FRA = 'Vous devez spécifier la date d''expiration pour le lot associé à cet article.';
                    begin
                        if ScannedQuantity <= 0 then
                            Error(lerr01);
                        if ItemNo = '' then
                            error(lerr02);
                        if (ShowLotNo = true) and (LotNo = '') then
                            error(lerr03);
                        if (ShowLotNo = true) and (ExpiryDate = 0D) then
                            error(lerr04);

                    end;
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {

            action("ScanInventoryLine")
            {
                ApplicationArea = All;
                CaptionML = FRA = 'Scanner inventaire', ENU = 'Scan Inventory';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    lScanMgt: Codeunit "WDC Scanner Management";
                    lInventoryScannBuffer: record "Inventory Scan Buffer";
                    lItemJournalLine: record "Item Journal Line";
                    IsImportedBatch: Boolean;
                    item: record item;
                    lerr01: textConst ENU = 'It is not possible to scan an inventory sheet that has not been initialized.', FRA = 'Il n''est pas possible de scanner une feuille d''inventaire qui n''a pas été initialisée.';
                    lerr02: textConst ENU = 'It is not possible to scan an inventory sheet that has not been fully initialized.', FRA = 'Il n''est pas possible de scanner une feuille d''inventaire qui n''a pas été entièrement initialisée.';
                    lerr03: textConst ENU = 'You must first scan the item number ', FRA = 'vous devez d''abord scanner  le n° d''article ';
                    lerr04: textConst ENU = 'You must specify the lot information  associated with this item.', FRA = 'Vous devez spécifier les informations de lot associé à cet article.';
                    lerr05: textConst ENU = 'The scanned quantity must be greater than zero.', FRA = 'La quantité scannée doit être supérieure à zéro.';


                begin
                    DocumentNo := '';
                    IsImportedBatch := false;
                    GetDocumentNo(InventoryBatchName, InventoryLocation);
                    if lScanMgt.NotInitializedBatch(InventoryBatchName, InventoryLocation, DocumentNo) then
                        error(lerr01);
                    if lScanMgt.CanInitializeInventory(InventoryBatchName, InventoryLocation, DocumentNo) then
                        error(lerr02);
                    if ItemNo = '' then
                        error(lerr03);
                    if (ShowLotNo = true) and ((LotNo = '') or (ExpiryDate = 0D)) then
                        error(lerr04);
                    if ScannedQuantity < 0 then
                        Error(lerr05);
                    lInventoryScannBuffer.reset();
                    lInventoryScannBuffer.setrange("Journal Template Name", 'INVENTAIRE');
                    lInventoryScannBuffer.SetRange("Journal Batch Name", InventoryBatchName);
                    lInventoryScannBuffer.SetRange("Location Code", InventoryLocation);
                    lInventoryScannBuffer.SetRange("Item No.", ItemNo);
                    lInventoryScannBuffer.SetRange("Document NO.", DocumentNo);
                    if (ShowLotNo = true) and (LotNo <> '') then
                        lInventoryScannBuffer.SetRange("Lot No.", LotNo);
                    if (Showvariante = true) and (VariantCode <> '') then
                        lInventoryScannBuffer.SetRange("Variant Code", VariantCode);
                    if lInventoryScannBuffer.FindFirst() then begin
                        lInventoryScannBuffer.validate("Scanned Inventory", lInventoryScannBuffer."Scanned Inventory" + ScannedQuantity);//MD310326
                        lInventoryScannBuffer."is Scanned " := true;
                        lInventoryScannBuffer.modify();
                        if lInventoryScannBuffer."Is Imported" = true then begin
                            SetImportedFalse(lInventoryScannBuffer);
                            resetItemJournalImport(lInventoryScannBuffer);
                        end;
                    end
                    else begin
                        lInventoryScannBuffer.Reset();
                        lInventoryScannBuffer.SetRange("Journal Template Name", 'INVENTAIRE');
                        lInventoryScannBuffer.SetRange("Journal Batch Name", InventoryBatchName);
                        lInventoryScannBuffer.SetRange("Location Code", InventoryLocation);
                        lInventoryScannBuffer.SetRange("Document No.", DocumentNo);
                        lInventoryScannBuffer.SetRange("Item No.", ItemNo);
                        lInventoryScannBuffer.setrange("Variant Code", VariantCode);
                        if lInventoryScannBuffer.FindSet() then begin
                            SetImportedFalse(lInventoryScannBuffer);
                            resetItemJournalImport(lInventoryScannBuffer);
                        end;
                        lInventoryScannBuffer.Init();
                        lInventoryScannBuffer."Entry No." := lInventoryScannBuffer.GetNextEntryNo();
                        lInventoryScannBuffer."Journal Template Name" := 'INVENTAIRE';
                        lInventoryScannBuffer."Journal Batch Name" := InventoryBatchName;
                        lInventoryScannBuffer."Document No." := DocumentNo;
                        lInventoryScannBuffer."Item No." := ItemNo;
                        if item.get(lInventoryScannBuffer."Item No.") then
                            lInventoryScannBuffer.Description := item.Description;
                        lInventoryScannBuffer."Location Code" := InventoryLocation;
                        if LotNo <> '' then begin
                            lInventoryScannBuffer."Lot No." := LotNo;
                            lInventoryScannBuffer."Expiry Date" := ExpiryDate;
                        end;
                        if VariantCode <> '' then
                            lInventoryScannBuffer."Variant Code" := VariantCode;
                        lInventoryScannBuffer."Journal Line No." := GetLineNoForScan(InventoryBatchName, InventoryLocation, DocumentNo, ItemNo);
                        lInventoryScannBuffer.Inventory := 0;
                        lInventoryScannBuffer.validate("Scanned Inventory", ScannedQuantity);
                        lInventoryScannBuffer."USERID " := UserId;
                        //lInventoryScannBuffer.ScanDate := WorkDate();
                        lInventoryScannBuffer."Inventory Date" := GetInventoryDateForScan(InventoryBatchName, InventoryLocation, DocumentNo);
                        lInventoryScannBuffer.InsertedFromScan := true;
                        lInventoryScannBuffer."is Scanned " := true;
                        // if lScanMgt.IsVariantItem(ItemNo) then
                        //     lInventoryScannBuffer."Variant Item" := true;
                        lInventoryScannBuffer.Insert(true);
                    end;
                    ItemNo := '';
                    LotNo := '';
                    ExpiryDate := 0D;
                    ScannedQuantity := 0;
                    VariantCode := '';
                    Showvariante := false;
                    ShowLotNo := false;
                    ExipryDateFromLot := false;
                    CurrPage.Update(false);
                end;
            }
        }
    }


    trigger OnOpenPage()
    var
    begin
        ShowLotNo := false;
        Showvariante := false;
        CurrPage.update(false);

    end;

    procedure SetInventoryBatchNameAndLocationcode(pBatchName: Code[20]; pLocation: code[10])
    begin
        InventoryBatchName := pBatchName;
        InventoryLocation := pLocation;
    end;

    procedure GetDocumentNo(pBatchName: Code[20]; pLocation: code[10])
    var
        lItemJournalLine: record "Item Journal Line";
    begin
        lItemJournalLine.reset();
        lItemJournalLine.setrange("Journal Template Name", 'INVENTAIRE');
        lItemJournalLine.SetRange("Journal Batch Name", InventoryBatchName);
        lItemJournalLine.SetRange("Location Code", InventoryLocation);
        if lItemJournalLine.FindLast() then
            DocumentNo := lItemJournalLine."Document No.";
    end;

    procedure GetLineNoForScan(pBatchName: Code[20]; pLocation: code[10]; pDocumentNo: code[20]; pItemNo: code[20]): Integer
    var
        lInventoryScanBuffer: record "Inventory Scan Buffer";
    begin
        lInventoryScanBuffer.reset();
        lInventoryScanBuffer.setrange("Journal Template Name", 'INVENTAIRE');
        lInventoryScanBuffer.SetRange("Journal Batch Name", pBatchName);
        lInventoryScanBuffer.SetRange("Document NO.", pDocumentNo);
        lInventoryScanBuffer.SetRange("Location Code", pLocation);
        lInventoryScanBuffer.SetRange("Item No.", pItemNo);
        if lInventoryScanBuffer.findfirst() then
            exit(lInventoryScanBuffer."Journal Line No.");
    end;

    procedure GetInventoryDateForScan(pBatchName: Code[20]; pLocation: code[10]; pDocumentNo: code[20]): Date
    var
        lItemJournalLine: record "Item Journal Line";
    begin
        lItemJournalLine.reset();
        lItemJournalLine.setrange("Journal Template Name", 'INVENTAIRE');
        lItemJournalLine.SetRange("Journal Batch Name", pBatchName);
        lItemJournalLine.SetRange("Location Code", pLocation);
        lItemJournalLine.SetRange("Document NO.", pDocumentNo);
        if lItemJournalLine.FindLast() then
            exit(lItemJournalLine."Posting Date");
    end;

    procedure SetImportedFalse(pScanInventoryBuffer: record "Inventory Scan Buffer")
    var

        lInventoryScanBuffer: record "Inventory Scan Buffer";
    begin
        lInventoryScanBuffer.reset();
        lInventoryScanBuffer.setrange("Journal Template Name", 'INVENTAIRE');
        lInventoryScanBuffer.SetRange("Journal Batch Name", pScanInventoryBuffer."Journal Batch Name");
        lInventoryScanBuffer.SetRange("Document NO.", pScanInventoryBuffer."Document NO.");
        lInventoryScanBuffer.SetRange("Location Code", pScanInventoryBuffer."Location Code");
        lInventoryScanBuffer.SetRange("Item No.", pScanInventoryBuffer."Item No.");
        lInventoryScanBuffer.SetRange("Variant Code", pScanInventoryBuffer."Variant Code");
        lInventoryScanBuffer.ModifyAll(lInventoryScanBuffer."Is Imported", false, true);
    end;

    procedure resetItemJournalImport(pScanInventoryBuffer: record "Inventory Scan Buffer")
    var
        lItemJournalLine: record "Item Journal Line";
    begin
        lItemJournalLine.setrange("Journal Template Name", pScanInventoryBuffer."Journal Template Name");
        lItemJournalLine.SetRange("Journal Batch Name", pScanInventoryBuffer."Journal Batch Name");
        lItemJournalLine.SetRange("Location Code", pScanInventoryBuffer."Location Code");
        lItemJournalLine.SetRange("Item No.", pScanInventoryBuffer."Item No.");
        lItemJournalLine.SetRange("Document NO.", pScanInventoryBuffer."Document NO.");
        lItemJournalLine.SetRange("Variant Code", pScanInventoryBuffer."Variant Code");
        lItemJournalLine.ModifyAll("Is Imported", false, true);

    end;

    procedure GetLotAssociatedExpiryDate(pItemNo: code[20]; pLotNo: code[50]; pLocationCode: code[10]): Date
    var
        lItemLedgerEntry: record "Item Ledger Entry";
    begin
        lItemLedgerEntry.reset();
        lItemLedgerEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.", "Package No.");
        lItemLedgerEntry.SetRange("Item No.", pItemNo);
        lItemLedgerEntry.SetRange(open, true);
        lItemLedgerEntry.SetRange("Lot No.", pLotNo);
        lItemLedgerEntry.SetRange("Location Code", pLocationCode);
        lItemLedgerEntry.SetFilter("Remaining Quantity", '>%1', 0);
        if lItemLedgerEntry.FindSet() then
            exit(lItemLedgerEntry."Expiration Date");
    end;




    var
        ShowLotNo: Boolean;
        InventoryBatchName: Code[10];
        InventoryLocation: Code[10];
        DocumentNo: code[20];
        ItemNo: code[20];
        LotNo: code[50];
        ExpiryDate: date;
        ScannedQuantity: decimal;
        ScanEntryNo: Integer;
        Showvariante: Boolean;
        VariantCode: code[10];
        ExipryDateFromLot: Boolean;

}


