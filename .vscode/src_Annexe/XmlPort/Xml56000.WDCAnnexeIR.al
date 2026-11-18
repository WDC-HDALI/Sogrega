xmlport 56000 "WDC Annexe I-R"
{
    Direction = Export;
    Format = FixedText;
    RecordSeparator = '<NewLine>';
    TableSeparator = '<NewLine>';

    schema
    {
        textelement(root)
        {
            tableelement("Company Information"; "Company Information")
            {
                XmlName = 'ANNXDEB00';
                SourceTableView = SORTING("Primary Key");
                textelement(ee0001)
                {
                    XmlName = 'EE0001';
                    Width = 2;
                }
                textelement(ee0011)
                {
                    XmlName = 'EE0011';
                    Width = 7;
                }
                textelement(ee0021)
                {
                    XmlName = 'EE0021';
                    Width = 1;
                }
                textelement(ee0031)
                {
                    XmlName = 'EE0031';
                    Width = 1;
                }
                textelement(ee0041)
                {
                    XmlName = 'EE0041';
                    Width = 3;
                }
                textelement(ee0051)
                {
                    XmlName = 'EE0051';
                    Width = 4;
                }
                textelement(ee0061)
                {
                    XmlName = 'EE0061';
                    Width = 3;
                }
                textelement(ee0071)
                {
                    XmlName = 'EE0071';
                    Width = 1;
                }
                textelement(ee0081)
                {
                    XmlName = 'EE0081';
                    Width = 6;
                }
                textelement(ee0091)
                {
                    XmlName = 'EE0091';
                    Width = 40;
                }
                textelement(ee00101)
                {
                    XmlName = 'EE00101';
                    Width = 40;
                }
                textelement(ee00111)
                {
                    XmlName = 'EE00111';
                    Width = 40;
                }
                textelement(ee00121)
                {
                    XmlName = 'EE00121';
                    Width = 72;
                }
                textelement(ee00131)
                {
                    XmlName = 'EE00131';
                    Width = 4;
                }
                textelement(ee00141)
                {
                    XmlName = 'EE00141';
                    Width = 4;
                }
                textelement(ee00151)
                {
                    XmlName = 'EE00151';
                    Width = 171;
                }

                trigger OnAfterGetRecord()
                var
                    Ddeb: Date;
                    dfin: Date;
                    tav: Integer;
                    tbrimp: Integer;
                    timp: Integer;
                    employee: Record 5200;
                    compt: Integer;
                    T4: Record 79;
                begin


                    //-- ligne entete annexe 1 : ANXDEB00 --//
                    //----------------------------------------------------------------------

                    //Type enregistrement
                    E000 := 'E1';
                    // BEGIN ADD TAK
                    MatriculeSociete := DELCHR("Company Information"."VAT Registration No.", '=', '/');
                    // END ADD TAK
                    //Matricule Fiscal
                    E001 := COPYSTR(MatriculeSociete, 1, 7);

                    //Clé du matricule fiscal
                    E002 := COPYSTR(MatriculeSociete, 8, 1);

                    //Catégorie contribuable
                    E003 := COPYSTR(MatriculeSociete, 10, 1);

                    //Numéro de l’établissement secondaire du contribuable
                    E004 := COPYSTR(MatriculeSociete, 11, 3);

                    //Exercice
                    E005 := FORMAT(IntG_Exercice);

                    //Type du document
                    E006 := 'An1';

                    //Code acte 0 : Spontané, 1 : Régularisation, 2 : redressement
                    E007 := '0';

                    //Nombre total de bénéficiaires
                    RecL_DeclarationEmployeur.RESET;
                    RecL_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecL_DeclarationEmployeur.SETRANGE("Type Ligne Decl. Emp.", RecL_DeclarationEmployeur."Type Ligne Decl. Emp."::"Annexe I");
                    IF RecL_DeclarationEmployeur.FINDSET THEN

                        //en tot 6 caractères : des 0 puis le nbr de benef
                        E008 := PADSTR('', 6 - STRLEN(FORMAT(RecL_DeclarationEmployeur.COUNT)), '0')
                              + FORMAT(RecL_DeclarationEmployeur.COUNT);

                    //Nom et prénom ou Raison sociale contribuable déclarant
                    E009 := COPYSTR("Company Information".Name, 1, 40);

                    //Activité contribuable déclarant
                    E010 := COPYSTR("Company Information".Activity, 1, 40);

                    //Dernière adresse contribuable déclarant :

                    //Ville
                    E011 := COPYSTR("Company Information".City, 1, 40);

                    //Rue
                    E012 := COPYSTR("Company Information".Address, 1, 72);
                    ;

                    //Numéro
                    //E013:=COPYSTR("Company Information"."No. Rue",1,4);


                    //Code postal
                    E014 := COPYSTR("Company Information"."Post Code", 1, 4);

                    //Zone réservée (192 espaces) // RB DECEMP V 2015
                    E015 := ' ';

                    //-----------------------------------------------------------------------

                    EVALUATE(EE0001, E000);
                    EVALUATE(EE0011, E001);
                    EVALUATE(EE0021, E002);
                    EVALUATE(EE0031, E003);
                    EVALUATE(EE0041, E004);
                    EVALUATE(EE0051, E005);
                    EVALUATE(EE0061, E006);
                    EVALUATE(EE0071, E007);
                    EVALUATE(EE0081, E008);
                    EVALUATE(EE0091, E009);
                    EVALUATE(EE0011, E001);
                    EVALUATE(EE0011, E001);
                    EVALUATE(EE00111, E011);
                    EVALUATE(EE00121, E012);
                    EVALUATE(EE00131, E013);
                    EVALUATE(EE00141, E014);
                    EVALUATE(EE00151, E015);
                end;
            }
            tableelement("Declaration Employeur"; "WDC Declaration Employeur")
            {
                XmlName = 'ANXBEN01';
                SourceTableView = SORTING("Sequence No.")
                                  WHERE("Type Ligne Decl. Emp." = FILTER(1));
                textelement(a1001)
                {
                    XmlName = 'A1001';
                    Width = 2;
                }
                textelement(a1011)
                {
                    XmlName = 'A1011';
                    Width = 7;
                }
                textelement(a1021)
                {
                    XmlName = 'A1021';
                    Width = 1;
                }
                textelement(a1031)
                {
                    XmlName = 'A1031';
                    Width = 1;
                }
                textelement(a1041)
                {
                    XmlName = 'A1041';
                    Width = 3;
                }
                textelement(a1051)
                {
                    XmlName = 'A1051';
                    Width = 4;
                }
                textelement(a1061)
                {
                    XmlName = 'A1061';
                    Width = 6;
                }
                textelement(a1071)
                {
                    XmlName = 'A1071';
                    Width = 1;
                }
                textelement(a1081)
                {
                    XmlName = 'A1081';
                    Width = 13;
                }
                textelement(a1091)
                {
                    XmlName = 'A1091';
                    Width = 40;
                }
                textelement(a1101)
                {
                    XmlName = 'A1101';
                    Width = 40;
                }
                textelement(a1111)
                {
                    XmlName = 'A1111';
                    Width = 120;
                }
                textelement(a1121)
                {
                    XmlName = 'A1121';
                    Width = 1;
                }
                textelement(a1131)
                {
                    XmlName = 'A1131';
                    Width = 2;
                }
                textelement(a1141)
                {
                    XmlName = 'A1141';
                    Width = 8;
                }
                textelement(a1151)
                {
                    XmlName = 'A1151';
                    Width = 8;
                }
                textelement(a1161)
                {
                    XmlName = 'A1161';
                    Width = 3;
                }
                textelement(a1171)
                {
                    XmlName = 'A1171';
                    Width = 15;
                }
                textelement(a1181)
                {
                    XmlName = 'A1181';
                    Width = 15;
                }
                textelement(a1191)
                {
                    XmlName = 'A1191';
                    Width = 15;
                }
                textelement(a1201)
                {
                    XmlName = 'A1201';
                    Width = 15;
                }
                textelement(a1211)
                {
                    XmlName = 'A1211';
                    Width = 15;
                }
                textelement(a1221)
                {
                    XmlName = 'A1221';
                    Width = 15;
                }
                textelement(a1231)
                {
                    XmlName = 'A1231';
                    Width = 15;
                }
                textelement(a1241)
                {
                    XmlName = 'A1241';
                    Width = 15;
                }
                textelement(a1251)
                {
                    XmlName = 'A1251';
                    Width = 19;
                }

                trigger OnAfterGetRecord()
                var
                    Ddeb: Date;
                    dfin: Date;
                    tav: Integer;
                    tbrimp: Integer;
                    timp: Integer;
                    T4: Record 79;
                begin


                    //-- lignes salariés : ANXBEN01 --//
                    //------------------------------------------------------------------------------------------

                    //Type d’enregistrement
                    A100 := 'L1';

                    //extraire Identifiant contribuable déclarant
                    RecG_CompanyInformation.GET;
                    // BEGIN ADD TAK
                    MatriculeSociete := DELCHR(RecG_CompanyInformation."VAT Registration No.", '=', '/');
                    // END ADD TAK
                    //Matricule Fiscal
                    A101 := COPYSTR(MatriculeSociete, 1, 7);

                    //Clé du matricule fiscal
                    A102 := COPYSTR(MatriculeSociete, 8, 1);

                    //Catégorie contribuable
                    A103 := COPYSTR(MatriculeSociete, 10, 1);

                    //Numéro de l’établissement secondaire du contribuable
                    A104 := COPYSTR(MatriculeSociete, 11, 3);

                    //Exercice
                    A105 := FORMAT(IntG_Exercice);

                    //Numéro d’ordre (exple Sequence No. 115 => enregistrement ds fichier : 000115)
                    IntG_LineNo += 1;
                    A106 := PADSTR('', 6 - STRLEN(FORMAT(IntG_LineNo)), '0') + FORMAT(IntG_LineNo);

                    //Type identifiant du bénéficiaire  2 : CIN, 3 : Numéro de la carte du séjour pour les étrangers
                    A107 := "Declaration Employeur"."Source Type ID";
                    // BEGIN ADD TAK
                    MatriculeEnregistrement := DELCHR("Declaration Employeur"."Source ID", '=', '/');
                    // END ADD TAK

                    //ID bénéficiaire : N° CIN ou Numéro de la carte de séjour pour les étrangers
                    A108 := MatriculeEnregistrement;

                    //Nom et prénom du bénéficiaire
                    A109 := COPYSTR("Declaration Employeur"."Source Name", 1, 40);

                    //Emploi occupé du bénéficiaire
                    A110 := COPYSTR("Declaration Employeur"."Source Activity", 1, 40);

                    //Dernière adresse du bénéficiaire
                    A111 := COPYSTR("Declaration Employeur"."Source Address", 1, 120);

                    //Family Situation du bénéficiaire (1 : célibataire, 2 : marié, 3 : divorcé, 4 : veuf)
                    A112 := "Declaration Employeur"."Family Situation";

                    //Nombre d’enfants à charge
                    A113 := PADSTR('', 2 - STRLEN(FORMAT("Declaration Employeur"."Loaded childs")), '0') + FORMAT("Declaration Employeur"."Loaded childs");

                    //Date début de la période de travail
                    A114 := FORMAT("Declaration Employeur"."Work Start Date", 8, '<day,2><Month,2><year4>');

                    //Date fin de la période de travail
                    A115 := FORMAT("Declaration Employeur"."Work End Date", 8, '<day,2><Month,2><year4>');

                    //Durée de la période en nombre de jours
                    A116 := PADSTR('', 3 - STRLEN(FORMAT("Declaration Employeur"."Duration of work period (D)")), '0') + FORMAT("Declaration Employeur"."Duration of work period (D)");

                    //Taxable Income
                    A117 := FnctG_FormatMontant("Declaration Employeur"."Taxable Income", 15);

                    //Valeur des Nature Benefits
                    A118 := FnctG_FormatMontant("Declaration Employeur"."Nature Benefits", 15);

                    //Total du revenu brut imposable (exple 15.369,200 :  000000015369200)
                    A119 := FnctG_FormatMontant("Declaration Employeur"."Taxable Income" + "Declaration Employeur"."Nature Benefits", 15);

                    //Reinvested Income
                    A120 := FnctG_FormatMontant("Declaration Employeur"."Reinvested Income", 15);

                    //Montant des retenues opérées selon le régime commun
                    A121 := FnctG_FormatMontant("Declaration Employeur"."With. Amount Common Regime", 15);

                    //Montant des retenues 20%
                    A122 := FnctG_FormatMontant("Declaration Employeur"."Total Withholding 20%", 15);

                    // Amount CSS
                    A123 := FnctG_FormatMontant("Declaration Employeur"."Amount CSS", 15);

                    //Montant net servi
                    //A124 := FnctG_FormatMontant ("Declaration Employeur"."Net Amount Served", 15);
                    //A124 :='000000000000000';

                    //Montant net servi
                    A124 := FnctG_FormatMontant("Declaration Employeur"."Net Amount Served", 15);

                    //--> Update Riadh 07-03-17
                    //Zone réservée : 40 espaces
                    A125 := ' ';

                    //--> End Update Riadh 07-03-17
                    // Ajouter //A125 = A124  ANCIEN
                    // A124 = A123 ANCIEN
                    //A123 = contribution sociale de solidarité...

                    //------------------------------------------------------------------------------------------


                    EVALUATE(A1001, A100);
                    EVALUATE(A1011, A101);
                    EVALUATE(A1021, A102);
                    EVALUATE(A1031, A103);
                    EVALUATE(A1041, A104);
                    EVALUATE(A1051, A105);
                    EVALUATE(A1061, A106);
                    EVALUATE(A1071, A107);
                    EVALUATE(A1081, A108);
                    EVALUATE(A1091, A109);
                    EVALUATE(A1101, A110);
                    EVALUATE(A1111, A111);
                    EVALUATE(A1121, A112);
                    EVALUATE(A1131, A113);
                    EVALUATE(A1141, A114);
                    EVALUATE(A1151, A115);
                    EVALUATE(A1161, A116);
                    EVALUATE(A1171, A117);
                    EVALUATE(A1181, A118);
                    EVALUATE(A1191, A119);
                    EVALUATE(A1201, A120);
                    EVALUATE(A1211, A121);
                    EVALUATE(A1221, A122);
                    EVALUATE(A1231, A123);
                    EVALUATE(A1241, A124);
                    EVALUATE(A1251, A125);
                    //EVALUATE(A1261,A126);
                end;

                trigger OnPreXmlItem()
                begin
                    compt1 := 0;
                    "Declaration Employeur".SETRANGE(Year, IntG_Exercice);
                end;
            }
            tableelement(integer; Integer)
            {
                XmlName = 'A1241';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(t1001)
                {
                    XmlName = 'T1001';
                    Width = 2;
                }
                textelement(t1011)
                {
                    XmlName = 'T1011';
                    Width = 7;
                }
                textelement(t1021)
                {
                    XmlName = 'T1021';
                    Width = 1;
                }
                textelement(t1031)
                {
                    XmlName = 'T1031';
                    Width = 1;
                }
                textelement(t1041)
                {
                    XmlName = 'T1041';
                    Width = 3;
                }
                textelement(t1051)
                {
                    XmlName = 'T1051';
                    Width = 4;
                }
                textelement(t1061)
                {
                    XmlName = 'T1061';
                    Width = 242;
                }
                textelement(t1071)
                {
                    XmlName = 'T1071';
                    Width = 15;
                }
                textelement(t1081)
                {
                    XmlName = 'T1081';
                    Width = 15;
                }
                textelement(t1091)
                {
                    XmlName = 'T1091';
                    Width = 15;
                }
                textelement(t1101)
                {
                    XmlName = 'T1101';
                    Width = 15;
                }
                textelement(t1111)
                {
                    XmlName = 'T1111';
                    Width = 15;
                }
                textelement(t1121)
                {
                    XmlName = 'T1121';
                    Width = 15;
                }
                textelement(t1131)
                {
                    XmlName = 'T1131';
                    Width = 15;
                }
                textelement(t1141)
                {
                    XmlName = 'T1141';
                    Width = 15;
                }
                textelement(t1151)
                {
                    XmlName = 'T1151';
                    Width = 19;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //-----------------------------------------------------------------------------------------

                    //-- ligne entete annexe 1 : ANXFIN01 --//

                    //Type enregistrement
                    T100 := 'T1';

                    //Matricule Fiscal
                    T101 := COPYSTR(MatriculeSociete, 1, 7);

                    //Clé du matricule fiscal
                    T102 := COPYSTR(MatriculeSociete, 8, 1);

                    //Catégorie contribuable
                    T103 := COPYSTR(MatriculeSociete, 10, 1);

                    //Numéro de l’établissement secondaire du contribuable
                    T104 := COPYSTR(MatriculeSociete, 11, 3);

                    //Exercice
                    T105 := FORMAT(IntG_Exercice);

                    //Zone réservée 242 espaces
                    T106 := ' ';

                    //calcul totaux
                    RecL_DeclarationEmployeur.RESET;
                    RecL_DeclarationEmployeur.SETCURRENTKEY(Year, "Type Ligne Decl. Emp.");
                    RecL_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecL_DeclarationEmployeur.SETRANGE("Type Ligne Decl. Emp.", RecL_DeclarationEmployeur."Type Ligne Decl. Emp."::"Annexe I");
                    RecL_DeclarationEmployeur.CALCSUMS("Taxable Income", "Nature Benefits", "Reinvested Income",
                       "With. Amount Common Regime", "Total Withholding 20%", "Total redevances caisse compen",
                       "Total Contribution Conjoncture", "Net Amount Served", "Amount CSS");


                    //Total revenus imposables
                    T107 := FnctG_FormatMontant(RecL_DeclarationEmployeur."Taxable Income", 15);

                    //Total Nature Benefits
                    T108 := FnctG_FormatMontant(RecL_DeclarationEmployeur."Nature Benefits", 15);

                    //Total revenus bruts imposables
                    T109 := FnctG_FormatMontant
                      (RecL_DeclarationEmployeur."Taxable Income" + RecL_DeclarationEmployeur."Nature Benefits", 15);

                    //Total revenus réinvestis
                    T110 := FnctG_FormatMontant(RecL_DeclarationEmployeur."Reinvested Income", 15);

                    //Total retenues opérées selon le régime commun
                    T111 := FnctG_FormatMontant(RecL_DeclarationEmployeur."With. Amount Common Regime", 15);

                    //Total retenues opérées au taux de 20%
                    T112 := FnctG_FormatMontant(RecL_DeclarationEmployeur."Total Withholding 20%", 15);


                    //-->Update RIADH 07-03-17 V 2016
                    // Total Montant des traitements et salaires preleves au titre de la contribution conjoncturelle
                    //T114 := FnctG_FormatMontant(RecL_DeclarationEmployeur."Total Contribution Conjoncture",15);
                    // Total mnt CSS V2018

                    T113 := FnctG_FormatMontant(RecL_DeclarationEmployeur."Amount CSS", 15);


                    //Total nets servis
                    //T114 :=('000000000000000');

                    //Total nets servis
                    T114 := FnctG_FormatMontant(RecL_DeclarationEmployeur."Net Amount Served", 15);

                    //Zone réservée 40 espaces
                    T115 := ' ';
                    //-->End Update RIADH 07-03-17 V 2016
                    // add aussi "Contribution sociale ici"
                    //-----------------------------------------------------------------------------------------



                    EVALUATE(T1001, T100);
                    EVALUATE(T1011, T101);
                    EVALUATE(T1021, T102);
                    EVALUATE(T1031, T103);
                    EVALUATE(T1041, T104);
                    EVALUATE(T1051, T105);
                    EVALUATE(T1061, T106);
                    EVALUATE(T1071, T107);
                    EVALUATE(T1081, T108);
                    EVALUATE(T1091, T109);
                    EVALUATE(T1101, T110);
                    EVALUATE(T1111, T111);
                    EVALUATE(T1121, T112);
                    EVALUATE(T1131, T113);
                    EVALUATE(T1141, T114);
                    EVALUATE(T1151, T115);
                    //EVALUATE(T1161,T116);
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {

                field(IntG_Exercice; IntG_Exercice)
                {
                    ApplicationArea = ALL;
                    Caption = 'Exercice:';
                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin

        totAv := 0;
        totbrimp := 0;
        totimp := 0;
    end;

    trigger OnPreXmlPort()
    begin

        currXMLport.FILENAME := STRSUBSTNO('C:\Declaration\ANXEMP_%1_%2_%3.txt', 1, COPYSTR(FORMAT(IntG_Exercice), 3, 2), 1);
    end;

    var
        Exercice: Integer;
        E000: Code[2];
        E001: Code[7];
        E002: Code[1];
        E003: Code[1];
        E004: Code[3];
        E005: Code[4];
        E006: Code[3];
        E007: Code[1];
        E008: Code[6];
        E009: Code[40];
        E010: Code[40];
        E011: Code[40];
        E012: Code[72];
        E013: Code[4];
        E014: Code[4];
        E015: Code[177];
        A100: Code[2];
        A101: Code[7];
        A102: Code[1];
        A103: Code[1];
        A104: Code[3];
        A105: Code[4];
        A106: Code[6];
        A107: Code[1];
        A108: Code[13];
        A109: Code[40];
        A110: Code[40];
        A111: Code[120];
        A112: Code[1];
        A113: Code[2];
        A114: Code[8];
        A115: Code[8];
        A116: Code[3];
        A117: Code[15];
        A118: Code[15];
        A119: Code[15];
        A120: Code[15];
        A121: Code[15];
        A122: Code[15];
        A123: Code[15];
        A124: Code[15];
        A125: Code[25];
        A126: Code[10];
        compt1: Integer;
        "compagny information": Integer;
        T100: Code[2];
        T101: Code[7];
        T102: Code[1];
        T103: Code[1];
        T104: Code[3];
        T105: Code[4];
        T106: Code[242];
        T107: Code[15];
        T108: Code[15];
        T109: Code[15];
        T110: Code[15];
        T111: Code[15];
        T112: Code[15];
        T113: Code[15];
        totAv: Decimal;
        totbrimp: Decimal;
        totimp: Decimal;
        L: Integer;
        mm: Text[30];
        Mnt: Text[30];
        // "rec. salary line": Record "52048946";
        T114: Code[15];
        T115: Code[25];
        T116: Code[10];
        RecG_CompanyInformation: Record "Company Information";
        IntG_Exercice: Integer;
        RecL_DeclarationEmployeur: Record "WDC Declaration Employeur";
        IntG_LineNo: Integer;
        MatriculeSociete: Text[30];
        MatriculeEnregistrement: Text[30];

    local procedure FnctG_FormatMontant(DecP_Montant: Decimal; IntG_NbChars: Integer): Text
    var
        Sep: Text[30];
        Nbres: Text[30];
    begin

        //formater DecP_Montant en un enregistrement de IntG_NbChars caractères de type 000000DecP_Montant
        //exple : DecP_Montant 15.369,200 , IntG_NbChars = 15  -> donne :  000000015369200
        //(idée de MBY, mise sous forme de fonction et commentée par MZK)

        //chercher le caractère séparateur ÿ
        Sep := DELCHR(FORMAT(ROUND(DecP_Montant, 0.001) * 1000), '=', '0|1|2|3|4|5|6|7|8|9');

        //eliminer les caractères autres que séparateur
        Nbres := DELCHR(FORMAT(ROUND(DecP_Montant, 0.001) * 1000), '=', '.|,|;|ÿ| ');

        //eliminer le séparateur
        Nbres := DELCHR(Nbres, '=', Sep);

        //mettre sous forme 000000montnat
        EXIT(PADSTR('', IntG_NbChars - STRLEN(FORMAT(Nbres)), '0') + FORMAT(Nbres));
    end;
}

