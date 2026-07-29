namespace sogrega.sogrega;

using Microsoft.Inventory.Location;

pageextension 53002 "WDC Location List" extends "Location List"
{
    layout
    {
        addafter(Name)
        {
            field("Inventory Batch Name"; Rec."Inventory Batch Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}
