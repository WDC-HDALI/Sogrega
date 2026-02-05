tableextension 50008 "WDC Posted Whse. Shipment Line" extends "Posted Whse. Shipment Line"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    fields
    {
        field(50000; "Matricule"; Code[50])
        {
            Caption = 'Matricule';
            DataClassification = ToBeClassified;
        }
        field(50001; "Reference No."; Code[50])
        {
            CaptionML = ENU = 'Refrence No.', FRA = 'N° référence';
        }
        field(50002; "Cust. Order No."; Code[35])
        {
            CaptionML = ENG = 'Sales Order No.', FRA = 'N° Commande client';
            DataClassification = ToBeClassified;
        }
        field(50003; "Cust. Line No."; Integer)
        {
            CaptionML = ENG = 'Sales Line No.', FRA = 'N° Ligne commande';
            DataClassification = ToBeClassified;
        }
    }
}
