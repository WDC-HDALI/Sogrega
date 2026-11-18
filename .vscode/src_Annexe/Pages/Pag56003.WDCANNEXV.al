page 56003 "WDC ANNEX V"
{
    captionML = ENU = 'Annex V', FRA = 'Annexe V';
    PageType = List;
    SourceTable = "WDC Declaration Employeur";
    SourceTableView = WHERE("Type Ligne Decl. Emp." = CONST("Annexe V"));
    applicationarea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sequence No."; Rec."Sequence No.")
                {
                    applicationarea = All;
                }
                field("Type Ligne Decl. Emp."; Rec."Type Ligne Decl. Emp.")
                {
                    applicationarea = All;
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    applicationarea = All;
                }
                field("Source Type Annxes"; Rec."Source Type Annxes")
                {
                    applicationarea = All;
                }
                field("Recap Line Code"; Rec."Recap Line Code")
                {
                    applicationarea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    applicationarea = All;
                }
                field("Source Name"; Rec."Source Name")
                {
                    applicationarea = All;
                }
                field("Source Type ID"; Rec."Source Type ID")
                {
                    applicationarea = All;
                }
                field("Source ID"; Rec."Source ID")
                {
                    applicationarea = All;
                }
                field("Source Activity"; Rec."Source Activity")
                {
                    applicationarea = All;
                }
                field("Source Address"; Rec."Source Address")
                {
                    applicationarea = All;
                }
                field("Sous type origine"; Rec."Sous type origine")
                {
                    applicationarea = All;
                }
                field("Base Withholding Amount"; Rec."Base Withholding Amount")
                {
                    applicationarea = All;
                }
                field("Withholding Amount"; Rec."Withholding Amount")
                {
                    applicationarea = All;
                }
                field("Net Amount Served"; Rec."Net Amount Served")
                {
                    applicationarea = All;
                }
                field("Discounts Amount"; Rec."Discounts Amount")
                {
                    applicationarea = All;
                }
                field("Amounts Sales PP Reg Flat"; Rec."Amounts Sales PP Reg Flat")
                {
                    applicationarea = All;
                }
                field("Advances On Sales PP Reg Flat"; Rec."Advances On Sales PP Reg Flat")
                {
                    applicationarea = All;
                }
                field("Taxable Income"; Rec."Taxable Income")
                {
                    applicationarea = All;
                }
                field("Nature Benefits"; Rec."Nature Benefits")
                {
                    applicationarea = All;
                }
                field("Reinvested Income"; Rec."Reinvested Income")
                {
                    applicationarea = All;
                }
                field("Withholding Amount Régime commun"; Rec."With. Amount Common Regime")
                {
                    applicationarea = All;
                }
                field("Total Withholding 20%"; Rec."Total Withholding 20%")
                {
                    applicationarea = All;
                }
                field("Total redevances caisse compen"; Rec."Total redevances caisse compen")
                {
                    applicationarea = All;
                }
                field("Total Contribution Conjoncture"; Rec."Total Contribution Conjoncture")
                {
                    applicationarea = All;
                }
                field("Amount Recovered in Cash"; Rec."Amount Recovered in Cash")
                {
                    applicationarea = All;
                }
                field("Date Quittance"; Rec."Quittance Date")
                {
                    applicationarea = All;
                }
                field("Quittance No."; Rec."Quittance No.")
                {
                    applicationarea = All;
                }
                field("Admin Fiscale"; Rec."Admin Fiscale")
                {
                    applicationarea = All;
                }
                field("% Withholding Tax"; Rec."% Withholding Tax")
                {
                    applicationarea = All;
                }
                field("Pos. mnt Brut dans Annexe"; Rec."Pos. mnt Brut dans Annexe")
                {
                    applicationarea = All;
                }
                field("Sous Pos. mnt Brut ds  Annexe"; Rec."Sous Pos. mnt Brut ds  Annexe")
                {
                    applicationarea = All;
                }
                field("Family Situation"; Rec."Family Situation")
                {
                    applicationarea = All;
                }
                field("Loaded childs"; Rec."Loaded childs")
                {
                    applicationarea = All;
                }
                field("Work Start Date"; Rec."Work Start Date")
                {
                    applicationarea = All;
                }
                field("Work End Date"; Rec."Work End Date")
                {
                    applicationarea = All;
                }
                field("Duration of work period (D)"; Rec."Duration of work period (D)")
                {
                    applicationarea = All;
                }
                field(Year; Rec.Year)
                {
                    applicationarea = All;
                }
                field(Archived; Rec.Archived)
                {
                    applicationarea = All;
                }
                field("Payed Amount Type"; Rec."Payed Amount Type")
                {
                    applicationarea = All;
                }
                field("Payed Amounts"; Rec."Payed Amounts")
                {
                    applicationarea = All;
                }
                field("Withholding Tax"; Rec."Withholding Tax")
                {
                    applicationarea = All;
                }
                field("Amount CSS"; Rec."Amount CSS")
                {
                    applicationarea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Calculer Annexe V")
            {
                applicationarea = All;
                Caption = 'Calculer Annexe V';
                Ellipsis = true;
                Image = Calculate;
                //RunObject = Report "WDC Calcul Dec Emp";
                promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    CalcDecEmp: Report "WDC Calcul Dec Emp";
                begin
                    CalcDecEmp.SetAnnexeID(5);
                    CalcDecEmp.Run();
                end;
            }
            action("Générer Annexe V")
            {
                applicationarea = All;
                Caption = 'Générer Annexe V';
                Ellipsis = true;
                Image = Export;
                RunObject = XMLport "WDC Annexe V-R";
                promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
            }
        }
    }
}

