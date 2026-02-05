tableextension 50023 "WDC Sales Shipment Line" extends "Sales Shipment Line"
{
    //*************Documentation***************************
    //WDC01  HD  26/08/2024  Create this current object

    fields
    {
        field(50000; "Matricule"; Code[50])
        {
            Caption = 'Matricule';
            DataClassification = ToBeClassified;
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
        field(50004; "finition"; Enum "WDC Finish")
        {
            CaptionML = ENG = 'Finish', FRA = 'Finition';
            DataClassification = ToBeClassified;
        }
        field(50005; "vernis"; Enum "WDC PAINTING")
        {
            CaptionML = ENG = 'Varnish', FRA = 'Vernis';
            DataClassification = ToBeClassified;
        }
        field(50006; "BlockingLevel"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "DueDateGap"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Model"; Text[100])
        {
            CaptionML = ENG = 'Model', FRA = 'Modèle';
            DataClassification = ToBeClassified;
        }
        field(50009; "Reserved from"; Text[100])
        {
            CaptionML = ENG = 'Reserved form', FRA = 'Réservé de';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50010; "Posted Whse Shp No."; Code[20])
        {
            CaptionML = ENU = 'Posted Whse Shp No.', FRA = 'N° Exp entrepôt enreg.';
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Whse. Shipment Line"."No." where(
                                                           "Source No." = field("Order No."),
                                                           "Source Line No." = field("Order Line No."),
                                                           "Source Document" = const("Sales Order")));
            Editable = false;

        }
    }
}
