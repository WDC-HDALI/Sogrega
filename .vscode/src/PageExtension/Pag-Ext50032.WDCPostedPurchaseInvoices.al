pageextension 50032 "WDC Posted Purchase Invoices" extends "Posted Purchase Invoices"
{
    //*************Documentation***************************
    //WDC01  HD  29/08/2024  Create the current object

    layout
    {
        addbefore("Location Code")
        {
            field("ShortcutDimension1Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                editable = false;
            }
        }
        addafter("No.")
        {
            field("Pre-Assigned No."; Rec."Pre-Assigned No.")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                editable = false;
            }
        }
    }
}