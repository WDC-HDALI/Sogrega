table 56002 "WDC Rec. Salary Lines"
{
    Caption = 'WDC Rec. Salary Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[50])
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
            editable = false;
            //tableRelation = "WDC Rec. Salary Headers"."No.";
        }
        field(2; Employee; Code[50])
        {
            CaptionML = ENU = 'Employee', FRA = 'Salarié';
            editable = false;
            tableRelation = Employee;
        }
        field(3; Month; Option)
        {
            CaptionML = ENU = 'Month', FRA = 'Mois';
            editable = false;
            OptionMembers = Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre,"13ème","14ème",Prime,Rappel,Autre,"Solde TC";
            OptionCaptionML = ENU = 'Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre,13ème,14ème,Prime,Rappel,Autre,Solde TC', FRA = 'Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre,13ème,14ème,Prime,Rappel,Autre,Solde TC';
        }
        field(4; Year; Integer)
        {
            CaptionML = ENU = 'Year', FRA = 'Année';
        }
        field(5; "Posting Date"; Date)
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date de comptabilisation';
        }
        field(6; Name; Text[90])
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            editable = false;
        }
        field(7; Description; Text[30])
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
            editable = false;
        }
        field(8; Assiduity; Decimal)
        {
            CaptionML = ENU = 'Assiduity', FRA = 'Assiduité';
        }
        field(9; "Basis Salary"; Decimal)
        {
            CaptionML = ENU = 'Basis Salary', FRA = 'Salaire de base';
        }
        field(10; "Real Basis Salary"; Decimal)
        {
            CaptionML = ENU = 'Real Basis Salary', FRA = 'Salaire de base réel';
        }
        field(11; "Ind Imp Cot"; Decimal)
        {
            CaptionML = ENU = 'Taxable indemnities', FRA = 'ind imp cot';
        }
        field(12; "Ind Imp Non Cot"; Decimal)
        {
            CaptionML = ENU = 'Non-taxable indemnities', FRA = 'Ind Imp Non Cot';
        }
        field(13; "Ind Non Imp"; Decimal)
        {
            CaptionML = ENU = 'Non-taxable indemnities', FRA = 'Ind Non Imp';
            editable = false;
        }
        field(14; "Base Montant Heures supp."; Decimal)
        {
            CaptionML = ENU = 'Base Amount Overtime', FRA = 'Base Montant Heures supp.';
        }
        field(15; "Cout Heure supp."; Decimal)
        {
            CaptionML = ENU = 'Cost Hour Overtime', FRA = 'Cout Heure supp.';
        }
        field(16; "Montant Heures Supp."; Decimal)
        {
            CaptionML = ENU = 'Overtime Amount', FRA = 'Montant Heures Supp.';
        }
        field(17; "gross salary (sans Av)"; Decimal)
        {
            CaptionML = ENU = 'Gross Salary (without Advances)', FRA = 'Salaire Brut total';
        }
        field(18; "gross salary imp cot"; Decimal)
        {
            CaptionML = ENU = 'Gross Salary', FRA = 'salaire brut  imp cot';
        }
        field(19; "Mission expenses"; Decimal)
        {
            CaptionML = ENU = 'Mission expenses Heading', FRA = 'Frais de mission';
            editable = false;
        }
        field(20; "Soc contrib ded of txble basis"; Decimal)
        {
            CaptionML = ENU = 'Non Taxable Soc. Contrib.', FRA = 'Cot soc ded de la base imposble';
        }
        field(21; "Soc contr n ded of txble basis"; Decimal)
        {
            CaptionML = ENU = 'Taxable Soc. Contrib.', FRA = 'Cot soc n ded de la base imposble';
            editable = false;
        }
        field(22; "Deduction Family chief"; Decimal)
        {
            CaptionML = ENU = 'Deduction Family chief', FRA = 'Déduction Chef de famille';
            editable = false;
        }
        field(23; "Deduction Loaded child"; Decimal)
        {
            CaptionML = ENU = 'Deduction Loaded child', FRA = 'Déduction enfants à charge';
            editable = false;
        }
        field(24; "Deduction Prof. expenses"; Decimal)
        {
            CaptionML = ENU = 'Deduction Prof. expenses', FRA = 'Déduction Frais pro.';
            editable = false;
        }
        field(25; "Taxable salary (month)"; Decimal)
        {
            CaptionML = ENU = 'Taxable salary (month)', FRA = 'Salaire imposable (mois)';
        }
        field(26; "Real taxable"; Decimal)
        {
            CaptionML = ENU = 'Real taxable', FRA = 'Imposable réel';
            editable = false;
        }
        field(27; "Total taxable rec."; Decimal)
        {
            CaptionML = ENU = 'Total taxable rec.', FRA = 'Total imposable enreg.';
            editable = false;
        }
        field(28; "nb rec. payments"; Integer)
        {
            CaptionML = ENU = 'Number of Receipt Payments', FRA = 'Nb salaires enreg.';
            editable = false;
        }
        field(29; "Total Gross Salary"; Decimal)
        {
            CaptionML = ENU = 'Total Gross Salary', FRA = 'Total salaire brût energ.';
        }
        field(30; "Total Net Salary"; Decimal)
        {
            CaptionML = ENU = 'Total Net Salary', FRA = 'Total Salaire Net';
        }
        field(31; "Total Net salary cashed"; Decimal)
        {
            CaptionML = ENU = 'Total Net salary cashed', FRA = 'Total Salaire net perçu';
        }
        field(32; "Taxable after deduct. (Year)"; Decimal)
        {
            CaptionML = ENU = 'Real taxable (Year)', FRA = 'Imposable après déductions (Année)';
            editable = false;
        }
        field(33; "Taxe (Year)"; Decimal)
        {
            CaptionML = ENU = 'Taxe (Year)', FRA = 'Impôt (Year)';
            editable = false;
        }
        field(34; "Taxe (Year) CSS"; Decimal)
        {
            CaptionML = ENU = 'Taxe (Year) CSS', FRA = 'Impôt (Année) CSS';
        }
        field(35; "Total taxes rec."; Decimal)
        {
            CaptionML = ENU = 'Total taxes rec.', FRA = 'Total impôts enreg.';
            editable = false;
        }
        field(36; "Total taxes rec.CSS"; Decimal)
        {
            CaptionML = ENU = 'Total taxes rec.CSS', FRA = 'Total impôts enreg. CSS';
        }
        field(37; "Taxe (Month)"; Decimal)
        {
            CaptionML = ENU = 'Taxe (Month)', FRA = 'Impôt (Mois)';
        }
        field(38; "Taxe (Month) CSS"; Decimal)
        {
            CaptionML = ENU = 'Taxe (Month) CSS', FRA = 'Impôt (Mois) CSS';
        }
        field(39; "CSS Amount"; Decimal)
        {
            CaptionML = ENU = 'CSS Amount', FRA = 'Montant CSS';
        }
        field(40; "Net salary"; Decimal)
        {
            CaptionML = ENU = 'Net salary', FRA = 'Salaire net';
        }
        field(41; Loans; Decimal)
        {
            CaptionML = ENU = 'Loans', FRA = 'Prêts';
        }
        field(42; Advances; Decimal)
        {
            CaptionML = ENU = 'Advances', FRA = 'Avances';
        }
        field(43; "Ajout  en +"; Decimal)
        {
            CaptionML = ENU = 'Ajout  en +', FRA = 'Ajout  en +';
        }
        field(44; "Report en -"; Decimal)
        {
            CaptionML = ENU = 'Report en -', FRA = 'Report en -';
        }
        field(45; "Net salary cashed"; Decimal)
        {
            CaptionML = ENU = 'Net salary cashed', FRA = 'Salaire net perçu';
        }
        field(46; "Ancien Arrondi"; Decimal)
        {
            CaptionML = ENU = 'Ancien Arrondi', FRA = 'Ancien Arrondi';
        }
        field(47; "Nouvel Arrondi"; Decimal)
        {
            CaptionML = ENU = 'Nouvel Arrondi', FRA = 'Nouvel Arrondi';
        }
        field(48; "base reved cc et exo imp"; Decimal)
        {
            Caption = 'base reved cc et exo imp';
        }
        field(49; "Redevance Caisse Comp. (an)"; Decimal)
        {
            Caption = 'Redevance Caisse Comp. (an)';
        }
        field(50; "Redevance Caisse Comp. (mois)"; Decimal)
        {
            Caption = 'Redevance Caisse Comp. (mois)';
        }
        field(51; "montant redev rec."; Decimal)
        {
            Caption = 'montant redev rec.';
        }
        field(52; "mnt ajout brut"; Decimal)
        {
            Caption = 'mnt ajout brut';
        }
        field(53; "Affectation Ajout net"; Code[20])
        {
            Caption = 'Affectation Ajout net';
            //TableRelation="Default Indemnities"."Indemnity Code" WHERE ("Employment Contract Code"=FIELD(Employee))
        }
        field(54; "mnt ajout net"; Decimal)
        {
            Caption = 'mnt ajout net';
        }
        field(55; "Emplymt. Contract Code"; Code[10])
        {
            CaptionML = ENU = 'Emplymt. Contract Code', FRA = 'Code contrat de travail';
            editable = false;
            TableRelation = "Employment Contract";
        }
        field(56; "Employee Regime of work"; Code[10])
        {
            CaptionML = ENU = 'Employee Regime of work', FRA = 'Régime de travail';
            editable = false;
        }
        field(57; "Employee's type"; Option)
        {
            CaptionML = ENU = 'Employee''s type', FRA = 'Type salarié';
            OptionMembers = "Hour based","Month based";
            OptionCaptionML = ENU = 'Hour based,Month based', FRA = 'Hour based,Month based,Tonnage';
            editable = false;
        }
        field(58; "Employee Posting Group"; Code[20])
        {
            CaptionML = ENU = 'Employee Posting Group', FRA = 'Groupe compta. salarié';
            TableRelation = "Employee Posting Group";
        }
        field(59; "Global Dimension 1"; Code[20])
        {
            CaptionML = ENU = 'Global Dimension 1', FRA = 'Code département';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            CaptionClass = '1,1,1';
        }
        field(60; "Global Dimension 2"; Code[20])
        {
            CaptionML = ENU = 'Global Dimension 2', FRA = 'Code dossier';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            CaptionClass = '1,1,2';
        }
        field(61; "Employee's Type Contrat"; Code[10])
        {
            Caption = 'Employee''s Type Contrat';
            TableRelation = "Employment Contract";
        }
        field(62; "Num CNSS"; Code[30])
        {
            Caption = 'Num CNSS';
        }
        field(63; "Num CIN"; Code[20])
        {
            Caption = 'Num CIN';
        }
        field(64; categ; Code[10])
        {
            Caption = 'categ';
        }
        field(65; echelon; Integer)
        {
            Caption = 'echelon';
        }
        field(66; "chef famille"; Boolean)
        {
            Caption = 'chef famille';
        }
        field(67; "nb enf a ch"; Integer)
        {
            Caption = 'nb enf a ch';
        }
        field(68; "Mode paiement"; Code[20])
        {
            Caption = 'Mode paiement';
        }
        field(69; "Compte Bancaire"; Code[20])
        {
            Caption = 'Compte Bancaire';
        }
        field(70; RIB; Code[20])
        {
            Caption = 'RIB';
        }
        field(71; Trimestre; Option)
        {
            Caption = 'Trimestre';
            OptionMembers = "1","2","3","4";
            OptionCaptionML = ENU = '1,2,3,4', FRA = '1,2,3,4';
        }
        field(72; "User ID"; Code[30])
        {
            Caption = 'User ID';
            editable = false;
            tableRelation = User;
        }
        field(73; "Last Date Modified"; Date)
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
            editable = false;
        }
        field(74; "montant jour abscence payé"; Decimal)
        {
            Caption = 'montant jour abscence payé';
        }
        field(75; "Nombre Congé pris"; Decimal)
        {
            Caption = 'Nombre Congé pris';
        }
        field(76; "Real Assiduity"; Decimal)
        {
            Caption = 'Real Assiduity';
        }
        field(77; "Droit congé"; Decimal)
        {
            Caption = 'Droit congé';
        }
        field(78; Direction; Code[10])
        {
            Caption = 'Direction';
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Code Direction" WHERE("No." = FIELD(Employee)));
            //TableRelation = "Employee Direction";
        }
        field(79; "Salaire Brut Ideal"; Decimal)
        {
            CaptionML = FRA = 'Salaire Brut Ideal';
        }
        field(80; "Salaire Imposable Théorique"; Decimal)
        {
            CaptionML = FRA = 'Salaire Imposable Théorique';
        }
        field(81; "Impôt Mois Théorique"; Decimal)
        {
            CaptionML = FRA = 'Impôt Mois Théorique';
        }
        field(82; "Ecart Impôt Mai 2015"; Decimal)
        {
            CaptionML = FRA = 'Ecart Impôt Mai 2015';
        }
        field(83; "Tranche écrat déduite"; Decimal)
        {
            CaptionML = FRA = 'Tranche écrat déduite';
        }
        field(84; Note; Decimal)
        {
            Caption = 'Note';
        }
        field(85; "Insurance Life Dedection"; Decimal)
        {
            Caption = 'Insurance Life Dedection';
        }
        field(86; "housing deduction"; Decimal)
        {
            CaptionML = ENU = 'housing deduction', FRA = 'Déduction Local Habitation';
        }
        field(87; "Impôt Mois Théorique CSS"; Decimal)
        {
            Caption = 'Impôt Mois Théorique CSS';
        }
        field(88; Site; Option)
        {
            Caption = 'Site';
            OptionMembers = "Site 1","Site 2","Site 3","Site 4";
            OptionCaptionML = ENU = 'Site 1,Site 2,Site 3,Site 4', FRA = 'Site 1,Site 2,Site 3,Site 4';
        }
        field(89; No_CarteB; Code[20])
        {
            Caption = 'No_CarteB';
        }
        field(90; "Payroll Run ID"; Code[30])
        {
            Caption = 'Payroll Run ID';
        }
    }
    keys
    {
        key(PK; "No.", employee)
        {
            Clustered = true;
        }
        key(Key1; Year, Employee)
        {
        }
    }
}
