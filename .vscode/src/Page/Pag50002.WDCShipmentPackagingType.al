namespace Sogrega.Sogrega;

page 50002 "WDC Shipment Packaging Type"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Shipment Packaging Type', FRA = 'Type colisage d''expédition';
    PageType = List;
    SourceTable = "WDC Shipment Packaging Type";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
