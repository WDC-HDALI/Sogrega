namespace SogregaDev.SogregaDev;

using Microsoft.Purchases.Pricing;
/**********************************Documentation*********************
 //WDC01     WDC.HG  03/12/2024          create current object 
 *********************************************************************/

pageextension 50052 "WDC Purchase Prices" extends "Purchase Prices"
{
    layout
    {
        addafter("Minimum Quantity")
        {
            field("Minimum Purchase Quantity"; Rec."Minimum Purchase Quantity")
            {
                ApplicationArea = all;
            }
        }
    }
}
