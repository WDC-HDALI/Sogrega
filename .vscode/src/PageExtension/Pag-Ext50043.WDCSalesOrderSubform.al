namespace SogregaDev.SogregaDev;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Tracking;
//WDC01  WDC.HG 16/12/2024   Show fields 
pageextension 50043 WDCSalesOrderSubform extends "Sales Order Subform"
{
    layout
    {

        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            visible = false;
        }
        modify("Item Charge Qty. to Handle")
        {
            visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Planned Shipment Date")
        {
            Visible = false;
        }
        modify("Planned Delivery Date")
        {
            Visible = false;
        }
        modify("Requested Delivery Date")
        {
            Visible = true;
        }
        modify("Promised Delivery Date")
        {
            Visible = true;
        }

        addbefore(Type)
        {
            field("Line No._"; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Reserved Quantity")
        {
            field("Reserved from"; Rec."Reserved from")
            {
                ApplicationArea = all;
            }
        }
        //<<WDC01
        addafter("Shortcut Dimension 1 Code")
        {
            field(Matricule; Rec.Matricule)
            {
                ApplicationArea = all;
            }
            field(Model; Rec.Model)
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Model', FRA = 'Model';
            }
            field(finition; Rec.finition)
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Nayl-Finition', FRA = 'Nayl-Finition';
            }
            field(vernis; Rec.vernis)
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Nayl-Vernis', FRA = 'Nayl-Vernis';
            }
            field(DueDateGap; Rec.DueDateGap)
            {
                ApplicationArea = all;
                CaptionML = ENU = 'AZ-DueDate', FRA = 'AZ-écheance';
                Visible = VisibleAZ;
            }
            field(BlockingLevel; Rec.BlockingLevel)
            {
                ApplicationArea = all;
                CaptionML = ENU = 'AZ-Blocking', FRA = 'AZ-Blockage';
                Visible = VisibleAZ;
            }
            field("Cust. Order No."; Rec."Cust. Order No.")
            {
                ApplicationArea = all;
            }
            field("Cust. Line No."; Rec."Cust. Line No.")
            {
                ApplicationArea = all;
            }
        }

        moveafter("Cust. Line No."; "Requested Delivery Date")
        moveafter("Requested Delivery Date"; "Promised Delivery Date")
        //>>WDC01

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

    procedure SetVisibility(pVisibleAZ: Boolean)
    var

    begin
        VisibleAZ := pVisibleAZ
    end;

    var
        VisibleAZ: Boolean;

}
