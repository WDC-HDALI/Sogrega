namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Setup;
using Microsoft.Inventory.Location;
//**************Documentation*************
//WDC01  WDC.HG  27/04/2026  add Import Onedrive Fields 

tableextension 50016 WDCManufacturingSetup extends "Manufacturing Setup"
{
    fields
    {
        field(50000; "BA Consuption Location"; Code[20])
        {
            CaptionML = ENU = 'BA Consuption Location', FRA = 'BA Magasin consommation';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50001; "MJ Consuption Location"; Code[20])
        {
            CaptionML = ENU = 'MJ Consumption Location', FRA = 'MJ Magasin consommation';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50002; "Mandatory Output Weight"; Boolean)
        {
            CaptionML = ENU = 'Mandatory PF Output Weight', FRA = 'Poids décl. Prod PF oblig.';
            DataClassification = ToBeClassified;
        }
        //<<WDC01
        field(50003; "Tenant ID"; Text[100])
        {
            CaptionML = ENU = 'Tenant ID', FRA = 'ID du locataire';
            DataClassification = ToBeClassified;

        }
        field(50004; "Client ID"; Text[100])
        {
            CaptionML = ENU = 'Client ID', FRA = 'ID client';
            DataClassification = ToBeClassified;
        }
        field(50005; "Client Secret"; text[100])
        {
            CaptionML = ENU = 'Client Secret', FRA = 'Secret client';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "Drive ID"; text[250])
        {
            CaptionML = ENU = 'Drive ID', FRA = 'ID Drive';
            DataClassification = ToBeClassified;
        }
        //>>WDC01

    }
}
