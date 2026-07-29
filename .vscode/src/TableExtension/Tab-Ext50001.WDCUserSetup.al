tableextension 50001 "WDC User Setup" extends "User Setup"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object
    //WDC02  HG   11/12/2024  Add field "Check Accounting"
    //WDC03  HG   12/05/2026  Add field "Allow Weight Import"

    fields
    {
        field(50000; "Site Code"; Code[20])
        {
            Caption = 'Site Code';
            DataClassification = ToBeClassified;
        }
        field(50001; "Default Sales Location Code"; Code[20])
        {
            CaptionML = ENG = 'Default Sales Location Code', FRA = 'Magasin vente par défaut';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50002; "Default Receipt Location Code"; Code[20])
        {
            CaptionML = ENG = 'Default Receipt Location Code', FRA = 'Magasin réception par défaut';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50003; "Default Shp Location Code"; Code[20])
        {
            CaptionML = ENG = 'Default Shipemt Location Code', FRA = 'Magasin Expédition par défaut';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50004; "Update Purchase Price"; Boolean)
        {
            CaptionML = ENG = 'Update Purchase Price', FRA = 'MAJ Prix achat';
            DataClassification = ToBeClassified;
        }
        //<<WDC02
        field(50005; "Check Accounting"; Boolean)
        {
            CaptionML = ENU = 'Check Accounting', FRA = 'Vérif Compta';
            DataClassification = ToBeClassified;
        }
        //<<WDC03
        field(50006; "Allow Weight Import"; Boolean)
        {
            CaptionML = ENU = 'Allow Weight Import', FRA = 'Autoriser import poid';
            DataClassification = ToBeClassified;
        }
        //>>WDC03
        // field(50006; "Update BOM"; Boolean)
        // {
        //     CaptionML = ENU = 'Update BOM', FRA = 'MAJ Nomenclature';
        //     DataClassification = ToBeClassified;
        // }
        // field(50007; "Update Routing"; Boolean)
        // {
        //     CaptionML = ENU = 'Update BOM', FRA = 'MAJ Nomenclature';
        //     DataClassification = ToBeClassified;
        // }

        //>>WDC02

    }
    var
        varc: record 36;
        pp: page 5600;
}
