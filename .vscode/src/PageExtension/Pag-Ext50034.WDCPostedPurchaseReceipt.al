pageextension 50034 "WDC Posted Purchase Receipt" extends "Posted Purchase Receipt"
{
    //*************Documentation***************************
    //WDC01  HD  29/08/2024  Create the current object

    layout
    {
        addafter("Responsibility Center")
        {
            field("ShortcutDimension1Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                editable = false;
            }
        }
    }
}