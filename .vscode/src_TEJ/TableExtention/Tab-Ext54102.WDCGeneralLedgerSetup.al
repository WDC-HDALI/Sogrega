tableextension 54102 WDCGeneralLedgerSetup extends "General Ledger Setup"
{
    fields
    {
        field(54100; "Withholding Tax Accounts"; Code[20])
        {
            CaptionML = FRA = 'Comptes retenu', ENU = 'Withholding Tax Accounts';
            DataClassification = ToBeClassified;
        }
        field(54101; "Incl VAT Withholding Tax Decl"; Boolean)
        {
            CaptionML = FRA = 'Inclure la TVA dans la déclaration de retenue', ENU = 'Include VAT in Withholding Tax Declaration';
            DataClassification = ToBeClassified;
        }
        field(54102; CNPC; Option)
        {
            CaptionML = ENU = 'CNPC', FRA = 'CNPC';
            DataClassification = ToBeClassified;
            OptionCaptionML = FRA = 'L''opération de retenue à la source a été effectuée selon le droit commun,l''opération de retenue à la source a été effectuée en vertu d''une convention de non double imposition',
                                ENU = 'The withholding tax operation was performed according to the general rule,the withholding tax operation was performed under a double taxation treaty';
            OptionMembers = "L''opération de retenue à la source a été effectuée selon le droit commun","l''opération de retenue à la source a été effectuée en vertu d''une convention de non double imposition";
        }
        field(54103; P_Charge; option)
        {
            CaptionML = ENU = 'P-Charge', FRA = 'P-Charge';
            DataClassification = ToBeClassified;
            OptionCaptionML = FRA = 'la retenue à la source n''a pas été prise en charge,La retenue à la source a été prise en charge',
                                ENU = 'withholding tax was not supported,withholding tax was supported';
            OptionMembers = "La retenue à la source n''a pas été prise en charge","La retenue à la source a été prise en charge";
        }
        field(54104; "TEJ Declaration No"; Code[20])
        {
            CaptionML = ENU = 'N° déclaration TEJ', FRA = 'TEJ Declaration No';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(54105; "Purch. Stamp Account No."; code[20])
        {
            CaptionML = ENU = 'Purch. Stamp Account No.', FRA = 'N° compte timbre achat';
            DataClassification = ToBeClassified;
            tableRelation = "G/L Account";
        }
    }
}
