
pageextension 50016 "WDC Purchase Invoices" extends "Purchase Invoices"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    layout
    {
        movebefore(Status; "Shortcut Dimension 1 Code")
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = all;
            ShowMandatory = true;
            Editable = Rec.Status <> Rec.Status::Released;
        }
    }
}