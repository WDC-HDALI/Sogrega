namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Document;
/**********************************Documentation*********************
 //WDC01     WDC.HG     03/12/2024       create current object
 //WDC02     WDC.HG    18/12/2025        Show field "External Sales Order No."
 *********************************************************************/
pageextension 50051 "WDC Released Prod. Order Lines" extends "Released Prod. Order Lines"
{
    layout
    {
        addafter("Item No.")
        {
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = all;
            }

        }
        //<<WDC02
        addafter("Cost Amount")
        {
            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = all;
            }
            field("External Sales Order No."; Rec."External Sales Order No.")
            {
                ApplicationArea = all;
            }
        }
        //<<WDC02
    }
    trigger OnAfterGetRecord()
    var
        lProdOrder: record "Production Order";
    begin
        if (rec."External Sales Order No." = '') or (rec."Sales Order No." = '') then begin
            if lProdOrder.get(rec.Status, rec."Prod. Order No.") then begin
                lProdOrder.CalcFields("External Sales Order No.");
                rec."Sales Order No." := lProdOrder."Sales Order No.";
                rec."External Sales Order No." := lProdOrder."External Sales Order No.";
                rec.modify();
                CurrPage.update(false);
            end;
        end;
    end;

}
