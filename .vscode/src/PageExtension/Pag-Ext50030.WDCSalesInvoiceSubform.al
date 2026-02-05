pageextension 50030 "WDC Sales Invoice Subform" extends "Sales Invoice Subform"
{
    //*************Documentation***************************
    //WDC01  HD  26/08/2024  Create this current object
    layout
    {
        addafter(Quantity)
        {
            field(Matricule; Rec.Matricule)
            {
                ApplicationArea = all;
            }
        }
    }
}