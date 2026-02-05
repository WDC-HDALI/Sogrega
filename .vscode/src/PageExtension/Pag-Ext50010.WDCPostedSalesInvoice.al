pageextension 50010 "WDC Posted Sales Invoice" extends "Posted Sales Invoice"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    layout
    {
        movebefore(Cancelled; "Shortcut Dimension 1 Code")
    }
}