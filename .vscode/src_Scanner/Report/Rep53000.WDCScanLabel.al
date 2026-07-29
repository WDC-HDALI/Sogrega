namespace sogrega.sogrega;
using Microsoft.Warehouse.Document;
using Microsoft.Inventory.Ledger;
using System.Text;
using Microsoft.Warehouse.History;
using Microsoft.Foundation.Company;
using System.Utilities;
using Microsoft.Purchases.Document;

report 53000 "WDC Scan Label"
{
    CaptionML = ENU = 'Label', FRA = 'Étiquette';
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Scanner/report/RDLC/Labelcopieorder.rdlc';
    PreviewMode = PrintLayout;
    //UseRequestPage = false;

    dataset
    {
        dataitem("WarehouseReceiptHeader"; "Posted Whse. Receipt Header")
        {
            // DataItemTableView = SORTING("No.")
            //                     ORDER(Ascending);

            dataitem("warehouseReceip"; "Posted Whse. Receipt Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemLinkReference = WarehouseReceiptHeader;
                DataItemTableView = sorting("No.", "Line No.") order(ascending);
                column(No_; "No.")
                {

                }
                column(Source_Document; "Source Document")
                {

                }
                column(Source_No_; "Source No.")
                {

                }
                column(Source_Line_No_; "Source Line No.")
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
                column(Quantity; "Qty Par")
                {

                }
                column(Item_No_; "Item No.")
                {

                }
                column(LotNo; LotNo)
                {

                }
                column(ExpirationDate; ExpirationDate)
                {

                }
                column(NoLabels; "No. of Labels To Scan")
                {

                }
                column(VendorNo; PurchaseHeader."Buy-from Vendor No.")
                {

                }
                column(VendorName; PurchaseHeader."Buy-from Vendor Name")
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
                column(Description; Description)
                {

                }
                column(DesriptionBL; DesriptionBL)
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
                        SETRANGE(Number, 1, warehouseReceip."No. of Labels To Scan");
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    ItemLedgerEntry: record "Item Ledger Entry";
                    BarcodeSymbolygy: Enum "Barcode Symbology";
                    BracodesFontProvider: Interface "Barcode Font Provider";
                    BarecodeString1: Text;
                    BarecodeString2: Text;
                    BarecodeString3: Text;

                begin
                    Clear(BracodesFontProvider);
                    Clear(BarcodeSymbolygy);
                    clear(ItemNoBarreCode);
                    clear(LotNoBarreCode);
                    clear(QuantityBarreCode);
                    clear(BarecodeString1);
                    clear(BarecodeString2);
                    clear(BarecodeString3);
                    PurchaseHeader.reset();
                    if PurchaseHeader.get(PurchaseHeader."Document Type"::Order, "Source No.") then;
                    BracodesFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeSymbolygy := Enum::"Barcode Symbology"::Code128;
                    BarecodeString1 := "Item No.";
                    BarecodeString3 := Format("Qty Par", 0, '<Integer>');
                    BracodesFontProvider.ValidateInput(BarecodeString1, BarcodeSymbolygy);
                    ItemNoBarreCode := BracodesFontProvider.EncodeFont(BarecodeString1, BarcodeSymbolygy);
                    BracodesFontProvider.ValidateInput(BarecodeString3, BarcodeSymbolygy);
                    QuantityBarreCode := BracodesFontProvider.EncodeFont(BarecodeString3, BarcodeSymbolygy);
                    LotNo := '';
                    ExpirationDate := 0D;
                    ItemLedgerEntry.reset();
                    ItemLedgerEntry.setrange("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                    ItemLedgerEntry.setrange("Document Type", ItemLedgerEntry."Document Type"::"Purchase Receipt");
                    ItemLedgerEntry.SetRange("Document No.", warehouseReceip."Posted Source No.");
                    if ItemLedgerEntry.FindSet() then begin
                        LotNo := ItemLedgerEntry."Lot No.";
                        ExpirationDate := ItemLedgerEntry."Expiration Date";
                    end;
                    if LotNo <> '' then begin
                        BarecodeString2 := LotNo;
                        BracodesFontProvider.ValidateInput(BarecodeString2, BarcodeSymbolygy);
                        LotNoBarreCode := BracodesFontProvider.EncodeFont(BarecodeString2, BarcodeSymbolygy);
                    end
                end;
            }
        }

    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        LotNo: code[50];
        ExpirationDate: date;
        ItemNoBarreCode: Text;
        QuantityBarreCode: Text;
        LotNoBarreCode: Text;
        PurchaseHeader: record "Purchase Header";
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
}
