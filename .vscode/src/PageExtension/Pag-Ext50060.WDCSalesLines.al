namespace SogregaDev.SogregaDev;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Tracking;
using Microsoft.Manufacturing.Journal;
using Microsoft.Inventory.Ledger;
using Microsoft.Sales.Document;

pageextension 50060 "WDC Sales Lines" extends "Sales Lines"
{

    layout
    {

        addafter("Document No.")
        {
            field("Line No._"; Rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("Cust. Order No."; Rec."Cust. Order No.")
            {
                ApplicationArea = All;
            }
            field("Cust. Line No."; Rec."Cust. Line No.")
            {
                ApplicationArea = All;
            }

        }

        addafter("No.")
        {

            field("Item Reference No."; Rec."Item Reference No.")
            {
                ApplicationArea = All;
            }
            field("Reserved from"; Rec."Reserved from")
            {
                ApplicationArea = all;
            }
        }
        modify(Reserve)
        {
            visible = false;
        }
        // modify("Outstanding Quantity")
        // {
        //     // Visible = false;
        // }

        moveafter(Quantity; "outstanding Quantity")


    }
    trigger OnAfterGetRecord()
    var
        lreservationEntries: Record "Reservation Entry";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
    begin
        lreservationEntries.Reset();
        lreservationEntries.SetRange("Source Type", lreservationEntries."Source Subtype"::"1");
        lreservationEntries.SetRange("Source ID", rec."Document No.");
        lreservationEntries.SetRange("Source Ref. No.", rec."Line No.");
        lreservationEntries.SetRange("Reservation Status", lreservationEntries."Reservation Status"::Reservation);
        lreservationEntries.SetRange("Source Type", 37);
        if lreservationEntries.FindFirst() then begin
            rec."Reserved from" := ReservEngineMgt.CreateFromText(lreservationEntries);
        end;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        rec.SetRange("Document Type", rec."Document Type"::Order);
        rec.SetFilter(type, '<>%1', rec.type::" ");
        CurrPage.update(false);
    end;

}
