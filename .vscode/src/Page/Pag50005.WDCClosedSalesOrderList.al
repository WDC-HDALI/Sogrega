namespace Sogrega.Sogrega;
using Microsoft.Sales.Document;

page 50005 "WDC Closed Sales Order List"
{
    ApplicationArea = All;
    CaptionML = ENU = 'WDC Closed Sales Order List', FRA = 'Commandes vente clôturées';
    PageType = List;
    Editable = false;
    QueryCategory = 'Sales Order List';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = where("Document Type" = const(Order),
                            "Order Closed" = const(true));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a unique number that identifies the sales order. The number can be generated automatically from a number series, or you can number each of them manually.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the customer that you''re selling to. By default, the same customer is suggested as the ship-to customer. If needed, you can specify a different ship-to customer on the document.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the customer that you''re selling to. By default, the same customer is suggested as the ship-to customer. If needed, you can specify a different ship-to customer on the document.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                }

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the location from where inventory items to the customer on the sales document are to be shipped by default.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }

                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';
                }

                field("Completely Shipped"; Rec."Completely Shipped")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies whether all the items on the order have been shipped or, in the case of inbound items, completely received.';

                    AboutTitle = 'Is the order completely shipped?';
                    AboutText = 'Sales orders stay in this list until their order quantities are fully shipped and invoiced. After that you can find them in the Posted Sales Invoice and Posted Sales Shipment lists.';
                }
                field("Amt. Ship. Not Inv. (LCY) Base"; Rec."Amt. Ship. Not Inv. (LCY) Base")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum, in LCY, for items that have been shipped but not yet been invoiced. The amount is calculated as Amount Including VAT x Qty. Shipped Not Invoiced / Quantity.';
                }
                field("Amt. Ship. Not Inv. (LCY)"; Rec."Amt. Ship. Not Inv. (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum, in LCY, for items that have been shipped but not yet been invoiced. The amount is calculated as Amount Including VAT x Qty. Shipped Not Invoiced / Quantity.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of amounts on all the lines in the document. This will include invoice discounts.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of amounts, including VAT, on all the lines in the document. This will include invoice discounts.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(CloseOrder)
            {
                CaptionML = ENU = 'Cancel Closing Order', FRA = 'Annuler clôture commande';
                Image = Close;
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                var
                    lText01: TextConst ENU = 'Do you want to cancel closing the order?', FRA = 'Voulez-vous annuler la clôture de la commande?';
                begin
                    if Confirm(lText01) then begin
                        Rec."Order Closed" := false;
                        Rec.Modify;
                    end;
                end;
            }
        }

    }

}
