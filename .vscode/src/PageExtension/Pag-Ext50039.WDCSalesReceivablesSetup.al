pageextension 50039 "WDC Sales & Receivables Setup " extends "Sales & Receivables Setup"
{
    //*************Documentation***************************
    //WDC01  CHG 03/09/2024 create this current object
    //WDC02  HG  19/12/2024 show field EDI

    layout
    {
        addlast(General)
        {
            field("Last Shipping Filter"; Rec."Last Shipping Date Filter")
            {
                ApplicationArea = all;
            }
            field("Controle Qty to invoice"; Rec."Controle Qty to invoice")
            {
                ApplicationArea = all;
            }
        }
        //<<WDC02
        addlast(content)
        {
            group(EDI)
            {
                Caption = 'EDI';
                field("Location Code Bouargoub"; Rec."Location Code Bouargoub")
                {
                    ApplicationArea = all;
                }

                field("Location code Menzel Jmil"; Rec."Location code Menzel Jmil")
                {
                    ApplicationArea = all;
                }
                field("Site Code Bouargoub"; Rec."Site Code Bouargoub")
                {
                    ApplicationArea = all;
                }
                field("Site code Menzel Jmil"; Rec."Site code Menzel Jmil")
                {
                    ApplicationArea = all;
                }
            }
        }
        //>>WDC02
    }
}