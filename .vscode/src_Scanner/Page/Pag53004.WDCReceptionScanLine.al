namespace sogrega.sogrega;
using Microsoft.Warehouse.History;

page 53004 "WDC ReceptionScanLine"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Scanned Reception Lines', FRA = 'Lignes réception Scannées';
    PageType = List;
    SourceTable = "Reception Scan Buffer";
    SourceTableView = where("Is Validated" = filter(true));
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(LineNo; Rec."Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(ItemNo; Rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Variante Code"; Rec."Variante Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Quantity; Rec."Quantity to Receive")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Qty Par"; Rec."Qty Par")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(CreatedDateTime; Rec."Created DateTime")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(validated; Rec."Is Validated")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field(userid; Rec."User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(sitecode; Rec."Site Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(receiptNo; rec."Posted Reception No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(PrintLabel)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Print Label', FRA = 'Imprimer étiquette';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    lwarehouseReceiptHeader: Record "Posted Whse. Receipt Header";
                    ScanBuffer: record "Reception Scan Buffer";
                    scanlabel: report "WDC Scan Label";
                begin
                    lwarehouseReceiptHeader.reset();
                    lwarehouseReceiptHeader.SetRange("No.", rec."Posted Reception No.");
                    if lwarehouseReceiptHeader.FindSet() then begin
                        ScanLabel.SetTableView(lwarehouseReceiptHeader);
                        ScanLabel.Run();
                    end
                end;
            }
        }
    }
}
