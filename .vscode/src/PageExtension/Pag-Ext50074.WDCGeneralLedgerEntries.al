namespace Sogrega.Sogrega;

using Microsoft.Finance.GeneralLedger.Ledger;

pageextension 50074 "WDC General Ledger Entries" extends "General Ledger Entries"
{
    layout
    {
        addbefore(Amount)
        {
            field("Debit Amount_"; Rec."Debit Amount")
            {
                ApplicationArea = all;
            }
            field("Credit Amount_"; Rec."Credit Amount")
            {
                ApplicationArea = all;
            }
        }
    }
}
