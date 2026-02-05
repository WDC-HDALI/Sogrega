pageextension 50028 "WDC Posted Sales InvoiceSub" extends "Posted Sales Invoice Subform"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object
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