namespace sogrega.sogrega;

using Microsoft.Manufacturing.Document;
using System.Utilities;
using Microsoft.Sales.Document;
using System.Text;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.Company;
//*************Documentation***************
//WDC01  WDC.HG  22/04/26  Create Current Object 

report 50096 "WDC Finished Product Label"
{
    CaptionML = ENU = 'Finished Product Label', FRA = 'étiquette Produit fini';
    RDLCLayout = './.vscode/src/Report/RDLC/FinishedProductLabel.rdlc';
    DefaultLayout = RDLC;
    ApplicationArea = all;
    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemLink = "Prod. Order No." = FIELD("No.");
                DataItemLinkReference = "Production Order";
                DataItemTableView = SORTING(Status, "Prod. Order No.", "Line No.")
                                        ORDER(Ascending);

                column(No_ProductionOrder; "Production Order"."No.")
                {
                }
                column(SalesOrderNo; "Production Order"."Sales Order No.")
                {

                }
                column(ItemNo; "Prod. Order Line"."Item No.")
                {
                }
                column(ItemReferenceNo; "Prod. Order Line"."Reference No.")
                {

                }
                column(ItemDescription; "Prod. Order Line".Description)
                {
                }
                column(CompImage; CompanyInformation.Picture)
                {
                }
                column(PrintDateTime; CurrentDateTime)
                {

                }
                column(CustomerName; SalesHeader."Sell-to Customer Name")
                {

                }
                column(ProductionOrderNoBarCode; ProductionOrderNoBarCode)
                {

                }
                column(ItemReferenceBarCode; ItemReferenceBarCode)
                {

                }
                trigger OnAfterGetRecord()
                var
                    BarcodeSymbolygy: Enum "Barcode Symbology";
                    BracodesFontProvider: Interface "Barcode Font Provider";
                    BarecodeString1: Text;
                    BarecodeString2: Text;
                begin
                    Clear(BracodesFontProvider);
                    Clear(BarcodeSymbolygy);
                    clear(ProductionOrderNoBarCode);
                    clear(ItemReferenceBarCode);
                    clear(BarecodeString1);
                    clear(BarecodeString2);
                    BracodesFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeSymbolygy := Enum::"Barcode Symbology"::Code128;
                    BarecodeString1 := "Prod. Order Line"."Prod. Order No.";
                    BarecodeString2 := "Prod. Order Line"."Reference No.";
                    BracodesFontProvider.ValidateInput(BarecodeString1, BarcodeSymbolygy);
                    ProductionOrderNoBarCode := BracodesFontProvider.EncodeFont(BarecodeString1, BarcodeSymbolygy);
                    BracodesFontProvider.ValidateInput(BarecodeString2, BarcodeSymbolygy);
                    ItemReferenceBarCode := BracodesFontProvider.EncodeFont(BarecodeString2, BarcodeSymbolygy);
                end;
            }
            trigger OnAfterGetRecord()
            var

            begin
                if SalesHeader.get(SalesHeader."Document Type"::Order, "Production Order"."Sales Order No.") then;

            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        Item: Record Item;
        SalesHeader: record "Sales Header";
        ProductionOrderNoBarCode: text;
        ItemReferenceBarCode: text;
}

