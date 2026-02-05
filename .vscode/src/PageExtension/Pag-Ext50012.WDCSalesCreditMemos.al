pageextension 50012 "WDC Sales Credit Memos" extends "Sales Credit Memos"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    layout
    {
        movebefore(Status; "Shortcut Dimension 1 Code")
        modify("Shortcut Dimension 1 Code")
        {
            Editable = Rec.Status <> Rec.Status::Released;
            ShowMandatory = true;
        }
    }
}