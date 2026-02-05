pageextension 50024 "WDC Whse. Shipment Subform" extends "Whse. Shipment Subform"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    layout
    {
        addafter("Item No.")
        {
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = All;
            }

        }
        addafter(Quantity)
        {
            field(Matricule; Rec.Matricule)
            {
                ApplicationArea = all;
            }
            field("Cust. Order No."; Rec."Cust. Order No.")
            {
                ApplicationArea = all;
            }
            field("Cust. Order Line No."; Rec."Cust. Line No.")
            {
                ApplicationArea = all;
            }
        }
    }
}