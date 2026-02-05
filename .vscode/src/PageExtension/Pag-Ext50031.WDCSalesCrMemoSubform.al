pageextension 50031 "WDC Sales Cr. Memo Subform" extends "Sales Cr. Memo Subform"
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