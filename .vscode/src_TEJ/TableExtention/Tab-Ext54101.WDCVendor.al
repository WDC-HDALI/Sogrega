tableextension 54101 WDCVendor extends Vendor
{
    fields
    {
        // field(54100; "VAT Registration No."; Text[30])
        // {
        //     CaptionML = FRA = 'Matricule Fiscal', ENU = 'Tax Registration Number';
        //     DataClassification = ToBeClassified;
        // }
        field(54101; "Vendor Type"; Option)
        {
            CaptionML = FRA = 'Type Fournisseur', ENU = 'Vendor Type';
            DataClassification = ToBeClassified;
            OptionMembers = "Personne Morale","Personne Physique";
            OptionCaptionML = FRA = 'Personne Morale,Personne Physique',
                          ENU = 'Legal Entity,Individual';
        }
        field(54102; "Resident"; option)
        {
            CaptionML = FRA = 'Résident en Tunisie', ENU = 'Resident';
            DataClassification = ToBeClassified;
            OptionMembers = Resident,NonResident;
            OptionCaptionML = FRA = 'Résident,Non Résident',
                           ENU = 'Resident,Non Resident';
        }
        field(54103; Activité; code[100])
        {
            CaptionML = FRA = 'Activité', ENU = 'Activity';
            DataClassification = ToBeClassified;
        }
        field(54104; "Birth Date"; Date)
        {
            CaptionML = FRA = 'Date de naissance', ENU = 'Birth Date';
            DataClassification = ToBeClassified;
        }
        field(54105; "Identification Type"; Enum "WDC Identification Type")
        {
            CaptionML = ENU = 'Identification Type', FRA = 'Type d''identification';
            DataClassification = ToBeClassified;
        }
    }
}
