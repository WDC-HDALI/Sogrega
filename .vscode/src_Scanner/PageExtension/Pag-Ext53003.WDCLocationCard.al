namespace sogrega.sogrega;

using Microsoft.Inventory.Location;

pageextension 53003 "WDC Location Card" extends "Location Card"
{
    layout
    {
        addafter(Name)
        {
            field("Inventory Batch Name"; Rec."Inventory Batch Name")
            {
                ApplicationArea = all;
            }
        }
    }
}
