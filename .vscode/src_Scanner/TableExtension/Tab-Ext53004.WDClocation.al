namespace sogrega.sogrega;

using Microsoft.Inventory.Location;
using Microsoft.Inventory.Journal;

tableextension 53004 "WDC location" extends Location
{
    fields
    {
        field(53000; "Inventory Batch Name"; code[10])
        {
            CaptionML = ENU = 'Inventory Batch Name', FRA = 'Nom feuille inventaire';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = filter('INVENTAIRE'));
        }
    }
}
