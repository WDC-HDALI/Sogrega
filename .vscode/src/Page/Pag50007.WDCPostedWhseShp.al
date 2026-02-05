namespace Sogrega.Sogrega;

using Microsoft.Warehouse.History;
using Microsoft.Sales.Document;

page 50007 "WDC Posted Whse. Shp"
{
    ApplicationArea = All;
    Caption = 'WDC Posted Whse. Shp';
    PageType = List;
    SourceTable = "Posted Whse. Shipment Header";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Whse. Shipment No."; Rec."Whse. Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}
