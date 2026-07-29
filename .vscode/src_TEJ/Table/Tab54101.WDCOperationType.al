table 54101 "WDC Operation Type"
{
    CaptionML = FRA = 'Types opérations', ENU = 'Operation Type';
    DataClassification = ToBeClassified;
    DrillDownPageId = "WDC Operation Type";
    LookupPageId = "WDC Operation Type";
    fields
    {
        field(1; "ID Type Operation"; Code[20])
        {
            CaptionML = FRA = 'ID Type opération', ENU = 'Operation Type ID';
        }
        field(2; "Category"; Text[500])
        {
            CaptionML = FRA = 'Catégorie', ENU = 'Category';
        }
        field(3; "Designation"; Text[1024])
        {
            CaptionML = FRA = 'Désignation', ENU = 'Designation';
        }
    }
    keys
    {
        key(PK; "ID Type Operation")
        {
            Clustered = true;
        }
    }
    var
        mm: Report 94;
}
