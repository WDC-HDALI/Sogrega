namespace sogrega.sogrega;

using Microsoft.Sales.History;
//***************Documentation*******************
//WDC01  HG  28/10/2025  Create Current Object 

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
    }
}
