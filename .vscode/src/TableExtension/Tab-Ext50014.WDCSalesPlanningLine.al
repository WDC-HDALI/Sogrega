namespace SogregaDev.SogregaDev;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item.Catalog;

tableextension 50014 WDCSalesPlanningLine extends "Sales Planning Line"
{
    fields
    {
        field(50000; "Selected Line"; Boolean)
        {
            CaptionML = ENU = 'Selected Line', FRA = 'O.F. à créer';
            DataClassification = ToBeClassified;
        }
        field(50001; "Reference No."; Code[50])
        {
            CaptionML = ENU = 'Refrence No.', FRA = 'N° référence';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Reference"."Reference No." where("Item No." = field("Item No."),
                                                                        "Reference Type" = filter("Item Reference Type"::Customer)));
        }
        field(50002; "Ordred Qty"; Decimal)
        {
            CaptionML = ENU = 'Ordred Qty', FRA = 'Qte commandée';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Sales Line".Quantity where("Document No." = field("Sales Order No."),
                                                              "Line No." = field("Sales Order Line No."),
                                                              "Document Type" = filter("Sales Document Type"::Order)));
        }
    }
}
