pageextension 54100 WDCChartofAccounts extends "Chart of Accounts"
{
    layout
    {
        addafter("Default Deferral Template Code")
        {
            field("ID Type Operation"; Rec."ID Type Operation")
            {
                ApplicationArea = All;
            }
            field("Code Retenue a la Source"; Rec."Withholding Tax Code")
            {
                ApplicationArea = All;
            }

        }
    }
}
