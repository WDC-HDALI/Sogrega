namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Document;
/**********************************Documentation*********************
 //WDC01     WDC.HG  25/12/2024          create current object 
 *********************************************************************/

pageextension 50055 "WDC Prod. Order Components" extends "Prod. Order Components"
{
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }

    }

}
