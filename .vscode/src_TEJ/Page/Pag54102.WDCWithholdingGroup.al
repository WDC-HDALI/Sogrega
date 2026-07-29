page 54102 "WDC Withholding Group"
{
    ApplicationArea = All;
    CaptionML = FRA = 'Groupe retenu', ENU = 'Withholding Group';
    PageType = List;
    SourceTable = "WDC Withholding Group";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                CaptionML = ENU = 'General', FRA = 'Générale';
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("% Retenue"; Rec."% Withholding Tax")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax Account"; Rec."Withholding Tax Account")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax Type"; Rec."Withholding Tax Type")
                {
                    ApplicationArea = All;
                }
                field(Proposition; Rec.Proposition)
                {
                    ApplicationArea = All;
                }
                field(Annexe; Rec.Annexe)
                {
                    ApplicationArea = All;
                }
                field("Pos. mnt Brut dans Annexe"; Rec."Pos. mnt Brut dans Annexe")
                {
                    ApplicationArea = All;
                }
                field("Sous Pos. mnt Brut ds  Annexe"; Rec."Sous Pos. mnt Brut ds  Annexe")
                {
                    ApplicationArea = All;
                }
                field("Activated"; Rec."Activated")
                {
                    ApplicationArea = All;
                }
                field(Ristourne; Rec.Ristourne)
                {
                    ApplicationArea = All;
                }
                field("R.S Activated"; Rec."R.S Activated")
                {
                    ApplicationArea = All;
                }
                field("Start Activation Date"; Rec."Start Activation Date")
                {
                    ApplicationArea = All;
                }
                field("Priority"; Rec."Priority")
                {
                    ApplicationArea = All;
                }
                field("Type Ligne Decl. Emp."; Rec."Type Ligne Decl. Emp.")
                {
                    ApplicationArea = All;
                }
                field("Sous Pos Mnt Brut ds Annexe"; Rec."Sous Pos Mnt Brut ds Annexe")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
