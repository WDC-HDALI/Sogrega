namespace sogrega.sogrega;

using Microsoft.Sales.Document;
/**********************************Documentation*********************
   //WDC01     WDC.HG    09/09/2025        Creation of "sales Invoice" report 
   *********************************************************************/

pageextension 50068 "WDC Sales Quote" extends "sales quote"
{
    layout
    {
        addafter(Status)
        {
            field("ShortcutDimension1Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = all;
            }
        }
    }
    var
}
