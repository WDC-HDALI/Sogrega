namespace SogregaDev.SogregaDev;

using Microsoft.Sales.Document;

pageextension 50044 WDCSalesOrderPlanning extends "Sales Order Planning"
{
    Editable = true;

    layout
    {

        addbefore("Item No.")
        {
            field("Selected Line"; Rec."Selected Line")
            {
                ApplicationArea = all;
            }
        }
        addafter("Item No.")
        {
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = all;
            }
        }
        addbefore(Available)
        {
            field("ordred Qty"; Rec."ordred Qty")
            {
                ApplicationArea = all;
            }
        }
        modify("Item No.")
        {
            Editable = false;
        }
        modify("Planning Status")
        {
            Editable = false;
        }
        modify(Description)
        {
            Editable = false;
        }
        modify("Shipment Date")
        {
            Editable = false;
        }
        modify("Planned Quantity")
        {
            Editable = false;
        }
        modify(Available)
        {
            Editable = false;
        }
        modify("Next Planning Date")
        {
            Editable = false;
        }
        modify("Expected Delivery Date")
        {
            Editable = false;
        }
        modify("Needs Replanning")
        {
            Editable = false;
        }

    }

    actions
    {
        addfirst(Creation)
        {
            action(Select_Deselect)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                CaptionML = ENU = 'Select/Deselect', FRA = 'Sélectionner/Désélectionner';
                Image = SelectLineToApply;
                trigger OnAction()
                begin
                    SeelectDeselectAll();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        rec.ModifyAll("Selected Line", false);
    end;

    var
        SelectedAll: Boolean;

    procedure SeelectDeselectAll()
    var

    begin
        If Not SelectedAll then begin
            Rec.ModifyAll(Rec."Selected Line", true);
            SelectedAll := true;
            CurrPage.Update;
        end Else begin
            SelectedAll := false;
            Rec.ModifyAll(Rec."Selected Line", false);
            CurrPage.Update;
        end;

    end;

}
