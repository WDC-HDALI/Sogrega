namespace sogrega.sogrega;

using Microsoft.Sales.History;
//***************Documentation*******************
//WDC01  HG  28/10/2025  Create Current Object 
//WDC02  HG  22/05/2026  Show weight fields 

pageextension 50069 "WDC Posted Sales Invoice Line" extends "Posted Sales Invoice Lines"
{
    layout
    {
        addafter("No.")
        {
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = all;
            }

        }
        //<<WDC02
        addlast(Control1)
        {
            field("Posted Whse Shp No."; Rec."Posted Whse Shp No.")
            {
                ApplicationArea = all;
            }
            field("Ship Gross weight"; Rec."Ship Gross weight")
            {
                ApplicationArea = all;
            }
            field("Ship Net weight"; Rec."Ship Net weight")
            {
                ApplicationArea = all;
            }
        }
        //>>WDC02
    }
}
