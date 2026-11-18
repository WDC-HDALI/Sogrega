tableextension 56004 "WDC GL Setup TableExt" extends "General Ledger Setup"
{

    fields
    {
        field(56000; "WDC Codes Retenue Annexe I"; Text[250])
        {
            CaptionML = ENU = 'Annex I Withholding Codes', FRA = 'Codes retenue Annexe I';
            DataClassification = ToBeClassified;
        }
        field(56001; "WDC Codes Retenue Annexe II"; Text[250])
        {
            CaptionML = ENU = 'Annex II Withholding Codes', FRA = 'Codes retenue Annexe II';
            DataClassification = ToBeClassified;
            //TableRelation = "WDC Withholding Group";
        }
        // field(56002; "WDC Codes Retenue Annexe IV"; Text[250])
        // {
        //     CaptionML = ENU = 'Annex IV Withholding Codes', FRA = 'Codes retenue Annexe IV';
        //     DataClassification = ToBeClassified;
        // }
        field(56003; "WDC Codes Retenue Annexe V"; Text[250])
        {
            CaptionML = ENU = 'Annex V Withholding Codes', FRA = 'Codes retenue Annexe V';
            DataClassification = ToBeClassified;
            //TableRelation = "WDC Withholding Group";
        }
        field(56004; "WDC Codes Retenue VI Ristourne"; Text[250])
        {
            CaptionML = ENU = 'Annex VI Withholding Codes - Rebate', FRA = 'Codes retenue Annexe VI - Ristourne';
            DataClassification = ToBeClassified;
            //TableRelation = "WDC Withholding Group";
        }
        field(56005; "WDC Codes Retenue VI Avance"; Text[250])
        {
            CaptionML = ENU = 'Annex VI Withholding Codes - Advance', FRA = 'Codes retenue Annexe VI - Avance';
            DataClassification = ToBeClassified;
            //TableRelation = "WDC Withholding Group";
        }
        field(56006; "WDC Codes Retenue VI Especes"; Text[250])
        {
            CaptionML = ENU = 'Annex VI Withholding Codes - Cash', FRA = 'Codes retenue Annexe VI - Espèces';
            DataClassification = ToBeClassified;
            //TableRelation = "WDC Withholding Group";
        }
    }

}
