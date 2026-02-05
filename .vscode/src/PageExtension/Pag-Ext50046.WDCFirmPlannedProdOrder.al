namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Document;
/**********************************Documentation*********************
 //WDC01     WDC.HG    05/12/2024        show field "Reference No."
 //WDC02     WDC.IM    27/12/2024        Show Field "Creation Date"
 //WDC03     WDC.HG    18/12/2025        Show field "External Sales Order No."
 *********************************************************************/

pageextension 50046 "WDCFirmPlannedProd.Order" extends "Firm Planned Prod. Order"
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
            //<<WDC03
            field("External Sales Order No."; Rec."External Sales Order No.")
            {
                ApplicationArea = all;
            }
            //>>WDC03
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
        //<<WDC02
        addafter("Assigned User ID")
        {
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = All;
            }
        }
        //>>WDC02
    }
}
