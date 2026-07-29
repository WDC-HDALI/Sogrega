namespace sogrega.sogrega;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Location;
using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Tracking;

page 53002 "WDC Scan Transfer Lines"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Location Transfer Scan', FRA = 'Scan Transfert magasin';
    PageType = Document;


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                ShowCaption = false;
                field(BatchName; BatchName)
                {
                    ApplicationArea = all;
                    editable = false;
                    CaptionML = ENU = 'Batch Name', FRA = 'Nom Feuille';



                }
                field(FromLocation; FromLocation)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Captionml = ENU = 'Source Location', FRA = 'Magasin Source';

                }
                field(ToLocation; ToLocation)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Captionml = ENU = 'Destination Location', FRA = 'Magasin Destination';

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
                        lScannerManagement.ItemVerification(ItemNo);
                        lScannerManagement.CheckItemStockAvailability(ItemNo, FromLocation, LotNo, VariantCode, Quantity);
                        ShowVariantCode := lScannerManagement.IsVariantItem(ItemNo);
                        showlotNo := lScannerManagement.IsItemLotTracked(ItemNo);


                    end;
                }
                group(Variant)
                {
                    Visible = ShowVariantCode;
                    ShowCaption = false;
                    field(VariantCode; VariantCode)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
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
                            lScannerManagement: Codeunit "WDC Scanner Management";
                        begin
                            lScannerManagement.CheckItemStockAvailability(ItemNo, FromLocation, LotNo, VariantCode, Quantity);
                        end;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ItemLedgerEntry: Record "Item Ledger Entry";
                            LotLookupPage: Page "WDC Lookup Lot";
                            lerr01: TextConst ENU = 'You must specify the item No.', FRA = 'vous devez specifier le numéro d''article';
                        begin
                            if ItemNo = '' then
                                Error(lerr01);
                            ItemLedgerEntry.Reset();
                            ItemLedgerEntry.SetCurrentKey("Item No.", "Location Code", "Lot No.");
                            ItemLedgerEntry.SetRange("Item No.", ItemNo);
                            ItemLedgerEntry.SetRange("Location Code", FromLocation);
                            ItemLedgerEntry.SetRange(Open, true);
                            ItemLedgerEntry.SetFilter("Remaining Quantity", '<>%1', 0);
                            LotLookupPage.SetTableView(ItemLedgerEntry);
                            LotLookupPage.LookupMode(true);
                            if LotLookupPage.RunModal() = Action::LookupOK then begin
                                LotLookupPage.GetRecord(ItemLedgerEntry);
                                Text := ItemLedgerEntry."Lot No.";
                                LotNo := Text;
                            end
                            else
                                exit(false);
                            exit(true)
                        end;

                    }
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Quantity', FRA = 'Quantité';
                    trigger OnValidate()
                    var
                        lScannerManagement: Codeunit "WDC Scanner Management";
                        lerr01: textConst ENU = 'You must first enter the item number to be transferred', FRA = 'vous devez d''abord entrer le n° d''article à transférer';
                        lerr02: textConst ENU = 'You must first enter the Lot to be transferred', FRA = 'vous devez d''abord entrer le Lot à transférer';
                        lerr03: textConst ENU = 'The quantity to be transferred must not be zero.', FRA = 'La quantité à transférer ne doit pas être nulle.';
                    begin
                        if ItemNo = '' then
                            error(lerr01);
                        if (ShowLotNo = true) and (LotNo = '') then
                            error(lerr02);
                        if Quantity = 0 then
                            error(lerr03);
                        lScannerManagement.CheckItemStockAvailability(ItemNo, FromLocation, LotNo, VariantCode, Quantity);
                    end;
                }
                field(WorkCenterCode; WorkCenterCode)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Work Center Code', FRA = 'Centre de coût Code';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));
                    ;
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {

            action("PostTransferLocation")
            {
                ApplicationArea = All;
                CaptionML = FRA = 'Transferer vers Feuille', ENU = 'Transfer to Sheet';
                Image = Insert;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    lLocationTransfertScanMgt: Codeunit "WDC Scanner Management";
                    lLocationTransfertScanner: record "Reception Scan Buffer";
                    ltext01: TextConst ENU = 'Do you want to move the scanned lines to the reclassification sheet?', FRA = 'Souhaitez-vous déplacer les lignes scannées vers la feuille de reclassement ?';
                    lerr01: textConst ENU = 'The quantity to be transferred must not be zero.', FRA = 'La quantité à transférer ne doit pas être nulle.';
                begin
                    if not Confirm(ltext01, false) then
                        exit;
                    if Quantity = 0 then
                        Error(lerr01);
                    ScanEntryNo := 0;
                    ScanEntryNo := InsertScanLocationBuffer();
                    ValidateLocationTransfer(ScanEntryNo);
                    ItemNo := '';
                    LotNo := '';
                    ExpiryDate := 0D;
                    Quantity := 0;
                    WorkCenterCode := '';
                    ShowLotNo := false;
                    ShowVariantCode := false;
                    VariantCode := '';
                    CurrPage.update(false);
                end;
            }
        }
    }


    trigger OnOpenPage()
    var
    begin
        ShowLotNo := false;
        ShowVariantCode := false;
        CurrPage.update(false);

    end;

    procedure SetBatchNameAndLocationFrom(pBatchName: Code[20]; pLocationFrom: code[10]; pToLocation: code[10])
    begin
        BatchName := pBatchName;
        FromLocation := pLocationFrom;
        ToLocation := pToLocation;
    end;

    procedure InsertScanLocationBuffer(): Integer
    var
        lLocationTransfertScanBuff: record "Location Transfert Scan ";
    begin
        lLocationTransfertScanBuff.Init();
        lLocationTransfertScanBuff."Entry No." := lLocationTransfertScanBuff.GetNextEntryNo();
        lLocationTransfertScanBuff."Document No." := BatchName;
        lLocationTransfertScanBuff."User ID" := UserId;
        lLocationTransfertScanBuff."Item No." := ItemNo;
        lLocationTransfertScanBuff."Variant Code" := VariantCode;
        lLocationTransfertScanBuff."Lot No." := LotNo;
        lLocationTransfertScanBuff."work Center Code" := WorkCenterCode;
        lLocationTransfertScanBuff.Quantity := Quantity;
        lLocationTransfertScanBuff."From Location" := FromLocation;
        lLocationTransfertScanBuff."To Location" := ToLocation;
        if lLocationTransfertScanBuff.insert() then
            exit(lLocationTransfertScanBuff."Entry No.");

    end;

    procedure ValidateLocationTransfer(pScanEntryNo: integer)
    var
        lTransfertScanBuf: Record "Location Transfert Scan ";
        ItemJnlLine: Record "Item Journal Line";

        text01: TextConst ENU = 'the line %1 is correctly inserted in the transfer sheet %2', FRA = 'la ligne %1 est bien insérée dans la feuille transfert %2';
    begin
        ItemJnlLine.Init();
        ItemJnlLine."Journal Template Name" := 'TRANSFERT';
        ItemJnlLine."Journal Batch Name" := BatchName;
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::Transfer;
        ItemJnlLine."Line No." := GetNextItemJnlLineNo('TRANSFERT', BatchName);
        ItemJnlLine.Validate("Posting Date", WorkDate());
        ItemJnlLine.Validate("Document No.", BatchName);
        ItemJnlLine.Validate("Item No.", ItemNo);
        ItemJnlLine.validate("Variant Code", VariantCode);
        ItemJnlLine.Validate(Quantity, Quantity);
        ItemJnlLine.Validate("Location Code", FromLocation);
        ItemJnlLine.Validate("New Location Code", ToLocation);
        if LotNo <> '' then begin
            ItemJnlLine.Validate("Lot No.", LotNo);
        end;
        ItemJnlLine.validate("Shortcut Dimension 2 Code", WorkCenterCode);
        if pScanEntryNo <> 0 then begin
            ItemJnlLine."Applied Scan Entry No." := pScanEntryNo;
            ItemJnlLine.IsScanned := True;

            if ItemJnlLine.Insert(true) then begin
                CreateItemTrackingForJournal(ItemJnlLine);
                if lTransfertScanBuf.get(pScanEntryNo) then begin
                    lTransfertScanBuf."Inserted to Journal" := true;
                    lTransfertScanBuf.modify()
                end;
            end;
        end;
        Message(text01, ItemJnlLine."Line No.", BatchName);
    end;

    procedure GetNextItemJnlLineNo(JnlTemplate: Code[20]; JnlBatch: Code[20]): Integer
    var
        lItemJnlLine: Record "Item Journal Line";
    begin
        lItemJnlLine.Reset();
        lItemJnlLine.SetRange("Journal Template Name", JnlTemplate);
        lItemJnlLine.SetRange("Journal Batch Name", JnlBatch);
        if lItemJnlLine.FindLast() then
            exit(lItemJnlLine."Line No." + 10000)
        else
            exit(10000);
    end;

    procedure CreateItemTrackingForJournal(ItemJnlLine: Record "Item Journal Line")
    var
        ReserEntry: Record "Reservation Entry";

    begin
        if LotNo = '' then
            exit;
        ReserEntry.init();
        ReserEntry."Entry No." := ReserEntry.GetLastEntryNo() + 1;
        ReserEntry."Item No." := ItemNo;
        ReserEntry."Location Code" := FromLocation;
        ReserEntry."Variant Code" := VariantCode;
        ReserEntry.validate("Quantity (Base)", -Quantity);
        ReserEntry.Validate(Quantity, -Quantity);
        ReserEntry."Reservation Status" := ReserEntry."Reservation Status"::Prospect;
        ReserEntry."Creation Date" := WorkDate();
        ReserEntry."Source Type" := 83;
        ReserEntry."Source Subtype" := 4;
        ReserEntry."Source ID" := ItemJnlLine."Journal Template Name";
        ReserEntry."Source Batch Name" := BatchName;
        ReserEntry."Source Ref. No." := ItemJnlLine."Line No.";
        ReserEntry.validate("Lot No.", LotNo);
        ReserEntry.validate("New Lot No.", LotNo);
        ReserEntry.Positive := false;
        ReserEntry."Item Tracking" := ReserEntry."Item Tracking"::"Lot No.";
        ReserEntry.Insert(true);
    end;


    var
        ShowLotNo: Boolean;
        BatchName: Code[10];
        FromLocation: Code[10];
        ItemNo: code[20];
        LotNo: code[50];
        ExpiryDate: date;
        Quantity: decimal;
        WorkCenterCode: code[20];
        VariantCode: code[10];
        ToLocation: code[10];
        ScanEntryNo: Integer;
        ShowVariantCode: Boolean;

}
