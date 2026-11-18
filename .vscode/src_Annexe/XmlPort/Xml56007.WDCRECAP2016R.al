xmlport 56007 "WDC RECAP-2016R"
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
                XmlName = 'Decemp00';
                SourceTableView = SORTING("Primary Key");
                textelement(ee0001)
                {
                    XmlName = 'EE0001';
                    Width = 3;
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
                    Width = 1;
                }
                textelement(ee0071)
                {
                    XmlName = 'EE0071';
                    Width = 1;
                }
                textelement(ee0081)
                {
                    XmlName = 'EE0081';
                    Width = 1;
                }
                textelement(ee0091)
                {
                    XmlName = 'EE0091';
                    Width = 1;
                }
                textelement(ee00101)
                {
                    XmlName = 'EE00101';
                    Width = 1;
                }
                textelement(ee00111)
                {
                    XmlName = 'EE00111';
                    Width = 1;
                }
                textelement(ee00121)
                {
                    XmlName = 'EE00121';
                    Width = 1;
                }
                textelement(ee00131)
                {
                    XmlName = 'EE00131';
                    Width = 12;
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


                    //-- ligne entete Recap : DECEMP00 --//

                    //Type enregistrement
                    "00D000" := '000';

                    // BEGIN ADD TAK
                    MatriculeSociete := DELCHR("Company Information"."VAT Registration No.", '=', '/');
                    // END ADD TAK
                    //Matricule Fiscal
                    "00D001" := COPYSTR(MatriculeSociete, 1, 7);

                    //Clé du matricule fiscal
                    "00D002" := COPYSTR(MatriculeSociete, 8, 1);

                    //Catégorie contribuable
                    "00D003" := COPYSTR(MatriculeSociete, 10, 1);

                    //Numéro de l’établissement secondaire du contribuable
                    "00D004" := COPYSTR(MatriculeSociete, 11, 3);
                    //Exercice
                    "00D005" := FORMAT(IntG_Exercice);

                    //présance des annexes (jles ai laissé figés pr le moment)
                    //présance des annexes (jles ai laissé figés pr le moment)
                    IF boolg_anx1 THEN "00D006" := '0';
                    IF boolg_anx2 THEN "00D007" := '0';
                    IF boolg_anx3 THEN "00D008" := '0';
                    IF boolg_anx4 THEN "00D009" := '0';
                    IF boolg_anx5 THEN "00D010" := '0';
                    IF boolg_anx6 THEN "00D011" := '0';
                    IF boolg_anx7 THEN "00D012" := '0';

                    //Zone réservée (12 espaces)
                    "00D013" := ' ';

                    //parcourir la tb "Param & valeurs Recap" et remplir ligne par lignes les champs du fichier Recap
                    RecG_DeclarationEmployeur.RESET;



                    EVALUATE(EE0001, "00D000");
                    EVALUATE(EE0011, "00D001");
                    EVALUATE(EE0021, "00D002");
                    EVALUATE(EE0031, "00D003");
                    EVALUATE(EE0041, "00D004");
                    EVALUATE(EE0051, "00D005");
                    EVALUATE(EE0061, "00D006");
                    EVALUATE(EE0071, "00D007");
                    EVALUATE(EE0081, "00D008");
                    EVALUATE(EE0091, "00D009");
                    EVALUATE(EE00101, "00D010");
                    EVALUATE(EE00111, "00D011");
                    EVALUATE(EE00121, "00D012");
                    EVALUATE(EE00131, "00D013");
                end;
            }
            tableelement("<integer1>"; Integer)
            {
                XmlName = 'Decemp01';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(t1001)
                {
                    XmlName = 'T1001';
                    Width = 3;
                }
                textelement(t1011)
                {
                    XmlName = 'T1011';
                    Width = 15;
                }
                textelement(t1021)
                {
                    XmlName = 'T1021';
                    Width = 5;
                }
                textelement(t1031)
                {
                    XmlName = 'T1031';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP01
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP01');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("With. Amount Common Regime", "Taxable Income");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."With. Amount Common Regime";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 010
                    "01D010" := '010';

                    //Total assiette des traitements, salaires, pensions et rentes viagères portant une retenue à la source selon le régime commun.
                    "01D011" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Taxable Income", 15);

                    //Zone réservée
                    "01D012" := '00000';

                    //Total retenues opérées au titre des traitements, salaires, pensions et rentes viagères selon le régime commun.
                    "01D013" := FnctG_FormatMontant(RecG_DeclarationEmployeur."With. Amount Common Regime", 15);



                    EVALUATE(T1001, "01D010");
                    EVALUATE(T1011, "01D011");
                    EVALUATE(T1021, "01D012");
                    EVALUATE(T1031, "01D013");
                end;
            }
            tableelement(integer; integer)
            {
                XmlName = 'Decemp02';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(a1)
                {
                    XmlName = 'A1';
                    Width = 3;
                }
                textelement(a2)
                {
                    XmlName = 'A2';
                    Width = 15;
                }
                textelement(a3)
                {
                    XmlName = 'A3';
                    Width = 5;
                }
                textelement(a4)
                {
                    XmlName = 'A4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP02
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP02');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");


                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 170
                    "02D020" := '170';

                    //Total assiette des traitements et salaires ayant subi une retenue à la source de 20%
                    "02D021" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    //Zone réservée
                    "02D022" := '00000';

                    //Total retenues opérées au titre des traitements et salaires ayant subi une retenue à la source de 20%.
                    "02D023" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);


                    EVALUATE(A1, "02D020");
                    EVALUATE(A2, "02D021");
                    EVALUATE(A3, "02D022");
                    EVALUATE(A4, "02D023");
                end;
            }
            tableelement("<integer2>"; Integer)
            {
                XmlName = 'Decemp03';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(b1)
                {
                    XmlName = 'B1';
                    Width = 3;
                }
                textelement(b2)
                {
                    XmlName = 'B2';
                    Width = 20;
                }
                textelement(b3)
                {
                    XmlName = 'B3';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP03
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP03');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    //RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount","Amount CSS");
                    RecG_DeclarationEmployeur.CALCSUMS("Amount CSS");
                    //cumuml total retenu
                    //TotalRetenu+=RecG_DeclarationEmployeur."Withholding Amount";
                    TotalRetenu += RecG_DeclarationEmployeur."Amount CSS";
                    //MESSAGE (FORMAT(TotalRetenu));
                    //Type enregistrement : Zone obligatoire, elle prend la valeur 300
                    //"03D030":='021';
                    "03D030" := '300';

                    //Total assiette honoraires, commissions, courtages, loyers et rémunérations au titre des activités non commerciales servis aux
                    //personnes établies et résidentes
                    // "03D031":= FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);
                    "03D031" := ' ';
                    //Taux de la retenue opérée
                    //"03D032":= FnctG_FormatMontant(RecG_DeclarationEmployeur."Amount CSS", 15);
                    //MESSAGE  (FORMAT(RecG_DeclarationEmployeur."Amount CSS"));

                    "03D032" := '000000002837045';

                    //Total retenues opérées au titre des honoraires, commissions, courtages, loyers et rémunérations au titre des activités non
                    //commerciales servis aux personnes établies et résidentes
                    //"03D033" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);



                    EVALUATE(B1, "03D030");
                    EVALUATE(B2, "03D031");
                    EVALUATE(B3, "03D032");
                    //EVALUATE(B4,"03D033");
                end;
            }
            tableelement("<integer3>"; Integer)
            {
                XmlName = 'Decemp04';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(c1)
                {
                    XmlName = 'C1';
                    Width = 3;
                }
                textelement(c2)
                {
                    XmlName = 'C2';
                    Width = 15;
                }
                textelement(c3)
                {
                    XmlName = 'C3';
                    Width = 5;
                }
                textelement(c4)
                {
                    XmlName = 'C4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP04
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP04');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");


                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 023
                    "04D040" := '021';

                    //Total assiette honoraires, commissions, courtages et rémunérations au titre des activités non commerciales, servis aux personnes
                    // non établies et non domiciliées.


                    "04D041" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée   (taux prise en charge)
                    "04D042" := '01500';

                    //Total retenues opérées au titre des Total assiette honoraires, commissions, courtages, loyers et rémunérations au titre des
                    //activités non commerciales servis aux personnes non résidents et non établies
                    "04D043" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);

                    EVALUATE(C1, "04D040");
                    EVALUATE(C2, "04D041");
                    EVALUATE(C3, "04D042");
                    EVALUATE(C4, "04D043");
                end;
            }
            tableelement("<integer4>"; Integer)
            {
                XmlName = 'Decemp05';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(d1)
                {
                    XmlName = 'D1';
                    Width = 3;
                }
                textelement(d2)
                {
                    XmlName = 'D2';
                    Width = 15;
                }
                textelement(d3)
                {
                    XmlName = 'D3';
                    Width = 5;
                }
                textelement(d4)
                {
                    XmlName = 'D4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP05
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP05');  //DECEMP05
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 025
                    "05D050" := '023';

                    // V 2015 Total assiette honoraires, commissions, courtages et rémunérations au titre des activités
                    //non commerciales servis aux personnes physiques provenant des opérations d’exportation.

                    "05D051" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "05D052" := '01500';

                    //Total retenues opérées au titre des honoraires, commissions, courtages et rémunérations au titre des activités
                    //non commerciales servis aux personnes physiques provenant des opérations d’exportation.

                    "05D053" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);


                    EVALUATE(D1, "05D050");
                    EVALUATE(D2, "05D051");
                    EVALUATE(D3, "05D052");
                    EVALUATE(D4, "05D053");
                end;
            }
            tableelement("<integer5>"; Integer)
            {
                XmlName = 'Decemp06';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(e1)
                {
                    XmlName = 'E1';
                    Width = 3;
                }
                textelement(e2)
                {
                    XmlName = 'E2';
                    Width = 15;
                }
                textelement(e3)
                {
                    XmlName = 'E3';
                    Width = 5;
                }
                textelement(e4)
                {
                    XmlName = 'E4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP06
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP06');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 030
                    "06D060" := '025';

                    //Total assiette Honoraires servis aux personnes morales et aux personnes physiques soumises au régime réel,
                    //et rémunérations servies aux artistes et créateurs
                    "06D061" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "06D062" := '00250';

                    //Total retenues opérées au titre des Honoraires servis aux personnes morales et aux personnes physiques soumises au régime réel,
                    //et rémunérations servies aux artistes et créateurs
                    "06D063" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);

                    EVALUATE(E1, "06D060");
                    EVALUATE(E2, "06D061");
                    EVALUATE(E3, "06D062");
                    EVALUATE(E4, "06D063");
                end;
            }
            tableelement("<integer6>"; Integer)
            {
                XmlName = 'Decemp07';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(f1)
                {
                    XmlName = 'F1';
                    Width = 3;
                }
                textelement(f2)
                {
                    XmlName = 'F2';
                    Width = 15;
                }
                textelement(f3)
                {
                    XmlName = 'F3';
                    Width = 5;
                }
                textelement(f4)
                {
                    XmlName = 'F4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP07
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP07');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");


                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 180
                    "07D070" := '030';

                    //Total assiette honoraires servis aux bureaux d’études exportateurs
                    "07D071" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "07D072" := '00500';

                    //Total retenues au titre des honoraires servis aux bureaux d’études exportateurs
                    "07D073" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);
                    EVALUATE(F1, "07D070");
                    EVALUATE(F2, "07D071");
                    EVALUATE(F3, "07D072");
                    EVALUATE(F4, "07D073");
                end;
            }
            tableelement("<integer7>"; Integer)
            {
                XmlName = 'Decemp08';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(g1)
                {
                    XmlName = 'G1';
                    Width = 3;
                }
                textelement(g2)
                {
                    XmlName = 'G2';
                    Width = 15;
                }
                textelement(g3)
                {
                    XmlName = 'G3';
                    Width = 5;
                }
                textelement(g4)
                {
                    XmlName = 'G4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP08
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP08');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 040
                    "08D080" := '180';

                    //Total assiette loyers des hôtels
                    "08D081" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "08D082" := '00250';

                    //Total retenues opérées au titre des loyers des hôtels
                    "08D083" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);

                    EVALUATE(G1, "08D080");
                    EVALUATE(G2, "08D081");
                    EVALUATE(G3, "08D082");
                    EVALUATE(G4, "08D083");
                end;
            }
            tableelement("<integer8>"; Integer)
            {
                XmlName = 'Decemp09';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(h1)
                {
                    XmlName = 'H1';
                    Width = 3;
                }
                textelement(h2)
                {
                    XmlName = 'H2';
                    Width = 15;
                }
                textelement(h3)
                {
                    XmlName = 'H3';
                    Width = 5;
                }
                textelement(h4)
                {
                    XmlName = 'H4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP09
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP09');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //UPDATE RIADH 10-03-17

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 060
                    "09D090" := '040';

                    //Total assiette Rémunérations payées en contrepartie de la performance dans la prestation de services pour le compte d’autrui
                    "09D091" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "09D092" := '00500';
                    //Total retenues opérées au titre des Rémunérations payées en contrepartie
                    //de la performance dans la prestation de services pour le compte d’autrui..
                    "09D093" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);

                    //UPDATE RIADH 10-03-17

                    EVALUATE(H1, "09D090");
                    EVALUATE(H2, "09D091");
                    EVALUATE(H3, "09D092");
                    EVALUATE(H4, "09D093");
                end;
            }
            tableelement("<integer9>"; integer)
            {
                XmlName = 'Decemp10';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(i1)
                {
                    XmlName = 'I1';
                    Width = 3;
                }
                textelement(i2)
                {
                    XmlName = 'I2';
                    Width = 15;
                }
                textelement(i3)
                {
                    XmlName = 'I3';
                    Width = 5;
                }
                textelement(i4)
                {
                    XmlName = 'I4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP10
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP10');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 060
                    "10D100" := '260';
                    //Total assiette intérêts des comptes spéciaux d’épargne ouverts auprès des banques et de la CENT.
                    "10D101" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée   (taux de prise de charge)
                    "10D102" := '01500';

                    //Total retenues opérées au titre des intérêts des comptes spéciaux d’épargne ouverts auprès des banques et de la CENT.
                    "10D103" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);


                    EVALUATE(I1, "10D100");
                    EVALUATE(I2, "10D101");
                    EVALUATE(I3, "10D102");
                    EVALUATE(I4, "10D103");
                end;
            }
            tableelement("<integer10>"; Integer)
            {
                XmlName = 'Decemp11';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(j1)
                {
                    XmlName = 'J1';
                    Width = 3;
                }
                textelement(j2)
                {
                    XmlName = 'J2';
                    Width = 15;
                }
                textelement(j3)
                {
                    XmlName = 'J3';
                    Width = 5;
                }
                textelement(j4)
                {
                    XmlName = 'J4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP11
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP11');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");


                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 073
                    "11D110" := '060';

                    //Total assiette revenus des autres capitaux mobiliers servis aux non résidents
                    "11D111" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "11D112" := '02000';

                    //Total retenues opérées au titre des Total assiette revenus des autres capitaux mobiliers servis aux
                    //non résidents
                    "11D113" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);


                    EVALUATE(J1, "11D110");
                    EVALUATE(J2, "11D111");
                    EVALUATE(J3, "11D112");
                    EVALUATE(J4, "11D113");
                end;
            }
            tableelement("<integer11>"; Integer)
            {
                XmlName = 'Decemp12';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(k1)
                {
                    XmlName = 'K1';
                    Width = 3;
                }
                textelement(k2)
                {
                    XmlName = 'K2';
                    Width = 15;
                }
                textelement(k3)
                {
                    XmlName = 'K3';
                    Width = 5;
                }
                textelement(k4)
                {
                    XmlName = 'K4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP12
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP12');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");


                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 080
                    "12D120" := '071';

                    //Total assiette valeurs mobilières servis aux non résidents et non établis
                    "12D121" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée  (taux de prise en charge)
                    "12D122" := '02000';

                    //Total retenues opérées au titre des valeurs mobilières servis aux non résidents et non établis
                    "12D123" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);

                    EVALUATE(K1, "12D120");
                    EVALUATE(K2, "12D121");
                    EVALUATE(K3, "12D122");
                    EVALUATE(K4, "12D123");
                end;
            }
            tableelement("<integer12>"; integer)
            {
                XmlName = 'Decemp13';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(l1)
                {
                    XmlName = 'L1';
                    Width = 3;
                }
                textelement(l2)
                {
                    XmlName = 'L2';
                    Width = 15;
                }
                textelement(l3)
                {
                    XmlName = 'L3';
                    Width = 5;
                }
                textelement(l4)
                {
                    XmlName = 'L4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP13
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP13');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");


                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 241
                    "13D130" := '073';

                    //Total assiette des actions et des parts sociales servies à des personnes physiques résidentes
                    "13D131" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "13D132" := '02000';

                    //Total retenues opérées au titre des actions et des parts sociales servies à des personnes physiques résidentes
                    "13D133" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);

                    EVALUATE(L1, "13D130");
                    EVALUATE(L2, "13D131");
                    EVALUATE(L3, "13D132");
                    EVALUATE(L4, "13D133");
                end;
            }
            tableelement("<integer13>"; Integer)
            {
                XmlName = 'Decemp14';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(m1)
                {
                    XmlName = 'M1';
                    Width = 3;
                }
                textelement(m2)
                {
                    XmlName = 'M2';
                    Width = 15;
                }
                textelement(m3)
                {
                    XmlName = 'M3';
                    Width = 5;
                }
                textelement(m4)
                {
                    XmlName = 'M4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP14
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP14');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 242
                    "14D140" := '080';

                    //Total assiette des actions et parts sociales servis à des personnes physiques et à des personnes morales non résidentes
                    "14D141" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée (taux de prise en charge)
                    "14D142" := '01500';

                    //Total retenues opérées au titre des parts sociales servis à des personnes physiques et à des personnes morales non résidentes
                    "14D143" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);


                    EVALUATE(M1, "14D140");
                    EVALUATE(M2, "14D141");
                    EVALUATE(M3, "14D142");
                    EVALUATE(M4, "14D143");
                end;
            }
            tableelement("<integer14>"; Integer)
            {
                XmlName = 'Decemp15';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(n1)
                {
                    XmlName = 'N1';
                    Width = 3;
                }
                textelement(n2)
                {
                    XmlName = 'N2';
                    Width = 15;
                }
                textelement(n3)
                {
                    XmlName = 'N3';
                    Width = 5;
                }
                textelement(n4)
                {
                    XmlName = 'N4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP15
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP15');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");


                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 091
                    "15D150" := '241';

                    //Total assiette jetons de présence servis à des résidents
                    "15D151" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "15D152" := '01000';

                    //Total retenue opérées au titre des jetons de présence servis à des résidente
                    "15D153" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);


                    EVALUATE(N1, "15D150");
                    EVALUATE(N2, "15D151");
                    EVALUATE(N3, "15D152");
                    EVALUATE(N4, "15D153");
                end;
            }
            tableelement("<integer15>"; integer)
            {
                XmlName = 'Decemp16';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(o1)
                {
                    XmlName = 'O1';
                    Width = 3;
                }
                textelement(o2)
                {
                    XmlName = 'O2';
                    Width = 15;
                }
                textelement(o3)
                {
                    XmlName = 'O3';
                    Width = 5;
                }
                textelement(o4)
                {
                    XmlName = 'O4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP16
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP16');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");


                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 093
                    "16D160" := '242';

                    //Total assiette jetons de présence servis à des non résidentes
                    "16D161" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "16D162" := '01000';

                    //Total retenues opérées au titre des jetons de présence servis à des non résidentes
                    "16D163" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);


                    EVALUATE(O1, "16D160");
                    EVALUATE(O2, "16D161");
                    EVALUATE(O3, "16D162");
                    EVALUATE(O4, "16D163");
                end;
            }
            tableelement("<integer16>"; Integer)
            {
                XmlName = 'Decemp17';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(p1)
                {
                    XmlName = 'P1';
                    Width = 3;
                }
                textelement(p2)
                {
                    XmlName = 'P2';
                    Width = 15;
                }
                textelement(p3)
                {
                    XmlName = 'P3';
                    Width = 5;
                }
                textelement(p4)
                {
                    XmlName = 'P4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP17
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP17');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 100
                    "17D170" := '091';

                    //Total assiette des rémunérations servies aux salariés et aux non salariés en contrepartie d'un travail
                    //occasionnel ou accidentel en dehors de leur activité principale

                    "17D171" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "17D172" := '02000';

                    //Total retenues opérées au titre des  des rémunérations servies aux salariés et aux non salariés en contrepartie d'un travail
                    //occasionnel ou accidentel en dehors de leur activité principale
                    "17D173" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);

                    EVALUATE(P1, "17D170");
                    EVALUATE(P2, "17D171");
                    EVALUATE(P3, "17D172");
                    EVALUATE(P4, "17D173");
                end;
            }
            tableelement("<integer17>"; Integer)
            {
                XmlName = 'Decemp18';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(q1)
                {
                    XmlName = 'Q1';
                    Width = 3;
                }
                textelement(q2)
                {
                    XmlName = 'Q2';
                    Width = 15;
                }
                textelement(q3)
                {
                    XmlName = 'Q3';
                    Width = 5;
                }
                textelement(q4)
                {
                    XmlName = 'Q4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP18
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP18');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 110
                    "18D180" := '093';

                    //Total assiette intérêts des prêts payés aux établissements bancaires non établis en Tunisie
                    "18D181" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "18D182" := '02000';

                    //Total retenues opérées au titre des Total assiette intérêts des prêts payés aux établissements bancaires non établis en Tunisie
                    "18D183" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);


                    EVALUATE(Q1, "18D180");
                    EVALUATE(Q2, "18D181");
                    EVALUATE(Q3, "18D182");
                    EVALUATE(Q4, "18D183");
                end;
            }
            tableelement("<integer18>"; Integer)
            {
                XmlName = 'Decemp19';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(r1)
                {
                    XmlName = 'R1';
                    Width = 3;
                }
                textelement(r2)
                {
                    XmlName = 'R2';
                    Width = 15;
                }
                textelement(r3)
                {
                    XmlName = 'R3';
                    Width = 5;
                }
                textelement(r4)
                {
                    XmlName = 'R4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP19
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP19');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 121
                    "19D190" := '100';

                    //Total assiette prix de cession déclaré dans l’acte  pour les résidents
                    "19D191" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "19D192" := '01500';

                    //Total retenues opérées sur le prix de cession déclaré dans l’acte pour
                    //les résidents
                    "19D193" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);
                    EVALUATE(R1, "19D190");
                    EVALUATE(R2, "19D191");
                    EVALUATE(R3, "19D192");
                    EVALUATE(R4, "19D193");
                end;
            }
            tableelement("<integer19>"; Integer)
            {
                XmlName = 'Decemp20';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(s1)
                {
                    XmlName = 'S1';
                    Width = 3;
                }
                textelement(s2)
                {
                    XmlName = 'S2';
                    Width = 15;
                }
                textelement(s3)
                {
                    XmlName = 'S3';
                    Width = 5;
                }
                textelement(s4)
                {
                    XmlName = 'S4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP20
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP20');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 122
                    "20D200" := '110';

                    //Total assiette prix de cession déclaré dans l’acte  pour les Personnes Physiques et morales non résidentes
                    "20D201" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée  (taux de prise en charge)
                    "20D202" := '01000';

                    //Total retenues opérées au titre des Total assiette prix de cession déclaré dans l’acte  pour les
                    //Personnes Physiques et morales non résidentes
                    "20D203" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);

                    EVALUATE(S1, "20D200");
                    EVALUATE(S2, "20D201");
                    EVALUATE(S3, "20D202");
                    EVALUATE(S4, "20D203");
                end;
            }
            tableelement("<integer20>"; Integer)
            {
                XmlName = 'Decemp21';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(t1)
                {
                    XmlName = 'T1';
                    Width = 3;
                }
                textelement(t2)
                {
                    XmlName = 'T2';
                    Width = 15;
                }
                textelement(t3)
                {
                    XmlName = 'T3';
                    Width = 5;
                }
                textelement(t40)
                {
                    XmlName = 'T40';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP21
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP21');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 123
                    "21D210" := '121';

                    //Total assiette Prix de cession déclaré dans l’acte pour les Personnes Morales non établies, et ce au titre des biens
                    //fonciers uniquement
                    "21D211" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "21D212" := '00250';

                    //Total retenues sur le prix de cession déclaré dans l'acte pour les personnes Morales ,
                    //non établies et ce au titre des biens fonciers uniquement

                    "21D213" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);


                    EVALUATE(T1, "21D210");
                    EVALUATE(T2, "21D211");
                    EVALUATE(T3, "21D212");
                    EVALUATE(T40, "21D213");
                end;
            }
            tableelement("<integer21>"; Integer)
            {
                XmlName = 'Decemp22';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(u1)
                {
                    XmlName = 'U1';
                    Width = 3;
                }
                textelement(u2)
                {
                    XmlName = 'U2';
                    Width = 15;
                }
                textelement(u3)
                {
                    XmlName = 'U3';
                    Width = 5;
                }
                textelement(u4)
                {
                    XmlName = 'U4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP22
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP22');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 131
                    "22D220" := '122';

                    //Total assiette des montants supérieurs ou égaux à 1000 dinars y compris la TVA provenant des opérations d'export
                    //et des opérations de ventes des personnes morales soumises à L'IS au taux de 10%
                    "22D221" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "22D222" := '00250';

                    //Total retenues opérées au titre des montants supérieurs ou égaux à 1000 dinars y compris la TVA
                    //provenant des opérations d'export et des opérations de ventes des personnes morales soumises à L'IS au taux de 10%
                    "22D223" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);

                    EVALUATE(U1, "22D220");
                    EVALUATE(U2, "22D221");
                    EVALUATE(U3, "22D222");
                    EVALUATE(U4, "22D223");
                end;
            }
            tableelement("<integer22>"; Integer)
            {
                XmlName = 'Decemp23';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(v1)
                {
                    XmlName = 'V1';
                    Width = 3;
                }
                textelement(v2)
                {
                    XmlName = 'V2';
                    Width = 15;
                }
                textelement(v3)
                {
                    XmlName = 'V3';
                    Width = 5;
                }
                textelement(v4)
                {
                    XmlName = 'V4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP23
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP23');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 132
                    "23D230" := '123';

                    //Total assiette des montants supérieurs ou égaux à 1000 dinars et y compris la TVA au titre des autres opérations
                    "23D231" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "23D232" := '01500';

                    //Total retenues opérées au titre des montants égaux ou supérieurs à 1000 dinars y compris la TVA au titre des autres opérations
                    "23D233" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);


                    EVALUATE(V1, "23D230");
                    EVALUATE(V2, "23D231");
                    EVALUATE(V3, "23D232");
                    EVALUATE(V4, "23D233");
                end;
            }
            tableelement("<integer23>"; Integer)
            {
                XmlName = 'Decemp24';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(w1)
                {
                    XmlName = 'W1';
                    Width = 3;
                }
                textelement(w2)
                {
                    XmlName = 'W2';
                    Width = 15;
                }
                textelement(w3)
                {
                    XmlName = 'W3';
                    Width = 5;
                }
                textelement(w4)
                {
                    XmlName = 'W4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP24
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP24');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 140
                    "24D240" := '131';

                    //Total assiette TVA au titre des montants égaux ou supérieurs à 1000 dinars (TTC) payés par les établissements
                    //et les entreprises publics
                    "24D241" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "24D242" := '00050';

                    //Total assiette TVA au titre des montants égaux ou supérieurs à 1000 dinars (TTC) payés par les établissements
                    //et les entreprises publics
                    "24D243" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);



                    EVALUATE(W1, "24D240");
                    EVALUATE(W2, "24D241");
                    EVALUATE(W3, "24D242");
                    EVALUATE(W4, "24D243");
                end;
            }
            tableelement("<integer24>"; Integer)
            {
                XmlName = 'Decemp25';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(x1)
                {
                    XmlName = 'X1';
                    Width = 3;
                }
                textelement(x2)
                {
                    XmlName = 'X2';
                    Width = 15;
                }
                textelement(x3)
                {
                    XmlName = 'X3';
                    Width = 5;
                }
                textelement(x4)
                {
                    XmlName = 'X4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP25
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP25');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 150
                    "25D250" := '132';

                    //Total assiette TVA au titre des opérations réalisées avec des personnes n’ayant pas d’établissement en Tunisie
                    "25D251" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "25D252" := '00150';

                    //Total retenues sur la TVA au titre des opérations réalisées avec des personnes n’ayant pas d’établissement en Tunisie
                    "25D253" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);

                    EVALUATE(X1, "25D250");
                    EVALUATE(X2, "25D251");
                    EVALUATE(X3, "25D252");
                    EVALUATE(X4, "25D253");
                end;
            }
            tableelement("<integer25>"; Integer)
            {
                XmlName = 'Decemp26';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(y1)
                {
                    XmlName = 'Y1';
                    Width = 3;
                }
                textelement(y2)
                {
                    XmlName = 'Y2';
                    Width = 15;
                }
                textelement(y3)
                {
                    XmlName = 'Y3';
                    Width = 5;
                }
                textelement(y4)
                {
                    XmlName = 'Y4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP26
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP26');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 160
                    "26D260" := '140';

                    //Total assiette des honoraires servis aux personnes non résidentes qui réalisent des travaux de construction ou des opérations
                    //de montage ou des services de contrôles connexes ou d’autres services pour une période ne dépassant pas 6 mois
                    "26D261" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "26D262" := '02500';               //montant

                    //Total retenues opérées au titre des honoraires servis aux personnes non résidentes qui réalisent des travaux de construction
                    //ou des opérations de montage ou des services de contrôles connexes ou d’autres services pour
                    //une période ne dépassant pas 6 mois
                    "26D263" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);


                    EVALUATE(Y1, "26D260");
                    EVALUATE(Y2, "26D261");
                    EVALUATE(Y3, "26D262");
                    EVALUATE(Y4, "26D263");
                end;
            }
            tableelement("<integer26>"; Integer)
            {
                XmlName = 'Decemp27';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(z1)
                {
                    XmlName = 'Z1';
                    Width = 3;
                }
                textelement(z2)
                {
                    XmlName = 'Z2';
                    Width = 15;
                }
                textelement(z3)
                {
                    XmlName = 'Z3';
                    Width = 5;
                }
                textelement(z4)
                {
                    XmlName = 'Z4';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP27
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP27');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 200
                    "27D270" := '150';

                    //Total assiette des avances dues sur les ventes des entreprises de commerce en gros aux P.P soumises à l'impot sur le revenu
                    //selon le régime forfaitaire dans la catégorie des bénéfices industriels et commerciaux ou sur la base d'une assiette
                    //forfaitaire de la catégorie des bénéfices des professions non commerciales
                    "27D271" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée  au titre des avances dues sur les ventes des entreprises de commerce en gros aux P.P
                    //soumises à l'impot sur le revenu selon  le régime forfaitaire dans la catégorie des bénéfices industriels et commerciaux
                    // ou sur la base d'une assiette forfaitaire de la catégorie des bénéfices des professions non commerciales
                    "27D272" := '10000';

                    //Total retenues opérées au titre des
                    "27D273" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);


                    EVALUATE(Z1, "27D270");
                    EVALUATE(Z2, "27D271");
                    EVALUATE(Z3, "27D272");
                    EVALUATE(Z4, "27D273");
                end;
            }
            tableelement("<integer27>"; Integer)
            {
                XmlName = 'Decemp28';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(a11)
                {
                    XmlName = 'A11';
                    Width = 3;
                }
                textelement(a22)
                {
                    XmlName = 'A22';
                    Width = 15;
                }
                textelement(a33)
                {
                    XmlName = 'A33';
                    Width = 5;
                }
                textelement(a44)
                {
                    XmlName = 'A44';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP28
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP28');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 191
                    "28D280" := '160';

                    //Total assiette plus values de cession des actions, des parts sociales ou des parts de fonds prévues par la législation en vigueur
                    //effectuées par les personnes physiques non établies et non résidentes
                    "28D281" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée    (taux de prise en charge)
                    "28D282" := '00000';

                    //Total retenues opérées au titre des Total assiette plus values de cession des actions, des parts sociales ou des parts de fonds
                    //prévues par la législation effectuées par les personnes physiques non établies et non résidentes
                    "28D283" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);

                    EVALUATE(A11, "28D280");
                    EVALUATE(A22, "28D281");
                    EVALUATE(A33, "28D282");
                    EVALUATE(A44, "28D283");
                end;
            }
            tableelement("<integer28>"; Integer)
            {
                XmlName = 'Decemp29';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(a55)
                {
                    XmlName = 'A55';
                    Width = 3;
                }
                textelement(a66)
                {
                    XmlName = 'A66';
                    Width = 15;
                }
                textelement(a77)
                {
                    XmlName = 'A77';
                    Width = 5;
                }
                textelement(a88)
                {
                    XmlName = 'A88';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP29
                    /*
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Advances On Sales PP Reg Flat", Year);
                    RecG_DeclarationEmployeur.SETFILTER("Advances On Sales PP Reg Flat", '>0');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Amounts Sales PP Reg Flat","Advances On Sales PP Reg Flat");
                    
                    //cumuml total retenu
                    TotalRetenu+=RecG_DeclarationEmployeur."Advances On Sales PP Reg Flat";
                    */
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP29');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 192
                    "29D290" := '270';

                    //Total assiette plus values de cession des actions, des parts sociales ou des parts de fonds prévues par la législation en vigueur
                    //effectuées par les personnes morales non établies et non domciliées
                    "29D291" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Amounts Sales PP Reg Flat", 15);

                    // Taux de la retenue opérée  (taux de prise en charge)
                    "29D292" := '01500';

                    //Total retenues opérées au titre des Total assiette plus values de cession des actions, des parts sociales ou des parts de fonds
                    //prévues par la législation effectuées par les personnes morales non établies et non domciliées
                    "29D293" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Advances On Sales PP Reg Flat", 15);


                    EVALUATE(A55, "29D290");
                    EVALUATE(A66, "29D291");
                    EVALUATE(A77, "29D292");
                    EVALUATE(A88, "29D293");

                end;
            }
            tableelement("<integer29>"; Integer)
            {
                XmlName = 'Decemp30';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(a99)
                {
                    XmlName = 'A99';
                    Width = 3;
                }
                textelement(a100)
                {
                    XmlName = 'A100';
                    Width = 15;
                }
                textelement(a101)
                {
                    XmlName = 'A101';
                    Width = 5;
                }
                textelement(a102)
                {
                    XmlName = 'A102';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP30

                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP30');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    /*RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Advances On Sales PP Reg Flat", Year);
                    RecG_DeclarationEmployeur.SETFILTER("Advances On Sales PP Reg Flat", '>0');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Amounts Sales PP Reg Flat","Advances On Sales PP Reg Flat");*/

                    //cumuml total retenu
                    //TotalRetenu+=RecG_DeclarationEmployeur."Advances On Sales PP Reg Flat";

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 051
                    "30D300" := '200';

                    //Total assiette autres revenus servis à des personnes non établies et non domiciliées
                    "30D301" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "30D302" := '00100';

                    //Total retenues opérées au titre des autres revenus servis à des personnes non établies et non domiciliées
                    "30D303" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);



                    EVALUATE(A99, "30D300");
                    EVALUATE(A100, "30D301");
                    EVALUATE(A101, "30D302");
                    EVALUATE(A102, "30D303");

                end;
            }
            tableelement("<integer30>"; Integer)
            {
                XmlName = 'Decemp31';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(a103)
                {
                    XmlName = 'A103';
                    Width = 3;
                }
                textelement(a104)
                {
                    XmlName = 'A104';
                    Width = 15;
                }
                textelement(a105)
                {
                    XmlName = 'A105';
                    Width = 5;
                }
                textelement(a106)
                {
                    XmlName = 'A106';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP31
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP31');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 210
                    "31D310" := '191';

                    //Total assiette Redevance au profit de la caisse générale de compensation
                    "31D311" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "31D312" := '01000';

                    //Total assiette Redevance au profit de la caisse générale de compensation
                    "31D313" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);




                    EVALUATE(A103, "31D310");
                    EVALUATE(A104, "31D311");
                    EVALUATE(A105, "31D312");
                    EVALUATE(A106, "31D313");
                end;
            }
            tableelement("<integer31>"; Integer)
            {
                XmlName = 'Decemp32';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(a107)
                {
                    XmlName = 'A107';
                    Width = 3;
                }
                textelement(a108)
                {
                    XmlName = 'A108';
                    Width = 15;
                }
                textelement(a109)
                {
                    XmlName = 'A109';
                    Width = 5;
                }
                textelement(a110)
                {
                    XmlName = 'A110';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP32
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP32'); //DECEMP32
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");

                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 220
                    "32D320" := '192';

                    // V 2015 Total assiette des rémunérations ou revenus servis à des personnes résidentes ou établies dans des paradis fiscaux.
                    "32D321" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "32D322" := '02500';

                    // V 2015 Total retenues opérées au titre des rémunérations ou revenus servis
                    // V 2015 à des personnes résidentes ou établies dans des paradis fiscaux.
                    "32D323" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);





                    EVALUATE(A107, "32D320");
                    EVALUATE(A108, "32D321");
                    EVALUATE(A109, "32D322");
                    EVALUATE(A110, "32D323");
                end;
            }
            tableelement("<integer32>"; Integer)
            {
                XmlName = 'Decemp33';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(a111)
                {
                    XmlName = 'A111';
                    Width = 3;
                }
                textelement(a112)
                {
                    XmlName = 'A112';
                    Width = 15;
                }
                textelement(a113)
                {
                    XmlName = 'A113';
                    Width = 5;
                }
                textelement(a114)
                {
                    XmlName = 'A114';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP33
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP33');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");


                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 250
                    "33D330" := '051';

                    //Total assiette commissions des distributeurs agrées des opérateurs téléphoniques
                    "33D331" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "33D332" := '01500';

                    //Total retenues opérées au titre des commissions des distributeurs agrées des opérateurs téléphoniques
                    "33D333" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);




                    EVALUATE(A111, "33D330");
                    EVALUATE(A112, "33D331");
                    EVALUATE(A113, "33D332");
                    EVALUATE(A114, "33D333");
                end;
            }
            tableelement("<integer33>"; Integer)
            {
                XmlName = 'Decemp34';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(a115)
                {
                    XmlName = 'A115';
                    Width = 3;
                }
                textelement(a116)
                {
                    XmlName = 'A116';
                    Width = 15;
                }
                textelement(a117)
                {
                    XmlName = 'A117';
                    Width = 5;
                }
                textelement(a118)
                {
                    XmlName = 'A118';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP34
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP34');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");


                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 250
                    "34D340" := '220';

                    //Total assiette commissions des distributeurs agrées des opérateurs téléphoniques
                    "34D341" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "34D342" := '02500';

                    //Total retenues opérées au titre des commissions des distributeurs agrées des opérateurs téléphoniques
                    "34D343" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);



                    EVALUATE(A115, "34D340");
                    EVALUATE(A116, "34D341");
                    EVALUATE(A117, "34D342");
                    EVALUATE(A118, "34D343");
                end;
            }
            tableelement("<integer34>"; Integer)
            {
                XmlName = 'Decemp35';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(a119)
                {
                    XmlName = 'A119';
                    Width = 3;
                }
                textelement(a120)
                {
                    XmlName = 'A120';
                    Width = 15;
                }
                textelement(a121)
                {
                    XmlName = 'A121';
                    Width = 5;
                }
                textelement(a122)
                {
                    XmlName = 'A122';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP35
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP35');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");


                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 250
                    "35D350" := '250';

                    //Total assiette commissions des distributeurs agrées des opérateurs téléphoniques
                    "35D351" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "35D352" := '00150';

                    //Total retenues opérées au titre des commissions des distributeurs agrées des opérateurs téléphoniques
                    "35D353" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);




                    EVALUATE(A119, "35D350");
                    EVALUATE(A120, "35D351");
                    EVALUATE(A121, "35D352");
                    EVALUATE(A122, "35D353");
                end;
            }
            tableelement("<integer35>"; Integer)
            {
                XmlName = 'Decemp36';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(a123)
                {
                    XmlName = 'A123';
                    Width = 3;
                }
                textelement(a124)
                {
                    XmlName = 'A124';
                    Width = 15;
                }
                textelement(a125)
                {
                    XmlName = 'A125';
                    Width = 5;
                }
                textelement(a126)
                {
                    XmlName = 'A126';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //extraire les lignes DECEMP36
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP36');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");


                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 250
                    "36D360" := '280';

                    //Total assiette commissions des distributeurs agrées des opérateurs téléphoniques
                    "36D361" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "36D362" := '02500';

                    //Total retenues opérées au titre des commissions des distributeurs agrées des opérateurs téléphoniques
                    "36D363" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);




                    EVALUATE(A123, "36D360");
                    EVALUATE(A124, "36D361");
                    EVALUATE(A125, "36D362");
                    EVALUATE(A126, "36D363");
                end;
            }
            tableelement("<integer38>"; Integer)
            {
                XmlName = 'Decemp38';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(a130)
                {
                    XmlName = 'A130';
                    Width = 3;
                }
                textelement(a131)
                {
                    XmlName = 'A131';
                    Width = 15;
                }
                textelement(a132)
                {
                    XmlName = 'A132';
                    Width = 5;
                }
                textelement(a133)
                {
                    XmlName = 'A133';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin

                    //
                    //extraire les lignes DECEMP38
                    RecG_DeclarationEmployeur.RESET;
                    RecG_DeclarationEmployeur.SETCURRENTKEY("Recap Line Code", Year);
                    RecG_DeclarationEmployeur.SETRANGE("Recap Line Code", 'DECEMP38');
                    RecG_DeclarationEmployeur.SETRANGE(Year, IntG_Exercice);
                    RecG_DeclarationEmployeur.CALCSUMS("Base Withholding Amount", "Withholding Amount");


                    //cumuml total retenu
                    TotalRetenu += RecG_DeclarationEmployeur."Withholding Amount";

                    //Type enregistrement : Zone obligatoire, elle prend la valeur 250
                    "38D380" := '290';

                    //Total assiette commissions des distributeurs agrées des opérateurs téléphoniques
                    "38D381" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Base Withholding Amount", 15);

                    // Taux de la retenue opérée
                    "38D382" := '00300';

                    //Total retenues opérées au titre des commissions des distributeurs agrées des opérateurs téléphoniques
                    "38D383" := FnctG_FormatMontant(RecG_DeclarationEmployeur."Withholding Amount", 15);




                    EVALUATE(A130, "38D380");
                    EVALUATE(A131, "38D381");
                    EVALUATE(A132, "38D382");
                    EVALUATE(A133, "38D383");
                end;
            }
            tableelement("<integer39>"; Integer)
            {
                XmlName = 'Decemp39';
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                textelement(a127)
                {
                    XmlName = 'A127';
                    Width = 3;
                }
                textelement(a128)
                {
                    XmlName = 'A128';
                    Width = 20;
                }
                textelement(a129)
                {
                    XmlName = 'A129';
                    Width = 15;
                }

                trigger OnAfterGetRecord()
                var
                    T4: Record 79;
                begin


                    //
                    //Type enregistrement : Zone obligatoire, elle prend la valeur 999
                    "37D370" := '999';

                    // V 2016 Zone réservée : 20 espaces
                    "37D371" := ' ';

                    // V 2016 Total général des retenues opérées.
                    "37D372" := '000000000000000';

                    Calc := 2837.045;
                    //maj tot si <>0
                    IF TotalRetenu <> 0 THEN
                        "37D372" := FnctG_FormatMontant(TotalRetenu + Calc, 15);


                    EVALUATE(A127, "37D370");
                    EVALUATE(A128, "37D371");
                    EVALUATE(A129, "37D372");
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

        //inits
        TotalRetenu := 0;
        "00D006" := '1';
        "00D007" := '1';
        "00D008" := '0';
        "00D009" := '0';
        "00D010" := '1';
        "00D011" := '1';
        "00D012" := '0';
    end;

    trigger OnPreXmlPort()
    begin

        currXMLport.FILENAME := STRSUBSTNO('C:\Declaration\ANXEMP_%1.txt', COPYSTR(FORMAT(IntG_Exercice), 3, 2));
    end;

    var
        Exercice: Integer;
        "00D000": Code[3];
        "00D001": Code[7];
        "00D002": Code[1];
        "00D003": Code[1];
        "00D004": Code[3];
        "00D005": Code[4];
        "00D006": Code[1];
        "00D007": Code[1];
        "00D008": Code[1];
        "00D009": Code[1];
        "00D010": Code[1];
        "00D011": Code[1];
        "00D012": Code[1];
        "01D010": Code[3];
        "01D011": Code[15];
        "01D012": Code[5];
        "01D013": Code[15];
        "02D020": Code[3];
        "02D021": Code[15];
        "02D022": Code[5];
        "02D023": Code[15];
        "03D030": Code[3];
        "03D031": Code[20];
        "03D032": Code[15];
        "03D033": Code[15];
        "04D040": Code[3];
        "04D041": Code[15];
        "04D042": Code[5];
        "04D043": Code[15];
        "05D050": Code[3];
        "05D051": Code[15];
        "05D052": Code[5];
        "05D053": Code[15];
        "06D060": Code[3];
        "06D061": Code[15];
        "06D062": Code[5];
        "06D063": Code[15];
        "07D070V15": Code[3];
        "07D071V15": Code[15];
        "07D072V15": Code[5];
        "07D073V15": Code[15];
        "08D080V15": Code[3];
        "08D081V15": Code[15];
        "08D082V15": Code[5];
        "08D083V15": Code[15];
        "07D070": Code[3];
        "07D071": Code[15];
        "07D072": Code[5];
        "07D073": Code[15];
        "08D080": Code[3];
        "08D081": Code[15];
        "08D082": Code[5];
        "08D083": Code[15];
        "09D090": Code[3];
        "09D091": Code[15];
        "09D092": Code[5];
        "09D093": Code[15];
        "10D100": Code[3];
        "10D101": Code[15];
        "10D102": Code[5];
        "10D103": Code[15];
        "11D110": Code[3];
        "11D111": Code[15];
        "11D112": Code[5];
        "11D113": Code[15];
        "12D120": Code[3];
        "12D121": Code[15];
        "12D122": Code[5];
        "12D123": Code[15];
        "13D130": Code[3];
        "13D131": Code[15];
        "13D132": Code[5];
        "13D133": Code[15];
        "14D140": Code[3];
        "14D141": Code[15];
        "14D142": Code[5];
        "14D143": Code[15];
        "15D150": Code[3];
        "15D151": Code[15];
        "15D152": Code[5];
        "15D153": Code[15];
        "16D160": Code[3];
        "16D161": Code[15];
        "16D162": Code[5];
        "16D163": Code[15];
        "17D170": Code[3];
        "17D171": Code[15];
        "17D172": Code[5];
        "17D173": Code[15];
        "18D180": Code[3];
        "18D181": Code[15];
        "18D182": Code[5];
        "18D183": Code[15];
        "19D190": Code[3];
        "19D191": Code[15];
        "19D192": Code[5];
        "19D193": Code[15];
        "20D200": Code[3];
        "20D201": Code[15];
        "20D202": Code[5];
        "20D203": Code[15];
        "21D210": Code[3];
        "21D211": Code[15];
        "21D212": Code[5];
        "21D213": Code[15];
        "22D220": Code[3];
        "22D221": Code[15];
        "22D222": Code[5];
        "22D223": Code[15];
        "23D230": Code[3];
        "23D231": Code[15];
        "23D232": Code[5];
        "23D233": Code[15];
        "24D240": Code[3];
        "24D241": Code[15];
        "24D242": Code[5];
        "24D243": Code[15];
        "25D250": Code[3];
        "25D251": Code[15];
        "25D252": Code[5];
        "25D253": Code[15];
        "26D260": Code[3];
        "26D261": Code[15];
        "26D262": Code[5];
        "26D263": Code[15];
        "27D270": Code[3];
        "27D271": Code[15];
        "27D272": Code[5];
        "27D273": Code[15];
        "28D280": Code[3];
        "28D281": Code[15];
        "28D282": Code[5];
        "28D283": Code[15];
        "29D290": Code[3];
        "29D291": Code[15];
        "29D292": Code[5];
        "29D293": Code[15];
        "30D300": Code[3];
        "30D301": Code[15];
        "30D302": Code[5];
        "30D303": Code[15];
        "31D310": Code[3];
        "31D311": Code[15];
        "31D312": Code[5];
        "31D313": Code[15];
        "32D320": Code[3];
        "32D321": Code[15];
        "32D322": Code[5];
        "32D323": Code[15];
        "33D330": Code[3];
        "33D331": Code[15];
        "33D332": Code[5];
        "33D333": Code[15];
        "34D340": Code[3];
        "34D341": Code[15];
        "34D342": Code[5];
        "34D343": Code[15];
        "35D350": Code[3];
        "35D351": Code[15];
        "35D352": Code[5];
        "35D353": Code[15];
        "36D360": Code[3];
        "36D361": Code[15];
        "36D362": Code[5];
        "36D363": Code[15];
        "37D370": Code[3];
        "37D371": Code[20];
        "37D372": Code[15];
        "38D380": Code[3];
        "38D381": Code[15];
        "38D382": Code[5];
        "38D383": Code[15];
        MntDeduit1: Decimal;
        Taux: Decimal;
        RecG_DeclarationEmployeur: Record "WDC Declaration Employeur";
        TotalRetenu: Decimal;
        IntG_Exercice: Integer;
        recg_companyinfo: Record "Company Information";
        boolg_anx1: Boolean;
        boolg_anx2: Boolean;
        boolg_anx3: Boolean;
        boolg_anx4: Boolean;
        boolg_anx5: Boolean;
        boolg_anx6: Boolean;
        RecG_CompanyInformation: Record "Company Information";
        MntBase: Decimal;
        MntRet: Decimal;
        MntContConj: Decimal;
        "00D013": Code[12];
        boolg_anx7: Boolean;
        MatriculeSociete: Text[30];
        Calc: Decimal;

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

