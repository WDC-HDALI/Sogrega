pageextension 50020 "WDC Posted PurchaseCreditMemo" extends "Posted Purchase Credit Memo"
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