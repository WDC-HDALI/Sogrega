namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Setup;
using Microsoft.Inventory.Location;

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

    }
}
