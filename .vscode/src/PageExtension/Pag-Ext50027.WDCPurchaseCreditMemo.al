pageextension 50027 "WDC PurchaseCreditMemo" extends "Purchase Credit Memo"
{
    //*************Documentation***************************
    //WDC01  HD  30/08/2024  Create this current object

    layout
    {
        moveAfter("Vendor Cr. Memo No."; "Shortcut Dimension 1 Code")
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = all;
            ShowMandatory = true;
            Editable = Rec.Status <> Rec.Status::Released;
        }
    }
}