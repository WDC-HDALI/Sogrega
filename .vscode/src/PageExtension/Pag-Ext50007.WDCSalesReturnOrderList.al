pageextension 50007 "WDC Sales Return Order List" extends "Sales Return Order List"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    layout
    {
        moveafter(Status; "Shortcut Dimension 1 Code")
        modify("Shortcut Dimension 1 Code")
        {
            Editable = Rec.Status <> Rec.Status::Released;
            ShowMandatory = true;
        }
    }
}