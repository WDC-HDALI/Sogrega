namespace Sogrega.Sogrega;

using Microsoft.Inventory.Item;

pageextension 50041 "WDC Item Card" extends "Item Card"

{
    layout
    {

        modify("Description 2")
        {
            Visible = true;
        }
        addafter("No.")
        {
            field("Reference No."; Rec."Reference No.")
            {
                ApplicationArea = All;
            }
        }
        addlast(Replenishment_Production)
        {
            field("Production Moule Date"; Rec."Production Moule Date")
            {
                ApplicationArea = all;
            }
            field("Technical Description"; Rec."Technical Description")
            {
                ApplicationArea = all;
                MultiLine = true;
            }
        }
        addafter(Inventory)
        {
            group(stockdetails)
            {
                CaptionML = ENU = 'stock details', FRA = 'détails stock';
                field("Inventory-BA"; Rec."Inventory-BA")
                {
                    ApplicationArea = all;

                }
                field("Inventory-MJ"; Rec."Inventory-MJ")
                {
                    ApplicationArea = all;

                }
            }
        }
        addafter("Net Weight")
        {
            field(PositiveWeightTolerance; rec."Positive Weight Tolerance %")
            {
                ApplicationArea = all;
            }
            field(NegativeWeightTolerance; rec."Negative Weight Tolerance %")
            {
                ApplicationArea = all;
            }

        }

    }
}
