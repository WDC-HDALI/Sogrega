
pageextension 50026 "WDC Warehouse Shipment" extends "Warehouse Shipment"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object
    //WDC02 CHG 30/08/2024 Add action "Extract line whse"
    //WDC03 HG   29/08/2025 Show "Customer No." field 
    layout
    {
        addLast(General)
        {
            field("Gross_Weight"; Rec."Gross Weight")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = Rec.Status <> Rec.Status::Released;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = Rec.Status <> Rec.Status::Released;
            }
            field("Number of Packages"; Rec."Number of Packages")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = Rec.Status <> Rec.Status::Released;
            }
            field("Packing Type"; Rec."Packing Type")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = Rec.Status <> Rec.Status::Released;
                MultiLine = true;

            }
            //<<WDC03   
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            //>>WDC03

        }
    }
    actions
    {

        addafter("Get Source Documents")
        {
            action(GetPostedDocumentLinesToReverse)
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Suite;
                CaptionML = ENG = 'Get SalesLines', FRA = 'Extraire lignes';
                Ellipsis = true;
                Image = ReverseLines;
                Enabled = Rec.Status <> Rec.Status::Released;
                trigger OnAction()
                begin
                    ExtractOrdersLines();
                end;
            }
        }


    }
    procedure ExtractOrdersLines()
    var
        lSalesLine: Record "Sales Line";
        lwhseList: page "WDC Sales Extract Lines";
        lWarehouseShipmentLine: record "Warehouse Shipment Line";
    begin
        Clear(SalesExtractLine);
        SalesReceivablesSetup.Get();
        ShipDate := CalcDate(SalesReceivablesSetup."Last Shipping Date Filter", WorkDate());
        lSalesLine.reset;
        lSalesLine.SetCurrentKey("Document Type", "Document No.", "Line No.");
        lSalesLine.SetRange("Document Type", lSalesLine."Document Type"::Order);
        lSalesLine.SetRange(Type, lSalesLine.Type::Item);
        lSalesLine.SetFilter("Outstanding Quantity", '>%1', 0);
        lSalesLine.SetRange("Whse. Outstanding Qty.", 0);
        //lSalesLine.SetFilter("Shipment Date", '<%1', shipDate); //Commented by request Sami
        lSalesLine.SetFilter("Location Code", '%1', rec."Location Code");
        lSalesLine.CalcFields(Status);
        lSalesLine.setrange("status", lSalesLine.status::Released);
        if lSalesLine.FindSet() then begin
            SalesExtractLine.SetTableView(lSalesLine);
            SalesExtractLine.LOOKUPMODE(TRUE);
            if SalesExtractLine.RUNMODAL = ACTION::LookupOK then begin
                SalesExtractLine.SetSelectionFilter(lSalesLine);
                if lSalesLine.findset then
                    repeat
                        lWarehouseShipmentLine.Init();
                        lWarehouseShipmentLine."No." := rec."No.";
                        lWarehouseShipmentLine."Reference No." := lSalesLine."Item Reference No.";
                        lWarehouseShipmentLine.Matricule := lSalesLine."Matricule";
                        lWarehouseShipmentLine."Location Code" := rec."Location Code";
                        lWarehouseShipmentLine."Source Type" := 37;
                        lWarehouseShipmentLine."Source Subtype" := 1;
                        lWarehouseShipmentLine."Source No." := lSalesLine."Document No.";
                        lWarehouseShipmentLine."Source Document" := lSalesLine."Document type"::Order;
                        lWarehouseShipmentLine."Line No." := SalesExtractLine.GetLineNo(rec."No.");
                        lWarehouseShipmentLine."Item No." := lSalesLine."No.";
                        lWarehouseShipmentLine.Description := lSalesLine.Description;
                        lWarehouseShipmentLine."Source Line No." := lSalesLine."Line No.";
                        lWarehouseShipmentLine."Unit of Measure Code" := lSalesLine."Unit of Measure code";
                        lWarehouseShipmentLine.Validate(Quantity, lSalesLine.Quantity - lSalesLine."Quantity Shipped");
                        lWarehouseShipmentLine.Insert();
                    until lSalesLine.Next() = 0;
                Rec."Customer No." := lSalesLine."Sell-to Customer No.";//<<WDC03


            end;

        end;
    end;

    var
        WhseNo: code[20];
        SalesExtractLine: page "WDC Sales Extract Lines";
        RemainingQty: decimal;
        ShipDate: Date;
        SalesReceivablesSetup: record "Sales & Receivables Setup";
}
