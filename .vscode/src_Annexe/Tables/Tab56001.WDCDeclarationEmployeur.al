table 56001 "WDC Declaration Employeur"
{

    fields
    {
        field(1; "Sequence No."; Integer)
        {
            captionML = ENU = 'Sequence No.', FRA = 'N° Sequence';
        }
        field(2; "Type Ligne Decl. Emp."; Option)
        {
            CaptionML = ENU = 'Type of line for employer declaration',
                        FRA = 'Type ligne déclaration employeur';
            OptionCaptionML = FRA = ' ,Annexe I,Annexe II,Annexe III,Annexe IV,Annexe V,Annexe VI,Recap,Quittance';
            OptionMembers = " ","Annexe I","Annexe II","Annexe III","Annexe IV","Annexe V","Annexe VI",Recap,Quittance;
        }
        field(3; "Withholding Tax Code"; Code[10])
        {
            captionML = ENU = 'Withholding Tax Code', FRA = 'Code retenue';
            trigger OnValidate()
            begin
                RecG_GroupeRetenue.RESET;
                RecG_GroupeRetenue.SETRANGE(Code, "Withholding Tax Code");
                IF RecG_GroupeRetenue.FINDFIRST THEN BEGIN
                    "% Withholding Tax" := RecG_GroupeRetenue."% Withholding Tax";
                    "Type Ligne Decl. Emp." := RecG_GroupeRetenue."Type Ligne Decl. Emp.";
                    "Pos. mnt Brut dans Annexe" := RecG_GroupeRetenue."Pos. mnt Brut dans Annexe";
                    "Sous Pos. mnt Brut ds  Annexe" := RecG_GroupeRetenue."Sous Pos Mnt Brut ds Annexe";
                END;
            end;
        }
        field(4; "Source Type Annxes"; Option)
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            OptionCaptionML = ENU = ' ,Customer,Vendor,Bank Account,Fixed Asset,Employee', FRA = ' ,Client,Fournisseur,Banque,Immobilisation,Salarié';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset","Salarié";
        }
        field(5; "Recap Line Code"; Code[10])
        {
            captionML = ENU = 'Recap Line Code', FRA = 'Code ligne recap';
        }
        field(6; "Source No."; Code[20])
        {
            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
            TableRelation = IF ("Source Type Annxes" = CONST(Customer)) Customer
            ELSE IF ("Source Type Annxes" = CONST(Vendor)) Vendor
            ELSE IF ("Source Type Annxes" = CONST(Salarié)) Employee;

            trigger OnValidate()
            begin
                CASE "Source Type Annxes" OF
                    "Source Type Annxes"::Vendor:
                        BEGIN
                            RecG_Vendor.GET("Source No.");
                            "Source Name" := RecG_Vendor.Name;
                            "Source Activity" := RecG_Vendor.Activité;
                            "Source Address" := RecG_Vendor.Address;
                            IF RecG_Vendor."VAT Registration No." <> '' THEN BEGIN
                                "Source Type ID" := '1';
                                "Source ID" := RecG_Vendor."VAT Registration No.";
                            END;
                        END;
                    "Source Type Annxes"::Customer:
                        BEGIN
                            RecG_Customer.GET("Source No.");
                            "Source Name" := RecG_Customer.Name;
                            "Source Address" := RecG_Customer.Address;
                            IF RecG_Customer."VAT Registration No." <> '' THEN BEGIN
                                "Source Type ID" := '1';
                                "Source ID" := RecG_Customer."VAT Registration No.";
                            END;
                        END;

                    "Source Type Annxes"::Salarié:
                        BEGIN
                            RecG_Employee.GET("Source No.");
                            "Source Name" := RecG_Employee."Last Name" + ' ' + RecG_Employee."First Name";

                            "Source Activity" := RecG_Employee."Job Title";
                            "Source Address" := RecG_Employee.Address + ' ' + RecG_Employee."Post Code" + ' ' + RecG_Employee.City;

                            IF RecG_Employee."Carte Séjour" THEN
                                "Source Type ID" := '3'
                            ELSE
                                "Source Type ID" := '2';

                            "Source ID" := RecG_Employee."National Identity Card No.";

                            //Family Situation
                            CASE RecG_Employee."Marital Status" OF
                                RecG_Employee."Marital Status"::Célibataire:
                                    "Family Situation" := '1';
                                RecG_Employee."Marital Status"::Marié:
                                    "Family Situation" := '2';
                                RecG_Employee."Marital Status"::Divorcé:
                                    "Family Situation" := '3';
                                RecG_Employee."Marital Status"::Veuf:
                                    "Family Situation" := '4';
                            END;

                            //Loaded childs
                            RecG_Employee.CALCFIELDS("Loaded childs");
                            "Loaded childs" := RecG_Employee."Loaded childs";

                            //Work Start Date
                            IF RecG_Employee."Employment Date" < (DMY2DATE(1, 1, Year + 1)) THEN
                                "Work Start Date" := DMY2DATE(1, 1, Year)
                            ELSE
                                "Work Start Date" := RecG_Employee."Employment Date";

                            //Work End Date
                            IF (RecG_Employee."Termination Date" IN [(DMY2DATE(1, 1, Year)) .. (DMY2DATE(31, 12, Year))])
                                  AND (RecG_Employee."Termination Date" <> (0D)) THEN
                                "Work End Date" := RecG_Employee."Termination Date"
                            ELSE
                                "Work End Date" := DMY2DATE(31, 12, Year);

                            //Durée période travail en Jrs
                            IF ("Work End Date" - "Work Start Date") <> 0 THEN
                                "Duration of work period (D)" := "Work End Date" - "Work Start Date" + 1;
                        END;
                END;
            end;
            // 25/02/2015 Importation ecritures
        }
        field(7; "Source Name"; Text[100])
        {
            Description = 'Annexes';
            captionML = ENU = 'Source Name', FRA = 'Nom origine';
        }
        field(8; "Source Type ID"; Code[1])
        {
            ValuesAllowed = '1', '2', '3', '4';
            Description = 'Annexes (1 : Matricule fiscal 2 : CIN ,3 : Numéro la carte du séjour pour les étrangers)';
            captionML = ENU = 'Source Type ID', FRA = 'Type ID origine';
        }
        field(9; "Source ID"; Code[20])
        {
            Description = 'Annexes';
            captionML = ENU = 'Source ID', FRA = 'ID origine';
        }
        field(10; "Source Activity"; Text[100])
        {
            Description = 'Annexes';
            captionML = ENU = 'Source Activity', FRA = 'Activité origine';
        }
        field(11; "Source Address"; Text[100])
        {
            Description = 'Annexes';
            captionML = ENU = 'Source Address', FRA = 'Adresse origine';
        }
        field(12; "Sous type origine"; Option)
        {
            captionML = ENU = 'Sous type origine', FRA = 'Sous type origine';
            Description = 'Annexes|Recap  ,Non Résident physique,Non Résident Morale,Résident Morale,Résident Physique,Régime réel';
            OptionMembers = " ","Non Resident physique","Non Resident Morale","Resident Morale","Resident Physique","Regime reel";
            OptionCaptionML = FRA = ' ,Non Résident physique,Non Résident Morale,Résident Morale,Résident Physique,Régime réel',
                            ENU = ' ,Not Physical Resident,Not Legal Entity Resident,Legal Entity Resident,Physical Resident,Real regime';
        }
        field(13; "Base Withholding Amount"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'Annexes|Recap';
            captionML = ENU = 'Base Withholding Amount', FRA = 'Montant Base Retenue';
        }
        field(14; "Withholding Amount"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'Annexes|Recap';
            captionML = ENU = 'Withholding Amount', FRA = 'Montant Retenue';

            trigger OnValidate()
            begin
                IF ("% Withholding Tax" <> 0) AND ("Withholding Tax Code" <> 'R100TVA') THEN
                    "Base Withholding Amount" := ROUND(("Withholding Amount" / "% Withholding Tax") * 100, 0.001);

                "Net Amount Served" := "Base Withholding Amount" - "Withholding Amount";
            end;
        }
        field(15; "Net Amount Served"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'Annexes';
            captionML = ENU = 'Net Amount Served', FRA = 'Montant Net Servis';
        }
        field(16; "Discounts Amount"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'special annexe 6';
            captionML = ENU = 'Discounts Amount', FRA = 'Montant Ristournes';
        }
        field(17; "Amounts Sales PP Reg Flat"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'special annexe 6';
            captionML = ENU = 'Amounts Sales PP Reg Flat', FRA = 'Montants ventes PP reg forf';
        }
        field(18; "Advances On Sales PP Reg Flat"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'special annexe 6';
            captionML = ENU = 'Advances On Sales PP Reg Flat', FRA = 'Avances sur ventes PP reg forf';
        }
        field(19; "Taxable Income"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'special annexe 1';
            captionML = ENU = 'Taxable Income', FRA = 'Revenu Imposable';
        }
        field(20; "Nature Benefits"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'special annexe 1';
            captionML = FRA = 'Avantages en nature', ENU = 'Nature Benefits';
        }
        field(21; "Reinvested Income"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'special annexe 1';
            captionML = FRA = 'Revenu Réinvesti', ENU = 'Reinvested Income';
        }
        field(22; "With. Amount Common Regime"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'special annexe 1';
            captionML = FRA = 'Montant retenue Régime commun', ENU = 'Withholding Amount Common Regime';
        }
        field(23; "Total Withholding 20%"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'special annexe 1';
            captionML = FRA = 'Total retenue 20%', ENU = 'Total Withholding 20%';
        }
        field(24; "Total redevances caisse compen"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'special annexe 1 || A CHANGER CAPTION PAR CONTRIBUTION SOCIALE MNT CSS';
            CaptionML = FRA = 'Totale redevances caisse compen', ENU = 'Total redevances caisse compen';
        }
        field(25; "Total Contribution Conjoncture"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'special annexe 1 V';
            CaptionML = FRA = 'Totale contribution conjoncture', ENU = 'Total Contribution Conjoncture';
        }
        field(26; "Amount Recovered in Cash"; Decimal)
        {
            Description = 'special annexe 6 V';
            CaptionML = FRA = 'Montant Recouvers en Especes', ENU = 'Amount Recovered in Cash';
        }
        field(27; "Quittance Date"; Date)
        {
            Description = 'QUITTANCES';
            CaptionML = ENU = 'Quittance Date', FRA = 'Date quittance';
        }
        field(28; "Quittance No."; Code[50])
        {
            Description = 'QUITTANCES';
            CaptionML = ENU = 'Quittance No.', FRA = 'N° quittance';
        }
        field(29; "Admin Fiscale"; Text[100])
        {
            Description = 'QUITTANCES';
            CaptionML = ENU = 'Admin Fiscale', FRA = 'Admin fiscale';
        }
        field(30; "% Withholding Tax"; Decimal)
        {
            Description = 'Annexes|Recap';
            CaptionML = ENU = '% Withholding Tax', FRA = '% Retenue';
        }
        field(31; "Pos. mnt Brut dans Annexe"; Code[10])
        {
            Description = 'Annexes';
        }
        field(32; "Sous Pos. mnt Brut ds  Annexe"; Code[1])
        {
            CharAllowed = '012345';
            Description = 'Annexes';
        }
        field(33; "Family Situation"; Code[1])
        {
            Description = 'Annexes (1:célibataire, 2:marié, 3:divorcé, 4:veuf)';
            ValuesAllowed = '1', '2', '3', '4';
            CaptionML = ENU = 'Family Situation', FRA = 'Situation familiale';
        }
        field(34; "Loaded childs"; Integer)
        {
            Description = 'special annexe 1';
            CaptionML = ENU = 'Number of Children', FRA = 'Enfants à charge';
        }
        field(35; "Work Start Date"; Date)
        {
            Description = 'special annexe 1';
            CaptionML = ENU = 'Work Start Date', FRA = 'Date début travail';
        }
        field(36; "Work End Date"; Date)
        {
            Description = 'special annexe 1';
            CaptionML = ENU = 'Work End Date', FRA = 'Date Fin travail';
        }
        field(37; "Duration of work period (D)"; Integer)
        {
            Description = 'special annexe 1';
            CaptionML = ENU = 'Duration of work period in days', FRA = 'Durée période travail (j)';
        }
        field(38; "Year"; Integer)
        {
            CaptionML = ENU = 'Year', FRA = 'Année';
        }
        field(39; "Archived"; Boolean)
        {
            CaptionML = ENU = 'Archived', FRA = 'Archivé';
        }
        field(40; "Payed Amount Type"; Code[2])
        {
            Description = 'special annexe 7 [1...24]';
            CaptionML = ENU = 'Payed Amount Type', FRA = 'Type montants payés';
        }
        field(41; "Payed Amounts"; Decimal)
        {
            Description = 'special annexe 7';
            CaptionML = ENU = 'Payed Amounts', FRA = 'Montants payés';
        }
        field(42; "Withholding Tax"; Decimal)
        {
            Description = 'special annexe 7';
            CaptionML = ENU = 'Withholding Tax', FRA = 'Retenue à la source';
        }
        field(43; "Amount CSS"; Decimal)
        {
            Description = 'ANNEXE I V';
            CaptionML = ENU = 'Amount CSS', FRA = 'Montant CSS';
        }
    }

    keys
    {
        key(Key1; "Year", "Type Ligne Decl. Emp.", "Sequence No.", "Source No.")
        {
            Clustered = true;
            SumIndexFields = "Base Withholding Amount", "Withholding Amount", "Net Amount Served", "Taxable Income", "Nature Benefits", "Reinvested Income", "With. Amount Common Regime", "Total Withholding 20%", "Total redevances caisse compen", "Discounts Amount", "Amounts Sales PP Reg Flat", "Advances On Sales PP Reg Flat", "Total Contribution Conjoncture";
        }
        key(Key2; "Year", "Type Ligne Decl. Emp.", "Pos. mnt Brut dans Annexe", "Sous Pos. mnt Brut ds  Annexe", "Source Type Annxes", "Source No.")
        {
            SumIndexFields = "Base Withholding Amount", "Withholding Amount", "Net Amount Served", "Taxable Income", "Nature Benefits", "Reinvested Income", "With. Amount Common Regime", "Total Withholding 20%", "Total redevances caisse compen", "Discounts Amount", "Amounts Sales PP Reg Flat", "Advances On Sales PP Reg Flat", "Total Contribution Conjoncture";
        }
        key(Key3; "Archived", "Year", "Withholding Tax Code", "Sous type origine")
        {
            SumIndexFields = "Base Withholding Amount", "Withholding Amount", "Net Amount Served", "Taxable Income", "Nature Benefits", "Reinvested Income", "With. Amount Common Regime", "Total Withholding 20%", "Total redevances caisse compen", "Discounts Amount", "Amounts Sales PP Reg Flat", "Advances On Sales PP Reg Flat", "Total Contribution Conjoncture";
        }
        key(Key4; "Recap Line Code")
        {
            SumIndexFields = "Base Withholding Amount", "Withholding Amount", "Net Amount Served", "Taxable Income", "Nature Benefits", "Reinvested Income", "With. Amount Common Regime", "Total Withholding 20%", "Total redevances caisse compen", "Discounts Amount", "Amounts Sales PP Reg Flat", "Advances On Sales PP Reg Flat", "Total Contribution Conjoncture";
        }
        key(Key5; "Type Ligne Decl. Emp.", "Sequence No.")
        {
            SumIndexFields = "Base Withholding Amount", "Withholding Amount", "Net Amount Served", "Taxable Income", "Nature Benefits", "Reinvested Income", "With. Amount Common Regime", "Total Withholding 20%", "Total redevances caisse compen", "Discounts Amount", "Amounts Sales PP Reg Flat", "Advances On Sales PP Reg Flat", "Total Contribution Conjoncture";
        }
        key(Key6; "Year", "Withholding Tax Code", "Sous type origine")
        {
            SumIndexFields = "Base Withholding Amount", "Withholding Amount", "Net Amount Served", "Taxable Income", "Nature Benefits", "Reinvested Income", "With. Amount Common Regime", "Total Withholding 20%", "Total redevances caisse compen", "Discounts Amount", "Amounts Sales PP Reg Flat", "Advances On Sales PP Reg Flat", "Total Contribution Conjoncture";
        }
        key(Key7; "Sequence No.")
        {
        }
        key(Key8; "Advances On Sales PP Reg Flat", "Year")
        {
            SumIndexFields = "Base Withholding Amount", "Withholding Amount", "Net Amount Served", "Taxable Income", "Nature Benefits", "Reinvested Income", "With. Amount Common Regime", "Total Withholding 20%", "Total redevances caisse compen", "Discounts Amount", "Amounts Sales PP Reg Flat", "Advances On Sales PP Reg Flat", "Total Contribution Conjoncture";
        }
    }

    fieldgroups
    {
    }

    var
        RecG_Vendor: Record Vendor;
        RecG_Customer: Record Customer;
        RecG_Employee: Record Employee;
        RecG_GroupeRetenue: Record "WDC Withholding Group";

}

