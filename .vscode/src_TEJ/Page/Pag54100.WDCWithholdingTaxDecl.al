page 54100 "WDC Withholding Tax Decl"
{
    ApplicationArea = All;
    CaptionML = FRA = 'Déclaration RS', ENU = 'RS Declaration';
    PageType = List;
    SourceTable = "WDC Withholding Tax Decl";
    DeleteAllowed = false;
    //Editable = false;
    InsertAllowed = false;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(Periode)
            {
                CaptionML = FRA = 'Période', ENU = 'Period';
                field("StartDate"; "StartDate")
                {
                    ApplicationArea = All;
                    CaptionML = FRA = 'Date début', ENU = 'Start Date';
                    trigger OnValidate()
                    var
                        lDeclarationRS: Record "WDC Withholding Tax Decl";
                    begin
                        if EndDate <> 0D then begin
                            EndDate := 0D;
                            lDeclarationRS.DeleteAll();
                            CurrPage.Update(false);
                        end;
                    end;
                }
                field("EndDate"; "EndDate")
                {
                    ApplicationArea = All;
                    CaptionML = FRA = 'Date fin', ENU = 'End Date';
                    // trigger OnValidate()
                    // var
                    //     ErrorMessage: TextConst FRA = 'Vous devez entrer la date début', ENU = 'You must enter the start date';
                    // begin
                    //     IF "StartDate" = 0D THEN
                    //         ERROR(ErrorMessage);
                    //     InsertDeclaration();
                    // end;
                }


            }
            repeater(Group)
            {
                field(Export; Rec.Export)
                {
                    ApplicationArea = All;
                    CaptionML = FRA = 'Exporter', ENU = 'Export';
                    StyleExpr = FieldStyle;
                    trigger OnValidate()
                    var
                        lDeclarationRS: Record "WDC Withholding Tax Decl";
                    begin
                        lDeclarationRS.RESET;
                        lDeclarationRS.SETRANGE("Document No.", Rec."Document No.");
                        lDeclarationRS.SETFILTER("Invoice No.", '<>%1', '');
                        IF lDeclarationRS.FINDSET THEN
                            REPEAT
                                lDeclarationRS.Export := Rec.Export;
                                lDeclarationRS.MODIFY;
                            UNTIL (lDeclarationRS.NEXT = 0);
                    end;
                }
                field(Attribut; Rec.Attribute)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Type identifient Société"; Rec."Type of Company Identifier")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Identifient société"; Rec."Company Identifier")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Categorie Contribuable"; Rec."Taxpayer Category")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Année dépot"; Rec."Deposit Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Payment Month"; Rec."Payment Month")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Type of Beneficiary Identifier"; Rec."Type of Beneficiary Identifier")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Taxpayer Fiscal Number/ CIN"; Rec."Taxpayer Fiscal Number/ CIN")
                {
                    ApplicationArea = All;
                    // Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Categorie Contribuable Bénéficiaire"; Rec."Taxpayer Category Beneficiary")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field(birthdate; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Resident In Tunisia"; Rec."Resident In Tunisia")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Name and First Name"; Rec."Name and First Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field(Adresse; Rec.Address)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                // field("Activity"; Rec."Activity")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     StyleExpr = FieldStyle;
                // }
                field(EMail; Rec.EMail)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("TEJ Declaration No."; Rec."TEJ Declaration No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("ID Type Operation"; Rec."ID Type Operation")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Billing Year"; Rec."Billing Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field(CNPC; Rec.CNPC)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("P-Charge"; Rec."P-Charge")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Amount HT"; Rec."Amount HT")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Withholding Tax Rate"; Rec."Withholding Tax Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("VAT Rate"; Rec."VAT Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                    Visible = InclureVAT;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                    Visible = InclureVAT;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Montant RS"; Rec."Montant RS")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                // field("Tax additionnelle (Code)"; Rec."Tax additionnelle (Code)")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     StyleExpr = FieldStyle;
                //}
                // field("Tax additionnelle (taux)"; Rec."Tax additionnelle (taux)")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     StyleExpr = FieldStyle;
                // }
                field("Montant Net servi"; Rec."Montant Net servi")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Code devise"; Rec."Code devise")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Taux de change"; Rec."Taux de change")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Montant RS devise"; Rec."Montant RS devise")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Total Currency Amount"; Rec."Total Currency Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }
                field("Net Amount in Currency"; Rec."Net Amount in Currency")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = FieldStyle;
                }

            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(UpdateSerie)
            {
                applicationArea = All;
                captionML = ENU = 'Update Last Serie No.', FRA = 'MAJ dernier N° utilisé';
                PromotedIsBig = true;
                promotedcategory = Process;
                promoted = true;
                image = SerialNo;
                trigger OnAction()
                var
                    lNoSeriesLinesPage: page "No. Series Lines";
                    lNoSeriesLines: Record "No. Series Line";
                    LGLSetup: Record "General Ledger Setup";
                begin
                    LGLSetup.Get();
                    LGLSetup.TestField("TEJ Declaration No");
                    lNoSeriesLines.SetRange("Series Code", LGLSetup."TEJ Declaration No");
                    if lNoSeriesLines.FindFirst() then
                        lNoSeriesLinesPage.SetTableView(lNoSeriesLines);
                    lNoSeriesLinesPage.Run();

                end;
            }
            action(Apply)
            {
                captionML = ENU = 'Apply', FRA = 'Appliquer';
                applicationArea = All;
                PromotedIsBig = true;
                promotedcategory = Process;
                promoted = true;
                image = ApplyEntries;
                trigger OnAction()
                var
                    lText001: TextConst FRA = 'Vous devez saisir la date début',
                                        ENU = 'You must enter the start date';
                    lText002: TextConst FRA = 'Vous devez Saisir la date fin',
                                        ENU = 'You must enter the end date';
                begin
                    IF "StartDate" = 0D THEN
                        ERROR(lText001);
                    If EndDate = 0D then
                        ERROR(lText002);
                    InsertDeclaration();
                end;
            }
            action(SelectAll)
            {
                applicationArea = All;
                captionML = FRA = 'Sélect/Désélec. tout', ENU = 'Select/Deselect all';
                PromotedIsBig = true;
                promotedcategory = Process;
                promoted = true;
                image = SelectLineToApply;
                trigger OnAction()
                var
                    lDeclarationRS: Record "WDC Withholding Tax Decl";
                begin
                    SeelectDeselectAll;
                end;
            }
            action("Export XML")
            {
                ApplicationArea = All;
                CaptionML = FRA = 'Exporter en XML', ENU = 'Export to XML';
                Image = XMLFile;
                PromotedIsBig = true;
                promotedcategory = Process;
                promoted = true;
                trigger OnAction()
                begin
                    CreateXMLFile()
                end;
            }
        }
    }
    trigger OnInit()
    begin
        CompanyInformation.GET();
        Rec."Company Identifier" := COPYSTR(CompanyInformation."VAT Registration No.", 1, 8);
        DocNo := '';
        CompGenNo := '';
    end;

    trigger OnOpenPage()
    var
        lDeclarationRS: Record "WDC Withholding Tax Decl";
    begin
        lDeclarationRS.DeleteAll();
        CompanyInformation.GET();
        GeneralLedgerSetup.Get();
        if GeneralLedgerSetup."Incl VAT Withholding Tax Decl" then begin
            InclureVAT := true;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        IF Rec."Invoice No." <> '' THEN
            FieldStyle := 'Unfavorable'
        ELSE
            FieldStyle := 'Strong';
    end;



    var
        SelectedAll: Boolean;
        GLSetup: Record "General Ledger Setup";

    procedure SeelectDeselectAll()
    begin
        If Not SelectedAll then begin
            Rec.ModifyAll(Rec.Export, true);
            SelectedAll := true;

        end Else begin
            SelectedAll := false;
            Rec.ModifyAll(Rec.Export, false);
        end;
        CurrPage.Update;
    end;

    procedure InsertDeclaration()
    var
        lVendorLedgerEntry: Record "Vendor Ledger Entry";
        lVendorLedgerEntry1: Record "Vendor Ledger Entry";
        lVendor: Record Vendor;
        lDetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        lDeclarationRS: Record "WDC Withholding Tax Decl";
        lDeclarationRS1: Record "WDC Withholding Tax Decl";

    begin
        GLSetup.get;
        lDeclarationRS.DeleteAll();
        SeqNo := 1;
        CLEAR(GLEntry);
        GLEntry.SETCURRENTKEY("G/L Account No.", "Document No.", "Posting Date");
        GLEntry.SETFILTER("G/L Account No.", GeneralLedgerSetup."Withholding Tax Accounts");
        GLEntry.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
        //GLEntry.SETRANGE("Entry Type", GLEntry."Entry Type"::Definitive);
        //GLEntry.SetRange("Document No.", 'REG260245');
        IF GLEntry.FINDSET THEN BEGIN
            REPEAT
                IF (DocNo <> GLEntry."Document No.") OR (CompGenNo <> GLEntry."G/L Account No.") THEN BEGIN
                    TotalMontantHT := 0;
                    TotalNetService := 0;
                    TotalMontantRS := 0;
                    TotalMontantTTC := 0;
                    TotalMontantTVA := 0;
                    TotalRSDevise := 0;
                    TotalTTCDevise := 0;
                    TotalNetServiceDevise := 0;
                    DocNo := GLEntry."Document No.";
                    CompGenNo := GLEntry."G/L Account No.";
                    MntDoc := 0;
                    lVendorLedgerEntry.Reset();
                    lVendorLedgerEntry.SetCurrentKey("Document No.");
                    lVendorLedgerEntry.SETRANGE("Document No.", GLEntry."Document No.");
                    lVendorLedgerEntry.Setfilter("Vendor No.", '<>%1', 'FRS-00073');
                    IF lVendorLedgerEntry.FindLast() THEN begin
                        lVendorLedgerEntry.CALCFIELDS(Amount);
                        MntDoc += lVendorLedgerEntry.Amount;
                    end;
                    IF MntDoc <> 0 THEN BEGIN
                        lDeclarationRS.INIT;
                        lDeclarationRS."Entry No." := SeqNo;
                        lDeclarationRS.Attribute := 1;
                        lDeclarationRS."Type of Company Identifier" := 1;
                        lDeclarationRS."Taxpayer Category" := 'PM';
                        lDeclarationRS."Company Identifier" := COPYSTR(CompanyInformation."VAT Registration No.", 1, 8);


                        if generalLedgerSetup.CNPC = generalLedgerSetup.CNPC::"l''opération de retenue à la source a été effectuée en vertu d''une convention de non double imposition" then
                            lDeclarationRS.CNPC := 1
                        else
                            lDeclarationRS.CNPC := 0;
                        If generalLedgerSetup.P_Charge = generalLedgerSetup.P_Charge::"La retenue à la source a été prise en charge" then
                            lDeclarationRS."P-Charge" := 1
                        else
                            lDeclarationRS."P-Charge" := 0;
                        if GeneralLedgerSetup."Incl VAT Withholding Tax Decl" then begin
                            lDeclarationRS."Tax additionnelle (Code)" := 'RSTVA100';
                            lDeclarationRS."Tax additionnelle (taux)" := 100;
                        end;
                        //lDeclarationRS."Deposit Year" := '20' + COPYSTR(FORMAT(GLEntry."Posting Date"), 7, 4);
                        lDeclarationRS."Deposit Year" := FORMAT(DATE2DMY(GLEntry."Posting Date", 3));
                        lDeclarationRS."Payment Month" := COPYSTR(FORMAT(GLEntry."Posting Date"), 4, 2);
                        GLAccount.GET(GLEntry."G/L Account No.");
                        lDeclarationRS."ID Type Operation" := GLAccount."ID Type Operation";
                        IF FORMAT(GLAccount."Withholding Tax Code") <> '' THEN BEGIN
                            WithholdingTax.RESET;
                            WithholdingTax.SETRANGE(Code, GLAccount."Withholding Tax Code");
                            IF WithholdingTax.FINDFIRST() THEN
                                lDeclarationRS."Withholding Tax Rate" := WithholdingTax."% Withholding Tax";
                            //EVALUATE(lDeclarationRS."Withholding Tax Rate",DELCHR(FORMAT(GLAccount."Withholding Tax Code"),'=','%'));
                        END;
                        lDeclarationRS."Document No." := GLEntry."Document No.";                                  //HD
                        lDeclarationRS."TEJ Declaration No." := NoSeries.GetNextNo(GLSetup."TEJ Declaration No"); //HD
                        lDeclarationRS."G/L Account No." := GLEntry."G/L Account No.";
                        lDeclarationRS."Payment Date" := FORMAT(GLEntry."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');

                        lVendorLedgerEntry1.RESET;
                        lVendorLedgerEntry1.SetCurrentKey("Document No.");
                        lVendorLedgerEntry1.SETRANGE("Document No.", GLEntry."Document No.");
                        IF lVendorLedgerEntry1.FINDLAST THEN BEGIN
                            lVendor.GET(lVendorLedgerEntry1."Vendor No.");
                            lDeclarationRS."Taxpayer Fiscal Number/ CIN" := COPYSTR(lVendor."VAT Registration No.", 1, 8);
                            if lVendor."Identification Type" = lVendor."Identification Type"::CIN then Begin
                                lVendor.TestField("Birth Date");
                                lDeclarationRS."Birth Date" := lVendor."Birth Date";
                            End;
                            IF lVendor."Vendor Type" = lVendor."Vendor Type"::"Personne Morale" THEN Begin
                                lDeclarationRS."Type of Beneficiary Identifier" := 1;
                                lDeclarationRS."Taxpayer Category Beneficiary" := 'PM'
                            END ELSE IF lVendor."Vendor Type" = lVendor."Vendor Type"::"Personne Physique" THEN Begin
                                lDeclarationRS."Type of Beneficiary Identifier" := 2;
                                lDeclarationRS."Taxpayer Category Beneficiary" := 'PP';
                            End;
                            lDeclarationRS."Name and First Name" := lVendor.Name;
                            if lVendor."Resident" = lVendor."Resident"::Resident then
                                lDeclarationRS."Resident In Tunisia" := 1
                            else
                                lDeclarationRS."Resident In Tunisia" := 0;
                            lDeclarationRS.EMail := lVendor."E-Mail";
                            //lDeclarationRS.Activity := lVendor.Activity;
                            lDeclarationRS."Phone Number" := lVendor."Phone No.";
                            lDeclarationRS.Address := lVendor.City;
                            lDeclarationRS."Billing Year" := FORMAT(DATE2DMY(GLEntry."Posting Date", 3));
                            lDeclarationRS.INSERT;

                            lDetailedVendorLedgEntry.RESET;
                            lDetailedVendorLedgEntry.SetCurrentKey("Document No.", "Document Type", "Posting Date");
                            lDetailedVendorLedgEntry.SETRANGE("Document No.", lVendorLedgerEntry1."Document No.");
                            lDetailedVendorLedgEntry.SETRANGE("Entry Type", lDetailedVendorLedgEntry."Entry Type"::Application);
                            lDetailedVendorLedgEntry.SETRANGE("Initial Document Type", lDetailedVendorLedgEntry."Initial Document Type"::Payment);
                            IF lDetailedVendorLedgEntry.FINDSET THEN BEGIN
                                CreditAdded := FALSE;
                                IF (lDetailedVendorLedgEntry.COUNT = 1) THEN BEGIN
                                    InsertInv(lVendorLedgerEntry1, lDeclarationRS);
                                END ELSE BEGIN
                                    InsertFromVendorLedEntry(lDetailedVendorLedgEntry, lDeclarationRS);
                                END;
                            END ELSE
                                InsertInv(lVendorLedgerEntry1, lDeclarationRS);
                        END;
                    END;

                    lDeclarationRS1.RESET();
                    lDeclarationRS1.SETRANGE("Document No.", GLEntry."Document No.");
                    lDeclarationRS1.SETRANGE("G/L Account No.", GLEntry."G/L Account No.");
                    lDeclarationRS1.SETFILTER("Invoice No.", '');
                    IF lDeclarationRS1.FINDSET THEN BEGIN
                        CurrencyExchangeRate.RESET;
                        CurrencyExchangeRate.SETRANGE("Currency Code", GLEntry."Source Currency Code");
                        if CurrencyExchangeRate.FINDSET then begin
                            lDeclarationRS1."Code devise" := CurrencyExchangeRate."Currency Code";
                            lDeclarationRS1."Taux de change" := CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";
                        end;
                        lDeclarationRS1."Amount HT" := TotalMontantHT;
                        lDeclarationRS1."Montant RS" := TotalMontantRS;
                        lDeclarationRS1."Total Amount" := TotalMontantTTC;
                        lDeclarationRS1."VAT Amount" := TotalMontantTVA;
                        lDeclarationRS1."Montant Net servi" := TotalNetService;
                        lDeclarationRS1."Montant RS devise" := TotalRSDevise;
                        lDeclarationRS1."Total Currency Amount" := TotalTTCDevise;
                        lDeclarationRS1."Net Amount in Currency" := TotalNetServiceDevise;
                        IF TotalMontantHT <> 0 THEN
                            lDeclarationRS1."VAT Rate" := TotalMontantTVA * 100 / TotalMontantHT;
                        lDeclarationRS1.MODIFY;
                    END;
                END;
                SeqNo += 1;
            UNTIL (GLEntry.NEXT = 0);
        END;
    end;


    LOCAL PROCEDURE InsertInv(pVendorLedgerEntry: Record "Vendor Ledger Entry"; pDeclarationRS: Record "WDC Withholding Tax Decl");
    VAR
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        DetailedVendorLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        lDetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        lDetailedVendorLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        lDetailedVendorLedgEntry2: Record "Detailed Vendor Ledg. Entry";
    BEGIN
        CLEAR(DetailedVendorLedgEntry);
        DetailedVendorLedgEntry.SetCurrentKey("Document No.", "Document Type", "Posting Date");
        DetailedVendorLedgEntry.SETRANGE("Document No.", pVendorLedgerEntry."Document No.");
        DetailedVendorLedgEntry.SETRANGE("Entry Type", DetailedVendorLedgEntry."Entry Type"::Application);
        DetailedVendorLedgEntry.SETRANGE("Initial Document Type", DetailedVendorLedgEntry."Initial Document Type"::Invoice);
        DetailedVendorLedgEntry.SETRANGE(Unapplied, FALSE);
        IF DetailedVendorLedgEntry.FINDSET THEN BEGIN
            REPEAT
                lDetailedVendorLedgEntry.RESET;
                lDetailedVendorLedgEntry.SetCurrentKey("Vendor Ledger Entry No.", "Entry Type", "Posting Date");
                lDetailedVendorLedgEntry.SETRANGE("Vendor Ledger Entry No.", DetailedVendorLedgEntry."Vendor Ledger Entry No.");
                lDetailedVendorLedgEntry.SETRANGE("Entry Type", lDetailedVendorLedgEntry."Entry Type"::Application);
                IF lDetailedVendorLedgEntry.COUNT > 1 THEN BEGIN
                    lDetailedVendorLedgEntry1.RESET;
                    lDetailedVendorLedgEntry1.SetCurrentKey("Document No.", "Document Type", "Posting Date");
                    lDetailedVendorLedgEntry1.SETRANGE("Document No.", GLEntry."Document No.");
                    lDetailedVendorLedgEntry1.SETRANGE("Vendor Ledger Entry No.", DetailedVendorLedgEntry."Vendor Ledger Entry No.");
                    lDetailedVendorLedgEntry1.SETRANGE("Entry Type", lDetailedVendorLedgEntry."Entry Type"::Application);
                    lDetailedVendorLedgEntry1.CALCSUMS(Amount);
                    IF lDetailedVendorLedgEntry1.Amount <> 0 THEN BEGIN
                        DetailedVendorLedgEntry1.RESET;
                        DetailedVendorLedgEntry1.SetCurrentKey("Vendor Ledger Entry No.", "Ledger Entry Amount", "Posting Date");
                        DetailedVendorLedgEntry1.SETRANGE("Vendor Ledger Entry No.", DetailedVendorLedgEntry."Vendor Ledger Entry No.");
                        DetailedVendorLedgEntry1.SETRANGE("Ledger Entry Amount", TRUE);
                        DetailedVendorLedgEntry1.SETRANGE(Unapplied, FALSE);
                        IF DetailedVendorLedgEntry1.FINDSET THEN
                            //InsertFromPaymentCHQ(DetailedVendorLedgEntry1."Document No.", pDeclarationRS)
                            InsertFromVendorLedEntry(DetailedVendorLedgEntry1, pDeclarationRS);
                    END;
                END ELSE BEGIN
                    DetailedVendorLedgEntry1.RESET;
                    DetailedVendorLedgEntry1.SetCurrentKey("Vendor Ledger Entry No.", "Ledger Entry Amount", "Posting Date");
                    DetailedVendorLedgEntry1.SETRANGE("Vendor Ledger Entry No.", DetailedVendorLedgEntry."Vendor Ledger Entry No.");
                    DetailedVendorLedgEntry1.SETRANGE("Ledger Entry Amount", TRUE);
                    DetailedVendorLedgEntry1.SETRANGE(Unapplied, FALSE);
                    IF DetailedVendorLedgEntry1.FINDSET THEN
                        REPEAT
                            InsertFromPurchInv(pDeclarationRS, DetailedVendorLedgEntry1);
                        UNTIL (DetailedVendorLedgEntry1.NEXT = 0);
                END;
            UNTIL (DetailedVendorLedgEntry.NEXT = 0);
        END
        ELSE BEGIN
            // InsertFromPayment(pDeclarationRS);
            CLEAR(DetailedVendorLedgEntry);
            DetailedVendorLedgEntry.SetCurrentKey("Document No.", "Document Type", "Posting Date");
            DetailedVendorLedgEntry.SETRANGE("Document No.", pVendorLedgerEntry."Document No.");
            if DetailedVendorLedgEntry.FINDSET() then
                InsertFromVendorLedEntry(DetailedVendorLedgEntry, pDeclarationRS);
        END;
    END;

    LOCAL PROCEDURE InsertFromPurchInv(pDeclarationRS: Record "WDC Withholding Tax Decl"; pDetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry");
    VAR
        lDeclarationRS: Record "WDC Withholding Tax Decl";
        lPurchaseInvHeader: Record "Purch. Inv. Header";
        lPurchaseInvLine: Record "Purch. Inv. Line";
        lDetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        lGeneralLedgerSetup: Record "General Ledger Setup";
        lAmountTTC: Decimal;
    BEGIN
        lGeneralLedgerSetup.GET;
        SeqNo += 1;
        lDeclarationRS.COPY(pDeclarationRS);
        lDeclarationRS."Entry No." := SeqNo;
        lDeclarationRS."Invoice No." := pDetailedVendorLedgEntry."Document No.";
        lPurchaseInvHeader.RESET;
        IF lPurchaseInvHeader.GET(pDetailedVendorLedgEntry."Document No.") THEN BEGIN
            lDeclarationRS."Amount HT" := 0;
            lDeclarationRS."Montant Net servi" := 0;
            lDeclarationRS."Net Amount in Currency" := 0;
            lDeclarationRS."Montant RS devise" := 0;
            lDeclarationRS."Total Amount" := 0;
            lDeclarationRS."Total Currency Amount" := 0;
            lDeclarationRS."VAT Amount" := 0;
            lPurchaseInvHeader.CALCFIELDS(Amount, "Amount Including VAT");
            CLEAR(lPurchaseInvLine);
            lPurchaseInvLine.SETRANGE("Document No.", lPurchaseInvHeader."No.");
            if lGeneralLedgerSetup."Purch. Stamp Account No." <> '' then
                lPurchaseInvLine.SETFILTER("No.", '<>%1', lGeneralLedgerSetup."Purch. Stamp Account No.");
            lPurchaseInvLine.SETFILTER(Amount, '<>%1', 0);
            IF lPurchaseInvLine.FINDSET THEN
                REPEAT
                    lDeclarationRS."Amount HT" += lPurchaseInvLine.Amount;
                    lDeclarationRS."Amount HT" := ROUND(lDeclarationRS."Amount HT", 0.001, '<');
                    lDeclarationRS."VAT Rate" := lPurchaseInvLine."VAT %";
                UNTIL lPurchaseInvLine.NEXT = 0;

            if lPurchaseInvHeader."Currency Factor" <> 0 then
                lDeclarationRS."Amount HT" := lDeclarationRS."Amount HT" / lPurchaseInvHeader."Currency Factor";//HD on a ajouté au pour les facture en devise
            lDeclarationRS."Amount HT" := ROUND(lDeclarationRS."Amount HT", 0.001, '<'); //HD

            lDeclarationRS."VAT Amount" := ROUND(lDeclarationRS."Amount HT", 0.001, '<') * lDeclarationRS."VAT Rate" / 100;
            lDeclarationRS."VAT Amount" := ROUND(lDeclarationRS."VAT Amount", 0.001, '<');

            lDeclarationRS."Total Amount" := ROUND(lDeclarationRS."Amount HT", 0.001, '<') + ROUND(lDeclarationRS."VAT Amount", 0.001, '<');
            lDeclarationRS."Total Amount" := ROUND(lDeclarationRS."Total Amount", 0.001, '<');

            lDeclarationRS."Montant RS" := ROUND(lDeclarationRS."Total Amount", 0.001, '<') * lDeclarationRS."Withholding Tax Rate" / 100;
            lDeclarationRS."Montant RS" := ROUND(lDeclarationRS."Montant RS", 0.001, '<');

            lDeclarationRS."Montant Net servi" := ROUND(lDeclarationRS."Total Amount", 0.001, '<') - ROUND(lDeclarationRS."Montant RS", 0.001, '<');
            lDeclarationRS."Montant Net servi" := ROUND(lDeclarationRS."Montant Net servi", 0.001, '<');

            lAmountTTC := 0;
            IF NOT CreditAdded THEN BEGIN
                lDetailedVendorLedgEntry.RESET();
                lDetailedVendorLedgEntry.SetCurrentKey("Document No.", "Document Type", "Posting Date");
                lDetailedVendorLedgEntry.SETRANGE("Document No.", pDetailedVendorLedgEntry."Document No.");
                lDetailedVendorLedgEntry.SETRANGE("Initial Document Type", lDetailedVendorLedgEntry."Initial Document Type"::"Credit Memo");
                lDetailedVendorLedgEntry.SETRANGE("Transaction No.", pDetailedVendorLedgEntry."Transaction No.");
                IF lDetailedVendorLedgEntry.FINDSET() THEN BEGIN
                    REPEAT
                        //lAmountTTC += lDetailedVendorLedgEntry.Amount; //Cmt HD
                        lAmountTTC += lDetailedVendorLedgEntry."Amount (LCY)"; //HD
                    UNTIL (lDetailedVendorLedgEntry.NEXT) = 0;
                    IF lAmountTTC < lDeclarationRS."Total Amount" THEN BEGIN
                        CreditAdded := TRUE;
                        lDeclarationRS."Total Amount" += lAmountTTC;
                        lDeclarationRS."Total Amount" := ROUND(lDeclarationRS."Total Amount", 0.001, '<');
                        lDeclarationRS."Montant RS" := ROUND(lDeclarationRS."Total Amount", 0.001, '<') * lDeclarationRS."Withholding Tax Rate" / 100;
                        lDeclarationRS."Montant RS" := ROUND(lDeclarationRS."Montant RS", 0.001, '<');
                        lDeclarationRS."Montant Net servi" := ROUND(lDeclarationRS."Total Amount", 0.001, '<') - ROUND(lDeclarationRS."Montant RS", 0.001, '<');
                        lDeclarationRS."Montant Net servi" := ROUND(lDeclarationRS."Montant Net servi", 0.001, '<');
                        lDeclarationRS."Amount HT" := 100 * ROUND(lDeclarationRS."Total Amount", 0.001, '<') / (100 + lDeclarationRS."VAT Rate");
                        lDeclarationRS."Amount HT" := ROUND(lDeclarationRS."Amount HT", 0.001, '<');
                        lDeclarationRS."VAT Amount" := ROUND(lDeclarationRS."Amount HT", 0.001, '<') * lDeclarationRS."VAT Rate" / 100;
                        lDeclarationRS."VAT Amount" := ROUND(lDeclarationRS."VAT Amount", 0.001, '<');
                        IF (ROUND(lDeclarationRS."Amount HT", 0.001, '<') + ROUND(lDeclarationRS."VAT Amount", 0.001, '<') <> ROUND(lDeclarationRS."Total Amount", 0.001, '<')) THEN BEGIN
                            lDeclarationRS."Total Amount" := ROUND(lDeclarationRS."Amount HT", 0.001, '<') + ROUND(lDeclarationRS."VAT Amount", 0.001, '<');
                            lDeclarationRS."Montant RS" := lDeclarationRS."Total Amount" * lDeclarationRS."Withholding Tax Rate" / 100;
                            lDeclarationRS."Montant RS" := ROUND(lDeclarationRS."Montant RS", 0.001, '<');
                            lDeclarationRS."Montant Net servi" := ROUND(lDeclarationRS."Total Amount", 0.001, '<') - ROUND(lDeclarationRS."Montant RS", 0.001, '<');
                            lDeclarationRS."Montant Net servi" := ROUND(lDeclarationRS."Montant Net servi", 0.001, '<');
                        END;
                    END;
                END;
            END;
            TotalMontantHT += ROUND(lDeclarationRS."Amount HT", 0.001, '<');
            TotalMontantTVA += ROUND(lDeclarationRS."VAT Amount", 0.001, '<');
            TotalMontantTTC += ROUND(lDeclarationRS."Total Amount", 0.001, '<');
            TotalMontantRS += ROUND(lDeclarationRS."Montant RS", 0.001, '<');
            TotalNetService += ROUND(lDeclarationRS."Montant Net servi", 0.001, '<');
            lDeclarationRS."Billing Year" := FORMAT(DATE2DMY(lPurchaseInvHeader."Posting Date", 3));
            CurrencyCode := lPurchaseInvHeader."Currency Code";
            IF CurrencyCode <> '' THEN BEGIN
                IF Currency.GET(CurrencyCode) THEN;
                CurrencyExchangeRate.RESET;
                CurrencyExchangeRate.SETRANGE("Currency Code", Currency.Code);
                IF CurrencyExchangeRate.FINDSET THEN BEGIN
                    lDeclarationRS."Code devise" := Currency.Code;
                    lDeclarationRS."Taux de change" := CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";

                    //<< Cmt HD
                    // lDeclarationRS."Montant RS devise" := lDeclarationRS."Montant RS" * CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";
                    // lDeclarationRS."Montant RS devise" := ROUND(lDeclarationRS."Montant RS devise", 0.001, '<');
                    // lDeclarationRS."Total Currency Amount" := lDeclarationRS."Total Amount" * CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";
                    // lDeclarationRS."Total Currency Amount" := ROUND(lDeclarationRS."Total Currency Amount", 0.001, '<');
                    // lDeclarationRS."Net Amount in Currency" := lDeclarationRS."Montant Net servi" * CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";
                    // lDeclarationRS."Net Amount in Currency" := ROUND(lDeclarationRS."Net Amount in Currency", 0.001, '<');
                    // TotalRSDevise += lDeclarationRS."Montant RS devise";
                    // TotalTTCDevise += lDeclarationRS."Total Currency Amount";
                    // TotalNetServiceDevise += lDeclarationRS."Net Amount in Currency";
                    //>>Cmt HD

                    //<<HD
                    lDeclarationRS."Montant RS devise" := ROUND(lPurchaseInvHeader."Amount Including VAT", 0.001, '<') * lDeclarationRS."Withholding Tax Rate" / 100;
                    lDeclarationRS."Montant RS devise" := ROUND(lDeclarationRS."Montant RS devise", 0.001, '<');

                    lDeclarationRS."Total Currency Amount" := lPurchaseInvHeader."Amount Including VAT";
                    lDeclarationRS."Total Currency Amount" := ROUND(lDeclarationRS."Total Currency Amount", 0.001, '<');

                    lDeclarationRS."Net Amount in Currency" := lDeclarationRS."Total Currency Amount" - lDeclarationRS."Montant RS devise";
                    lDeclarationRS."Net Amount in Currency" := ROUND(lDeclarationRS."Net Amount in Currency", 0.001, '<');
                    TotalRSDevise += lDeclarationRS."Montant RS devise";
                    TotalTTCDevise += lDeclarationRS."Total Currency Amount";
                    TotalNetServiceDevise += lDeclarationRS."Net Amount in Currency";
                    //>>HD
                END;
            END;
            lDeclarationRS.INSERT;
        END;
    END;

    LOCAL PROCEDURE InsertFromVendorLedEntry(pDetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry"; pDeclarationRS: Record "WDC Withholding Tax Decl");
    VAR
        lDeclarationRS: Record "WDC Withholding Tax Decl";
        lVendorLedgEntry: Record 25;
        lDetailedVendorLedgEntry: Record 380;
        lDetailedVendorLedgEntry1: Record 380;
        InvoiceNo: Code[20];
        MntTTc: Decimal;
    BEGIN
        //REPEAT
        IF lVendorLedgEntry.GET(pDetailedVendorLedgEntry."Vendor Ledger Entry No.") THEN BEGIN
            SeqNo += 1;
            lDeclarationRS.COPY(pDeclarationRS);
            lDeclarationRS."Entry No." := SeqNo;

            CLEAR(lDetailedVendorLedgEntry);
            lDetailedVendorLedgEntry.SETRANGE("Document No.", lVendorLedgEntry."Document No.");
            lDetailedVendorLedgEntry.SETRANGE("Entry Type", lDetailedVendorLedgEntry."Entry Type"::Application);
            lDetailedVendorLedgEntry.SETRANGE("Initial Document Type", lDetailedVendorLedgEntry."Initial Document Type"::Invoice);
            IF lDetailedVendorLedgEntry.FINDSET THEN BEGIN
                lDetailedVendorLedgEntry1.RESET;
                lDetailedVendorLedgEntry1.SETRANGE("Vendor Ledger Entry No.", lDetailedVendorLedgEntry."Vendor Ledger Entry No.");
                lDetailedVendorLedgEntry1.SETRANGE("Ledger Entry Amount", TRUE);
                lDetailedVendorLedgEntry1.SETRANGE(Unapplied, FALSE);
                IF lDetailedVendorLedgEntry1.FINDSET THEN
                    InvoiceNo := lDetailedVendorLedgEntry1."Document No."
                ELSE
                    InvoiceNo := lVendorLedgEntry."Document No.";
            END;
            IF InvoiceNo = '' THEN
                lDeclarationRS."Invoice No." := lVendorLedgEntry."Document No."
            ELSE
                lDeclarationRS."Invoice No." := InvoiceNo;

            lDeclarationRS."Montant RS" := 0;
            lDeclarationRS."Amount HT" := 0;
            lDeclarationRS."Montant Net servi" := 0;
            lDeclarationRS."Total Amount" := 0;
            lDeclarationRS."VAT Amount" := 0;

            lVendorLedgEntry.CALCFIELDS(Amount);
            lVendorLedgEntry.CALCFIELDS("Amount (LCY)");
            lDeclarationRS."Billing Year" := FORMAT(DATE2DMY(lVendorLedgEntry."Posting Date", 3));
            //MntTTc := lVendorLedgEntry.Amount; //Cmt HD
            MntTTc := lVendorLedgEntry."Amount (LCY)";//HD
            if MntTTc < 0 then
                MntTTc := -MntTTc;
            lDeclarationRS."Total Amount" := MntTTc;

            lDeclarationRS."Montant RS" := ROUND(lDeclarationRS."Total Amount", 0.001, '<') * lDeclarationRS."Withholding Tax Rate" / 100;
            lDeclarationRS."Montant RS" := ROUND(lDeclarationRS."Montant RS", 0.001, '<');

            lDeclarationRS."Montant Net servi" := ROUND(lDeclarationRS."Total Amount", 0.001, '<') - ROUND(lDeclarationRS."Montant RS", 0.001, '<');
            lDeclarationRS."Montant Net servi" := ROUND(lDeclarationRS."Montant Net servi", 0.001, '<');

            lDeclarationRS."VAT Rate" := 0;
            lDeclarationRS."Amount HT" := 100 * ROUND(lDeclarationRS."Total Amount", 0.001, '<') / (100 + lDeclarationRS."VAT Rate");
            lDeclarationRS."Amount HT" := ROUND(lDeclarationRS."Amount HT", 0.001, '<');
            TotalMontantHT += ROUND(lDeclarationRS."Amount HT", 0.001, '<');

            lDeclarationRS."VAT Amount" := ROUND(lDeclarationRS."Amount HT", 0.001, '<') * lDeclarationRS."VAT Rate" / 100;
            lDeclarationRS."VAT Amount" := ROUND(lDeclarationRS."VAT Amount", 0.001, '<');
            TotalMontantTVA += ROUND(lDeclarationRS."VAT Amount", 0.001, '<');
            //
            IF (ROUND(lDeclarationRS."Amount HT", 0.001, '<') + ROUND(lDeclarationRS."VAT Amount", 0.001, '<') <> ROUND(lDeclarationRS."Total Amount", 0.001, '<')) THEN BEGIN
                lDeclarationRS."Total Amount" := ROUND(lDeclarationRS."Amount HT", 0.001, '<') + ROUND(lDeclarationRS."VAT Amount", 0.001, '<');
                lDeclarationRS."Montant RS" := lDeclarationRS."Total Amount" * lDeclarationRS."Withholding Tax Rate" / 100;
                lDeclarationRS."Montant RS" := ROUND(lDeclarationRS."Montant RS", 0.001, '<');
                lDeclarationRS."Montant Net servi" := ROUND(lDeclarationRS."Total Amount", 0.001, '<') - ROUND(lDeclarationRS."Montant RS", 0.001, '<');
                lDeclarationRS."Montant Net servi" := ROUND(lDeclarationRS."Montant Net servi", 0.001, '<');
            END;
            CurrencyCode := lVendorLedgEntry."Currency Code";
            IF CurrencyCode <> '' THEN BEGIN
                IF Currency.GET(CurrencyCode) THEN;
                CurrencyExchangeRate.RESET;
                CurrencyExchangeRate.SETRANGE("Currency Code", Currency.Code);
                IF CurrencyExchangeRate.FINDSET THEN BEGIN
                    lDeclarationRS."Code devise" := Currency.Code;
                    lDeclarationRS."Taux de change" := CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";
                    lDeclarationRS."Montant RS devise" := lDeclarationRS."Montant RS" * CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";
                    lDeclarationRS."Montant RS devise" := ROUND(lDeclarationRS."Montant RS devise", 0.001, '<');
                    lDeclarationRS."Total Currency Amount" := lDeclarationRS."Total Amount" * CurrencyExchangeRate."Relational Adjmt Exch Rate Amt"; //CMt HD
                    lDeclarationRS."Total Currency Amount" := ROUND(lDeclarationRS."Total Currency Amount", 0.001, '<');
                    lDeclarationRS."Net Amount in Currency" := lDeclarationRS."Montant Net servi" * CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";
                    lDeclarationRS."Net Amount in Currency" := ROUND(lDeclarationRS."Net Amount in Currency", 0.001, '<');
                    TotalRSDevise += lDeclarationRS."Montant RS devise";
                    TotalTTCDevise += lDeclarationRS."Total Currency Amount";
                    TotalNetServiceDevise += lDeclarationRS."Net Amount in Currency";
                END;
            END;

            TotalMontantTTC += ROUND(lDeclarationRS."Total Amount", 0.001, '<');
            TotalMontantRS += ROUND(lDeclarationRS."Montant RS", 0.001, '<');
            TotalNetService += ROUND(lDeclarationRS."Montant Net servi", 0.001, '<');
            //
            lDeclarationRS.INSERT;
        END;
        // UNTIL (pDetailedVendorLedgEntry.NEXT) = 0;
    END;

    procedure createXMLFile()
    var
        Options: Text;
        NomFichier: Text;
        acteDepot: Integer;
        AcDep: Integer;
        DeclarationRS: Record "WDC Withholding Tax Decl";
        DeclarationRS1: Record "WDC Withholding Tax Decl";
        DeclarationRS2: Record "WDC Withholding Tax Decl";
        FileName: File;
        FileManagement: Codeunit "File Management";
        tmpBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        CRLF: Text[2];
        lText001: textconst ENU = 'You have to select at least one record to generate the XML file.',
                            FRA = 'Vous devez sélectionner au moins un enregistrement pour générer le fichier XML.';
    begin
        DeclarationRS.RESET;
        DeclarationRS.SETRANGE(Export, TRUE);
        IF DeclarationRS.FINDSET THEN BEGIN
            GeneralLedgerSetup.get;
            Options := 'AjouterCertificats,ModifierCertificats,AnnulerCertificats';
            acteDepot := DIALOG.STRMENU(Options);
            IF acteDepot <> 0 THEN
                AcDep := acteDepot - 1;

            tmpBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
            //creaion balise entête
            OutStr.WriteText('<?xml version="1.0" encoding="UTF-8"?>' + CRLF);
            OutStr.WriteText('<DeclarationsRS VersionSchema="1.0">' + CRLF);
            //@@@ DECLARANT (2)
            OutStr.WriteText(PADSTR('', 1) + '<Declarant>' + CRLF);
            OutStr.WriteText(PADSTR('', 2) + '<TypeIdentifiant>' + FORMAT(DeclarationRS."Type of Company Identifier") + '</TypeIdentifiant>' + CRLF);
            OutStr.WriteText(PADSTR('', 2) + '<Identifiant>' + DeclarationRS."Company Identifier" + '</Identifiant>' + CRLF);
            OutStr.WriteText(PADSTR('', 2) + '<CategorieContribuable>' + DeclarationRS."Taxpayer Category" + '</CategorieContribuable>' + CRLF);
            OutStr.WriteText(PADSTR('', 1) + '</Declarant>' + CRLF);

            //@@@ ReferenceDeclaration(2)
            OutStr.WriteText(PADSTR('', 1) + '<ReferenceDeclaration>' + CRLF);
            OutStr.WriteText(PADSTR('', 2) + '<ActeDepot>' + FORMAT(AcDep) + '</ActeDepot>' + CRLF);
            OutStr.WriteText(PADSTR('', 2) + '<AnneeDepot>' + DeclarationRS."Deposit Year" + '</AnneeDepot>' + CRLF);
            OutStr.WriteText(PADSTR('', 2) + '<MoisDepot>' + DeclarationRS."Payment Month" + '</MoisDepot>' + CRLF);
            OutStr.WriteText(PADSTR('', 1) + '</ReferenceDeclaration>' + CRLF);
            //@@@ AjouterCertificats(I)
            OutStr.WriteText(PADSTR('', 1) + '<AjouterCertificats>' + CRLF);
            DeclarationRS1.RESET;
            DeclarationRS1.SETRANGE(Export, TRUE);
            DeclarationRS1.SETRANGE("Invoice No.", '');
            IF DeclarationRS1.FINDSET THEN BEGIN
                REPEAT
                    //@@@Certificat
                    OutStr.WriteText(PADSTR('', 2) + '<Certificat>' + CRLF);
                    OutStr.WriteText(PADSTR('', 3) + '<Beneficiaire>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<IdTaxpayer>' + CRLF);
                    IF DeclarationRS1."Type of Beneficiary Identifier" = 1 THEN BEGIN
                        OutStr.WriteText(PADSTR('', 5) + '<MatriculeFiscal>' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<TypeIdentifiant>' + FORMAT(DeclarationRS1."Type of Beneficiary Identifier") + '</TypeIdentifiant>' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<Identifiant>' + DeclarationRS1."Taxpayer Fiscal Number/ CIN" + '</Identifiant>' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<CategorieContribuable>' + DeclarationRS1."Taxpayer Category Beneficiary" + '</CategorieContribuable>' + CRLF);
                        OutStr.WriteText(PADSTR('', 5) + '</MatriculeFiscal>' + CRLF);
                    END ELSE BEGIN
                        OutStr.WriteText(PADSTR('', 5) + '<CIN>' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<TypeIdentifiant>' + FORMAT(DeclarationRS1."Type of Beneficiary Identifier") + '</TypeIdentifiant>' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<Identifiant>' + DeclarationRS1."Taxpayer Fiscal Number/ CIN" + '</Identifiant>' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<DateNaissance>' + FORMAT(DeclarationRS1."Birth Date", 0, '<Day,2>/<Month,2>/<Year4,4>') + '</DateNaissance>' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<CategorieContribuable>' + DeclarationRS1."Taxpayer Category Beneficiary" + '</CategorieContribuable>' + CRLF);
                        OutStr.WriteText(PADSTR('', 5) + '</CIN>' + CRLF);
                    END;

                    OutStr.WriteText(PADSTR('', 4) + '</IdTaxpayer>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<Resident>' + FORMAT(DeclarationRS1."Resident In Tunisia") + '</Resident>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<NometprenonOuRaisonsociale>' + fncConvCaracSpec(DeclarationRS1."Name and First Name") + '</NometprenonOuRaisonsociale>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<Adresse>' + fncConvCaracSpec(DeclarationRS1.Address) + '</Adresse>' + CRLF);
                    // OutStr.WriteText(PADSTR('', 4) + '<Activite>' + fncConvCaracSpec(DeclarationRS1.Activity) + '</Activite>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<InfosContact>' + CRLF);
                    OutStr.WriteText(PADSTR('', 5) + '<AdresseMail>' + fncConvCaracSpec(DeclarationRS1.EMail) + '</AdresseMail>' + CRLF);
                    OutStr.WriteText(PADSTR('', 5) + '<NumTel>' + DeclarationRS1."Phone Number" + '</NumTel>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '</InfosContact>' + CRLF);
                    OutStr.WriteText(PADSTR('', 3) + '</Beneficiaire>' + CRLF);
                    OutStr.WriteText(PADSTR('', 3) + '<DatePayement>' + DeclarationRS1."Payment Date" + '</DatePayement>' + CRLF);
                    OutStr.WriteText(PADSTR('', 3) + '<Ref_certif_chez_declarant>' + DeclarationRS1."TEJ Declaration No." + '</Ref_certif_chez_declarant>' + CRLF);
                    OutStr.WriteText(PADSTR('', 3) + '<ListeOperations>' + CRLF);

                    DeclarationRS2.RESET;
                    DeclarationRS2.SETRANGE("Document No.", DeclarationRS1."Document No.");
                    DeclarationRS2.SETFILTER("Invoice No.", '<>%1', '');
                    IF DeclarationRS2.FINDSET THEN
                        REPEAT
                            OutStr.WriteText(PADSTR('', 4) + '<Operation IdTypeOperation=' + '"' + DeclarationRS2."ID Type Operation" + '"' + '>' + CRLF);
                            OutStr.WriteText(PADSTR('', 5) + '<AnneeFacturation>' + DeclarationRS2."Billing Year" + '</AnneeFacturation>' + CRLF);
                            OutStr.WriteText(PADSTR('', 5) + '<CNPC>' + FORMAT(DeclarationRS2.CNPC) + '</CNPC>' + CRLF);
                            OutStr.WriteText(PADSTR('', 5) + '<P_Charge>' + FORMAT(DeclarationRS2."P-Charge") + '</P_Charge>' + CRLF);
                            OutStr.WriteText(PADSTR('', 5) + '<MontantHT>' + DELCHR(FORMAT(ROUND(DeclarationRS2."Amount HT" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantHT>' + CRLF);
                            OutStr.WriteText(PADSTR('', 5) + '<TauxRS>' + FormatAmount(FORMAT(DeclarationRS2."Withholding Tax Rate"), 6) + '</TauxRS>' + CRLF);
                            //OutStr.WriteText(PADSTR('', 5) + '<TauxRS>' + DELCHR(FORMAT(ROUND(DeclarationRS2."Withholding Tax Rate" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TauxRS>' + CRLF);

                            if GeneralLedgerSetup."Incl VAT Withholding Tax Decl" then begin
                                OutStr.WriteText(PADSTR('', 5) + '<TauxTVA>' + FormatAmount(FORMAT(DeclarationRS2."VAT Rate"), 6) + '</TauxTVA>' + CRLF);
                                //OutStr.WriteText(PADSTR('', 5) + '<TauxTVA>' + DELCHR(FORMAT(ROUND(DeclarationRS2."VAT Rate" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TauxTVA>' + CRLF);
                                OutStr.WriteText(PADSTR('', 5) + '<MontantTVA>' + DELCHR(FORMAT(ROUND(DeclarationRS2."VAT Amount" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantTVA>' + CRLF);
                            end;
                            OutStr.WriteText(PADSTR('', 5) + '<MontantTTC>' + DELCHR(FORMAT(ROUND(DeclarationRS2."Total Amount" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantTTC>' + CRLF);
                            OutStr.WriteText(PADSTR('', 5) + '<MontantRS>' + DELCHR(FORMAT(ROUND(DeclarationRS2."Montant RS" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantRS>' + CRLF);
                            //OutStr.WriteText(PADSTR('',5)+'<TaxeAdditionnelle Code='+Finance1."Tax additionnelle (Code)"+'Taux='+FORMAT(Finance1."Tax additionnelle (taux)")+'</TaxeAdditionnelle>');
                            OutStr.WriteText(PADSTR('', 5) + '<MontantNetServi>' + DELCHR(FORMAT(ROUND(DeclarationRS2."Montant Net servi" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantNetServi>' + CRLF);
                            IF DeclarationRS2."Code devise" <> '' THEN BEGIN
                                OutStr.WriteText(PADSTR('', 5) + '<Devise>' + CRLF);
                                OutStr.WriteText(PADSTR('', 6) + '<CodeDevise>' + DeclarationRS2."Code devise" + '</CodeDevise>' + CRLF);
                                // OutStr.WriteText(PADSTR('', 5) + '<TauxChange>' + FormatAmount(FORMAT(DeclarationRS2."Taux de change"), 6) + '</TauxChange>' + CRLF); //Cmt HD
                                OutStr.WriteText(PADSTR('', 5) + '<TauxChange>' + AmountToText(DeclarationRS2."Taux de change", 0.000001) + '</TauxChange>' + CRLF);
                                OutStr.WriteText(PADSTR('', 6) + '<MontantRSDevise>' + DELCHR(FORMAT(ROUND(DeclarationRS2."Montant RS devise" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantRSDevise>' + CRLF); //HD
                                OutStr.WriteText(PADSTR('', 6) + '<MontantTTCDevise>' + DELCHR(FORMAT(ROUND(DeclarationRS2."Total Currency Amount" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantTTCDevise>' + CRLF);
                                OutStr.WriteText(PADSTR('', 6) + '<MontantNetServiDevise>' + DELCHR(FORMAT(ROUND(DeclarationRS2."Net Amount in Currency" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantNetServiDevise>' + CRLF);
                                // OutStr.WriteText(PADSTR('', 6) + '<MontantRSDevise>' + AmountToText(DeclarationRS2."Montant RS devise") + '</MontantRSDevise>' + CRLF);
                                // OutStr.WriteText(PADSTR('', 6) + '<MontantTTCDevise>' + AmountToText(DeclarationRS2."Total Currency Amount") + '</MontantTTCDevise>' + CRLF);
                                // OutStr.WriteText(PADSTR('', 6) + '<MontantNetServiDevise>' + AmountToText(DeclarationRS2."Net Amount in Currency") + '</MontantNetServiDevise>' + CRLF);
                                OutStr.WriteText(PADSTR('', 5) + '</Devise>' + CRLF);
                            END;
                            OutStr.WriteText(PADSTR('', 4) + '</Operation>' + CRLF);
                        UNTIL (DeclarationRS2.NEXT) = 0;
                    OutStr.WriteText(PADSTR('', 3) + '</ListeOperations>' + CRLF);
                    OutStr.WriteText(PADSTR('', 3) + '<TotalPayement>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<TotalMontantHT>' + DELCHR(FORMAT(ROUND(DeclarationRS1."Amount HT" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantHT>' + CRLF);
                    if GeneralLedgerSetup."Incl VAT Withholding Tax Decl" then
                        OutStr.WriteText(PADSTR('', 4) + '<TotalMontantTVA>' + DELCHR(FORMAT(ROUND(DeclarationRS1."VAT Amount" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantTVA>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<TotalMontantTTC>' + DELCHR(FORMAT(ROUND(DeclarationRS1."Total Amount" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantTTC>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<TotalMontantRS>' + DELCHR(FORMAT(ROUND(DeclarationRS1."Montant RS" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantRS>' + CRLF);
                    //IF (Finance."Total Taxe"<>0) THEN BEGIN
                    //FileName.WriteText(PADSTR('',4)+'<TotalTaxes>');
                    //FileName.WriteText(PADSTR('',4)+'</TotalTaxes>');
                    //END;
                    OutStr.WriteText(PADSTR('', 4) + '<TotalMontantNetServi>' + DELCHR(FORMAT(ROUND(DeclarationRS1."Montant Net servi" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantNetServi>' + CRLF);
                    IF (DeclarationRS1."Code devise" <> '') THEN BEGIN
                        OutStr.WriteText(PADSTR('', 4) + '<TotalDevise>' + CRLF);
                        OutStr.WriteText(PADSTR('', 5) + '<TotalMontantDevise Code="' + DeclarationRS1."Code devise" + '">' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<TotalMontantRS>' + DELCHR(FORMAT(ROUND(DeclarationRS1."Montant RS devise" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantRS>' + CRLF); //Cmt HD
                        OutStr.WriteText(PADSTR('', 6) + '<TotalMontantTTC>' + DELCHR(FORMAT(ROUND(DeclarationRS1."Total Currency Amount" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantTTC>' + CRLF); //Cmt HD
                        OutStr.WriteText(PADSTR('', 6) + '<TotalMontantNetServi>' + DELCHR(FORMAT(ROUND(DeclarationRS1."Net Amount in Currency" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantNetServi>' + CRLF); //Cmt HD
                        // OutStr.WriteText(PADSTR('', 6) + '<TotalMontantRS>' + AmountToText(DeclarationRS1."Montant RS devise") + '</TotalMontantRS>' + CRLF);
                        // OutStr.WriteText(PADSTR('', 6) + '<TotalMontantTTC>' + AmountToText(DeclarationRS1."Total Currency Amount") + '</TotalMontantTTC>' + CRLF);
                        // OutStr.WriteText(PADSTR('', 6) + '<TotalMontantNetServi>' + AmountToText(DeclarationRS1."Net Amount in Currency") + '</TotalMontantNetServi>' + CRLF);
                        OutStr.WriteText(PADSTR('', 5) + '</TotalMontantDevise>' + CRLF);
                        OutStr.WriteText(PADSTR('', 4) + '</TotalDevise>' + CRLF);
                    END;
                    OutStr.WriteText(PADSTR('', 3) + '</TotalPayement>' + CRLF);
                    OutStr.WriteText(PADSTR('', 2) + '</Certificat>' + CRLF);
                UNTIL DeclarationRS1.NEXT = 0;
            END;
            OutStr.WriteText(PADSTR('', 1) + '</AjouterCertificats>' + CRLF);
            OutStr.WriteText('</DeclarationsRS>' + CRLF);

            NomFichier := COPYSTR(CompanyInformation."VAT Registration No.", 1, 8) + '-' + DeclarationRS."Deposit Year" + '-' + DeclarationRS."Payment Month" + '-' + FORMAT(AcDep) + '.xml';
            tmpBlob.CreateInStream(InStr, TextEncoding::Windows);
            DownloadFromStream(InStr, '', '', '', NomFichier);
            MESSAGE('Export terminée avec succès');
        END ELSE
            Error(lText001);
    END;
    // end;

    procedure Ansi2Ascii(_Text: Text[250]): Text[250]
    var
        AsciiStr: Text[250];
        AnsiStr: Text[250];
    begin
        MakeVars;
        EXIT(CONVERTSTR(_Text, AnsiStr, AsciiStr));
    end;

    procedure Ascii2Ansi(_Text: Text[250]): Text[250]
    var
        AsciiStr: Text[250];
        AnsiStr: Text[250];
    begin
        MakeVars;
        EXIT(CONVERTSTR(_Text, AsciiStr, AnsiStr));
    end;

    procedure MakeVars()
    var
        AsciiStr: Text[250];
        AnsiStr: Text[250];
        CharVar: array[32] of Char;
    begin
        AsciiStr := 'ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜø£Ø×ƒáíóúñÑªº¿®¬½¼¡«»¦¦¦¦¦ÁÂÀ©¦¦++¢¥++--+-+ãÃ++--¦-+';
        AsciiStr := AsciiStr + '¤ðÐÊËÈiÍÎÏ++¦_¦Ì¯ÓßÔÒõÕµþÞÚÛÙýÝ¯´­±=¾¶§÷¸°¨·¹³²¦ ';
        CharVar[1] := 196;
        CharVar[2] := 197;
        CharVar[3] := 201;
        CharVar[4] := 242;
        CharVar[5] := 220;
        CharVar[6] := 186;
        CharVar[7] := 191;
        CharVar[8] := 188;
        CharVar[9] := 187;
        CharVar[10] := 193;
        CharVar[11] := 194;
        CharVar[12] := 192;
        CharVar[13] := 195;
        CharVar[14] := 202;
        CharVar[15] := 203;
        CharVar[16] := 200;
        CharVar[17] := 205;
        CharVar[18] := 206;
        CharVar[19] := 204;
        CharVar[20] := 175;
        CharVar[21] := 223;
        CharVar[22] := 213;
        CharVar[23] := 254;
        CharVar[24] := 218;
        CharVar[25] := 219;
        CharVar[26] := 217;
        CharVar[27] := 180;
        CharVar[28] := 177;
        CharVar[29] := 176;
        CharVar[30] := 185;
        CharVar[31] := 179;
        CharVar[32] := 178;
        AnsiStr := 'Ã³ÚÔõÓÕþÛÙÞ´¯ý' + FORMAT(CharVar[1]) + FORMAT(CharVar[2]) + FORMAT(CharVar[3]) + 'µã¶÷' + FORMAT(CharVar[4]);
        AnsiStr := AnsiStr + '¹¨ Í' + FORMAT(CharVar[5]) + '°úÏÎâßÝ¾·±Ð¬' + FORMAT(CharVar[6]) + FORMAT(CharVar[7]);
        AnsiStr := AnsiStr + '«¼¢' + FORMAT(CharVar[8]) + 'í½' + FORMAT(CharVar[9]) + '___ªª' + FORMAT(CharVar[10]) + FORMAT(CharVar[11]);
        AnsiStr := AnsiStr + FORMAT(CharVar[12]) + '®ªª++óÑ++--+-+Ò' + FORMAT(CharVar[13]) + '++--ª-+ñ­ð';
        AnsiStr := AnsiStr + FORMAT(CharVar[14]) + FORMAT(CharVar[15]) + FORMAT(CharVar[16]) + 'i' + FORMAT(CharVar[17]) + FORMAT(CharVar[18]);
        AnsiStr := AnsiStr + '¤++__ª' + FORMAT(CharVar[19]) + FORMAT(CharVar[20]) + 'Ë' + FORMAT(CharVar[21]) + 'ÈÊ§';
        AnsiStr := AnsiStr + FORMAT(CharVar[22]) + 'Á' + FORMAT(CharVar[23]) + 'Ì' + FORMAT(CharVar[24]) + FORMAT(CharVar[25]);
        AnsiStr := AnsiStr + FORMAT(CharVar[26]) + '²¦»' + FORMAT(CharVar[27]) + '¡' + FORMAT(CharVar[28]) + '=¥Âº¸©' + FORMAT(CharVar[29]);
        AnsiStr := AnsiStr + '¿À' + FORMAT(CharVar[30]) + FORMAT(CharVar[31]) + FORMAT(CharVar[32]) + '_ ';
    end;

    procedure fncConvCaracSpec(pText: Text[1024]): Text[1024]
    var
        lAsciiStr: Text[1024];
        lAnsiStr: Text[1024];
        i: Integer;
        lCharVar: array[100] of Char;
        lCharVar2: char;
    begin
        pText := CONVERTSTR(pText, 'þ', 'ç');
        pText := CONVERTSTR(pText, 'Ú', 'é');

        lAsciiStr := 'ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ';
        lAnsiStr := '';
        i := 0;
        REPEAT
            i := i + 1;
            lCharVar[i] := 191 + i;
            lAnsiStr := lAnsiStr + FORMAT(lCharVar[i]);
        UNTIL i = 64;

        pText := CONVERTSTR(pText, lAsciiStr, lAnsiStr);

        lCharVar2 := 176;    //code ASCII de °
        pText := CONVERTSTR(pText, '°', FORMAT(lCharVar2));

        lCharVar2 := 154;    //code ASCII de š
        pText := CONVERTSTR(pText, 'š', FORMAT(lCharVar2));


        pText := CONVERTSTR(pText, 'é', 'e');
        pText := CONVERTSTR(pText, 'è', 'e');
        pText := CONVERTSTR(pText, 'â', 'a');
        pText := CONVERTSTR(pText, 'ç', 'c');
        pText := CONVERTSTR(pText, 'ã', 'a');
        EXIT(pText);

    end;

    procedure MontantToText(pMontant: Decimal): Text[40]
    var
        lMontant: Text;
        Pos: Integer;
        Len: Integer;
    begin
        lMontant := FORMAT(pMontant);
        Pos := STRPOS(lMontant, ',');

        IF Pos = 0 THEN
            EXIT(DELCHR(DELCHR(Ascii2Ansi(lMontant + '000'), '=', ' '), '=', ','));
        lMontant := COPYSTR(lMontant, 1, Pos + 3);//
        Len := STRLEN(COPYSTR(lMontant, Pos + 1));
        IF Len = 0 THEN
            EXIT(DELCHR(DELCHR(Ascii2Ansi(lMontant + '000'), '=', ' '), '=', ','))
        ELSE IF Len = 1 THEN
            EXIT(DELCHR(DELCHR(Ascii2Ansi(lMontant + '00'), '=', ' '), '=', ','))
        ELSE IF Len = 2 THEN
            EXIT(DELCHR(DELCHR(Ascii2Ansi(lMontant + '0'), '=', ' '), '=', ','))
        ELSE IF Len = 3 THEN
            EXIT(DELCHR(DELCHR(Ascii2Ansi(lMontant), '=', ' '), '=', ','))
        ELSE
            EXIT(COPYSTR(DELCHR(DELCHR(Ascii2Ansi(lMontant), '=', ' '), '=', ','), 1, Pos + 3));
    end;

    procedure FormatAmount(pText: Text; pLen: Integer): Text[6]
    var
        Posit: Integer;
    begin
        Posit := STRPOS(pText, ',');
        IF Posit <> 0 THEN BEGIN
            IF (COPYSTR(pText, Posit, 1) <> '0') THEN
                EXIT(COPYSTR(pText, 1, Posit - 1) + '.' + COPYSTR(pText, Posit + 1, 1))
            ELSE
                EXIT(COPYSTR(pText, 1, Posit - 1))
        END
        ELSE
            EXIT(pText);

    end;



    procedure AmountToText(pAmount: Decimal; pPrecision: Decimal) ResultText: Text;
    Var
        lAmountText: Text;
        Posit: Integer;
    begin

        lAmountText := Format(Round(pAmount, pPrecision));
        for Posit := 1 TO StrLen(lAmountText) Do begin
            if lAmountText[Posit] = ',' then
                ResultText := ResultText + '.'
            else if lAmountText[Posit] IN ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'] then
                ResultText := ResultText + lAmountText[Posit];
        end;
        //ResultText := DeleteSpace(ResultText);
    end;

    procedure DeleteSpace(pAmountText: Text) ResultText: Text;
    Var
        lAmountText: Text;
        Posit: Integer;
        cc: Char;
    begin
        for Posit := 1 TO StrLen(pAmountText) Do begin
            if pAmountText[Posit] IN ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'] then
                ResultText := ResultText + pAmountText[Posit];
        end;
    end;

    var
        CompanyInformation: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        FieldStyle: Text;
        DocNo: Code[20];
        CompGenNo: Code[20];
        InclureVAT: Boolean;
        GeneralLedgerSetup: Record "General Ledger Setup";
        GLEntry: Record "G/L Entry";
        SeqNo: Integer;
        GLAccount: Record "G/L Account";
        Currency: Record Currency;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        CurrencyCode: Code[10];
        TotalMontantHT: Decimal;
        TotalNetService: Decimal;
        TotalMontantRS: Decimal;
        TotalMontantTTC: Decimal;
        TotalMontantTVA: Decimal;
        TotalRSDevise: Decimal;
        TotalTTCDevise: Decimal;
        TotalNetServiceDevise: Decimal;
        MntDoc: Decimal;
        WithholdingTax: Record "WDC Withholding Group";
        CreditAdded: Boolean;
        Compteur: Integer;
        LastUsedTejNo: Code[20];
        DeclarationNo: Code[20];
        Counter: Integer;
        NoSeries: Codeunit "No. Series";

}
