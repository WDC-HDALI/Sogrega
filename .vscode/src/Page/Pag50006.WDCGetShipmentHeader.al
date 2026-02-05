//*************Documentation***************************
//WDC01  IM  25/03/2025  Create this current object
page 50006 "WDC Get Shipment Header"
{
    CaptionML = ENU = 'Get Shipment Header', FRA = 'Extraire lignes expédition';
    Editable = false;
    PageType = List;
    SourceTable = "Sales Shipment Header";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("Posted Whse Shp No."; Rec."Posted Whse Shp No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                { ApplicationArea = All; }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = ALL;
                }

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }

            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(CARD)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Card', FRA = 'Fiche';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Card;
                trigger OnAction()
                var
                    lPostedWhseShptHeader: Record "Posted Whse. Shipment Header";
                    lPostedwheseShpPage: Page "Posted Whse. Shipment";
                begin
                    lPostedWhseShptHeader.Reset();
                    lPostedWhseShptHeader.SetRange("No.", Rec."Posted Whse Shp No.");
                    if lPostedWhseShptHeader.FindSet() then begin
                        lPostedwheseShpPage.SetTableView(lPostedWhseShptHeader);
                        lPostedwheseShpPage.RunModal();
                    end;
                end;
            }
        }
    }
    trigger OnOpenPage()
    var

        SalesShptHeader: Record "Sales Shipment Header";
        lSalesShptLine: Record "Sales Shipment Line";
        myInt: Integer;
    begin
        SalesShptHeader.Reset();
        SalesShptHeader.SetCurrentKey("Bill-to Customer No.");
        SalesShptHeader.SetRange("Bill-to Customer No.", SalesHeader."Bill-to Customer No.");
        SalesShptHeader.SetRange("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
        SalesShptHeader.SetRange("Currency Code", SalesHeader."Currency Code");
        if SalesShptHeader.FindSet() then begin
            repeat
                lSalesShptLine.Reset();
                lSalesShptLine.SetCurrentKey("Bill-to Customer No.");
                lSalesShptLine.SetRange("Bill-to Customer No.", SalesShptHeader."Bill-to Customer No.");
                lSalesShptLine.SetRange("Document No.", SalesShptHeader."No.");
                lSalesShptLine.SetRange("Currency Code", SalesShptHeader."Currency Code");
                lSalesShptLine.SetFilter("Qty. Shipped Not Invoiced", '<>0');
                lSalesShptLine.SetRange("Authorized for Credit Card", false);
                if lSalesShptLine.FindSet() then begin
                    Rec.Init();
                    Rec := SalesShptHeader;
                    Rec.Insert();
                end;
            until (SalesShptHeader.Next() = 0)
        end;
    end;

    trigger OnQueryClosePage(CloseAction: Action) Result: Boolean
    var
        IsHandled: Boolean;
    begin
        if CloseAction in [ACTION::OK, ACTION::LookupOK] then
            CreateLines();
    end;

    procedure SetSalesHerder(pSalesHeader: Record "Sales Header")
    begin
        SalesHeader := pSalesHeader;
    end;

    procedure CreateLines()
    var
        Window: Dialog;
        LineCount: Integer;
        lSalesShptLine: Record "Sales Shipment Line";
        SalesLine: Record "Sales Line";
        lSalesOrderLine: Record "Sales Line";
        Text002: Label 'Creating Sales Invoice Lines\';
        Text003: Label 'Inserted lines             #1######';
        TransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
    begin
        CurrPage.SetSelectionFilter(Rec);
        if Rec.FindSet() then begin
            Window.Open(Text002 + Text003);
            repeat
                lSalesShptLine.Reset();
                lSalesShptLine.SetCurrentKey("Bill-to Customer No.");
                lSalesShptLine.SetRange("Bill-to Customer No.", Rec."Bill-to Customer No.");
                lSalesShptLine.SetRange("Document No.", Rec."No.");
                lSalesShptLine.SetRange("Currency Code", Rec."Currency Code");
                lSalesShptLine.SetFilter("Qty. Shipped Not Invoiced", '<>0');
                lSalesShptLine.SetRange("Authorized for Credit Card", false);
                if lSalesShptLine.FindSet() then begin
                    InsertComment(lSalesShptLine);
                    InitCurrency(lSalesShptLine."Currency Code");
                    repeat
                        lSalesOrderLine.GET(SalesLine."Document Type"::Order, lSalesShptLine."Order No.", lSalesShptLine."Order Line No.");
                        LineCount := LineCount + 1;
                        Window.Update(1, LineCount);
                        SalesLine.init();
                        SalesLine := lSalesOrderLine;
                        SalesLine."Line No." := GetLastLineNo;
                        SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine."Variant Code" := lSalesShptLine."Variant Code";
                        SalesLine."Location Code" := lSalesShptLine."Location Code";
                        SalesLine."Drop Shipment" := lSalesShptLine."Drop Shipment";
                        SalesLine."Shipment No." := lSalesShptLine."Document No.";
                        SalesLine."Shipment Line No." := lSalesShptLine."Line No.";
                        SalesLine.Validate(Quantity, lSalesShptLine.Quantity - lSalesShptLine."Quantity Invoiced");
                        SalesLine."Qty. to Invoice" := lSalesShptLine.Quantity - lSalesShptLine."Quantity Invoiced";
                        SalesLine."Qty. to Ship" := 0;
                        SalesLine.Validate("Unit Price", lSalesOrderLine."Unit Price");
                        SalesLine."Allow Line Disc." := lSalesOrderLine."Allow Line Disc.";
                        SalesLine."Allow Invoice Disc." := lSalesOrderLine."Allow Invoice Disc.";
                        lSalesOrderLine."Line Discount Amount" :=
                          Round(
                            lSalesOrderLine."Line Discount Amount" * SalesLine.Quantity / lSalesOrderLine.Quantity,
                            Currency."Amount Rounding Precision");
                        SalesLine.Validate("Line Discount Amount", lSalesOrderLine."Line Discount Amount");
                        SalesLine."Line Discount %" := lSalesOrderLine."Line Discount %";
                        SalesLine.UpdatePrePaymentAmounts();
                        if SalesLine."Allow Invoice Disc." then
                            SalesLine.Validate("Inv. Discount Amount", Round(
                                lSalesOrderLine."Inv. Discount Amount" * SalesLine.Quantity / lSalesOrderLine.Quantity,
                                Currency."Amount Rounding Precision"))
                        else
                            SalesLine.Validate("Inv. Discount Amount", 0);
                        SalesLine."Attached to Line No." := TransferOldExtLines.TransferExtendedText(lSalesOrderLine."Line No.", GetLastLineNo, lSalesShptLine."Attached to Line No.");
                        SalesLine."Shortcut Dimension 1 Code" := lSalesShptLine."Shortcut Dimension 1 Code";
                        SalesLine."Shortcut Dimension 2 Code" := lSalesShptLine."Shortcut Dimension 2 Code";
                        SalesLine."Dimension Set ID" := lSalesShptLine."Dimension Set ID";
                        SalesLine.Insert();
                    until (lSalesShptLine.Next() = 0);
                end;
            until (Rec.Next() = 0);
            Window.Close();
        end;
    end;

    procedure GetLastLineNo(): Integer
    var
        lSalesLine: Record "Sales Line";
    begin
        lSalesLine.Reset();
        lSalesLine.SetRange("Document Type", lSalesLine."Document Type"::Invoice);
        lSalesLine.SetRange("Document No.", SalesHeader."No.");
        if lSalesLine.FindLast() then
            exit(lSalesLine."Line No." + 10000)
        else
            exit(10000);
    end;

    procedure InsertComment(pSalesShptLine: Record "Sales Shipment Line")
    var
        lSalesHeader: Record "Sales Header";
        lSalesLine: Record "Sales Line";
        ltext001: Label ' BCC: %1';
    begin
        lSalesHeader.GET(lSalesHeader."Document Type"::Order, pSalesShptLine."Order No.");
        lSalesLine.Init();
        lSalesLine."Line No." := GetLastLineNo;
        lSalesLine."Document Type" := SalesHeader."Document Type";
        lSalesLine."Document No." := SalesHeader."No.";
        lSalesLine.Description := StrSubstNo(ltext001, lSalesHeader."External Document No.");
        lSalesLine.Insert();
    end;

    local procedure InitCurrency(CurrencyCode: Code[10])
    begin
        if (Currency.Code = CurrencyCode) then
            exit;

        if CurrencyCode <> '' then
            Currency.Get(CurrencyCode)
        else
            Currency.InitRoundingPrecision();
    end;

    var
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
}