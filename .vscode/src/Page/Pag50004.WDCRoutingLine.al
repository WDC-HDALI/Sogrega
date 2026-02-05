namespace Sogrega.Sogrega;

using Microsoft.Manufacturing.Routing;

page 50004 "WDC Routing Line"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Routing Line', FRA = 'Lignes gammes';
    PageType = List;
    SourceTable = "Routing Line";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = all;
                }

                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = all;
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Run Time"; Rec."Run Time")
                {
                    ApplicationArea = all;
                }
                field("Next Operation No."; Rec."Next Operation No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
