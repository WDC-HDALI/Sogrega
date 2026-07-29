namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Document;
/**********************************Documentation*********************
 //WDC01     WDC.HG     03/12/2024      add field "Reference No."
//WDC02    WDC.HG     08/09/2025        add New fields
//WDC03    WDC.HG     18/12/2025        add New field 
//WDC04    WDC.HG     18/06/2026        add Customer Name
 *********************************************************************/

tableextension 50015 WDCProductionOrder extends "Production Order"
{
    fields
    {
        field(50000; "Sales Order No."; Code[20])
        {
            CaptionML = ENU = 'Sales Order No.', FRA = 'N° commande client';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header";
            Editable = false;
        }
        //<<WDC01
        field(50001; "Reference No."; Code[50])
        {
            CaptionML = ENU = 'Reference No.', FRA = 'N° référence';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50002; "Production Bom No."; Code[20])
        {
            CaptionML = ENU = 'Production Bom No.', FRA = 'N° nomenclature production';
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Production BOM No." where("No." = field("Source No.")));
            Editable = false;
        }
        modify("Source No.")
        {
            trigger OnAfterValidate()
            var
                ItemReference: record 5777;
            begin
                "Reference No." := '';
                ItemReference.reset;
                ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::Customer);
                ItemReference.SetRange("Item No.", "Source No.");
                if ItemReference.FindFirst() then
                    "Reference No." := ItemReference."Reference No.";


            end;

        }
        //>>WDC01
        //<<WDC02
        field(50003; "Sales Line No."; Integer)
        {
            CaptionML = ENU = 'Sales Line No.', FRA = 'N° ligne client';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Finished Quantity"; Decimal)
        {
            CaptionML = ENU = 'Finished Quantity', FRA = 'Qté realisée';
            FieldClass = FlowField;
            CalcFormula = lookup("Prod. Order Line"."Finished Quantity" where("Prod. Order No." = field("No."), "Item No." = field("Source No.")));
            Editable = false;
        }
        //>>WDC02
        //<<WDC03
        field(50005; "External Sales Order No."; Code[35])
        {
            CaptionML = ENU = 'External Sales Order No.', FRA = 'N° commande client Externe';
            FieldClass = FlowField;
            calcFormula = lookup("Sales Header"."External Document No." where("Document Type" = filter(order), "No." = field("Sales Order No.")));
            Editable = false;
        }
        //<<WDC03
        //<<WDC04
        field(50006; "Customer Name"; text[100])
        {
            CaptionML = ENU = 'Customer Name', FRA = 'Nom client';
            FieldClass = FlowField;
            calcFormula = lookup("Sales Header"."Sell-to Customer Name" where("Document Type" = filter(order), "No." = field("Sales Order No.")));
            Editable = false;
        }
        //>>WDC04

    }


    trigger OnAfterInsert()
    begin
        "Assigned User ID" := userid;
    end;


}
