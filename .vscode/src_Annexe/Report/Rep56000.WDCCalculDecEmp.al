report 56000 "WDC Calcul Dec Emp"
{
    //DefaultLayout = RDLC;
    //RDLCLayout = './.vscode/Annexe/Report/RDLC/CalculDecEmp.rdlc';
    applicationarea = All;
    captionml = ENU = 'Calcul Declaration Employer', FRA = 'Calcul Déclaration Employeur';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Creer_Lignes_Annexe_I; Employee)
        {
            DataItemTableView = SORTING("No.");
            dataitem("Rec. Salary Lines"; "WDC Rec. Salary Lines")
            {
                DataItemLink = Employee = FIELD("No.");
                DataItemTableView = SORTING("No.", Employee);
                trigger OnPreDataItem()
                begin
                    SETRANGE("Rec. Salary Lines".Year, IntG_Year);
                end;

                trigger OnAfterGetRecord()
                var
                    RecL_DeclEmp: Record "WDC Declaration Employeur";
                begin
                    IF (NumAnnexe = 1) OR (NumAnnexe = 8) THEN BEGIN

                        CLEAR(RecL_DeclEmp);
                        RecL_DeclEmp.SETFILTER("Type Ligne Decl. Emp.", '%1', RecL_DeclEmp."Type Ligne Decl. Emp."::"Annexe I");
                        RecL_DeclEmp.SETFILTER("Withholding Tax Code", '%1', 'RSAL');
                        RecL_DeclEmp.SETFILTER(Year, FORMAT(IntG_Year));
                        RecL_DeclEmp.SETFILTER("Source Type Annxes", '%1', RecL_DeclEmp."Source Type Annxes"::Salarié);
                        RecL_DeclEmp.SETFILTER("Source No.", '%1', "Rec. Salary Lines".Employee);
                        IF RecL_DeclEmp.FINDFIRST THEN BEGIN
                            RecL_DeclEmp."Taxable Income" += "Taxable salary (month)";
                            RecL_DeclEmp."With. Amount Common Regime" += "Rec. Salary Lines"."Taxe (Month)";
                            RecL_DeclEmp."Net Amount Served" += "Rec. Salary Lines"."Net salary";
                            RecL_DeclEmp."Amount CSS" += "Rec. Salary Lines"."CSS Amount"; // A CHANGER PAR CONTRIBUTION SOCIAL
                            RecL_DeclEmp.MODIFY;
                        END ELSE BEGIN
                            RecL_DeclEmp1.INIT;

                            //Sequence No.
                            IntG_NumSeq += 1;
                            RecL_DeclEmp1."Sequence No." := IntG_NumSeq;

                            //type ligne
                            RecL_DeclEmp1."Type Ligne Decl. Emp." := RecL_DeclEmp1."Type Ligne Decl. Emp."::"Annexe I";
                            RecL_DeclEmp1."Withholding Tax Code" := 'RSAL';

                            //remplir Year
                            RecL_DeclEmp1.Year := IntG_Year;

                            //code employé
                            CodeG_CodeEmployee := Creer_Lignes_Annexe_I."No.";

                            //otre datas
                            RecL_DeclEmp1.Year := DATE2DWY("Posting Date", 3);
                            //RecL_DeclEmp.Year := 2015;
                            RecL_DeclEmp1."Source Type Annxes" := RecL_DeclEmp1."Source Type Annxes"::Salarié;
                            RecL_DeclEmp1.VALIDATE("Source No.", CodeG_CodeEmployee);

                            //montants
                            RecL_DeclEmp1."Taxable Income" := "Taxable salary (month)";
                            RecL_DeclEmp1."With. Amount Common Regime" := "Rec. Salary Lines"."Taxe (Month)";

                            RecL_DeclEmp1."Amount CSS" := "Rec. Salary Lines"."CSS Amount";   // A CHANGER PAR CONTRIBUTION SOCIAL

                            RecL_DeclEmp1."Net Amount Served" := "Rec. Salary Lines"."Net salary";
                            RecL_DeclEmp1.INSERT;
                        END;
                    END;
                end;
            }

            trigger OnPreDataItem()
            var
                RecL_DeclEmp1: Record "WDC Declaration Employeur";
            begin
                CLEAR(IntG_NumSeq);

                IF (NumAnnexe = 1) OR (NumAnnexe = 8) THEN BEGIN
                    CLEAR(RecL_DeclEmp1);
                    RecL_DeclEmp1.SETFILTER("Type Ligne Decl. Emp.", '%1', RecL_DeclEmp1."Type Ligne Decl. Emp."::"Annexe I");
                    RecL_DeclEmp1.SETFILTER(RecL_DeclEmp1.Year, '%1', IntG_Year);
                    IF RecL_DeclEmp1.FINDFIRST THEN
                        RecL_DeclEmp1.DELETEALL;
                END;
            end;
        }
        dataitem(Cree_Ligne_AnnexeII; "G/L Entry")
        {
            CalcFields = "Withholding Tax Code";
            DataItemTableView = WHERE("Source No. RS" = filter(<> 'FRS-00073'),
                                      "Source Type RS" = filter(<> " "));
            trigger OnPreDataItem()
            var
                RecL_DeclEmp: Record "WDC Declaration Employeur";
            begin
                GLSetup.TESTFIELD("WDC Codes Retenue Annexe II");
                Cree_Ligne_AnnexeII.SETFILTER("Posting Date", '%1..%2', DMY2DATE(1, 1, IntG_Year), DMY2DATE(31, 12, IntG_Year));
                //Cree_Ligne_AnnexeII.SETFILTER("Withholding Tax Code", '%1|%2|%3|%4|%5|%6', '5%', '3%', '10%', '20%', '15%', 'R100TVA', '2.5%');
                Cree_Ligne_AnnexeII.SETFILTER("Withholding Tax Code", GLSetup."WDC Codes Retenue Annexe II");
                IntG_NumSeq := 0;
                IF (NumAnnexe = 2) OR (NumAnnexe = 8) THEN BEGIN
                    CLEAR(RecL_DeclEmp);
                    RecL_DeclEmp.SETFILTER("Type Ligne Decl. Emp.", '%1', RecL_DeclEmp."Type Ligne Decl. Emp."::"Annexe II");
                    RecL_DeclEmp.SETFILTER(RecL_DeclEmp.Year, '%1', IntG_Year);
                    IF RecL_DeclEmp.FINDFIRST THEN
                        RecL_DeclEmp.DELETEALL;
                END;
            end;

            trigger OnAfterGetRecord()
            var
                RecG_GroupeRetenue: Record "WDC Withholding Group";
                RecL_DeclEmp: Record "WDC Declaration Employeur";
                RecL_DeclEmpEncours: Record "WDC Declaration Employeur";
            begin
                IF (NumAnnexe = 2) OR (NumAnnexe = 8) THEN BEGIN
                    Cree_Ligne_AnnexeII.CalcFields("Source Type RS");
                    Cree_Ligne_AnnexeII.CalcFields("Source No. RS");
                    Cree_Ligne_AnnexeII.CalcFields("Withholding Tax Code");

                    if RecG_GroupeRetenue.Get(Cree_Ligne_AnnexeII."Withholding Tax Code") then;

                    RecL_DeclEmp.INIT;
                    IntG_NumSeq += 1;
                    RecL_DeclEmp."Sequence No." := IntG_NumSeq;
                    RecL_DeclEmp."Type Ligne Decl. Emp." := RecL_DeclEmp."Type Ligne Decl. Emp."::"Annexe II";
                    RecL_DeclEmp.Year := IntG_Year;
                    RecL_DeclEmp.VALIDATE("Withholding Tax Code", "Withholding Tax Code");
                    IF Cree_Ligne_AnnexeII."Source Type RS" = Cree_Ligne_AnnexeII."Source Type RS"::Vendor THEN
                        RecL_DeclEmp."Source Type Annxes" := RecL_DeclEmp."Source Type Annxes"::Vendor;
                    IF Cree_Ligne_AnnexeII."Source Type RS" = Cree_Ligne_AnnexeII."Source Type RS"::Customer THEN
                        RecL_DeclEmp."Source Type Annxes" := RecL_DeclEmp."Source Type Annxes"::Customer;
                    RecL_DeclEmp.VALIDATE("Source No.", Cree_Ligne_AnnexeII."Source No. RS");
                    RecL_DeclEmp.VALIDATE("Withholding Amount", -Amount);
                    RecL_DeclEmp."% Withholding Tax" := RecG_GroupeRetenue."% Withholding Tax";
                    RecL_DeclEmp.INSERT;
                END;
            end;
        }
        dataitem(Create_Line_AnnexeV; "G/L Entry")
        {
            DataItemTableView = WHERE("Source No. RS" = filter(<> 'FRS-00073'),
                                      "Source Type RS" = filter(<> " "));
            trigger OnPreDataItem()
            var
                RecL_DeclEmp: Record "WDC Declaration Employeur";
            begin
                GLSetup.TESTFIELD("WDC Codes Retenue Annexe V");
                Create_Line_AnnexeV.SETFILTER("Posting Date", '%1..%2', DMY2DATE(1, 1, IntG_Year), DMY2DATE(31, 12, IntG_Year));
                //Create_Line_AnnexeV.SETFILTER("Withholding Tax Code", '%1|%2|%3|%4|%5|%6', '0,5%', '1%', '1,50%', 'R100TVA', '1.5%PP', '1.5%PM');
                Create_Line_AnnexeV.SETFILTER("Withholding Tax Code", GLSetup."WDC Codes Retenue Annexe V");
                IntG_NumSeq := 0;
                IF (NumAnnexe = 5) OR (NumAnnexe = 8) THEN BEGIN
                    CLEAR(RecL_DeclEmp);
                    RecL_DeclEmp.SETFILTER("Type Ligne Decl. Emp.", '%1', RecL_DeclEmp."Type Ligne Decl. Emp."::"Annexe V");
                    RecL_DeclEmp.SETFILTER(RecL_DeclEmp.Year, '%1', IntG_Year);
                    IF RecL_DeclEmp.FINDFIRST THEN
                        RecL_DeclEmp.DELETEALL;
                END;
            end;

            trigger OnAfterGetRecord()
            var
                RecG_GroupeRetenue: Record "WDC Withholding Group";
                RecL_DeclEmp: Record "WDC Declaration Employeur";
                RecL_DeclEmpEncours: Record "WDC Declaration Employeur";
            begin
                IF (NumAnnexe = 5) OR (NumAnnexe = 8) THEN BEGIN

                    Create_Line_AnnexeV.CalcFields("Withholding Tax Code");
                    if RecG_GroupeRetenue.Get(Create_Line_AnnexeV."Withholding Tax Code") then;

                    RecL_DeclEmp.INIT;
                    MNT := 0;
                    Create_Line_AnnexeV.CalcFields("Source Type RS");
                    Create_Line_AnnexeV.CalcFields("Source No. RS");
                    Create_Line_AnnexeV.CalcFields("Withholding Tax Code");
                    IntG_NumSeq += 1;
                    RecL_DeclEmp."Sequence No." := IntG_NumSeq;
                    RecL_DeclEmp."Type Ligne Decl. Emp." := RecL_DeclEmp."Type Ligne Decl. Emp."::"Annexe V";
                    RecL_DeclEmp.Year := IntG_Year;
                    RecL_DeclEmp.VALIDATE("Withholding Tax Code", Create_Line_AnnexeV."Withholding Tax Code");
                    IF Create_Line_AnnexeV."Source Type RS" = Create_Line_AnnexeV."Source Type RS"::Vendor THEN
                        RecL_DeclEmp."Source Type Annxes" := RecL_DeclEmp."Source Type Annxes"::Vendor;
                    IF Create_Line_AnnexeV."Source Type RS" = Create_Line_AnnexeV."Source Type RS"::Customer THEN
                        RecL_DeclEmp."Source Type Annxes" := RecL_DeclEmp."Source Type Annxes"::Customer;
                    RecL_DeclEmp.VALIDATE("Source No.", Create_Line_AnnexeV."Source No. RS");
                    MNT += Create_Line_AnnexeV.Amount;
                    RecL_DeclEmp.VALIDATE("Withholding Amount", -MNT);
                    RecL_DeclEmp."% Withholding Tax" := RecG_GroupeRetenue."% Withholding Tax";
                    RecL_DeclEmp.INSERT;
                END;
            end;
        }
        dataitem(Cree_Ligne_AnnexeVI_Ristourne; "G/L Entry")
        {
            DataItemTableView = SORTING("G/L Account No.", "Document No.", "Posting Date");
            trigger OnPreDataItem()
            var
                RecL_DeclEmp: Record "WDC Declaration Employeur";
            begin
                GLSetup.TESTFIELD("WDC Codes Retenue VI Ristourne");
                Cree_Ligne_AnnexeVI_Ristourne.SETFILTER("Posting Date", '%1..%2', DMY2DATE(1, 1, IntG_Year), DMY2DATE(31, 12, IntG_Year));
                //Cree_Ligne_AnnexeVI_Ristourne.SetFilter("Withholding Tax Code", '%1|%2', 'RCIST', 'RCIST2');
                Cree_Ligne_AnnexeVI_Ristourne.SetFilter("Withholding Tax Code", GLSetup."WDC Codes Retenue VI Ristourne");
                CLEAR(IntG_NumSeq);
                IF (NumAnnexe = 6) OR (NumAnnexe = 8) THEN BEGIN
                    CLEAR(RecL_DeclEmp);
                    RecL_DeclEmp.SETFILTER("Type Ligne Decl. Emp.", '%1', RecL_DeclEmp."Type Ligne Decl. Emp."::"Annexe VI");
                    RecL_DeclEmp.SETFILTER(RecL_DeclEmp.Year, '%1', IntG_Year);
                    IF RecL_DeclEmp.FINDLAST THEN
                        IntG_NumSeq := RecL_DeclEmp."Sequence No.";
                END;
            end;

            trigger OnAfterGetRecord()
            var
                RecL_DeclEmp: Record "WDC Declaration Employeur";
                RecL_DeclEmpEncours: Record "WDC Declaration Employeur";
                RecG_DeclEmpEncours: Record "WDC Declaration Employeur";
            begin
                IF (NumAnnexe = 6) OR (NumAnnexe = 8) THEN BEGIN
                    RecG_GroupeRetenue.RESET;
                    //RecG_GroupeRetenue.SETFILTER(Code, '%1|%2', 'RCIST', 'RCIST3');
                    REcG_GroupeRetenue.SETFILTER(Code, GLSetup."WDC Codes Retenue VI Ristourne");
                    if RecG_GroupeRetenue.FindFirst() then;
                    RecG_DeclEmpEncours.SETRANGE("Type Ligne Decl. Emp.", RecG_DeclEmpEncours."Type Ligne Decl. Emp."::"Annexe VI");
                    RecG_DeclEmpEncours.SETRANGE(Year, IntG_Year);
                    RecG_DeclEmpEncours.SETRANGE("Source No.", Cree_Ligne_AnnexeVI_Ristourne."Source No.");
                    IF RecG_DeclEmpEncours.FINDFIRST THEN BEGIN
                        RecG_DeclEmpEncours."Discounts Amount" := RecG_DeclEmpEncours."Discounts Amount" + Amount;//
                        RecG_DeclEmpEncours.MODIFY;
                    END ELSE BEGIN
                        RecL_DeclEmp.INIT;
                        IntG_NumSeq += 1;
                        RecL_DeclEmp."Sequence No." := IntG_NumSeq;
                        RecL_DeclEmp."Type Ligne Decl. Emp." := RecL_DeclEmp."Type Ligne Decl. Emp."::"Annexe VI";
                        RecL_DeclEmp.Year := IntG_Year;
                        IF Cree_Ligne_AnnexeVI_Ristourne."Source Type" = Cree_Ligne_AnnexeVI_Ristourne."Source Type"::Vendor THEN
                            RecL_DeclEmp."Source Type Annxes" := RecL_DeclEmp."Source Type Annxes"::Vendor;
                        IF Cree_Ligne_AnnexeVI_Ristourne."Source Type" = Cree_Ligne_AnnexeVI_Ristourne."Source Type"::Customer THEN
                            RecL_DeclEmp."Source Type Annxes" := RecL_DeclEmp."Source Type Annxes"::Customer;
                        RecL_DeclEmp.VALIDATE("Source No.", Cree_Ligne_AnnexeVI_Ristourne."Source No.");
                        RecL_DeclEmp.VALIDATE("Withholding Tax Code", RecG_GroupeRetenue.Code);
                        RecL_DeclEmp."Pos. mnt Brut dans Annexe" := RecG_GroupeRetenue."Pos. mnt Brut dans Annexe";
                        RecL_DeclEmp."Sous Pos. mnt Brut ds  Annexe" := RecG_GroupeRetenue."Sous Pos. mnt Brut ds  Annexe";

                        RecL_DeclEmp."% Withholding Tax" := RecG_GroupeRetenue."% Withholding Tax";
                        RecL_DeclEmp."Discounts Amount" := Amount;
                        RecL_DeclEmp.INSERT;
                    END;
                END;
            end;
        }
        dataitem(Cree_Ligne_AnnexeVI_Avance; "G/L Entry")
        {
            DataItemTableView = SORTING("G/L Account No.", "Document No.", "Posting Date")
                                    ORDER(Ascending);
            trigger OnPreDataItem()
            var
                RecL_DeclEmp: Record "WDC Declaration Employeur";
            begin
                GLSetup.TESTFIELD("WDC Codes Retenue VI Avance");
                Cree_Ligne_AnnexeVI_Avance.SETFILTER("Posting Date", '%1..%2', DMY2DATE(1, 1, IntG_Year), DMY2DATE(31, 12, IntG_Year));
                //Cree_Ligne_AnnexeVI_Avance.SetFilter("Withholding Tax Code", '%1', 'RF1%');
                Cree_Ligne_AnnexeVI_Avance.SetFilter("Withholding Tax Code", GLSetup."WDC Codes Retenue VI Avance");
                CLEAR(IntG_NumSeq);
                IF (NumAnnexe = 6) OR (NumAnnexe = 8) THEN BEGIN
                    CLEAR(RecL_DeclEmp);
                    RecL_DeclEmp.SETFILTER("Type Ligne Decl. Emp.", '%1', RecL_DeclEmp."Type Ligne Decl. Emp."::"Annexe VI");
                    RecL_DeclEmp.SETFILTER(RecL_DeclEmp.Year, '%1', IntG_Year);
                    IF RecL_DeclEmp.FINDLAST THEN
                        IntG_NumSeq := RecL_DeclEmp."Sequence No.";
                END
            end;

            trigger OnAfterGetRecord()
            var
                RecG_DeclEmpEncours: Record "WDC Declaration Employeur";
                RecL_DeclEmp: Record "WDC Declaration Employeur";
            begin
                IF (NumAnnexe = 6) OR (NumAnnexe = 8) THEN BEGIN
                    //RecG_GroupeRetenue.Get('RF1%');
                    RecG_GroupeRetenue.Get(GLSetup."WDC Codes Retenue VI Avance");
                    RecG_DeclEmpEncours.SETRANGE("Type Ligne Decl. Emp.", RecG_DeclEmpEncours."Type Ligne Decl. Emp."::"Annexe VI");
                    RecG_DeclEmpEncours.SETRANGE(Year, IntG_Year);
                    RecG_DeclEmpEncours.SETRANGE("Source No.", Cree_Ligne_AnnexeVI_Avance."Source No.");
                    RecG_DeclEmpEncours.SETFILTER("Withholding Tax Code", GLSetup."WDC Codes Retenue VI Avance");
                    IF RecG_DeclEmpEncours.FINDFIRST THEN BEGIN
                        RecG_DeclEmpEncours."Advances On Sales PP Reg Flat" := RecG_DeclEmpEncours."Advances On Sales PP Reg Flat" - Amount;
                        RecG_DeclEmpEncours."Amounts Sales PP Reg Flat" := RecG_DeclEmpEncours."Advances On Sales PP Reg Flat" * 100;
                        RecG_DeclEmpEncours.MODIFY;
                    END ELSE BEGIN
                        RecL_DeclEmp.INIT;
                        IntG_NumSeq += 1;
                        RecL_DeclEmp."Sequence No." := IntG_NumSeq;
                        RecL_DeclEmp."Type Ligne Decl. Emp." := RecL_DeclEmp."Type Ligne Decl. Emp."::"Annexe VI";
                        RecL_DeclEmp.Year := IntG_Year;
                        RecL_DeclEmp."Source Type Annxes" := RecL_DeclEmp."Source Type Annxes"::Customer;
                        RecL_DeclEmp.VALIDATE("Source No.", Cree_Ligne_AnnexeVI_Avance."Source No.");
                        RecL_DeclEmp.VALIDATE("Withholding Tax Code", RecG_GroupeRetenue.Code);
                        RecL_DeclEmp."Pos. mnt Brut dans Annexe" := RecG_GroupeRetenue."Pos. mnt Brut dans Annexe";
                        RecL_DeclEmp."Sous Pos. mnt Brut ds  Annexe" := RecG_GroupeRetenue."Sous Pos. mnt Brut ds  Annexe";
                        RecL_DeclEmp."% Withholding Tax" := RecG_GroupeRetenue."% Withholding Tax";
                        RecL_DeclEmp."Advances On Sales PP Reg Flat" += -Amount;
                        RecL_DeclEmp."Amounts Sales PP Reg Flat" += RecL_DeclEmp."Advances On Sales PP Reg Flat" * 100;
                        RecL_DeclEmp.INSERT;
                    END;
                END;
            end;
        }
        dataitem("Cree_Ligne_AnnexeVI_Espèces"; "G/L Entry")
        {
            DataItemTableView = SORTING("G/L Account No.", "Document No.", "Posting Date");
            trigger OnPreDataItem()
            var
                RecL_DeclEmp: Record "WDC Declaration Employeur";
            begin
                GLSetup.TESTFIELD("WDC Codes Retenue VI Especes");
                Cree_Ligne_AnnexeVI_Espèces.SETFILTER("Posting Date", '%1..%2', DMY2DATE(1, 1, IntG_Year), DMY2DATE(31, 12, IntG_Year));
                //Cree_Ligne_AnnexeVI_Espèces.SETFILTER("Withholding Tax Code", '%1', 'ESPCOUV');
                Cree_Ligne_AnnexeVI_Espèces.SETFILTER("Withholding Tax Code", GLSetup."WDC Codes Retenue VI Especes");
                CLEAR(IntG_NumSeq);
                IF (NumAnnexe = 6) OR (NumAnnexe = 8) THEN BEGIN
                    CLEAR(RecL_DeclEmp);
                    RecL_DeclEmp.SETFILTER("Type Ligne Decl. Emp.", '%1', RecL_DeclEmp."Type Ligne Decl. Emp."::"Annexe VI");
                    RecL_DeclEmp.SETFILTER(RecL_DeclEmp.Year, '%1', IntG_Year);
                    IF RecL_DeclEmp.FINDLAST THEN
                        IntG_NumSeq := RecL_DeclEmp."Sequence No.";
                END;
            end;

            trigger OnAfterGetRecord()
            var
                RecG_DeclEmpEncours: Record "WDC Declaration Employeur";
                RecL_DeclEmp: Record "WDC Declaration Employeur";
            begin
                IF (NumAnnexe = 6) OR (NumAnnexe = 8) THEN BEGIN
                    //RecG_GroupeRetenue.Get('ESPCOUV');
                    RecG_GroupeRetenue.Get(GLSetup."WDC Codes Retenue VI Especes");
                    RecG_DeclEmpEncours.SETRANGE("Type Ligne Decl. Emp.", RecG_DeclEmpEncours."Type Ligne Decl. Emp."::"Annexe VI");
                    RecG_DeclEmpEncours.SETRANGE(Year, IntG_Year);
                    RecL_DeclEmp.INIT;
                    IntG_NumSeq += 1;
                    RecL_DeclEmp."Sequence No." := IntG_NumSeq;
                    RecL_DeclEmp."Type Ligne Decl. Emp." := RecL_DeclEmp."Type Ligne Decl. Emp."::"Annexe VI";
                    RecL_DeclEmp.Year := IntG_Year;
                    RecL_DeclEmp."Source Type Annxes" := RecL_DeclEmp."Source Type Annxes"::Customer;
                    RecL_DeclEmp.VALIDATE("Source No.", Cree_Ligne_AnnexeVI_Espèces."Source No.");
                    RecL_DeclEmp.VALIDATE("Withholding Tax Code", GLSetup."WDC Codes Retenue VI Especes");
                    RecL_DeclEmp."Pos. mnt Brut dans Annexe" := RecG_GroupeRetenue."Pos. mnt Brut dans Annexe";
                    RecL_DeclEmp."Sous Pos. mnt Brut ds  Annexe" := RecG_GroupeRetenue."Sous Pos. mnt Brut ds  Annexe";

                    RecL_DeclEmp."% Withholding Tax" := RecG_GroupeRetenue."% Withholding Tax";
                    RecL_DeclEmp."Amount Recovered in Cash" := Amount;
                    RecL_DeclEmp.INSERT;
                END;
            end;
        }
        dataitem(Crer_Lignes_Recap_anx1_VI; Integer)
        {
            DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
            trigger OnPreDataItem()
            var
                RecL_DeclEmp: Record "WDC Declaration Employeur";
            begin
                CLEAR(IntG_NumSeq);
                IF (NumAnnexe = 9) OR (NumAnnexe = 8) THEN BEGIN
                    CLEAR(RecL_DeclEmp);
                    RecL_DeclEmp.SETFILTER("Type Ligne Decl. Emp.", '%1', RecL_DeclEmp."Type Ligne Decl. Emp."::Recap);
                    RecL_DeclEmp.SETFILTER(RecL_DeclEmp.Year, '%1', IntG_Year);
                    IF RecL_DeclEmp.FINDFIRST THEN
                        RecL_DeclEmp.DELETEALL;
                END;
            end;

            trigger OnAfterGetRecord()
            var
                RecG_DeclEmpEncours: Record "WDC Declaration Employeur";
                RecL_DeclEmp: Record "WDC Declaration Employeur";
            begin
                IF (NumAnnexe = 9) OR (NumAnnexe = 8) THEN BEGIN
                    RecG_DeclEmpEncours.RESET;
                    RecG_DeclEmpEncours.SETCURRENTKEY(Year, "Type Ligne Decl. Emp.");
                    RecG_DeclEmpEncours.SETRANGE(Year, IntG_Year);
                    RecG_DeclEmpEncours.SETRANGE("Type Ligne Decl. Emp.", RecG_DeclEmpEncours."Type Ligne Decl. Emp."::"Annexe I");
                    RecG_DeclEmpEncours.CALCSUMS("Taxable Income", "Nature Benefits", "With. Amount Common Regime", "Net Amount Served", "Total redevances caisse compen", "Amount CSS"); // A VERIFIER POUR RECAP DISCO
                    IF (RecG_DeclEmpEncours."Taxable Income" + RecG_DeclEmpEncours."Nature Benefits") <> 0 THEN BEGIN
                        RecL_DeclEmp.INIT;
                        IntG_NumSeq += 1;
                        RecL_DeclEmp."Sequence No." := IntG_NumSeq;
                        RecL_DeclEmp.Year := IntG_Year;
                        RecL_DeclEmp."Type Ligne Decl. Emp." := RecL_DeclEmp."Type Ligne Decl. Emp."::Recap;
                        RecL_DeclEmp."Recap Line Code" := 'DECEMP01';
                        RecL_DeclEmp."Source Name" := 'Traitements, salaires, pensions et rentes viageres payes operees selon le regime commun';
                        RecL_DeclEmp."Base Withholding Amount" :=
                          RecG_DeclEmpEncours."Taxable Income" + RecG_DeclEmpEncours."Nature Benefits";
                        RecL_DeclEmp."Withholding Amount" := RecG_DeclEmpEncours."With. Amount Common Regime";
                        RecL_DeclEmp."% Withholding Tax" := 0;
                        RecL_DeclEmp.INSERT;
                    END;

                    IF (RecG_DeclEmpEncours."Total redevances caisse compen") <> 0 THEN BEGIN
                        RecL_DeclEmp.INIT;
                        IntG_NumSeq += 1;
                        RecL_DeclEmp."Sequence No." := IntG_NumSeq;
                        RecL_DeclEmp.Year := IntG_Year;
                        RecL_DeclEmp."Type Ligne Decl. Emp." := RecL_DeclEmp."Type Ligne Decl. Emp."::Recap;
                        RecL_DeclEmp."Recap Line Code" := 'DECEMP35';
                        RecL_DeclEmp."Source Name" := 'Total assiette Redevance de subvention de la caisse générale de compensation';
                        RecL_DeclEmp."Base Withholding Amount" := RecG_DeclEmpEncours."Total redevances caisse compen" * 100;
                        RecL_DeclEmp."% Withholding Tax" := 1;
                        RecL_DeclEmp."Withholding Amount" := RecG_DeclEmpEncours."Total redevances caisse compen";
                        RecL_DeclEmp.INSERT;
                    END;

                    RecG_DeclEmpEncours.RESET;
                    RecG_DeclEmpEncours.SETCURRENTKEY(Year, "Type Ligne Decl. Emp.");
                    RecG_DeclEmpEncours.SETRANGE(Year, IntG_Year);
                    RecG_DeclEmpEncours.SETRANGE("Type Ligne Decl. Emp.", RecG_DeclEmpEncours."Type Ligne Decl. Emp."::"Annexe VI");
                    RecG_DeclEmpEncours.CALCSUMS("Amounts Sales PP Reg Flat", "Advances On Sales PP Reg Flat");
                    IF (RecG_DeclEmpEncours."Advances On Sales PP Reg Flat") <> 0 THEN BEGIN
                        RecL_DeclEmp.INIT;
                        IntG_NumSeq += 1;
                        RecL_DeclEmp."Sequence No." := IntG_NumSeq;
                        RecL_DeclEmp.Year := IntG_Year;
                        RecL_DeclEmp."Type Ligne Decl. Emp." := RecL_DeclEmp."Type Ligne Decl. Emp."::Recap;
                        RecL_DeclEmp."Recap Line Code" := 'DECEMP33';
                        RecL_DeclEmp."Source Name" := 'Total assiette des avances sur les ventes Forfait';
                        RecL_DeclEmp."Base Withholding Amount" := RecG_DeclEmpEncours."Advances On Sales PP Reg Flat" * 100;
                        RecL_DeclEmp."% Withholding Tax" := 1;
                        RecL_DeclEmp."Withholding Amount" := RecG_DeclEmpEncours."Advances On Sales PP Reg Flat";
                        RecL_DeclEmp.INSERT;
                    END;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Year Declaration"; IntG_Year)
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Year declaration', FRA = 'Année de déclaration';
                }


            }

        }
        trigger OnQueryClosePage(CLOSEACTION: Action): Boolean
        var
            myInt: Integer;
        begin
            IF CLOSEACTION <> Action::Cancel THEN BEGIN
                IF IntG_Year = 0 THEN
                    ERROR('Veuillez Taper l''année de déclaration');
            END;
        end;
    }


    trigger OnInitReport()
    begin
        // if NumAnnexe <> 0 then
        //     NumAnnexe := STRMENU(Text0001, NumAnnexe);
    end;

    trigger OnPostReport()
    begin
        MESSAGE('Traitement de l''annexe %1 est terminé', NumAnnexe);
    end;

    trigger OnPreReport()
    begin
        if NumAnnexe = 0 then
            NumAnnexe := STRMENU(Text0001, NumAnnexe);
        GLSetup.Get();
    end;

    procedure SetAnnexeID(pAnnexId: Integer)
    begin
        NumAnnexe := pAnnexId;
    end;


    var
        "IntG_Year": Integer;
        NumAnnexe: Integer;
        Text0001: Label 'Annexe I,Annexe II,Annexe III,Annexe IV,Annexe V,Annexe VI,Annexe VII,ALL,Récup';
        IntG_NumSeq: Integer;
        w: Dialog;
        CodeG_CodeEmployee: Code[20];
        //recsalaryline: Record 52048946;
        RecL_DeclEmp1: Record "WDC Declaration Employeur";
        RecG_GroupeRetenue: Record "WDC Withholding Group";
        RecVendor: Record Vendor;
        Retenu: Decimal;
        // GLEntry: Record "G/L Entry";
        MNT: Decimal;
        GLSetup: Record "General Ledger Setup";

}

