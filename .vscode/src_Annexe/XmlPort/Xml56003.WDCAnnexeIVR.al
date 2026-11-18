xmlport 56003 "WDC Annexe IV-R"
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

                    //-- ligne entete annexe 1 : ANXDEB00 --//

                    //Type enregistrement
                    E000 := 'E4';

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
                    E006 := 'An4';

                    //Code acte 0 : Spontané, 1 : Régularisation, 2 : redressement
                    E007 := '0';

                    //Nombre total de bénéficiaires
                    RecL_DeclarationEmployeur.RESET;
                    RecL_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecL_DeclarationEmployeur.SETRANGE("Type Ligne Decl. Emp.", RecL_DeclarationEmployeur."Type Ligne Decl. Emp."::"Annexe IV");
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
                    //RK 2016
                    //E013:= FORMAT(RecG_CompanyInformation."No. Rue");
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
                                  WHERE("Type Ligne Decl. Emp." = FILTER(4));
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
                    Width = 5;
                }
                textelement(a1141)
                {
                    XmlName = 'A1141';
                    Width = 15;
                }
                textelement(a1151)
                {
                    XmlName = 'A1151';
                    Width = 5;
                }
                textelement(a1161)
                {
                    XmlName = 'A1161';
                    Width = 15;
                }
                textelement(a1171)
                {
                    XmlName = 'A1171';
                    Width = 5;
                }
                textelement(a1181)
                {
                    XmlName = 'A1181';
                    Width = 15;
                }
                textelement(a1191)
                {
                    XmlName = 'A1191';
                    Width = 5;
                }
                textelement(a1201)
                {
                    XmlName = 'A1201';
                    Width = 15;
                }
                textelement(a1211)
                {
                    XmlName = 'A1211';
                    Width = 5;
                }
                textelement(a1221)
                {
                    XmlName = 'A1221';
                    Width = 15;
                }
                textelement(a1231)
                {
                    XmlName = 'A1231';
                    Width = 1;
                }
                textelement(a1241)
                {
                    XmlName = 'A1241';
                    Width = 15;
                }
                textelement(a1251)
                {
                    XmlName = 'A1251';
                    Width = 15;
                }
                textelement(a1261)
                {
                    XmlName = 'A1261';
                    Width = 15;
                }
                textelement(a1271)
                {
                    XmlName = 'A1271';
                    Width = 15;
                }
                textelement(a1281)
                {
                    XmlName = 'A1281';
                    Width = 5;
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
                    A400 := 'L4';

                    //extraire Identifiant contribuable déclarant
                    RecG_CompanyInformation.GET;

                    // BEGIN ADD TAK
                    MatriculeSociete := DELCHR(RecG_CompanyInformation."VAT Registration No.", '=', '/');
                    // END ADD TAK
                    //Matricule Fiscal
                    A401 := COPYSTR(MatriculeSociete, 1, 7);

                    //Clé du matricule fiscal
                    A402 := COPYSTR(MatriculeSociete, 8, 1);

                    //Catégorie contribuable
                    A403 := COPYSTR(MatriculeSociete, 10, 1);

                    //Numéro de l’établissement secondaire du contribuable
                    A404 := COPYSTR(MatriculeSociete, 11, 3);

                    //Exercice
                    A405 := FORMAT(IntG_Exercice);

                    //Numéro d’ordre (exple Sequence No. 115 => enregistrement ds fichier : 000115)
                    IntG_LineNo += 1;
                    A406 := PADSTR('', 6 - STRLEN(FORMAT(IntG_LineNo)), '0') + FORMAT(IntG_LineNo);

                    //Type identifiant du bénéficiaire  2 : CIN, 3 : Numéro de la carte du séjour pour les étrangers
                    A407 := "Declaration Employeur"."Source Type ID";

                    // BEGIN ADD TAK
                    MatriculeEnregistrement := DELCHR("Declaration Employeur"."Source ID", '=', '/');
                    // END ADD TAK

                    //ID bénéficiaire : N° CIN ou Numéro de la carte de séjour pour les étrangers
                    A408 := COPYSTR(MatriculeEnregistrement, 1, 13);

                    //Nom et prénom du bénéficiaire
                    A409 := COPYSTR("Declaration Employeur"."Source Name", 1, 40);

                    //Emploi occupé du bénéficiaire
                    A410 := COPYSTR("Declaration Employeur"."Source Activity", 1, 40);

                    //Dernière adresse du bénéficiaire
                    A411 := COPYSTR("Declaration Employeur"."Source Address", 1, 120);

                    //Type des montants servis au titre des honoraires, commissions, courtages, loyers et rémunérations des activités non commerciales.
                    //val par defaut 0.
                    A412 := '0';
                    A413 := '0';

                    //"Pos. mnt Brut dans Annexe" determine le type de retenu de la ligne
                    CASE "Declaration Employeur"."Pos. mnt Brut dans Annexe" OF

                        //Montant brut des honoraires, commissions, courtages, loyers et rémunérations des activités non commerciales et autres revenus
                        'A414':
                            BEGIN
                                A412 := "Declaration Employeur"."Sous Pos. mnt Brut ds  Annexe";
                                A413 := FnctG_FormatMontant("Declaration Employeur"."% Withholding Tax", 5);
                                A414 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                A415 := '00000';
                                A416 := '000000000000000';
                                A417 := '00000';
                                A418 := '000000000000000';
                                A419 := '00000';
                                A420 := '000000000000000';
                                A421 := '00000';
                                A422 := '000000000000000';
                                // V 2015
                                A424 := '0';
                                A425 := '000000000000000';
                                //update 2017
                                // A426 := '000000000000000';
                                // V 2015

                                //tot 414
                                DecG_Tot414 += "Declaration Employeur"."Base Withholding Amount";
                            END;



                        //Montant des honoraires servis aux personnes non résidentes qui réalisent des travaux de construction ou des opérations
                        //de montage ou des services de contrôles connexes ou d’autres services et travaux pour une période ne dépassant pas 6 mois.
                        'A416':
                            BEGIN
                                A413 := '00000';
                                A414 := '000000000000000';
                                A415 := FnctG_FormatMontant("Declaration Employeur"."% Withholding Tax", 5);
                                A416 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                A417 := '00000';
                                A418 := '000000000000000';
                                A419 := '00000';
                                A420 := '000000000000000';
                                A421 := '00000';
                                A422 := '000000000000000';
                                // V 2015
                                A423 := '0';
                                A424 := '000000000000000';
                                A425 := '000000000000000';
                                //update 2017
                                A426 := '000000000000000';
                                // V 2015

                                //tot 416
                                DecG_Tot416 += "Declaration Employeur"."Base Withholding Amount";
                            END;


                        //Montant de la plus-value immobilière.
                        'A418':
                            BEGIN
                                A413 := '00000';
                                A414 := '000000000000000';
                                A415 := '00000';
                                A416 := '000000000000000';
                                A417 := FnctG_FormatMontant("Declaration Employeur"."% Withholding Tax", 5);
                                A418 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                A419 := '00000';
                                A420 := '000000000000000';
                                A421 := '00000';
                                A422 := '000000000000000';
                                // V 2015
                                A424 := '0';
                                A425 := '000000000000000';
                                //update 2017
                                //A426 := '000000000000000';
                                // V 2015

                                //tot 418
                                DecG_Tot418 += "Declaration Employeur"."Base Withholding Amount";
                            END;


                        //Revenus des valeurs mobilières et jetons de présence
                        'A420':
                            BEGIN
                                A413 := '00000';
                                A414 := '000000000000000';
                                A415 := '00000';
                                A416 := '000000000000000';
                                A417 := '00000';
                                A418 := '000000000000000';
                                A419 := FnctG_FormatMontant("Declaration Employeur"."% Withholding Tax", 5);
                                A420 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                A421 := '00000';
                                A422 := '000000000000000';
                                // V 2015
                                A424 := '0';
                                A425 := '000000000000000';
                                //update 2017
                                //A426 := '000000000000000';
                                // V 2015

                                //tot 420
                                DecG_Tot420 += "Declaration Employeur"."Base Withholding Amount";
                            END;

                        //Montant plus-value de cession des actions, des parts sociales ou des parts de fonds prévues par la législation
                        'A422':
                            BEGIN
                                A413 := '00000';
                                A414 := '000000000000000';
                                A415 := '00000';
                                A416 := '000000000000000';
                                A417 := '00000';
                                A418 := '000000000000000';
                                A419 := '00000';
                                A420 := '000000000000000';
                                A421 := FnctG_FormatMontant("Declaration Employeur"."% Withholding Tax", 5);
                                A422 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                // V 2015
                                A424 := '0';
                                A425 := '000000000000000';
                                //update 2017
                                //A426 := '000000000000000';
                                // V 2015

                                //tot 422
                                DecG_Tot422 += "Declaration Employeur"."Base Withholding Amount";
                            END;

                        // Type des montants servis au titre des honoraires (1), commissions(2), courtages(3), loyers(4)
                        //et rémunérations des activités non commerciales provenant des opérations d’exportation (5)
                        'A424':
                            BEGIN
                                A413 := '00000';
                                A414 := '000000000000000';
                                A415 := '00000';
                                A416 := '000000000000000';
                                A417 := '00000';
                                A418 := '000000000000000';
                                A419 := '00000';
                                A420 := '000000000000000';
                                A421 := '00000';
                                A422 := '000000000000000';

                                // V 2015
                                A423 := "Declaration Employeur"."Sous Pos. mnt Brut ds  Annexe";
                                A424 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                A425 := '000000000000000';
                                //tot 425
                                DecG_Tot425 += "Declaration Employeur"."Base Withholding Amount";
                                // V 2015

                            END;
                        // PAaradis fiscaux
                        'A425':
                            BEGIN
                                A413 := '00000';
                                A414 := '000000000000000';
                                A415 := '00000';
                                A416 := '000000000000000';
                                A417 := '00000';
                                A418 := '000000000000000';
                                A419 := '00000';
                                A420 := '000000000000000';
                                A421 := '00000';
                                A422 := '000000000000000';

                                // V 2015
                                A424 := '000000000000000';
                                A425 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                //tot 425
                                DecG_Tot425 += "Declaration Employeur"."Base Withholding Amount";
                                // V 2016

                            END;


                    END;

                    //Montant des retenues opérées
                    A426 := FnctG_FormatMontant("Declaration Employeur"."Withholding Amount", 15);

                    //RB DECEMP V 2016

                    //Montant net servi
                    A427 := FnctG_FormatMontant("Declaration Employeur"."Net Amount Served", 15);

                    //Zone Réservée 5 espaces
                    A428 := ' ';

                    //RB DECEMP V 2016


                    EVALUATE(A1001, A400);
                    EVALUATE(A1011, A401);
                    EVALUATE(A1021, A402);
                    EVALUATE(A1031, A403);
                    EVALUATE(A1041, A404);
                    EVALUATE(A1051, A405);
                    EVALUATE(A1061, A406);
                    EVALUATE(A1071, A407);
                    EVALUATE(A1081, A408);
                    EVALUATE(A1091, A409);
                    EVALUATE(A1101, A410);
                    EVALUATE(A1111, A411);
                    EVALUATE(A1121, A412);
                    EVALUATE(A1131, A413);
                    EVALUATE(A1141, A414);
                    EVALUATE(A1151, A415);
                    EVALUATE(A1161, A416);
                    EVALUATE(A1171, A417);
                    EVALUATE(A1181, A418);
                    EVALUATE(A1191, A419);
                    EVALUATE(A1201, A420);
                    EVALUATE(A1211, A421);
                    EVALUATE(A1221, A422);
                    EVALUATE(A1231, A423);
                    EVALUATE(A1241, A424);
                    EVALUATE(A1251, A425);
                    EVALUATE(A1261, A426);
                    EVALUATE(A1271, A427);
                    EVALUATE(A1281, A428);
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
                    Width = 221;
                }
                textelement(t1071)
                {
                    XmlName = 'T1071';
                    Width = 5;
                }
                textelement(t1081)
                {
                    XmlName = 'T1081';
                    Width = 15;
                }
                textelement(t1091)
                {
                    XmlName = 'T1091';
                    Width = 5;
                }
                textelement(t1101)
                {
                    XmlName = 'T1101';
                    Width = 15;
                }
                textelement(t1111)
                {
                    XmlName = 'T1111';
                    Width = 5;
                }
                textelement(t1121)
                {
                    XmlName = 'T1121';
                    Width = 15;
                }
                textelement(t1131)
                {
                    XmlName = 'T1131';
                    Width = 5;
                }
                textelement(t1141)
                {
                    XmlName = 'T1141';
                    Width = 15;
                }
                textelement(t1151)
                {
                    XmlName = 'T1151';
                    Width = 5;
                }
                textelement(t1161)
                {
                    XmlName = 'T1161';
                    Width = 15;
                }
                textelement(t1171)
                {
                    XmlName = 'T1171';
                    Width = 1;
                }
                textelement(t1181)
                {
                    XmlName = 'T1181';
                    Width = 15;
                }
                textelement(t1191)
                {
                    XmlName = 'T1191';
                    Width = 15;
                }
                textelement(t1201)
                {
                    XmlName = 'T1201';
                    Width = 15;
                }
                textelement(t1211)
                {
                    XmlName = 'T1211';
                    Width = 15;
                }
                textelement(t1221)
                {
                    XmlName = 'T1221';
                    Width = 5;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //-- ligne entete annexe 1 : ANXFIN0 --//

                    //Type enregistrement
                    T400 := 'T4';

                    //Matricule Fiscal
                    T401 := COPYSTR(MatriculeSociete, 1, 7);

                    //Clé du matricule fiscal
                    T402 := COPYSTR(MatriculeSociete, 8, 1);

                    //Catégorie contribuable
                    T403 := COPYSTR(MatriculeSociete, 10, 1);

                    //Numéro de l’établissement secondaire du contribuable
                    T404 := COPYSTR(MatriculeSociete, 11, 3);
                    //Exercice
                    T405 := FORMAT(IntG_Exercice);

                    //Zone réservée 221 espaces
                    T406 := ' ';

                    //tot Montant brut des honoraires, commissions, courtages, loyers et rémunérations des activités non commerciales et autres revenus
                    T407 := '00000';
                    T408 := FnctG_FormatMontant(DecG_Tot414, 15);

                    //tot Montant des honoraires servis aux personnes non résidentes qui réalisent des travaux de construction ou des opérations
                    //de montage ou des services de contrôles connexes ou d’autres services et travaux pour une période ne dépassant pas 6 mois.
                    T409 := '00000';
                    T410 := FnctG_FormatMontant(DecG_Tot416, 15);

                    //tot Montant de la plus-value immobilière.
                    T411 := '00000';
                    T412 := FnctG_FormatMontant(DecG_Tot418, 15);

                    //tot Montant plus-value de cession des actions, des parts sociales ou des parts de fonds prévues par la législation
                    T413 := '00000';
                    T414 := FnctG_FormatMontant(DecG_Tot420, 15);

                    //tot Montant plus-value de cession des actions, des parts sociales ou des parts de fonds prévues par la législation
                    T415 := '00000';
                    T416 := FnctG_FormatMontant(DecG_Tot422, 15);
                    //A RéGLER--------------------------------------------------------------
                    // Zone Réservée 01 Espace
                    T417 := ' ';
                    //calcul totaux
                    RecL_DeclarationEmployeur.RESET;
                    RecL_DeclarationEmployeur.SETCURRENTKEY(Year, "Type Ligne Decl. Emp.");
                    RecL_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecL_DeclarationEmployeur.SETRANGE("Type Ligne Decl. Emp.", RecL_DeclarationEmployeur."Type Ligne Decl. Emp."::"Annexe IV");
                    RecL_DeclarationEmployeur.CALCSUMS("Withholding Amount", "Net Amount Served");
                    // RK DECEMP V 2016
                    //Total de montant brut des honoraires, commissions, courtages, loyers et rémunérations des activités non commerciales provenant des
                    T418 := FnctG_FormatMontant(DecG_Tot424, 15);
                    // Total de montant des rémunérations ou revenus servis à des personnes résidentes ou établies dans des paradis fiscaux.
                    T419 := FnctG_FormatMontant(DecG_Tot425, 15);
                    //Total retenues opérées
                    T420 := FnctG_FormatMontant(RecL_DeclarationEmployeur."Withholding Amount", 15);
                    //Total nets servis
                    T421 := FnctG_FormatMontant(RecL_DeclarationEmployeur."Net Amount Served", 15);

                    // Zone Réservée 5 Espace
                    T422 := ' ';

                    // RK DECEMP V 2016


                    EVALUATE(T1001, T400);
                    EVALUATE(T1011, T401);
                    EVALUATE(T1021, T402);
                    EVALUATE(T1031, T403);
                    EVALUATE(T1041, T404);
                    EVALUATE(T1051, T405);
                    EVALUATE(T1061, T406);
                    EVALUATE(T1071, T407);
                    EVALUATE(T1081, T408);
                    EVALUATE(T1091, T409);
                    EVALUATE(T1101, T410);
                    EVALUATE(T1111, T411);
                    EVALUATE(T1121, T412);
                    EVALUATE(T1131, T413);
                    EVALUATE(T1141, T414);
                    EVALUATE(T1151, T415);
                    EVALUATE(T1161, T416);
                    EVALUATE(T1171, T417);
                    EVALUATE(T1181, T418);
                    EVALUATE(T1191, T419);
                    EVALUATE(T1201, T420);
                    EVALUATE(T1211, T421);
                    EVALUATE(T1221, T422);
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
    end;

    trigger OnPreXmlPort()
    begin

        currXMLport.FILENAME := STRSUBSTNO('C:\Declaration\ANXEMP_%1_%2_%3.txt', 4, COPYSTR(FORMAT(IntG_Exercice), 3, 2), 1);
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
        A400: Code[2];
        A401: Code[7];
        A402: Code[1];
        A403: Code[1];
        A404: Code[3];
        A405: Code[4];
        A406: Code[6];
        A407: Code[1];
        A408: Code[13];
        A409: Code[40];
        A410: Code[40];
        A411: Code[120];
        A412: Code[1];
        A413: Code[5];
        A414: Code[15];
        A415: Code[5];
        A416: Code[15];
        A417: Code[5];
        A418: Code[15];
        A419: Code[5];
        A420: Code[15];
        A421: Code[5];
        A422: Code[15];
        A423: Code[1];
        A424: Code[15];
        A425: Code[15];
        A426: Code[15];
        A427: Code[15];
        A428: Code[5];
        compt1: Integer;
        "compagny information": Integer;
        T400: Code[2];
        T401: Code[7];
        T402: Code[1];
        T403: Code[1];
        T404: Code[3];
        T405: Code[4];
        T406: Code[221];
        T407: Code[5];
        T408: Code[15];
        T409: Code[5];
        T410: Code[15];
        T411: Code[5];
        T412: Code[15];
        T413: Code[5];
        T414: Code[15];
        T415: Code[5];
        T416: Code[15];
        T417: Code[1];
        T418: Code[15];
        T419: Code[15];
        T420: Code[15];
        T421: Code[15];
        T422: Code[5];
        totAv: Decimal;
        totbrimp: Decimal;
        totimp: Decimal;
        L: Integer;
        mm: Text[30];
        Mnt: Text[30];
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
        DecG_Tot424: Decimal;
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

