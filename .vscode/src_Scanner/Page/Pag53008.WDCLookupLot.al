namespace sogrega.sogrega;

using Microsoft.Inventory.Ledger;

page 53008 "WDC Lookup Lot"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Item availability by batch number', FRA = 'Disponibilité article par n° lot';
    PageType = List;
    SourceTable = "item ledger entry";
    editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = all;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
