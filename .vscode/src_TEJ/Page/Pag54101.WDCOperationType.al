page 54101 "WDC Operation Type"
{
    ApplicationArea = All;
    CaptionML = FRA = 'Types opérations', ENU = 'Operation Type';
    PageType = List;
    SourceTable = "WDC Operation Type";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(IDTypeOperation; Rec."ID Type Operation")
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec."Category")
                {
                    ApplicationArea = All;
                }
                field("Designation"; Rec."Designation")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}
