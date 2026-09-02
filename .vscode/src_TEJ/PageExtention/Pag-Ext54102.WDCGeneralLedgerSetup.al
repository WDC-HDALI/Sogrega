pageextension 54102 WDCGeneralLedgerSetup extends "General Ledger Setup"
{
    layout
    {
        addafter(Application)
        {
            group(DeclarationRS)
            {
                CaptionML = FRA = 'Déclaration RS', ENU = 'Withholding Tax Declaration';
                field("Withholding Tax Accounts"; Rec."Withholding Tax Accounts")
                {
                    ApplicationArea = All;
                }
                field("Purch. Stamp Account No."; Rec."Purch. Stamp Account No.")
                {
                    ApplicationArea = All;
                }
                field("Incl VAT Withholding Tax Decl"; Rec."Incl VAT Withholding Tax Decl")
                {
                    ApplicationArea = All;
                }
                field(CNPC; Rec.CNPC)
                {
                    ApplicationArea = All;
                }
                field(P_Charge; Rec.P_Charge)
                {
                    ApplicationArea = All;
                }
                field("TEJ Declaration No"; Rec."TEJ Declaration No")
                {
                    ApplicationArea = All;
                }
                field("Column DEC RS Editable"; Rec."Column DEC RS Editable")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
