table 54100 "WDC Withholding Tax Decl"
{
    CaptionML = FRA = 'Déclaration RS', ENU = 'Withholding Tax Declaration';
    DataClassification = ToBeClassified;
    DrillDownPageId = "WDC Withholding Tax Decl";
    LookupPageId = "WDC Withholding Tax Decl";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            CaptionML = FRA = 'N° Séquence', ENU = 'Entry No.';
        }
        field(2; Attribute; Integer)
        {
            CaptionML = FRA = 'Attribut', ENU = 'Attribute';
        }
        field(3; "Type of Company Identifier"; Integer)
        {
            CaptionML = FRA = 'Type identifient Société', ENU = 'Type of Company Identifier';
        }
        field(4; "Company Identifier"; Code[10])
        {
            CaptionML = FRA = 'Identifient société', ENU = 'Company Identifier';
        }
        field(5; "Taxpayer Category"; Code[10])
        {
            CaptionML = FRA = 'Categorie Contribuable', ENU = 'Taxpayer Category';
        }
        field(6; "Deposit Act"; Integer)
        {
            CaptionML = FRA = 'Acte dépot', ENU = 'Deposit Act';
        }
        field(7; "Deposit Year"; Text[10])
        {
            CaptionML = FRA = 'Année dépot', ENU = 'Deposit Year';
        }
        field(8; "Payment Month"; Text[10])
        {
            CaptionML = FRA = 'Mois paiement', ENU = 'Payment Month';
        }
        field(9; "Type of Beneficiary Identifier"; Integer)
        {
            CaptionML = FRA = 'Type identifient Bénéficiaire', ENU = 'Type of Beneficiary Identifier';
        }
        field(10; "Taxpayer Fiscal Number/ CIN"; Code[10])
        {
            CaptionML = FRA = 'Matricule fiscal bénéficiaire/CIN', ENU = 'Taxpayer Fiscal Number/ CIN';
        }
        field(11; "Taxpayer Category Beneficiary"; Code[10])
        {
            CaptionML = FRA = 'Categorie Contribuable Bénéficiaire', ENU = 'Taxpayer Category of Beneficiary';
        }
        field(12; "Resident In Tunisia"; Integer)
        {
            CaptionML = FRA = 'Résident en tunisie', ENU = 'Resident in Tunisia';
        }
        field(13; "Name and First Name"; Text[250])
        {
            CaptionML = FRA = 'Nom et prénom', ENU = 'Name and First Name';
        }
        field(14; Address; Text[250])
        {
            CaptionML = FRA = 'Adresse', ENU = 'Address';
        }
        field(15; "Activity"; Text[250])
        {
            CaptionML = FRA = 'Activité', ENU = 'Activity';
        }
        field(16; EMail; Text[250])
        {
            CaptionML = FRA = 'EMail', ENU = 'EMail';
        }
        field(17; "Phone Number"; Code[50])
        {
            CaptionML = FRA = 'N° téléphone', ENU = 'Phone Number';
        }
        field(18; "Payment Date"; Text[30])
        {
            CaptionML = FRA = 'Date paiement', ENU = 'Payment Date';
        }
        field(19; "Document No."; Code[50])
        {
            CaptionML = FRA = 'N° document', ENU = 'Document No.';
        }
        field(20; "ID Type Operation"; Code[20])
        {
            CaptionML = FRA = 'ID type opération', ENU = 'ID type operation';
        }
        field(21; "Billing Year"; Text[10])
        {
            CaptionML = FRA = 'Année facturation', ENU = 'Billing Year';
        }
        field(22; CNPC; Integer)
        {
            CaptionML = FRA = 'CNPC', ENU = 'CNPC';
        }
        field(23; "P-Charge"; Integer)
        {
            CaptionML = FRA = 'P-Charge', ENU = 'P-Charge';
        }
        field(24; "Amount HT"; Decimal)
        {
            CaptionML = FRA = 'Montant HT', ENU = 'Amount HT';
        }
        field(25; "Withholding Tax Rate"; Decimal)
        {
            CaptionML = FRA = 'Taux Retenu à la source', ENU = 'Withholding Tax Rate';
        }
        field(26; "VAT Rate"; Decimal)
        {
            CaptionML = FRA = 'Taux TVA', ENU = 'VAT Rate';
        }
        field(27; "VAT Amount"; Decimal)
        {
            CaptionML = FRA = 'Montant TVA', ENU = 'VAT Amount';
        }
        field(28; "Total Amount"; Decimal)
        {
            CaptionML = FRA = 'Montant TTC', ENU = 'Total Amount';
        }
        field(29; "Montant RS"; Decimal)
        {
            CaptionML = FRA = 'Montant RS', ENU = 'Amount RS';
        }
        field(30; "Tax additionnelle (Code)"; Code[10])
        {
            CaptionML = FRA = 'Tax additionnelle (Code)', ENU = 'Additional Tax (Code)';
        }
        field(31; "Tax additionnelle (taux)"; Integer)
        {
            CaptionML = FRA = 'Tax additionnelle (taux)', ENU = 'Additional Tax (Rate)';
        }
        field(32; "Montant Net servi"; Decimal)
        {
            CaptionML = FRA = 'Montant Net servi', ENU = 'Net Amount Serviced';
        }
        field(33; "Code devise"; Code[10])
        {
            CaptionML = FRA = 'Code devise', ENU = 'Currency Code';
        }
        field(34; "Taux de change"; Decimal)
        {
            CaptionML = FRA = 'Taux de change', ENU = 'Exchange Rate';
        }
        field(35; "Montant RS devise"; Decimal)
        {
            CaptionML = FRA = 'Montant RS devise', ENU = 'Amount RS in Currency';
        }
        field(36; "Total Currency Amount"; Decimal)
        {
            CaptionML = FRA = 'Montant TTC devise', ENU = 'Total Amount in Currency';
        }
        field(37; "Net Amount in Currency"; Decimal)
        {
            CaptionML = FRA = 'Montant Net Servie Devise', ENU = 'Net Amount Serviced in Currency';
        }
        field(38; "Invoice No."; Code[20])
        {
            CaptionML = FRA = 'N° Facture', ENU = 'Invoice No.';
        }
        field(39; Export; Boolean)
        {
            CaptionML = FRA = 'Export', ENU = 'Export';
        }
        field(40; "G/L Account No."; Code[20])
        {
            CaptionML = FRA = 'N° Compte G/L', ENU = 'G/L Account No.';
        }
        field(41; "Total Currency"; code[10])
        {
            CaptionML = FRA = 'Total Devise', ENU = 'Total Currency';
        }
        field(42; "TEJ Declaration No."; Code[20])
        {
            CaptionML = FRA = 'N° déclaration TEJ', ENU = 'TEJ Declaration No.';
        }
        field(43; "Birth Date"; Date)
        {
            CaptionML = FRA = 'Date naissance', ENU = 'Birth Date';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
