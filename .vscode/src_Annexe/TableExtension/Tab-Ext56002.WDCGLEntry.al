namespace sogrega.sogrega;

using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Journal;

tableextension 56002 "WDC G/L Entry" extends "G/L Entry"
{
    fields
    {
        field(56000; "Withholding Tax Code"; Code[20])
        {
            CaptionML = ENU = 'Withholding Tax Code', FRA = 'Code de retenue à la source';
            FieldClass = FlowField;
            CalcFormula = lookup("G/L Account"."Withholding Tax Code" where("No." = field("G/L Account No.")));
        }
        field(56001; "Source Type Rs"; Enum "Gen. Journal Source Type")
        {
            CaptionML = ENU = 'Source Type Rs', FRA = 'Type origine RS';
            FieldClass = FlowField;
            CalcFormula = max("G/L Entry"."Source Type" where("Transaction No." = field("Transaction No."),
            "Source Type" = filter(Vendor | Customer),
            "G/L Account No." = filter('<>432*')));
        }
        field(56002; "Source No. Rs"; Code[10])
        {
            CaptionML = ENU = 'Source No. Rs', FRA = 'N° origine RS';
            FieldClass = FlowField;
            CalcFormula = max("G/L Entry"."Source No." where("Transaction No." = field("Transaction No."),
            "Source Type" = filter(Vendor | Customer),
            "G/L Account No." = filter('<>432*')));
        }

    }
}
