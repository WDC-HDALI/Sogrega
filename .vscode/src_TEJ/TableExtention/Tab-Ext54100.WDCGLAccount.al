tableextension 54100 WDCGLAccount extends "G/L Account"
{
    fields
    {
        field(54100; "ID Type Operation"; code[20])
        {
            CaptionML = FRA = 'ID type opération', ENU = 'ID Type Operation';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Operation Type";
        }
        field(54101; "Withholding Tax Code"; code[10])
        {
            CaptionML = FRA = 'Code retenue à la source', ENU = 'Withholding Tax Code';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Withholding Group".Code;
        }

    }
}
