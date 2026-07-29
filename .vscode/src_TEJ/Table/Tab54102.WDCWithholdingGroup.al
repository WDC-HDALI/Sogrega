table 54102 "WDC Withholding Group"
{
    CaptionML = FRA = 'Groupe retenue', ENU = 'Withholding Group';
    DataClassification = ToBeClassified;
    DrillDownPageId = "WDC Withholding Group";
    LookupPageId = "WDC Withholding Group";
    fields
    {
        field(1; "Code"; Code[10])
        {
            CaptionML = FRA = 'Code', ENU = 'Code';
        }
        field(2; Designation; Text[80])
        {
            CaptionML = FRA = 'Désignation', ENU = 'Designation';
        }
        field(3; "% Withholding Tax"; Decimal)
        {
            CaptionML = FRA = '% Retenue', ENU = '% Withholding Tax';
        }
        field(4; "Withholding Tax Account"; Code[20])
        {
            CaptionML = FRA = 'Compte retenue', ENU = 'Withholding Tax Account';
            tableRelation = "G/L Account";
            validateTableRelation = true;
        }
        field(5; "Withholding Tax Type"; Option)
        {
            CaptionML = FRA = 'Type retenue', ENU = 'Withholding Tax Type';
            OptionMembers = "Retenu à la source","Retenu de garantie";
        }
        field(6; Proposition; Option)
        {
            CaptionML = FRA = 'Proposition', ENU = 'Proposition';
            OptionMembers = ,Customers,Vendors,Employee;
            OptionCaptionML = FRA = ' ,Clients,Fournisseurs,Salarié', ENU = ' ,Customers,Vendors,Employee';
        }
        field(7; Annexe; Option)
        {
            CaptionML = FRA = 'Annexe', ENU = 'Annexe';
            OptionMembers = ,I,II,III,IV,V,VI,VII;
        }
        field(8; "Pos. mnt Brut dans Annexe"; Code[10])
        {
            CaptionML = FRA = 'Pos. mnt Brut dans Annexe', ENU = 'Pos. mnt Brut dans Annexe';
        }
        field(9; "Sous Pos. mnt Brut ds  Annexe"; Code[10])
        {
            CaptionML = FRA = 'Sous Pos. mnt Brut ds  Annexe', ENU = 'Sous Pos. mnt Brut ds  Annexe';
        }
        field(10; "Activated"; Boolean)
        {
            CaptionML = FRA = 'Activé', ENU = 'Activated';
        }
        field(11; Ristourne; Boolean)
        {
            CaptionML = FRA = 'Ristourne', ENU = 'Ristourne';
        }
        field(12; "R.S Activated"; Boolean)
        {
            CaptionML = FRA = 'Activé R.S', ENU = 'R.S Activated';
        }
        field(13; "Start Activation Date"; Date)
        {
            CaptionML = FRA = 'Date début activation', ENU = 'Start Activation Date';
        }
        field(14; "Priority"; Option)
        {
            CaptionML = FRA = 'Priorité', ENU = 'Priority';
            OptionMembers = "0","1";
        }
        field(15; "Type Ligne Decl. Emp."; Option)
        {
            CaptionML = FRA = 'Type ligne decl. Emp.', ENU = 'Type Ligne Decl. Emp.';
            OptionMembers = ,AnxI,AnxII,AnxIII,AnxIV,AnxV,AnxVI,AnxVII,Recap,Quittance;
        }
        field(16; "Sous Pos Mnt Brut ds Annexe"; Code[10])
        {
            CaptionML = FRA = 'Sous Pos Mnt Brut ds Annexe', ENU = 'Sous Pos Mnt Brut ds Annexe';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(Key1; "Withholding Tax Type", Code)
        {
        }
    }
}
