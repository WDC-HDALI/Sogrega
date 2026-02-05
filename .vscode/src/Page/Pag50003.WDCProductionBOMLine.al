namespace Sogrega.Sogrega;

using Microsoft.Manufacturing.ProductionBOM;

page 50003 "WDC Production BOM Line"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Production BOM Line', FRA = 'Ligne nomenclature production';
    PageType = List;
    SourceTable = "Production BOM Line";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ApplicationArea = all;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
