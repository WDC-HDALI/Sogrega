namespace SogregaDev.SogregaDev;

using Microsoft.Purchases.Setup;
/**********************************Documentation*********************
 //WDC01     WDC.HG  03/12/2024          create current object 
 *********************************************************************/
pageextension 50053 "WDC Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Vend Posting Group import "; Rec."Vendor Post. Group Import")
            {
                ApplicationArea = all;

            }
            field("site code importation"; Rec."site code importation")
            {
                ApplicationArea = all;

            }
        }
    }
}
