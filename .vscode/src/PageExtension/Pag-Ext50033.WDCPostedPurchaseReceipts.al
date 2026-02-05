pageextension 50033 "WDC Posted Purchase Receipts" extends "Posted Purchase Receipts"
{
    //*************Documentation***************************
    //WDC01  HD  29/08/2024  Create the current object

    layout
    {
        addbefore("Location Code")
        {
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                editable = false;
            }
            field("ShortcutDimension1Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                editable = false;
            }
        }
    }
}