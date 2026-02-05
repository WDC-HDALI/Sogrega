pageextension 50025 "WDC Posted Whse. Shipment Sub" extends "Posted Whse. Shipment Subform"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object
    layout
    {
        addafter("Item No.")
        {
            field(ReferenceNo; Rec."Reference No.")
            {
                ApplicationArea = all;
                ShowMandatory = true;
            }
        }
        addafter(Quantity)
        {
            field(Matricule; Rec.Matricule)
            {
                ApplicationArea = all;
                ShowMandatory = true;

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