namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Document;
//******************Documentation*******************
//WDC01  WDC.HG  18/12/2025  show field "External Sales Order No."
pageextension 50045 "WDCFirmPlannedProd.Orders" extends "Firm Planned Prod. Orders"
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
            //<<WDC01
            field("External Sales Order No."; Rec."External Sales Order No.")
            {
                ApplicationArea = all;
            }
            //>>WDC01
        }
        addafter("Source No.")
        {
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = all;
            }
        }
        //<<WDC.IM
        addafter("Due Date")
        {
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = All;
            }
        }
        //>>WDC.IM
    }

}
