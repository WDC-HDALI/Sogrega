namespace SogregaDev.SogregaDev;

using Microsoft.Inventory.Item;

pageextension 50057 "WDC Item List" extends "Item List"
{
    layout
    {
        addafter("No.")
        {
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
