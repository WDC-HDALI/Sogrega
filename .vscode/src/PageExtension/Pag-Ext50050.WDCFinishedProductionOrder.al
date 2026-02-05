namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Document;
/**********************************Documentation*********************
 //WDC01     WDC.HG    05/12/2024        show field "Reference No."
 *********************************************************************/

pageextension 50050 WDCFinishedProductionOrder extends "Finished Production Order"
{
    layout
    {
        addafter(Quantity)
        {
            field("Shortcut Dimension 1 Code 2"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = all;
            }
            field("Sales Order No."; Rec."Sales Order No.")
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
