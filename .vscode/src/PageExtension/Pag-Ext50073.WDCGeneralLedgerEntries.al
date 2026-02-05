namespace Sogrega.Sogrega;

using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Account;

pageextension 50073 "WDC G/L Account Card" extends "G/L Account Card"
{
    layout
    {
        addafter(Balance)
        {
            field("Balance Not Reviwed"; Rec."Balance Not Reviwed")
            {
                Editable = false;
                ApplicationArea = All;
            }

        }
    }
}
