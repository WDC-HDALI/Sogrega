pageextension 50033 "WDC Posted Purchase Receipts" extends "Posted Purchase Receipts"
{
    //*************Documentation***************************
    //WDC01  HD  29/08/2024  Create the current object
    //WDC02  HG  19/03/2026  Add Action Purchase Receipts print

    layout
    {
        addbefore("Location Code")
        {
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                editable = false;
            }
            field("ShortcutDimension1Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = all;
                ShowMandatory = true;
                editable = false;
            }
        }

    }
    actions
    {
        addafter("&Print")
        {
            action(PrintPurchaseReceipts)
            {
                CaptionML = ENU = 'Print Purchase Receipts', FRA = 'Imprimer réceptions achat';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                image = Print;
                trigger OnAction()
                var
                    lPurchaseHeader: record "Purchase Header";
                begin
                    lPurchaseHeader.SetRange("Document Type", lPurchaseHeader."Document Type"::Order);
                    lPurchaseHeader.SetRange("No.", rec."Order No.");
                    lPurchaseHeader.setrange("Buy-from Vendor No.", rec."Buy-from Vendor No.");
                    if lPurchaseHeader.FindSet() then
                        report.run(50095, true, false, lPurchaseHeader);
                end;
            }
        }
    }


}