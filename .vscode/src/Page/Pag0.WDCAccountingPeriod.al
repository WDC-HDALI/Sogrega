page 50011 "WDC Accounting Period"
{
    ApplicationArea = All;
    Caption = 'WDC Accounting Period';
    PageType = List;
    SourceTable = "Accounting Period";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                    ApplicationArea = all;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = all;
                }

                field("Date Locked"; Rec."Date Locked")
                {
                    ApplicationArea = all;
                }

            }

        }

    }
    actions
    {
        area(Creation)
        {
            action("Update Closed")
            {
                Image = UpdateDescription;
                ApplicationArea = all;
                CaptionML = FRA = 'Update Closed', ENU = 'Modif clôturé';
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.Closed := false;
                    rec."Date Locked" := false;
                    rec.Modify();
                end;
            }
        }
    }
}
