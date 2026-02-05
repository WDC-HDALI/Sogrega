namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Document;
/**********************************Documentation*********************
 //WDC01     WDC.HG        03/12/2024    create current object 
 //WDC01     WDC.HG        18/12/2025    Add New field 
 *********************************************************************/


tableextension 50017 "WDC Prod. Order Line" extends "Prod. Order Line"
{
    fields
    {
        field(50000; "Reference No."; Code[50])
        {
            CaptionML = ENU = 'Reference No.', FRA = 'N° référence';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                ItemReference: record 5777;
            begin
                "Reference No." := '';
                ItemReference.reset;
                ItemReference.SetRange("Reference Type", ItemReference."Reference Type"::Customer);
                ItemReference.SetRange("Item No.", "Item No.");
                if ItemReference.FindFirst() then
                    "Reference No." := ItemReference."Reference No.";


            end;

        }
        //<<WDC02
        field(50001; "Sales Order No."; Code[20])
        {
            CaptionML = ENU = 'Sales Order No.', FRA = 'N° commande client';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50002; "External Sales Order No."; Code[35])
        {
            CaptionML = ENU = 'External Sales Order No.', FRA = 'N° commande client Externe';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        //<<WDC02
    }
}

