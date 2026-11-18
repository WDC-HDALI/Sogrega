xmlport 56001 "WDC Annexe II-R"
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
                    E000 := 'E2';

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
                    E006 := 'An2';

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

                    //Zone réservée (177 espaces) // RB DECEMP V 2015
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
                XmlName = 'ANXBEN02';
                SourceTableView = SORTING("Sequence No.")
                                  WHERE("Type Ligne Decl. Emp." = FILTER("Annexe II"));
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
                    Width = 10;
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
                    // MESSAGE('Hi');
                    //-- lignes salariés : ANXBEN01 --//

                    //Type d’enregistrement
                    A200 := 'L2';

                    //extraire Identifiant contribuable déclarant
                    RecG_CompanyInformation.GET;

                    // BEGIN ADD TAK
                    MatriculeSociete := DELCHR(RecG_CompanyInformation."VAT Registration No.", '=', '/');
                    // END ADD TAK
                    //Matricule Fiscal
                    A201 := COPYSTR(MatriculeSociete, 1, 7);

                    //Clé du matricule fiscal
                    A202 := COPYSTR(MatriculeSociete, 8, 1);

                    //Catégorie contribuable
                    A203 := COPYSTR(MatriculeSociete, 10, 1);

                    //Numéro de l’établissement secondaire du contribuable
                    A204 := COPYSTR(MatriculeSociete, 11, 3);
                    //Exercice
                    A205 := FORMAT(IntG_Exercice);

                    //Numéro d’ordre (exple Sequence No. 115 => enregistrement ds fichier : 000115)
                    IntG_LineNo += 1;
                    A206 := PADSTR('', 6 - STRLEN(FORMAT(IntG_LineNo)), '0') + FORMAT(IntG_LineNo);

                    //Type identifiant du bénéficiaire  2 : CIN, 3 : Numéro de la carte du séjour pour les étrangers
                    A207 := "Declaration Employeur"."Source Type ID";

                    // BEGIN ADD TAK
                    MatriculeEnregistrement := DELCHR("Declaration Employeur"."Source ID", '=', '/');
                    // END ADD TAK

                    //ID bénéficiaire : N° CIN ou Numéro de la carte de séjour pour les étrangers
                    A208 := MatriculeEnregistrement;

                    //Nom et prénom du bénéficiaire
                    A209 := COPYSTR("Declaration Employeur"."Source Name", 1, 40);

                    //Emploi occupé du bénéficiaire
                    A210 := COPYSTR("Declaration Employeur"."Source Activity", 1, 40);

                    //Dernière adresse du bénéficiaire
                    A211 := COPYSTR("Declaration Employeur"."Source Address", 1, 120);

                    //Type des montants servis au titre des honoraires, commissions, courtages, loyers et rémunérations des activités non commerciales.
                    //val par defaut 0.
                    A212 := '0';
                    A221 := '0';
                    // RB 16/02/2014

                    A213 := '000000000000000';
                    A214 := '000000000000000';
                    A215 := '000000000000000';
                    A216 := '000000000000000';
                    A217 := '000000000000000';
                    A218 := '000000000000000';
                    A219 := '000000000000000';
                    A220 := '000000000000000';
                    A221 := '0';
                    A222 := '000000000000000';
                    A224 := '000000000000000';

                    // RB 16/02/2014

                    //"Pos. mnt Brut dans Annexe" determine le type de retenu de la ligne
                    CASE "Declaration Employeur"."Pos. mnt Brut dans Annexe" OF

                        //Montant brut des honoraires, commissions, courtages, loyers et rémunérations des activités non commerciales.
                        //2016: y compris les commissions des distributeurs agrées des opérateurs téléphoniques.
                        'A213':
                            BEGIN
                                A212 := "Declaration Employeur"."Sous Pos. mnt Brut ds  Annexe";
                                A213 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                A214 := '000000000000000';
                                A215 := '000000000000000';
                                A216 := '000000000000000';
                                A217 := '000000000000000';
                                A218 := '000000000000000';
                                A219 := '000000000000000';
                                A220 := '000000000000000';
                                // V 2015
                                A221 := '0';
                                A222 := '000000000000000';
                                // V 2015

                                //tot 213
                                DecG_Tot213 += "Declaration Employeur"."Base Withholding Amount";
                            END;

                        //Honoraires servis aux sociétés et aux personnes physiques soumises au régime réel
                        'A214':
                            BEGIN
                                A213 := '000000000000000';
                                A214 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                A215 := '000000000000000';
                                A216 := '000000000000000';
                                A217 := '000000000000000';
                                A218 := '000000000000000';
                                A219 := '000000000000000';
                                A220 := '000000000000000';
                                // V 2015
                                A221 := '0';
                                A222 := '000000000000000';
                                // V 2015

                                //tot 214
                                DecG_Tot214 += "Declaration Employeur"."Base Withholding Amount";
                            END;

                        //Jetons de présence
                        //(2016: actions et parts sociales).
                        'A215':
                            BEGIN
                                A213 := '000000000000000';
                                A214 := '000000000000000';
                                A215 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                A216 := '000000000000000';
                                A217 := '000000000000000';
                                A218 := '000000000000000';
                                A219 := '000000000000000';
                                A220 := '000000000000000';
                                // V 2015
                                A221 := '0';
                                A222 := '000000000000000';
                                // V 2015

                                //tot 215
                                A221 := '0';
                                DecG_Tot215 += "Declaration Employeur"."Base Withholding Amount";
                            END;

                        //Rémunérations payées aux salariés et aux non salariés en contrepartie d’un travail occasionnel ou accidentel
                        //en dehors de leur activité principale
                        'A216':
                            BEGIN
                                A213 := '000000000000000';
                                A214 := '000000000000000';
                                A215 := '000000000000000';
                                A216 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                A217 := '000000000000000';
                                A218 := '000000000000000';
                                A219 := '000000000000000';
                                A220 := '000000000000000';
                                // V 2015
                                A221 := '0';
                                A222 := '000000000000000';
                                // V 2015

                                //tot 216
                                DecG_Tot216 += "Declaration Employeur"."Base Withholding Amount";
                            END;

                        //Plus-value immobilière (prix de l’immeuble déclaré dans l’acte)
                        'A217':
                            BEGIN
                                A213 := '000000000000000';
                                A214 := '000000000000000';
                                A215 := '000000000000000';
                                A216 := '000000000000000';
                                A217 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                A218 := '000000000000000';
                                A219 := '000000000000000';
                                A220 := '000000000000000';
                                // V 2015
                                A221 := '0';
                                A222 := '000000000000000';
                                // V 2015

                                //tot 217
                                DecG_Tot217 += "Declaration Employeur"."Base Withholding Amount";
                            END;

                        //Loyers des Hôtels payés aux sociétés et aux personnes physiques soumises au régime réel
                        'A218':
                            BEGIN
                                A213 := '000000000000000';
                                A214 := '000000000000000';
                                A215 := '000000000000000';
                                A216 := '000000000000000';
                                A217 := '000000000000000';
                                A218 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                A219 := '000000000000000';
                                A220 := '000000000000000';
                                // V 2015
                                A221 := '0';
                                A222 := '000000000000000';
                                // V 2015

                                //tot 218
                                DecG_Tot218 += "Declaration Employeur"."Base Withholding Amount";
                            END;

                        //Rémunérations servies aux artistes et créateurs
                        'A219':
                            BEGIN
                                A213 := '000000000000000';
                                A214 := '000000000000000';
                                A215 := '000000000000000';
                                A216 := '000000000000000';
                                A217 := '000000000000000';
                                A218 := '000000000000000';
                                A219 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                A220 := '000000000000000';
                                // V 2015
                                A221 := '0';
                                A222 := '000000000000000';
                                // V 2015

                                //tot 219
                                DecG_Tot219 += "Declaration Employeur"."Base Withholding Amount";
                            END;

                        //Honoraires servis aux bureaux d’études exportateurs
                        'A220':
                            BEGIN
                                A213 := '000000000000000';
                                A214 := '000000000000000';
                                A215 := '000000000000000';
                                A216 := '000000000000000';
                                A217 := '000000000000000';
                                A218 := '000000000000000';
                                A219 := '000000000000000';
                                A220 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                // V 2015
                                A221 := '0';
                                A222 := '000000000000000';
                                // V 2015

                                //tot 220
                                DecG_Tot220 += "Declaration Employeur"."Base Withholding Amount";
                            END;

                        //Montant brut des honoraires, commissions, courtages, loyers et rémunérations des activités non commerciales
                        //provenant des opérations d’exportation.
                        'A222':
                            BEGIN
                                A213 := '000000000000000';
                                A214 := '000000000000000';
                                A215 := '000000000000000';
                                A216 := '000000000000000';
                                A217 := '000000000000000';
                                A218 := '000000000000000';
                                A219 := '000000000000000';
                                A220 := '000000000000000';

                                // V 2015
                                //A221 := "Declaration Employeur"."Sous Pos. mnt Brut ds  Annexe";
                                //A222 := FnctG_FormatMontant("Declaration Employeur"."Base Withholding Amount", 15);
                                // V 2015

                                //tot 222
                                DecG_Tot222 += "Declaration Employeur"."Base Withholding Amount";
                            END;

                    END;


                    A221 := FnctG_FormatMontant("Declaration Employeur"."Withholding Amount", 15);
                    A222 := FnctG_FormatMontant("Declaration Employeur"."Net Amount Served", 15);
                    A223 := ' ';
                    // RK DECEMP V 2016

                    //Montant des retenues opérées
                    //A223 :=  FnctG_FormatMontant("Declaration Employeur"."Withholding Amount", 15);

                    //Montant net servi
                    //A224 := FnctG_FormatMontant("Declaration Employeur"."Net Amount Served", 15);

                    // RK DECEMP V 2016
                    EVALUATE(A1001, A200);
                    EVALUATE(A1011, A201);
                    EVALUATE(A1021, A202);
                    EVALUATE(A1031, A203);
                    EVALUATE(A1041, A204);
                    EVALUATE(A1051, A205);
                    EVALUATE(A1061, A206);
                    EVALUATE(A1071, A207);
                    EVALUATE(A1081, A208);
                    EVALUATE(A1091, A209);
                    EVALUATE(A1101, A210);
                    EVALUATE(A1111, A211);
                    EVALUATE(A1121, A212);
                    EVALUATE(A1131, A213);
                    EVALUATE(A1141, A214);
                    EVALUATE(A1151, A215);
                    EVALUATE(A1161, A216);
                    EVALUATE(A1171, A217);
                    EVALUATE(A1181, A218);
                    EVALUATE(A1191, A219);
                    EVALUATE(A1201, A220);
                    EVALUATE(A1211, A221);
                    EVALUATE(A1221, A222);
                    EVALUATE(A1231, A223);
                    //EVALUATE(A1241,A224);
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
                    Width = 15;
                }
                textelement(t1171)
                {
                    XmlName = 'T1171';
                    Width = 10;
                }
                textelement(t1181)
                {
                    XmlName = 'T1181';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //-----------------------------------------------------------------------------------------

                    //-- ligne entete annexe 1 : ANXFIN01 --//

                    //-- ligne entete annexe 1 : ANXDEB00 --//

                    //Type enregistrement
                    T200 := 'T2';

                    //Matricule Fiscal
                    T201 := COPYSTR(MatriculeSociete, 1, 7);

                    //Clé du matricule fiscal
                    T202 := COPYSTR(MatriculeSociete, 8, 1);

                    //Catégorie contribuable
                    T203 := COPYSTR(MatriculeSociete, 10, 1);

                    //Numéro de l’établissement secondaire du contribuable
                    T204 := COPYSTR(MatriculeSociete, 11, 3);

                    //Exercice
                    T205 := FORMAT(IntG_Exercice);

                    //Zone réservée 221 espaces
                    T206 := ' ';

                    //Total honoraires, commissions, courtages, loyers et rémunérations au titre des activités non commerciales servis.
                    //(2016: y compris les commissions des distributeurs agrées des opérateurs téléphoniques)
                    T207 := FnctG_FormatMontant(DecG_Tot213, 15);

                    //Total honoraires servis aux sociétés et aux personnes physiques soumises au régime réel.
                    T208 := FnctG_FormatMontant(DecG_Tot214, 15);

                    //Total jetons de présence
                    //(2016:Les actions et les parts sociales)
                    T209 := FnctG_FormatMontant(DecG_Tot215, 15);

                    //Total des rémunérations payées aux salariés et aux non salariés en contrepartie d’un travail occasionnel
                    //ou accidentel en dehors de leur activité principale
                    T210 := FnctG_FormatMontant(DecG_Tot216, 15);

                    //Total plus-value immobilière
                    T211 := FnctG_FormatMontant(DecG_Tot217, 15);

                    //Total Loyers des Hôtels
                    T212 := FnctG_FormatMontant(DecG_Tot218, 15);

                    //Total rémunérations servies aux artistes et créateurs
                    T213 := FnctG_FormatMontant(DecG_Tot219, 15);

                    //Total honoraires servis aux bureaux d’études exportateurs
                    T214 := FnctG_FormatMontant(DecG_Tot220, 15);

                    //calcul totaux
                    RecL_DeclarationEmployeur.RESET;
                    RecL_DeclarationEmployeur.SETCURRENTKEY(Year, "Type Ligne Decl. Emp.");
                    RecL_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecL_DeclarationEmployeur.SETRANGE("Type Ligne Decl. Emp.", RecL_DeclarationEmployeur."Type Ligne Decl. Emp."::"Annexe II");
                    RecL_DeclarationEmployeur.CALCSUMS("Withholding Amount", "Net Amount Served", "Base Withholding Amount");

                    // RB DECEMP V 2015

                    //Zone réservée T215 espaces
                    T215 := ' ';

                    // Total des montants servis au titre des honoraires, commissions,courtages, loyers et rémunérations des activités non commerciales
                    //provenant des opérations d’exportation. "Base Withholding Amount"
                    T216 := FnctG_FormatMontant(DecG_Tot222, 15);

                    //Total retenues opérées
                    T217 := FnctG_FormatMontant(RecL_DeclarationEmployeur."Withholding Amount", 15);

                    //Total nets servis
                    // T218 := FnctG_FormatMontant(RecL_DeclarationEmployeur."Net Amount Served", 15);



                    EVALUATE(T1001, T200);
                    EVALUATE(T1011, T201);
                    EVALUATE(T1021, T202);
                    EVALUATE(T1031, T203);
                    EVALUATE(T1041, T204);
                    EVALUATE(T1051, T205);
                    EVALUATE(T1061, T206);
                    EVALUATE(T1071, T207);
                    EVALUATE(T1081, T208);
                    EVALUATE(T1091, T209);
                    EVALUATE(T1101, T210);
                    EVALUATE(T1111, T211);
                    EVALUATE(T1121, T212);
                    EVALUATE(T1131, T213);
                    EVALUATE(T1141, T214);
                    EVALUATE(T1151, T215);
                    EVALUATE(T1161, T216);
                    EVALUATE(T1171, T217);
                    //EVALUATE(T1181, T218);
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
                    CaptionML = ENU = 'Exercise: ', FRA = 'Exercice:';
                }
            }
        }

    }

    trigger OnInitXmlPort()
    begin

        totAv := 0;
        totbrimp := 0;
        totimp := 0;

        CLEAR(IntG_LineNo);
        CLEAR(DecG_Tot213);
        CLEAR(DecG_Tot214);
        CLEAR(DecG_Tot215);
        CLEAR(DecG_Tot216);
        CLEAR(DecG_Tot217);
        CLEAR(DecG_Tot218);
        CLEAR(DecG_Tot219);
        CLEAR(DecG_Tot220);
        CLEAR(DecG_Tot222);
        CLEAR(DecG_Tot224);

        //filtre sur Year indiquée
        "Declaration Employeur".SETRANGE(Year, IntG_Exercice);
    end;

    trigger OnPreXmlPort()
    begin
        currXMLport.FILENAME := STRSUBSTNO('C:\Declaration\ANXEMP_%1_%2_%3.txt', 2, COPYSTR(FORMAT(IntG_Exercice), 3, 2), 1);
    end;

    var
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
        A200: Code[2];
        A201: Code[7];
        A202: Code[1];
        A203: Code[1];
        A204: Code[3];
        A205: Code[4];
        A206: Code[6];
        A207: Code[1];
        A208: Code[13];
        A209: Code[40];
        A210: Code[40];
        A211: Code[120];
        A212: Code[1];
        A213: Code[15];
        A214: Code[15];
        A215: Code[15];
        A216: Code[15];
        A217: Code[15];
        A218: Code[15];
        A219: Code[15];
        A220: Code[15];
        A221: Code[15];
        A222: Code[15];
        A223: Code[15];
        A224: Code[15];
        compt1: Integer;
        "compagny information": Integer;
        T200: Code[2];
        T201: Code[7];
        T202: Code[1];
        T203: Code[1];
        T204: Code[3];
        T205: Code[4];
        T206: Code[221];
        T207: Code[15];
        T208: Code[15];
        T209: Code[15];
        T210: Code[15];
        T211: Code[15];
        T212: Code[15];
        T213: Code[15];
        T215: Code[1];
        T216: Code[15];
        T217: Code[15];
        // T218: Code[15];
        totAv: Decimal;
        totbrimp: Decimal;
        totimp: Decimal;
        L: Integer;
        mm: Text[30];
        Mnt: Text[30];
        //"rec. salary line": Record 52048946;
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

