pageextension 50015 "WDC Purchase Return Order" extends "Purchase Return Order"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    layout
    {
        moveAfter(Status; "Shortcut Dimension 1 Code")
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = all;
            ShowMandatory = true;
            Editable = Rec.Status <> Rec.Status::Released;
        }
    }
}