namespace sogrega.sogrega;

using Microsoft.Manufacturing.Document;
//*************Documentation*****************************
//WDC01     WDC.HG    18/12/2025        Create current object : Show field "External Sales Order No."
pageextension 50071 WDCProdOrderLinesList extends "Prod. Order Line List"
{
    layout
    {
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

    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
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
