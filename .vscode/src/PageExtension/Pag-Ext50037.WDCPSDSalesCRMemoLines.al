pageextension 50037 "WDC PSD  Sales CR Memo Lines" extends "Posted Sales Credit Memo Lines"
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