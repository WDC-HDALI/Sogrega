namespace sogrega.sogrega;

using Microsoft.Purchases.Document;
using System.Text;

reportextension 50001 "WDC Purchase Order" extends "Order"
{

    RDLCLayout = './.vscode/src/ReportExtension/RDLC/Order.rdlc';
    dataset
    {


        add("Purchase Header")
        {
            column(EncodedNo; EncodedNO)
            {

            }
            column(CompanyPicture; CompanyInfo.Picture)
            {

            }


        }
        modify("Purchase Header")
        {
            trigger OnAfterAfterGetRecord()
            var
            begin
                Clear(BracodesFontProvider);
                Clear(BarcodeSymbolygy);
                Clear(EncodedNO);
                BracodesFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbolygy := Enum::"Barcode Symbology"::Code128;
                Clear(BarcodeString);
                BarcodeString := "No.";
                BracodesFontProvider.ValidateInput(BarcodeString, BarcodeSymbolygy);
                EncodedNO := BracodesFontProvider.EncodeFont(BarcodeString, BarcodeSymbolygy);
            end;
        }
        modify("RoundLoop")
        {
            trigger OnAfterAfterGetRecord()

            var
            begin
                Clear(BracodesFontProvider);
                Clear(BarcodeSymbolygy);
                clear(EncodedLineNo);
                BracodesFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbolygy := Enum::"Barcode Symbology"::Code128;
                Clear(BarcodeString);
                BarcodeString := format("Purchase Line"."Line No.");
                BracodesFontProvider.ValidateInput(BarcodeString, BarcodeSymbolygy);
                EncodedLineNo := BracodesFontProvider.EncodeFont(BarcodeString, BarcodeSymbolygy);

            end;
        }
        add("RoundLoop")
        {
            column(EncodedLineNo; EncodedLineNo)
            {

            }
        }

    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInfo.CalcFields(Picture);
    end;



    var
        BarcodeSymbolygy: Enum "Barcode Symbology";
        BracodesFontProvider: Interface "Barcode Font Provider";
        BarcodeString: Text;
        EncodedNO: Text;
        EncodedLineNo: Text;

}