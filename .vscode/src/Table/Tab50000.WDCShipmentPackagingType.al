table 50000 "WDC Shipment Packaging Type"
{
    CaptionML = ENU = 'Shipment Packaging Type', FRA = 'Type colisage d''expédition';
    DataClassification = ToBeClassified;
    DrillDownPageId = "WDC Shipment Packaging Type";
    LookupPageId = "WDC Shipment Packaging Type";

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        field(2; Description; Text[100])
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
