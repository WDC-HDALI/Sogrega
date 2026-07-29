tableextension 50009 "WDC Sales Invoice Line" extends "Sales Invoice Line"
{
    //*************Documentation***************************
    //WDC01  HD  26/08/2024  Create this current object
    //WDC02  HG  28/10/2025  Add field  "Reference No."
    //WDC03  HG  22/05/2026  Add "shipment No." , "Gross weight" , "Net weight"

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
        //<<WDC02
        field(50010; "Reference No."; Code[50])
        {
            CaptionML = ENU = 'Refrence No.', FRA = 'N° référence';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Reference"."Reference No." where("Item No." = field("No."), "Reference Type" = filter("Item Reference Type"::Customer)));
            Editable = false;
        }
        //>>WDC02
        field(50011; Position; Integer)
        {
            Captionml = ENU = 'Position', FRA = 'Position';
            DataClassification = ToBeClassified;
        }
        //<<WDC03
        field(50012; "Posted Whse Shp No."; Code[20])
        {
            CaptionML = ENU = 'Posted Whse Shp No.', FRA = 'N° Exp entrepôt enreg.';
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Whse. Shipment Line"."No." where(
                                                           "Source No." = field("Order No."),
                                                           "Source Line No." = field("Order Line No."),
                                                           "Source Document" = const("Sales Order")));
            Editable = false;
        }
        //>>WDC03
        field(50013; "Ship Gross weight"; Decimal)
        {
            CaptionML = ENG = 'Gross Weight(Kg)', FRA = 'Poid brut(Kg)';
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Whse. Shipment Header"."Gross Weight" where("No." = field("Posted Whse Shp No.")));
            Editable = false;
        }
        field(50014; "Ship Net weight"; Decimal)
        {
            CaptionML = ENG = 'Net Weight(Kg)', FRA = 'Poid net(Kg)';
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Whse. Shipment Header"."Net Weight" where("No." = field("Posted Whse Shp No.")));
            Editable = false;
        }
        //>>WDC03
    }

}
