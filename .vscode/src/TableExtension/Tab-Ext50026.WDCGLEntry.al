namespace Sogrega.Sogrega;

using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Account;

tableextension 50026 "WDC G/L Account" extends "G/L Account"
{
    fields
    {

        field(50000; "Balance Not Reviwed"; Decimal)
        {
            CaptionML = ENU = 'Balance Not Reviwed', FRA = 'Solde non révisé';
            AutoFormatType = 1;
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("No."),
                                                        "G/L Account No." = field(filter(Totaling)),
                                                        "Business Unit Code" = field("Business Unit Filter"),
                                                        Reviewed = const(false),
                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                        "Dimension Set ID" = field("Dimension Set ID Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

}
