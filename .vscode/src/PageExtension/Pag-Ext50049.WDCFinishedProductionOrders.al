namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Document;

pageextension 50049 WDCFinishedProductionOrders extends "Finished Production Orders"
{
    layout
    {

        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }
        addafter("Last Date Modified")
        {
            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("No.")
        {
            field("Firm Planned Order No."; Rec."Firm Planned Order No.")
            {
                ApplicationArea = all;
            }
        }
        //<<WDC01
        addafter("Source No.")
        {
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = all;
            }

        }
        //>>WDC01
    }
}
