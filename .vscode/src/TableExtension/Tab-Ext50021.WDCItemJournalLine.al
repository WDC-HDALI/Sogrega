namespace SogregaDev.SogregaDev;

using Microsoft.Warehouse.Request;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Inventory.Journal;
using Microsoft.Sales.Customer;
//***************Documentation***********************
//WDC01  WDC.HG 08/09/2025  Add "reference No" for PF Journal
tableextension 50021 "WDC Item Journal Line" extends "Item Journal Line"

{
    fields
    {
        field(50000; "Net Weight"; Decimal)
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
            DataClassification = ToBeClassified;
        }
        field(50001; "Qty Checked"; Boolean)
        {
            CaptionML = ENU = 'Qty Checked', FRA = 'Quantité Vérifiée';
            DataClassification = ToBeClassified;
        }
        modify("Qty. (Phys. Inventory)")
        {
            trigger OnAfterValidate()
            begin

                If Rec."Qty. (Phys. Inventory)" <> Rec."Qty. (Calculated)" then
                    Rec."Qty Checked" := true;
            end;
        }
        field(50002; "Reference No."; Code[50])
        {
            CaptionML = ENU = 'Refrence No.', FRA = 'N° référence';
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                lItemReference: record "Item Reference";
            begin

                if "Inventory Posting Group" = 'PF' then begin
                    lItemReference.reset();
                    lItemReference.SetRange("Item No.", "Item No.");
                    lItemReference.setrange("Reference Type", "Item Reference Type"::Customer);
                    if lItemReference.FindSet() then
                        "Reference No." := lItemReference."Reference No.";
                end

            end;
        }
        //<<WDC01

        //<<WDC01
    }
}
