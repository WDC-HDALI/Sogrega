namespace sogrega.sogrega;

using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.Company;
using System.Utilities;
using System.Text;
using Microsoft.Inventory.Location;

report 53001 "Inventory Label"
{
    CaptionML = ENU = 'Inventory Label Print', FRA = 'Impression d''étiquettes d''inventaire';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Scanner/report/RDLC/InventoryLabel.rdlc';
    PreviewMode = PrintLayout;
    UseRequestPage = true;
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Item No.", "Location Code", "Lot No.") where(Open = filter(true), "Remaining Quantity" = filter(<> 0));
            column(Item_No_; "Item No.")
            {

            }
            column(Location_Code; "Location Code")
            {

            }
            column(Lot_No_; "Lot No.")
            {

            }
            column(InventryQty; InventryQty)
            {

            }
            column(Quantity; QtyPar)
            {

            }
            column(LabelCount; LabelCount)
            {

            }
            column(Document_No_; "Document No.")
            {

            }
            column(Description; item.Description)
            {

            }
            column(Expiration_Date; "Expiration Date")
            {

            }
            column(Companypicture; CompanyInformation.Picture)
            {

            }
            column(VendorNOLBL; VendorNOLBL)
            {

            }
            column(VendorBameLBL; VendornameLBL)
            {

            }
            column(ItemNoLBL; ItemNoLBL)
            {

            }
            column(LotNoLBL; LotNoLBL)
            {

            }
            column(QuantityLBL; QuantityLBL)
            {

            }
            column(OrderNoLBL; OrderNoLBL)
            {

            }
            column(ReceiptNoLBL; ReceiptNoLBL)
            {

            }
            column(ExpirationDateLBL; ExpirationDateLBL)
            {

            }
            column(DesriptionBL; DesriptionBL)
            {

            }

            column(QuantityBarreCode; QuantityBarreCode)
            {

            }
            column(Item_No_BarreCode; ItemNoBarreCode)
            {

            }
            column(LotNoBarreCode; LotNoBarreCode)
            {

            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(LabelNo; Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    SETRANGE(Number, 1, LabelCount);
                end;
            }


            trigger OnPreDataItem()
            var
                Item: record Item;
                lerr01: TextConst ENU = 'Item %1 is managed by Lot. You must specify a Lot No.', FRA = 'L''article %1 est géré par lot. Vous devez préciser un N° Lot.';
            begin
                if LocationCode = '' then
                    error('vous devez specifier le magasin');
                if ItemNo <> '' then begin
                    if item.get(ItemNo) then begin
                        if item."Item Tracking Code" = 'LOT' then begin
                            if LotNo = '' then
                                Error(lerr01, Item."No.");
                        end;
                    end;
                end;
                if LocationCode <> '' then
                    ItemLedgerEntry.SetRange("Location Code", LocationCode);
                if ItemNo <> '' then
                    ItemLedgerEntry.setrange("Item No.", ItemNo);
                if LotNo <> '' then
                    ItemLedgerEntry.SetRange("Lot No.", LotNo);
            end;

            trigger OnAfterGetRecord()
            var
                ItemLedgerEntry: record "Item Ledger Entry";
                BarcodeSymbolygy: Enum "Barcode Symbology";
                BracodesFontProvider: Interface "Barcode Font Provider";
                BarecodeString1: Text;
                BarecodeString2: Text;
                BarecodeString3: Text;

            begin
                if item.get("Item No.") then;
                Clear(BracodesFontProvider);
                Clear(BarcodeSymbolygy);
                clear(ItemNoBarreCode);
                clear(LotNoBarreCode);
                clear(QuantityBarreCode);
                clear(BarecodeString1);
                clear(BarecodeString2);
                clear(BarecodeString3);
                BracodesFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbolygy := Enum::"Barcode Symbology"::Code128;
                BarecodeString1 := "Item No.";
                BarecodeString3 := Format(QtyPar, 0, '<Integer>');
                BracodesFontProvider.ValidateInput(BarecodeString1, BarcodeSymbolygy);
                ItemNoBarreCode := BracodesFontProvider.EncodeFont(BarecodeString1, BarcodeSymbolygy);
                BracodesFontProvider.ValidateInput(BarecodeString3, BarcodeSymbolygy);
                QuantityBarreCode := BracodesFontProvider.EncodeFont(BarecodeString3, BarcodeSymbolygy);
                if "Lot No." <> '' then begin
                    BarecodeString2 := "Lot No.";
                    BracodesFontProvider.ValidateInput(BarecodeString2, BarcodeSymbolygy);
                    LotNoBarreCode := BracodesFontProvider.EncodeFont(BarecodeString2, BarcodeSymbolygy);
                end
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(LocationCode; LocationCode)
                    {
                        CaptionML = ENU = 'Location Code', FRA = 'Code Magasin';
                        ApplicationArea = All;
                        TableRelation = Location;
                    }
                    field(ItemNo; ItemNo)
                    {
                        CaptionML = ENU = 'Item No.', FRA = 'N° article';
                        ApplicationArea = All;
                        TableRelation = Item;
                        trigger OnValidate()
                        var
                            lerr01: TextConst ENU = 'You must specify the Location Code', FRA = 'vous devez specifier le code magasin';
                        begin
                            if LocationCode = '' then
                                error(lerr01);
                            InventoryByLocation := 0;
                            if item.get(ItemNo) then begin
                                if LocationCode <> '' then
                                    item.SetFilter("Location Filter", LocationCode);
                                if LotNo <> '' then
                                    item.SetFilter("Lot No. Filter", LotNo);
                                item.CalcFields(Inventory);
                                InventoryByLocation := item.Inventory;
                                InventryQty := inventoryByLocation;
                            end
                        end;
                    }

                    field(LotNo; LotNo)
                    {
                        CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            InventoryByLocation := 0;
                            if item.get(ItemNo) then begin
                                if LocationCode <> '' then
                                    item.SetFilter("Location Filter", LocationCode);
                                if LotNo <> '' then
                                    item.SetFilter("Lot No. Filter", LotNo);
                                item.CalcFields(Inventory);
                                InventoryByLocation := item.Inventory;
                                InventryQty := inventoryByLocation;
                            end
                        end;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ItemLedgerEntry: Record "Item Ledger Entry";
                            LotLookupPage: Page "WDC Lookup Lot";
                            lerr01: TextConst ENU = 'You must specify the item No.', FRA = 'vous devez specifier le numéro d''article';
                            lerr02: TextConst ENU = 'You must specify the Location Code', FRA = 'vous devez specifier le code magasin';
                        begin
                            if ItemNo = '' then
                                Error(lerr01);
                            if LocationCode = '' then
                                Error(lerr02);
                            ItemLedgerEntry.Reset();
                            ItemLedgerEntry.SetCurrentKey("Item No.", "Location Code", "Lot No.");
                            ItemLedgerEntry.SetRange("Item No.", ItemNo);
                            ItemLedgerEntry.SetRange("Location Code", LocationCode);
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
                    field(InventryQty; InventryQty)
                    {
                        CaptionML = ENU = 'Quantity', FRA = 'Quantité';
                        ApplicationArea = All;
                        trigger OnValidate()
                        var
                            ItemLedgerEntry: record "Item Ledger Entry";
                            ItemInventory: decimal;
                            lItem: record Item;
                            lerr01: TextConst ENU = 'Item %1 is managed by Lot. You must specify a Lot No.', FRA = 'L''article %1 est géré par lot. Vous devez préciser un N° Lot.';
                            lerr02: TextConst ENU = 'You cannot exceed the current stock of this item %1', FRA = 'vous ne pouvez pas depasser le stock actuel de cet article %1';
                        begin
                            if ItemNo <> '' then begin
                                if lItem.get(ItemNo) then begin
                                    if lItem."Item Tracking Code" = 'LOT' then begin
                                        if LotNo = '' then
                                            Error(lerr01, lItem."No.");
                                    end;
                                end;
                            end;
                            ItemInventory := 0;
                            ItemLedgerEntry.reset();
                            ItemLedgerEntry.SetCurrentKey("Item No.", "Location Code", "Lot No.");
                            ItemLedgerEntry.SetRange("Item No.", ItemNo);
                            ItemLedgerEntry.SetRange("Location Code", LocationCode);
                            ItemLedgerEntry.SetFilter(Open, 'true');
                            ItemLedgerEntry.SetFilter("Remaining Quantity", '<>%1', 0);
                            if LotNo <> '' then
                                ItemLedgerEntry.SetRange("Lot No.", LotNo);
                            if ItemLedgerEntry.FindSet() then
                                repeat
                                    ItemInventory += ItemLedgerEntry."Remaining Quantity"
                                until ItemLedgerEntry.next() = 0;
                            if InventryQty > ItemInventory then
                                error(lerr02, ItemNo);


                        end;
                    }
                    field(QtyPar; QtyPar)
                    {
                        CaptionML = ENU = 'Qty Per', FRA = 'Qty Par';
                        ApplicationArea = All;
                    }
                    field(LabelCount; LabelCount)
                    {
                        ApplicationArea = All;
                        CaptionML = ENU = 'Label Number', FRA = 'Nombre d''étiquettes';
                        trigger OnValidate()
                        var
                            lerr01: TextConst ENU = 'Please enter the "Quantity per" before continuing.', FRA = 'Veuillez saisir la « Quantité par » avant de continuer.';
                            lerr02: TextConst ENU = 'The total quantity (%1 * %2) is different from the quantity %3',
                       FRA = 'La quantité totale (%1 * %2) est différente de la quantité %3';
                        begin
                            if QtyPar = 0 then
                                error(lerr01);
                            if (LabelCount * QtyPar) <> InventryQty then
                                error(lerr02, QtyPar, LabelCount, InventryQty);

                        end;
                    }


                }
            }

        }
        actions
        {
            area(Processing)
            {
            }
        }
        trigger OnOpenPage()
        var
        begin
            QtyPar := 1;
        end;


    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        ItemNo: code[20];
        LocationCode: code[10];
        LotNo: code[50];
        InventryQty: Decimal;
        QtyPar: Decimal;
        LabelCount: Integer;
        item: record item;
        CompanyInformation: Record "Company Information";
        VendorNOLBl: TextConst ENU = 'Vendor No.', FRA = 'N° fournisseur';
        VendornameLBL: TextConst ENU = 'Vendor Name', FRA = 'Nom fournisseur';
        OrderNoLBL: TextConst ENU = 'Order No. :', FRA = 'N° commande';
        ReceiptNoLBL: TextConst ENU = 'Receipt No.', FRA = 'N° réception';
        ItemNoLBL: TextConst ENU = 'Item No.', FRA = 'N° article';
        LotNoLBL: TextConst ENU = 'Lot No.', FRA = 'N° lot';
        DesriptionBL: TextConst ENU = 'Description', FRA = 'Description';
        QuantityLBL: TextConst ENU = 'Quantity', FRA = 'Quantité';
        ExpirationDateLBL: TextConst ENU = 'Expiration Date', FRA = 'date d''expiration';
        ItemNoBarreCode: Text;
        QuantityBarreCode: Text;
        LotNoBarreCode: Text;
        InventoryByLocation: Decimal;
}
