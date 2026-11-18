pageextension 56004 "WDC GL Setup PageExt" extends "General Ledger Setup"
{
    layout
    {
        addlast(content)
        {
            group(WDCCodesRetenue)
            {
                Caption = 'Codes retenue par annexe';

                field("WDC Codes Retenue Annexe I"; Rec."WDC Codes Retenue Annexe I")
                {
                    ApplicationArea = All;
                    ToolTip = 'Un seul code (exemple : RSAL)';
                }
                field("WDC Codes Retenue Annexe II"; Rec."WDC Codes Retenue Annexe II")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codes séparés par | (exemple : 5%|3%|10%)';
                }
                // field("WDC Codes Retenue Annexe IV"; Rec."WDC Codes Retenue Annexe IV")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Codes séparés par | (exemple : 5%|3%|10%)';
                // }
                field("WDC Codes Retenue Annexe V"; Rec."WDC Codes Retenue Annexe V")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codes séparés par | (exemple : 0,5%|1%|1,50%)';
                }
                field("WDC Codes Retenue VI Ristourne"; Rec."WDC Codes Retenue VI Ristourne")
                {
                    ApplicationArea = All;
                    ToolTip = 'Codes séparés par | (exemple : RCIST|RCIST2)';
                }
                field("WDC Codes Retenue VI Avance"; Rec."WDC Codes Retenue VI Avance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Un seul code (exemple : RF1%)';
                }
                field("WDC Codes Retenue VI Especes"; Rec."WDC Codes Retenue VI Especes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Un seul code (exemple : ESPCOUV)';
                }
            }
        }
    }
}