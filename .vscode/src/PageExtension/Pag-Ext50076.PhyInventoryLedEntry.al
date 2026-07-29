namespace sogrega.sogrega;

using Microsoft.Inventory.Counting.Journal;
//**************Documentation***********************
//WDC01  WDC.HG  08/04/2026  Create Current Object

pageextension 50076 PhyInventoryLedEntry extends "Phys. Inventory Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = all;
            }
        }
    }
}
