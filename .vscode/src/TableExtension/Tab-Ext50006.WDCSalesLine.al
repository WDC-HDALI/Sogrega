
tableextension 50006 "WDC Sales Line" extends "Sales Line"
{
    //*************Documentation***************************
    //WDC01  HD  26/08/2024  Create the current object
    //WDC02  CHG 30/08/2024  add new field
    //WDC03  HG  09/12/2024  Add new field for edi process
    //WDC04  HG  17/12/2024  add field for EDI Process
    fields
    {
        field(50000; "Matricule"; Code[50])
        {
            CaptionML = ENU = 'Matricule', FRA = 'Matricule';
            DataClassification = ToBeClassified;
        }

        //<<WDC02
        field(50001; "Status"; Enum "Sales Document Status")
        {
            CaptionML = ENG = 'Status', FRA = 'Statut';
            CalcFormula = lookup("sales Header".Status where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        //>>WDC02
        //<<WDC03
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
        //>>WDC03
        //>>WDC04
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
        field(50011; Position; Integer)
        {
            Captionml = ENU = 'Position', FRA = 'Position';
            DataClassification = ToBeClassified;
        }

        //>>WDC04

        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if rec.Type = rec.Type::Item then begin
                    if UserSetup.get(UserId) then
                        If UserSetup."Default Sales Location Code" <> '' then
                            rec.Validate("Location Code", UserSetup."Default Sales Location Code");
                end;
            end;

        }

        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                Err01: TextConst FRA = 'Location Code %1 doit commencer par une valeur similaire aux site code  %2- ', ENU = 'Location Code %1 must start with a value similar to the site code  %2-';
                lSalesHeader: record "Sales Header";
            begin
                if lSalesHeader.get(rec."Document Type", rec."Document No.") then
                    if (rec."Location Code" <> '') AND (rec."Shortcut Dimension 1 Code" <> '') then
                        if (CopyStr(rec."Location Code", 1, 2) <> rec."Shortcut Dimension 1 Code") OR (CopyStr(rec."Location Code", 1, 2) <> lSalesHeader."Shortcut Dimension 1 Code") then
                            Error(Err01, rec."Location Code", lSalesHeader."Shortcut Dimension 1 Code");
            end;
        }
        modify("Shortcut Dimension 1 Code")
        {


            trigger OnAfterValidate()
            var
                Err01: TextConst FRA = 'site code %1 doit avoir une valeur similaire à %2 ', ENU = 'site code %1 must have a value similar to %2';
                lSalesHeader: record "Sales Header";
            begin
                if lSalesHeader.get(rec."Document Type", rec."Document No.") then
                    if (rec."Shortcut Dimension 1 Code" <> CopyStr(rec."Location Code", 1, 2)) OR (rec."Shortcut Dimension 1 Code" <> CopyStr(lsalesheader."Location Code", 1, 2)) then
                        Error(Err01, rec."Shortcut Dimension 1 Code", CopyStr(rec."Location Code", 1, 2));
            end;
        }

    }
    var
        UserSetup: record "User Setup";
}