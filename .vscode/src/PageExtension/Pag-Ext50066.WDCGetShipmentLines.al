namespace Sogrega.Sogrega;

using Microsoft.Sales.History;

pageextension 50066 "WDC Get Shipment Lines" extends "Get Shipment Lines"
{
    layout
    {
        addbefore("Document No.")
        {
            field("Posted Whse Shp No."; Rec."Posted Whse Shp No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
