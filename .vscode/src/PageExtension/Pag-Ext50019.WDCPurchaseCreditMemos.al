pageextension 50019 "WDC Purchase Credit Memos" extends "Purchase Credit Memos"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    layout
    {
        moveAfter("Vendor Cr. Memo No."; "Shortcut Dimension 1 Code")
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = all;
            ShowMandatory = true;
            Editable = false;
        }
    }
}