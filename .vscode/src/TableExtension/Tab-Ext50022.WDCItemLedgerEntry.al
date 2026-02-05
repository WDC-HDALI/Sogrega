namespace SogregaDev.SogregaDev;

using Microsoft.Warehouse.Request;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Sales.Customer;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Item;
//********************Documentation**********************
//WDC01  WDC.HG  18/06/2025  Add field 
tableextension 50022 "WDC Item Ledger Entry" extends "Item Ledger Entry"

{
    fields
    {
        field(50000; "Net Weight"; Decimal)
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
            DataClassification = ToBeClassified;
        }
        field(50001; "Reference No."; Code[50])
        {
            CaptionML = ENU = 'Refrence No.', FRA = 'N° référence';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Reference"."Reference No." where("Item No." = field("Item No."), "Reference Type" = filter("Item Reference Type"::Customer)));
            Editable = false;
        }
        //<<WDC01
        field(50002; "Gen. Prod. Posting Group"; Code[20])
        {
            CaptionML = ENU = 'Prod Posting Group', FRA = 'Groupe compta. produit';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Gen. Prod. Posting Group" where("No." = field("Item No.")));
            Editable = false;

        }
        //>>WDC01
    }
}
