xmlport 56005 "WDC Annexe VI-R"
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


                    //Type enregistrement
                    E000 := 'E6';

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
                    E006 := 'An6';

                    //Code acte 0 : Spontané, 1 : Régularisation, 2 : redressement
                    E007 := '0';

                    //Nombre total de bénéficiaires
                    RecL_DeclarationEmployeur.RESET;
                    RecL_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecL_DeclarationEmployeur.SETRANGE("Type Ligne Decl. Emp.", RecL_DeclarationEmployeur."Type Ligne Decl. Emp."::"Annexe VI");
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
                                  WHERE("Type Ligne Decl. Emp." = FILTER("Annexe VI"));
                //   "Year" = FILTER(2020));
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
                    Width = 16;
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
                    Width = 46;
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

                    //-- lignes salariés : ANXBEN01 --//

                    //Type d’enregistrement
                    A600 := 'L6';

                    //extraire Identifiant contribuable déclarant
                    RecG_CompanyInformation.GET;

                    // BEGIN ADD TAK
                    MatriculeSociete := DELCHR(RecG_CompanyInformation."VAT Registration No.", '=', '/');
                    // END ADD TAK
                    //Matricule Fiscal
                    A601 := COPYSTR(MatriculeSociete, 1, 7);
                    //Clé du matricule fiscal
                    A602 := COPYSTR(MatriculeSociete, 8, 1);

                    //Catégorie contribuable
                    A603 := COPYSTR(MatriculeSociete, 10, 1);

                    //Numéro de l’établissement secondaire du contribuable
                    A604 := COPYSTR(MatriculeSociete, 11, 3);

                    //Exercice
                    A605 := FORMAT(IntG_Exercice);

                    //Numéro d’ordre (exple Sequence No. 115 => enregistrement ds fichier : 000115)
                    IntG_LineNo += 1;
                    A606 := PADSTR('', 6 - STRLEN(FORMAT(IntG_LineNo)), '0') + FORMAT(IntG_LineNo);

                    //Type identifiant du bénéficiaire  2 : CIN, 3 : Numéro de la carte du séjour pour les étrangers
                    A607 := "Declaration Employeur"."Source Type ID";

                    // BEGIN ADD TAK
                    MatriculeEnregistrement := DELCHR("Declaration Employeur"."Source ID", '=', '/| ');
                    // END ADD TAK

                    //ID bénéficiaire : N° CIN ou Numéro de la carte de séjour pour les étrangers
                    A608 := MatriculeEnregistrement;

                    //Nom et prénom du bénéficiaire
                    A609 := COPYSTR("Declaration Employeur"."Source Name", 1, 40);

                    //Emploi occupé du bénéficiaire
                    A610 := COPYSTR("Declaration Employeur"."Source Activity", 1, 40);

                    //Dernière adresse du bénéficiaire
                    A611 := COPYSTR("Declaration Employeur"."Source Address", 1, 120);

                    //Montants des ristournes commerciales et non commerciales servies.
                    A612 := FnctG_FormatMontant("Declaration Employeur"."Discounts Amount", 15);
                    DecG_Tot612 += "Declaration Employeur"."Discounts Amount";

                    //Montant des ventes aux P.P soumises au régime forfaitaire
                    A613 := FnctG_FormatMontant("Declaration Employeur"."Amounts Sales PP Reg Flat", 15);
                    DecG_Tot613 += "Declaration Employeur"."Amounts Sales PP Reg Flat";

                    //Montant de l’avance sur les ventes aux P.P soumises à l’impôt sur le revenu selon le régime forfaitaire
                    A614 := FnctG_FormatMontant("Declaration Employeur"."Advances On Sales PP Reg Flat", 15);
                    DecG_Tot614 += "Declaration Employeur"."Amounts Sales PP Reg Flat";

                    // Rk DECEMP V 2016

                    //Montant des revenus au titre des jeux de pari de hasard et de loteri---------------------
                    A615 := FnctG_FormatMontant(0, 16);
                    DecG_Tot615 := 0;
                    //Retenue à la source sur les revenus au titre des jeux de pari de hasard et de loterie.
                    A616 := FnctG_FormatMontant(0, 15);
                    DecG_Tot616 := 0;
                    //Montant des ventes des entreprises industrielles et de commerce au profit des intervenants dans la distribution de biens
                    //et de produits et s ervices qui ne dépassent pas 20.000 DT par an.
                    A617 := FnctG_FormatMontant(0, 15);
                    DecG_Tot617 := 0;
                    //Retenues à la source sur les ventes des entreprises industrielles et de de commerce au profit des intervenants
                    //dans la distribution de biens et de produits et services qui ne dépassent pas 20.000 DT par an.
                    A618 := FnctG_FormatMontant(0, 15);
                    DecG_Tot618 := 0;
                    //Montants perçus en espèces au titre des marchandises vendues et services rendus
                    A619 := FnctG_FormatMontant("Declaration Employeur"."Amount Recovered in Cash", 15);
                    DecG_Tot619 += "Declaration Employeur"."Amount Recovered in Cash";
                    //Zone Réservée 46 espaces
                    A620 := ' ';

                    //RB DECEMP V 2016


                    EVALUATE(A1001, A600);
                    EVALUATE(A1011, A601);
                    EVALUATE(A1021, A602);
                    EVALUATE(A1031, A603);
                    EVALUATE(A1041, A604);
                    EVALUATE(A1051, A605);
                    EVALUATE(A1061, A606);
                    EVALUATE(A1071, A607);
                    EVALUATE(A1081, A608);
                    EVALUATE(A1091, A609);
                    EVALUATE(A1101, A610);
                    EVALUATE(A1111, A611);
                    EVALUATE(A1121, A612);
                    EVALUATE(A1131, A613);
                    EVALUATE(A1141, A614);
                    EVALUATE(A1151, A615);
                    EVALUATE(A1161, A616);
                    EVALUATE(A1171, A617);
                    EVALUATE(A1181, A618);
                    EVALUATE(A1191, A619);
                    EVALUATE(A1201, A620);
                end;

                trigger OnPreXmlItem()
                begin
                    compt1 := 0;
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
                    Width = 16;
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
                    Width = 46;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //-- ligne entete annexe 1 : ANXDEB00 --//


                    //Type enregistrement
                    T600 := 'T6';

                    //Matricule Fiscal
                    T601 := COPYSTR(MatriculeSociete, 1, 7);

                    //Clé du matricule fiscal
                    T602 := COPYSTR(MatriculeSociete, 8, 1);

                    //Catégorie contribuable
                    T603 := COPYSTR(MatriculeSociete, 10, 1);

                    //Numéro de l’établissement secondaire du contribuable
                    T604 := COPYSTR(MatriculeSociete, 11, 3);

                    //Exercice
                    T605 := FORMAT(IntG_Exercice);

                    //Zone réservée: 220 espaces
                    T606 := ' ';

                    //Montants total des ristournes commerciales et non commerciales servies
                    T607 := FnctG_FormatMontant(DecG_Tot612, 15);

                    //Montant total des ventes aux P.P soumises au régime forfaitaire
                    T608 := FnctG_FormatMontant(DecG_Tot613, 15);

                    //Montant total de l’avance sur les ventes aux P.P soumises à l’impôt sur le revenu selon le régime forfaitaire
                    T609 := FnctG_FormatMontant(DecG_Tot614, 15);

                    // RK DECEMP V 2016 --------------------------------

                    //Montant total des revenus au titre des jeux de pari de hasard et de loterie
                    T610 := FnctG_FormatMontant(DecG_Tot615, 16);

                    //Total Retenues à la source sur les revenus au titre des jeux de pari de hasard et de loterie
                    T611 := FnctG_FormatMontant(DecG_Tot616, 15);
                    //Montant Total des ventes des entreprises industrielles et de de commerce au profit des intervenants dans la distribution de biens
                    //et de produits et services qui ne dépassent pas 20.000 DT par an.
                    T612 := FnctG_FormatMontant(DecG_Tot617, 15);
                    //Total des retenues sur les ventes des entreprises industrielles et de de commerce au profit des intervenants
                    //dans la distribution de biens et de produits et services qui ne dépassent pas 20.000 DT par an.
                    T613 := FnctG_FormatMontant(DecG_Tot618, 15);
                    //Montants total perçus en espèces au titre des marchandises vendues et services rendus
                    T614 := FnctG_FormatMontant(DecG_Tot619, 15);
                    //Zone réservée 46 espace
                    T615 := ' ';

                    // RK DECEMP V 2016 --------------------------------



                    EVALUATE(T1001, T600);
                    EVALUATE(T1011, T601);
                    EVALUATE(T1021, T602);
                    EVALUATE(T1031, T603);
                    EVALUATE(T1041, T604);
                    EVALUATE(T1051, T605);
                    EVALUATE(T1061, T606);
                    EVALUATE(T1071, T607);
                    EVALUATE(T1081, T608);
                    EVALUATE(T1091, T609);
                    EVALUATE(T1101, T610);
                    EVALUATE(T1111, T611);
                    EVALUATE(T1121, T612);
                    EVALUATE(T1131, T613);
                    EVALUATE(T1141, T614);
                    EVALUATE(T1151, T615);
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


        //inits
        CLEAR(IntG_LineNo);
        CLEAR(DecG_Tot612);
        CLEAR(DecG_Tot613);
        CLEAR(DecG_Tot614);
        CLEAR(DecG_Tot615);
        CLEAR(DecG_Tot616);
        CLEAR(DecG_Tot617);
        CLEAR(DecG_Tot618);
        CLEAR(DecG_Tot619);
    end;

    trigger OnPreXmlPort()
    begin

        currXMLport.FILENAME := STRSUBSTNO('C:\Declaration\ANXEMP_%1_%2_%3.txt', 6, COPYSTR(FORMAT(IntG_Exercice), 3, 2), 1);
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
        A600: Code[2];
        A601: Code[7];
        A602: Code[1];
        A603: Code[1];
        A604: Code[3];
        A605: Code[4];
        A606: Code[6];
        A607: Code[1];
        A608: Code[13];
        A609: Code[40];
        A610: Code[40];
        A611: Code[120];
        A612: Code[15];
        A613: Code[15];
        A614: Code[15];
        A615: Code[16];
        A616: Code[15];
        A617: Code[15];
        A618: Code[15];
        A619: Code[15];
        A620: Code[46];
        compt1: Integer;
        "compagny information": Integer;
        T600: Code[2];
        T601: Code[7];
        T602: Code[1];
        T603: Code[1];
        T604: Code[3];
        T605: Code[4];
        T606: Code[220];
        T607: Code[15];
        T608: Code[15];
        T609: Code[15];
        T610: Code[16];
        T611: Code[15];
        T612: Code[15];
        T613: Code[15];
        T614: Code[15];
        T615: Code[46];
        totAv: Decimal;
        totbrimp: Decimal;
        totimp: Decimal;
        L: Integer;
        mm: Text[30];
        Mnt: Text[30];
        //"rec. salary line": Record "52048946";
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
        DecG_Tot612: Decimal;
        DecG_Tot615: Decimal;
        DecG_Tot613: Decimal;
        DecG_Tot614: Decimal;
        DecG_Tot616: Decimal;
        DecG_Tot617: Decimal;
        DecG_Tot618: Decimal;
        DecG_Tot619: Decimal;
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

