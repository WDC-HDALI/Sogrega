namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Document;
/**********************************Documentation*********************
 //WDC01     WDC.HG    03/12/2024        show field "Reference No."
//WDC02       WDC.HG    18/12/2025      show field "External Sales Order No."
 *********************************************************************/

pageextension 50042 WDCReleasedProductionOrder extends "Released Production Order"
{
    layout
    {
        addafter(Blocked)
        {
            field("Shortcut Dimension 1 Code 2"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = all;

            }

            field("Location Code1"; Rec."Location Code")
            {
                ApplicationArea = All;
            }

            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = all;
            }
            //<<WDC02
            field("External Sales Order No."; Rec."External Sales Order No.")
            {
                ApplicationArea = all;
            }
            //>>WDC02
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
