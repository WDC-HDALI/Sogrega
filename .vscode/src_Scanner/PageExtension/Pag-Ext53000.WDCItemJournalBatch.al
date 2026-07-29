namespace sogrega.sogrega;

using Microsoft.Inventory.Journal;

pageextension 53000 "WDC Item Journal Batch" extends "Item Journal Batches"
{
    layout
    {
        addafter("Item Tracking on Lines")
        {
            field("Scanner Sheet"; Rec."Scanner Sheet")
            {
                ApplicationArea = all;
            }
            field("Scanner Inventory Sheet"; rec."Scanner Inventory sheet")
            {
                ApplicationArea = all;
            }
        }
    }

}
