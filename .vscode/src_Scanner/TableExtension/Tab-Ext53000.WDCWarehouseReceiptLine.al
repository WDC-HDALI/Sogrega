namespace sogrega.sogrega;
using Microsoft.Warehouse.Document;
//***************Documentation**********************
//WDC01  WDC.HG  08/09/2025 Create current object : Scanner flux
tableextension 53000 "WDC WarehouseReceiptLine" extends "Warehouse Receipt Line"
{
    fields
    {
        field(53000; "No. of Labels To Scan"; Integer)
        {
            CaptionML = ENU = 'No. of Labels To Print', FRA = 'Nombre d''étiquette à imprimer';
            DataClassification = ToBeClassified;
        }
        field(53001; "Qty Par"; decimal)
        {
            CaptionML = ENU = 'Qty Per', FRA = 'Qty par';
            DataClassification = ToBeClassified;
        }
    }
}