xmlport 56008 "WDC Import Annexe I (CSV)"
{
    Caption = 'Import Annexe I';
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ';';
    FieldDelimiter = '"';
    TextEncoding = UTF8;
    UseRequestPage = true;

    schema
    {
        textelement(Root)
        {
            tableelement(Ligne; Integer)
            {
                AutoSave = false;
                UseTemporary = true;
                SourceTableView = sorting(Number);

                textelement(Matricule) { }
                textelement(TypeIdentifiant) { }
                textelement(NumIdentifiant) { }
                textelement(Nom) { }
                textelement(Prenom) { }
                textelement(Emploi) { }
                textelement(Adresse) { }
                textelement(SituationFamiliale) { }
                textelement(NbEnfants) { }
                textelement(DateDebut) { }
                textelement(DateFin) { }
                textelement(NbJours) { }
                textelement(RevenuImposable) { }
                textelement(AvantagesNature) { }
                textelement(TotalRevenuBrut) { }
                textelement(RetenueIRPP) { }
                textelement(RReinvesti) { }
                textelement(CSS) { }
                textelement(RetEtranger) { }
                textelement(MontantNetServi) { }
                textelement(InteretsPrets) { }
                //textelement(ContribCOVID) { }
                textelement(NbMoisTravail) { }

                trigger OnBeforeInsertRecord()
                begin
                    // LineNo += 1;
                    // // Ignore la ligne d'entête (1re ligne)
                    // if LineNo > 1 then
                    ImportLine();
                    currXMLport.Skip();
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
                field(YearCtrl; IntG_Year)
                {
                    ApplicationArea = All;
                    Caption = 'Année';
                }
            }
        }
    }

    var
        IntG_Year: Integer;
        IntG_NumSeq: Integer;
    //LineNo: Integer;

    trigger OnPreXmlPort()
    var
        RecL_Del: Record "WDC Declaration Employeur";
    begin
        if IntG_Year = 0 then
            Error('Veuillez renseigner l''année.');

        RecL_Del.Reset();
        RecL_Del.SetRange("Type Ligne Decl. Emp.", RecL_Del."Type Ligne Decl. Emp."::"Annexe I");
        RecL_Del.SetRange(Year, IntG_Year);
        RecL_Del.DeleteAll();

        IntG_NumSeq := 0;
        RecL_Del.Reset();
        if RecL_Del.FindLast() then
            IntG_NumSeq := RecL_Del."Sequence No.";
    end;

    local procedure ImportLine()
    var
        RecL_DeclEmp: Record "WDC Declaration Employeur";
        RecL_Employee: Record Employee;
        GLSetup: Record "General Ledger Setup";
        Taxable: Decimal;
        Nature: Decimal;
        Reinvest: Decimal;
        IRPP: Decimal;
        Ret20: Decimal;
        CSSAmt: Decimal;
        Net: Decimal;
        Conj: Decimal;
    begin
        Matricule := DelChr(Matricule, '<>', ' ');
        if Matricule = '' then
            exit;

        GLSetup.get;
        GLSetup.TESTFIELD("WDC Codes Retenue Annexe I");

        Taxable := ToDec(RevenuImposable);
        Nature := ToDec(AvantagesNature);
        Reinvest := ToDec(RReinvesti);
        IRPP := ToDec(RetenueIRPP);
        Ret20 := ToDec(RetEtranger);
        CSSAmt := ToDec(CSS);
        Net := ToDec(MontantNetServi);
        //Conj := ToDec(ContribCOVID);

        RecL_DeclEmp.Init();
        IntG_NumSeq += 1;
        RecL_DeclEmp."Sequence No." := IntG_NumSeq;
        RecL_DeclEmp."Type Ligne Decl. Emp." := RecL_DeclEmp."Type Ligne Decl. Emp."::"Annexe I";
        RecL_DeclEmp."Withholding Tax Code" := GLSetup."WDC Codes Retenue Annexe I";
        RecL_DeclEmp.Year := IntG_Year;
        RecL_DeclEmp."Source Type Annxes" := RecL_DeclEmp."Source Type Annxes"::Salarié;


        // if RecL_Employee.Get(Matricule) then
        //     RecL_DeclEmp.Validate("Source No.", Matricule)
        // else
        RecL_DeclEmp."Source No." := Matricule;

        if TypeIdentifiant <> '' then
            RecL_DeclEmp."Source Type ID" := CopyStr(DelChr(TypeIdentifiant, '<>', ' '), 1, 1);
        if NumIdentifiant <> '' then
            RecL_DeclEmp."Source ID" := CopyStr(DelChr(NumIdentifiant, '<>', ' '), 1, MaxStrLen(RecL_DeclEmp."Source ID"));
        if (Nom <> '') or (Prenom <> '') then
            RecL_DeclEmp."Source Name" := CopyStr(DelChr(Nom, '<>', ' ') + ' ' + DelChr(Prenom, '<>', ' '), 1, MaxStrLen(RecL_DeclEmp."Source Name"));
        if Emploi <> '' then
            RecL_DeclEmp."Source Activity" := CopyStr(Emploi, 1, MaxStrLen(RecL_DeclEmp."Source Activity"));
        if Adresse <> '' then
            RecL_DeclEmp."Source Address" := CopyStr(Adresse, 1, MaxStrLen(RecL_DeclEmp."Source Address"));
        if SituationFamiliale <> '' then
            RecL_DeclEmp."Family Situation" := ConvertFamilySituation(SituationFamiliale);
        if NbEnfants <> '' then
            RecL_DeclEmp."Loaded childs" := ToInt(NbEnfants);
        if ToDate(DateDebut) <> 0D then
            RecL_DeclEmp."Work Start Date" := ToDate(DateDebut);
        if ToDate(DateFin) <> 0D then
            RecL_DeclEmp."Work End Date" := ToDate(DateFin);
        if NbJours <> '' then
            RecL_DeclEmp."Duration of work period (D)" := ToInt(NbJours);


        RecL_DeclEmp."Taxable Income" := Taxable;
        RecL_DeclEmp."Nature Benefits" := Nature;
        RecL_DeclEmp."Reinvested Income" := Reinvest;
        RecL_DeclEmp."With. Amount Common Regime" := IRPP;
        RecL_DeclEmp."Total Withholding 20%" := Ret20;
        RecL_DeclEmp."Amount CSS" := CSSAmt;
        RecL_DeclEmp."Net Amount Served" := Net;
        RecL_DeclEmp."Total Contribution Conjoncture" := Conj;
        RecL_DeclEmp.Insert();
    end;

    local procedure ConvertFamilySituation(Txt: Text): Code[1]
    begin
        case UpperCase(DelChr(Txt, '<>', ' ')) of
            'C', '1':
                exit('1');
            'M', '2':
                exit('2');
            'D', '3':
                exit('3');
            'V', '4':
                exit('4');
        end;
        exit('');
    end;

    local procedure ToDec(Txt: Text): Decimal
    var
        D: Decimal;
    begin
        Txt := DelChr(Txt, '=', ' ');
        if Txt = '' then
            exit(0);
        Txt := ConvertStr(Txt, '.', ',');
        if not Evaluate(D, Txt) then
            exit(0);
        exit(D);
    end;

    local procedure ToInt(Txt: Text): Integer
    var
        I: Integer;
    begin
        if not Evaluate(I, DelChr(Txt, '=', ' ')) then
            exit(0);
        exit(I);
    end;

    local procedure ToDate(Txt: Text): Date
    var
        D, M, Y : Integer;
    begin
        Txt := DelChr(Txt, '<>', ' ');
        if (StrLen(Txt) <> 10) or (CopyStr(Txt, 3, 1) <> '/') or (CopyStr(Txt, 6, 1) <> '/') then
            exit(0D);
        if not Evaluate(D, CopyStr(Txt, 1, 2)) then exit(0D);
        if not Evaluate(M, CopyStr(Txt, 4, 2)) then exit(0D);
        if not Evaluate(Y, CopyStr(Txt, 7, 4)) then exit(0D);
        exit(DMY2Date(D, M, Y));
    end;
}