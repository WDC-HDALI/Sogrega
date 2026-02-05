namespace Sogrega.Sogrega;

using Microsoft.Finance.Dimension;

pageextension 50072 "WDC Default Dimensions" extends "Default Dimensions"
{
    layout
    {
        addafter(AllowedValuesFilter)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
