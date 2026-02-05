namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Document;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Tracking;
//********************Documentation**********************
//WDC01  WDC.HG  18/06/2025 Show Field
//WDC02  WDC.HG  08/09/2025 Show Field
//WDC03     WDC.HG    18/12/2025        Show field "External Sales Order No."
pageextension 50047 WDCReleasedProductionOrders extends "Released Production Orders"
{
    layout
    {

        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }
        addafter("Last Date Modified")
        {
            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = all;
            }
            //<<WDC03
            field("External Sales Order No."; Rec."External Sales Order No.")
            {
                ApplicationArea = all;
            }
            //>>WDC03
        }
        addafter("Routing No.")
        {
            field("Production Bom No."; Rec."Production Bom No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Source No.")
        {
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = all;
            }
        }

        addafter("No.")
        {
            field("Firm Planned Order No."; Rec."Firm Planned Order No.")
            {
                ApplicationArea = all;
            }
        }
        //<<WDC01
        addafter(Status)
        {
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = all;
                editable = false;
            }
        }
        //>>WDC01
        //<<WDC02
        addafter(Quantity)
        {
            field("Finished Quantity"; Rec."Finished Quantity")
            {
                ApplicationArea = all;
                DecimalPlaces = 0 : 5;
                MinValue = 0;
            }
            field(QuantityToInvoice; QuantityToInvoice)
            {
                CaptionML = ENU = 'Quantity To Invoice', FRA = 'Qté à facturer';
                ApplicationArea = all;
                editable = false;
                DecimalPlaces = 0 : 5;
                MinValue = 0;
            }
            field(QuantityInvoiced; QuantityInvoiced)
            {
                CaptionML = ENU = 'Qty Invoiced', FRA = 'Quantité facturée';
                ApplicationArea = all;
                editable = false;
                DecimalPlaces = 0 : 5;
                MinValue = 0;
            }
        }
        //>>WDC02


    }
    //<<WDC02
    trigger OnAfterGetRecord()
    var
        LProductionOrderLine: record "Prod. Order Line";
        lReservationEntry: record "Reservation Entry";
        lReservationEntry2: record "Reservation Entry";
        lSalesLine: record "Sales Line";
    begin
        QuantityInvoiced := 0;
        QuantityToInvoice := 0;
        LProductionOrderLine.reset();
        LProductionOrderLine.SetCurrentKey("Prod. Order No.", "Line No.", Status);
        LProductionOrderLine.setrange("Prod. Order No.", rec."No.");
        LProductionOrderLine.setrange("Item No.", rec."Source No.");
        if LProductionOrderLine.findset() then begin
            lReservationEntry.reset();
            lReservationEntry.SetCurrentKey("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
            lReservationEntry.setrange("Source ID", LProductionOrderLine."Prod. Order No.");
            lReservationEntry.setrange("Source Type", 5406);
            lReservationEntry.setrange("Source Prod. Order Line", LProductionOrderLine."Line No.");
            lReservationEntry.setrange("Reservation Status", lReservationEntry."Reservation Status"::Reservation);
            if lReservationEntry.FindSet() then begin
                lReservationEntry2.reset();
                lReservationEntry2.SetCurrentKey("Entry No.", Positive);
                lReservationEntry2.setrange("Entry No.", lReservationEntry."Entry No.");
                lReservationEntry2.setrange("Source Type", 37);
                if lReservationEntry2.FindSet() then begin
                    if lReservationEntry2."Source ID" = rec."Sales Order No." then begin
                        if lSalesLine.get(lSalesLine."Document Type"::Order, lReservationEntry2."Source ID", lReservationEntry2."Source Ref. No.") then begin
                            QuantityToInvoice := lSalesLine."Qty. to Invoice";
                            QuantityInvoiced := lSalesLine."Quantity Invoiced";
                        end;
                    end;
                end
            end;

        end;

    end;

    var
        QuantityToInvoice: Decimal;
        QuantityInvoiced: decimal;
    //>>WDC02
}
