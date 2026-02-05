namespace SogregaDev.SogregaDev;

using Microsoft.Purchases.Setup;
using Microsoft.Purchases.Vendor;
using Microsoft.Finance.Dimension;

tableextension 50019 "WDC Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Vendor Post. Group Import"; code[20])
        {
            CaptionML = ENU = 'Importation Vendor Posting Group ', FRA = 'Groupe compta. four importation';
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group";

        }
        field(50001; "site code importation"; code[20])
        {
            CaptionML = ENU = 'Importation Site Code', FRA = 'Site code importation';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));

        }
    }
}
