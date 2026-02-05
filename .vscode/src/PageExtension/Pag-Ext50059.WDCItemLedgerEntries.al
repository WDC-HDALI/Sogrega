namespace SogregaDev.SogregaDev;

using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Journal;
using Microsoft.Inventory.Ledger;
//********************Documentation**********************
//WDC01  WDC.HG  18/06/2025  show field 
pageextension 50059 "WDC Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Item No.")
        {

            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = All;
            }
            //<<WDC01
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
                DrillDown = false;
            }
            //>>WDC01
        }

        addafter(Quantity)
        {

            field("Net weight"; Rec."Net weight")
            {
                ApplicationArea = All;
            }
        }
    }

}
