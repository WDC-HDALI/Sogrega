pageextension 50018 "WDC Posted Purchase Invoice" extends "Posted Purchase Invoice"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    layout
    {
        moveAfter("Vendor Invoice No."; "Shortcut Dimension 1 Code")
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = all;
            ShowMandatory = true;
            Editable = false;
        }
    }
}