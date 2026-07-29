namespace sogrega.sogrega;

using Microsoft.Warehouse.History;

tableextension 53003 "WDC PostedWarehouseReceiptLine" extends "Posted Whse. Receipt Line"
{
    fields
    {
        field(53000; "No. of Labels To Scan"; Integer)
        {
            CaptionML = ENU = 'No. of Labels To Print', FRA = 'Nombre d''étiquette à imprimer';
            DataClassification = ToBeClassified;
        }
        field(53001; "Qty Par"; Decimal)
        {
            CaptionML = ENU = 'Qty Per', FRA = 'Qty par';
            DataClassification = ToBeClassified;
        }
    }
}
