namespace Sogrega.Sogrega;

using Microsoft.Inventory.Counting.Journal;
//***************Documentation***********************
//WDC01  WDC.HG 08/09/2025  Add "reference No" for PF Journal
pageextension 50062 "WDC Phys. Inventory Journal" extends "Phys. Inventory Journal"
{
    layout
    {
        addafter("Qty. (Phys. Inventory)")
        {
            field("Qty Checked"; Rec."Qty Checked")
            {
                ApplicationArea = All;
            }

        }
        //<<WDC01
        addafter("Item No.")
        {
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = all;
                Visible = true;

            }
        }


    }
    // trigger OnAfterGetRecord()
    // var
    // begin
    //     ShowItemReference := (rec."Journal Template Name" = 'INVENTAIRE') and
    //     (rec."Inventory Posting Group" = 'PF') and
    //      ((rec."Journal Batch Name" = 'BA') or (rec."Journal Batch Name" = 'MJ'));

    // end;

    // var
    //     ShowItemReference: Boolean;
    //>>WDC01
}

