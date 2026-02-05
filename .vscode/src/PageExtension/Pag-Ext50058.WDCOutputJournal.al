namespace SogregaDev.SogregaDev;

using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Journal;
using Microsoft.Inventory.Ledger;

pageextension 50058 "WDC Output Journal" extends "Output Journal"
{
    layout
    {
        modify("Document No.")
        {
            Visible = false;
        }
        modify("Run Time")
        {
            Visible = false;
        }
        modify("Cap. Unit of Measure Code")
        {
            Visible = false;
        }
        modify("Applies-to Entry")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify(Finished)
        {
            Visible = false;
        }

        addafter("Output Quantity")
        {
            field("Net weight"; Rec."Net weight")
            {
                ApplicationArea = All;
            }
        }

    }

}
