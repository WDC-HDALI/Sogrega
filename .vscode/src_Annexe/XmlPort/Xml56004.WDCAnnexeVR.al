xmlport 56004 "WDC Annexe V-R"
{
    // 
    // mm:=DELCHR(FORMAT((T1."Taxable salary"*1000)+100000000000000),'=','0|1|2|3|4|5|6|7|8|9');
    // Mnt:=DELCHR(STRSUBSTNO('%1',FORMAT((T1."Taxable salary"*1000)+100000000000000)),'=','.|,|;| ');
    // Mnt:=DELCHR(Mnt,'=',mm);

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
                XmlName = 'ANXDEB00';
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
                    Width = 177;
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


                    //Type enregistrement
                    E000 := 'E5';

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
                    E006 := 'An5';

                    //Code acte 0 : Spontané, 1 : Régularisation, 2 : redressement
                    E007 := '0';

                    //Nombre total de bénéficiaires
                    RecL_DeclarationEmployeur.RESET;
                    RecL_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecL_DeclarationEmployeur.SETRANGE("Type Ligne Decl. Emp.", RecL_DeclarationEmployeur."Type Ligne Decl. Emp."::"Annexe II");
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

                    //Zone réservée (177 espaces)
                    E015 := ' ';


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
                XmlName = 'ANXBEN02';
                SourceTableView = SORTING("Sequence No.")
                                  WHERE("Type Ligne Decl. Emp." = FILTER(5));
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
                    Width = 15;
                }
                textelement(a1131)
                {
                    XmlName = 'A1131';
                    Width = 15;
                }
                textelement(a1141)
                {
                    XmlName = 'A1141';
                    Width = 15;
                }
                textelement(a1151)
                {
                    XmlName = 'A1151';
                    Width = 15;
                }
                textelement(a1161)
                {
                    XmlName = 'A1161';
                    Width = 15;
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
                    Width = 32;
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

                    //Type d’enregistrement
                    A500 := 'L5';

                    //extraire Identifiant contribuable déclarant
                    RecG_CompanyInformation.GET;

                    // BEGIN ADD TAK
                    MatriculeSociete := DELCHR(RecG_CompanyInformation."VAT Registration No.", '=', '/');
                    // END ADD TAK
                    //Matricule Fiscal
                    A501 := COPYSTR(MatriculeSociete, 1, 7);

                    //Clé du matricule fiscal
                    A502 := COPYSTR(MatriculeSociete, 8, 1);

                    //Catégorie contribuable
                    A503 := COPYSTR(MatriculeSociete, 10, 1);

                    //Numéro de l’établissement secondaire du contribuable
                    A504 := COPYSTR(MatriculeSociete, 11, 3);

                    //Exercice
                    A505 := FORMAT(IntG_Exercice);

                    //Numéro d’ordre (exple Sequence No. 115 => enregistrement ds fichier : 000115)
                    IntG_LineNo += 1;
                    A506 := PADSTR('', 6 - STRLEN(FORMAT(IntG_LineNo)), '0') + FORMAT(IntG_LineNo);

                    //Type identifiant du bénéficiaire  2 : CIN, 3 : Numéro de la carte du séjour pour les étrangers
                    A507 := "Declaration Employeur"."Source Type ID";

                    // BEGIN ADD TAK
                    MatriculeEnregistrement := DELCHR("Declaration Employeur"."Source ID", '=', '/ ');
                    // END ADD TAK

                    //ID bénéficiaire : N° CIN ou Numéro de la carte de séjour pour les étrangers
                    A508 := MatriculeEnregistrement;
                    //Nom et prénom du bénéficiaire
                    A509 := COPYSTR("Declaration Employeur"."Source Name", 1, 40);

                    //Emploi occupé du bénéficiaire
                    A510 := COPYSTR("Declaration Employeur"."Source Activity", 1, 40);

                    //Dernière adresse du bénéficiaire
                    A511 := COPYSTR("Declaration Employeur"."Source Address", 1, 120);

                    //"Pos. mnt Brut dans Annexe" determine le type de retenu de la ligne
                    CASE "Declaration Employeur"."Pos. mnt Brut dans Annexe" OF

                        //Payed Amounts >= 2000 dinars et les Payed Amounts par les établissements publics >= à 1000 dinars (TTC)
                        'A512':
                            BEGIN

                                //bases retenue
                                A512 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);

                                //Retenues
                                A513 := FnctG_FormatMontant("Declaration Employeur"."Withholding Amount", 15);

                                A514 := '000000000000000';
                                A515 := '000000000000000';
                                A516 := '000000000000000';
                                A517 := '000000000000000';
                                A518 := '000000000000000';
                                A519 := '000000000000000';

                                //tot 512, 513
                                DecG_Tot512 += "Declaration Employeur"."Base Withholding Amount";
                                DecG_Tot513 += "Declaration Employeur"."Withholding Amount";
                            END;

                        //--> Update Ramis 28-01-16

                        //Montants  >= 1000 dinars y comrpis la TVA payés au titre des autres opérations
                        'A514':
                            BEGIN


                                A512 := '000000000000000';
                                A513 := '000000000000000';
                                //bases retenue
                                A514 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                //Retenues
                                A515 := FnctG_FormatMontant("Declaration Employeur"."Withholding Amount", 15);
                                A516 := '000000000000000';
                                A517 := '000000000000000';
                                //BEGIN ADD TAK
                                A518 := '000000000000000';
                                A519 := '000000000000000';
                                //ADD END TAK
                                //tot 514, 515
                                DecG_Tot514 += "Declaration Employeur"."Base Withholding Amount";
                                DecG_Tot515 += "Declaration Employeur"."Withholding Amount";
                            END;



                        //Payed Amounts par les entreprises etab publics >= 1000 dinars y compris la TVA
                        //et soumis à la retenue à la source au titre de la TVA.
                        'A516':
                            BEGIN
                                //MESSAGE('fdfff');
                                A514 := '000000000000000';
                                A515 := '000000000000000';

                                //bases retenue
                                A516 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);

                                //retenues
                                A517 := FnctG_FormatMontant("Declaration Employeur"."Withholding Amount", 15);

                                A518 := '000000000000000';
                                A519 := '000000000000000';

                                //tot 516, 517
                                DecG_Tot516 += "Declaration Employeur"."Base Withholding Amount";
                                DecG_Tot517 += "Declaration Employeur"."Withholding Amount";
                            END;


                        //Montants servis au titre des opérations réalisées avec les personnes n’ayant pas d’établissement en Tunisie *
                        //et dont la retenue à la source au titre de la TVA est de 100%.
                        'A518':
                            BEGIN
                                A514 := '000000000000000';
                                A515 := '000000000000000';
                                A516 := '000000000000000';
                                A517 := '000000000000000';

                                //base retenue
                                A518 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);

                                //retenues
                                A519 := FnctG_FormatMontant("Declaration Employeur"."Withholding Amount", 15);

                                //tot 518, 519
                                DecG_Tot518 += "Declaration Employeur"."Base Withholding Amount";
                                DecG_Tot519 += "Declaration Employeur"."Withholding Amount";
                            END;
                    END;

                    // Montant de la redevance au profit de la caisse générale de compensation (C.G.C).
                    /*A520 := '000000000000000';
                    IF  "Declaration Employeur"."Pos. mnt Brut dans Annexe" = 'A224' THEN
                    BEGIN
                       A520 := FnctG_FormatMontant( "Declaration Employeur"."Withholding Amount", 15);
                       // tot 520
                       DecG_Tot520 +=  "Declaration Employeur"."Withholding Amount";
                    END;*/

                    //Montant net servi
                    A520 := FnctG_FormatMontant("Declaration Employeur"."Net Amount Served", 15);

                    //Zone réservée : 32 espaces
                    A521 := ' ';

                    //--> End Update RIADH 09-03-17

                    //RB DECEMP V 2016


                    EVALUATE(A1001, A500);
                    EVALUATE(A1011, A501);
                    EVALUATE(A1021, A502);
                    EVALUATE(A1031, A503);
                    EVALUATE(A1041, A504);
                    EVALUATE(A1051, A505);
                    EVALUATE(A1061, A506);
                    EVALUATE(A1071, A507);
                    EVALUATE(A1081, A508);
                    EVALUATE(A1091, A509);
                    EVALUATE(A1101, A510);
                    EVALUATE(A1111, A511);
                    EVALUATE(A1121, A512);
                    EVALUATE(A1131, A513);
                    EVALUATE(A1141, A514);
                    EVALUATE(A1151, A515);
                    EVALUATE(A1161, A516);
                    EVALUATE(A1171, A517);
                    EVALUATE(A1181, A518);
                    EVALUATE(A1191, A519);
                    EVALUATE(A1201, A520);
                    EVALUATE(A1211, A521);

                end;

                trigger OnPreXmlItem()
                begin
                    compt1 := 0;
                    "Declaration Employeur".SETRANGE(Year, IntG_Exercice);
                end;
            }
            tableelement(Integer; Integer)
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
                    Width = 220;
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
                    Width = 15;
                }
                textelement(t1161)
                {
                    XmlName = 'T1161';
                    Width = 32;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //-- ligne entete annexe 1 : ANXDEB00 --//

                    //Type enregistrement
                    T500 := 'T5';

                    //Matricule Fiscal
                    T501 := COPYSTR(MatriculeSociete, 1, 7);

                    //Clé du matricule fiscal
                    T502 := COPYSTR(MatriculeSociete, 8, 1);

                    //Catégorie contribuable
                    T503 := COPYSTR(MatriculeSociete, 10, 1);

                    //Numéro de l’établissement secondaire du contribuable
                    T504 := COPYSTR(MatriculeSociete, 11, 3);
                    //Exercice
                    T505 := FORMAT(IntG_Exercice);

                    //Zone réservée 220 espaces
                    T506 := ' ';

                    //--> Update Ramis 28-01-2016
                    //-- Payed Amounts >= 2000 dinars et les Payed Amounts par les établissements publics >= à 1000 dinars (TTC) --//
                    //base retene
                    T507 := FnctG_FormatMontant(DecG_Tot512, 15);
                    //retenue
                    T508 := FnctG_FormatMontant(DecG_Tot513, 15);

                    //-- Montants  >= 1000 dinars y comrpis la TVA payés au titre des autres opérations --//
                    //base retenue
                    T509 := FnctG_FormatMontant(DecG_Tot514, 15);
                    //retenue
                    T510 := FnctG_FormatMontant(DecG_Tot515, 15);

                    //-- Payed Amounts par les etab publics > 1000 dinars (TTC) et soumis à la retenue à la source au titre de la TVA. --//
                    //base retenue
                    T511 := FnctG_FormatMontant(DecG_Tot516, 15);
                    //retenue
                    T512 := FnctG_FormatMontant(DecG_Tot517, 15);

                    //-- Montants servis au titre des opérations réalisées avec les personnes n’ayant pas d’établissement en Tunisie
                    //et dont la retenue à la source au titre de la TVA est de 100%. -- //
                    //base retenue
                    T513 := FnctG_FormatMontant(DecG_Tot518, 15);
                    //retenue
                    T514 := FnctG_FormatMontant(DecG_Tot519, 15);


                    //calcul totaux
                    RecL_DeclarationEmployeur.RESET;
                    RecL_DeclarationEmployeur.SETCURRENTKEY(Year, "Type Ligne Decl. Emp.");
                    RecL_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecL_DeclarationEmployeur.SETRANGE("Type Ligne Decl. Emp.", RecL_DeclarationEmployeur."Type Ligne Decl. Emp."::"Annexe V");
                    RecL_DeclarationEmployeur.CALCSUMS("Net Amount Served");


                    // Total des montants de la redevance au profit de la caisse générale de compensation (C.G.C).
                    //T515 := FnctG_FormatMontant(DecG_Tot520, 15);

                    //Total nets servis
                    T515 := FnctG_FormatMontant(RecL_DeclarationEmployeur."Net Amount Served", 15);

                    //Zone réservée 32 espaces
                    T516 := ' ';
                    //--> End Update Ramis 28-01-2016
                    // RB DECEMP V 2015


                    EVALUATE(T1001, T500);
                    EVALUATE(T1011, T501);
                    EVALUATE(T1021, T502);
                    EVALUATE(T1031, T503);
                    EVALUATE(T1041, T504);
                    EVALUATE(T1051, T505);
                    EVALUATE(T1061, T506);
                    EVALUATE(T1071, T507);
                    EVALUATE(T1081, T508);
                    EVALUATE(T1091, T509);
                    EVALUATE(T1101, T510);
                    EVALUATE(T1111, T511);
                    EVALUATE(T1121, T512);
                    EVALUATE(T1131, T513);
                    EVALUATE(T1141, T514);
                    EVALUATE(T1151, T515);
                    EVALUATE(T1161, T516);
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

    }

    trigger OnInitXmlPort()
    begin

        CLEAR(IntG_LineNo);

        CLEAR(DecG_Tot414);
        CLEAR(DecG_Tot416);
        CLEAR(DecG_Tot418);
        CLEAR(DecG_Tot420);
        CLEAR(DecG_Tot422);
        CLEAR(DecG_Tot425);
        CLEAR(DecG_Tot426);

        //filtre sur Year indiquée
        RecL_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);


        //inits
        CLEAR(IntG_LineNo);
        CLEAR(DecG_Tot512);
        CLEAR(DecG_Tot513);
        CLEAR(DecG_Tot514);
        CLEAR(DecG_Tot515);
        CLEAR(DecG_Tot516);
        CLEAR(DecG_Tot517);
        CLEAR(DecG_Tot518);
        CLEAR(DecG_Tot519);
        CLEAR(DecG_Tot520);
    end;

    trigger OnPreXmlPort()
    begin

        currXMLport.FILENAME := STRSUBSTNO('C:\Declaration\ANXEMP_%1_%2_%3.txt', 5, COPYSTR(FORMAT(IntG_Exercice), 3, 2), 1);
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
        A500: Code[2];
        A501: Code[7];
        A502: Code[1];
        A503: Code[1];
        A504: Code[3];
        A505: Code[4];
        A506: Code[6];
        A507: Code[1];
        A508: Code[13];
        A509: Code[40];
        A510: Code[40];
        A511: Code[120];
        A512: Code[15];
        A513: Code[15];
        A514: Code[15];
        A515: Code[15];
        A516: Code[15];
        A517: Code[15];
        A518: Code[15];
        A519: Code[15];
        A520: Code[15];
        A521: Code[32];
        compt1: Integer;
        "compagny information": Integer;
        T500: Code[2];
        T501: Code[7];
        T502: Code[1];
        T503: Code[1];
        T504: Code[3];
        T505: Code[4];
        T506: Code[220];
        T507: Code[15];
        T508: Code[15];
        T509: Code[15];
        T510: Code[15];
        T511: Code[15];
        T512: Code[15];
        T513: Code[15];
        T514: Code[15];
        T515: Code[15];
        T516: Code[32];
        totAv: Decimal;
        totbrimp: Decimal;
        totimp: Decimal;
        L: Integer;
        mm: Text[30];
        Mnt: Text[30];
        // "rec. salary line": Record "52048946";
        T214: Code[15];
        RecG_CompanyInformation: Record "Company Information";
        IntG_Exercice: Integer;
        RecL_DeclarationEmployeur: Record "WDC Declaration Employeur";
        IntG_LineNo: Integer;
        DecG_Tot213: Decimal;
        DecG_Tot214: Decimal;
        DecG_Tot215: Decimal;
        DecG_Tot216: Decimal;
        DecG_Tot217: Decimal;
        DecG_Tot218: Decimal;
        DecG_Tot219: Decimal;
        DecG_Tot220: Decimal;
        DecG_Tot222: Decimal;
        DecG_Tot224: Decimal;
        DecG_Tot312: Decimal;
        DecG_Tot313: Decimal;
        DecG_Tot314: Decimal;
        DecG_Tot316: Decimal;
        DecG_Tot414: Decimal;
        DecG_Tot416: Decimal;
        DecG_Tot418: Decimal;
        DecG_Tot420: Decimal;
        DecG_Tot422: Decimal;
        DecG_Tot425: Decimal;
        DecG_Tot426: Decimal;
        DecG_Tot512: Decimal;
        DecG_Tot513: Decimal;
        DecG_Tot514: Decimal;
        DecG_Tot515: Decimal;
        DecG_Tot516: Decimal;
        DecG_Tot517: Decimal;
        DecG_Tot518: Decimal;
        DecG_Tot519: Decimal;
        DecG_Tot520: Decimal;
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

