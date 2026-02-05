namespace Sogrega.Sogrega;

using Microsoft.Sales.History;
using Microsoft.Warehouse.History;

tableextension 50024 "WDC Sales Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
        field(50000; "Posted Whse Shp No."; Code[20])
        {
            CaptionML = ENU = 'Posted Whse Shp No.', FRA = 'N° Exp entrepôt enreg.';
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Whse. Shipment Line"."No." where(
                                                           "Posted Source No." = field("No.")));
            Editable = false;

        }
    }
}
