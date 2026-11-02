page 54100 "WDC Withholding Tax Decl"
{
    ApplicationArea = All;
    CaptionML = FRA = 'Déclaration RS', ENU = 'RS Declaration';
    PageType = List;
    SourceTable = "WDC Withholding Tax Decl";
    DeleteAllowed = false;
    //Editable =IsEditable;
    InsertAllowed = false;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(Periode)
            {
                CaptionML = FRA = 'Période', ENU = 'Period';
                field("StartDate"; StartDate)
                {
                    ApplicationArea = All;
                    CaptionML = FRA = 'Date début', ENU = 'Start Date';
                    trigger OnValidate()
                    var
                        lDeclarRS: Record "WDC Withholding Tax Decl";
                    begin
                        if EndDate <> 0D then begin
                            EndDate := 0D;
                            lDeclarRS.DeleteAll();
                            CurrPage.Update(false);
                        end;
                    end;
                }
                field("EndDate"; EndDate)
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
                field("DocNoFilter"; DocNoFilter)
                {
                    ApplicationArea = All;
                    CaptionML = FRA = 'N° document', ENU = 'Document No.';
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
                        lDeclarRS: Record "WDC Withholding Tax Decl";
                    begin
                        lDeclarRS.RESET;
                        lDeclarRS.SETRANGE("Document No.", Rec."Document No.");
                        lDeclarRS.SETFILTER("Invoice No.", '<>%1', '');
                        IF lDeclarRS.FINDSET THEN
                            REPEAT
                                lDeclarRS.Export := Rec.Export;
                                lDeclarRS.MODIFY;
                            UNTIL (lDeclarRS.NEXT = 0);
                    end;
                }
                field(Attribut; Rec.Attribute)
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Type identifient Société"; Rec."Type of Company Identifier")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Identifient société"; Rec."Company Identifier")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Categorie Contribuable"; Rec."Taxpayer Category")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Année dépot"; Rec."Deposit Year")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Payment Month"; Rec."Payment Month")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Type of Beneficiary Identifier"; Rec."Type of Beneficiary Identifier")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Taxpayer Fiscal Number/ CIN"; Rec."Taxpayer Fiscal Number/ CIN")
                {
                    ApplicationArea = All;
                    // Editable =IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Categorie Contribuable Bénéficiaire"; Rec."Taxpayer Category Beneficiary")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field(birthdate; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Resident In Tunisia"; Rec."Resident In Tunisia")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Name and First Name"; Rec."Name and First Name")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field(Adresse; Rec.Address)
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                // field("Activity"; Rec."Activity")
                // {
                //     ApplicationArea = All;
                //     Editable =IsEditable;
                //     StyleExpr = FieldStyle;
                // }
                field(EMail; Rec.EMail)
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("TEJ Declaration No."; Rec."TEJ Declaration No.")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                }
                field("ID Type Operation"; Rec."ID Type Operation")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Billing Year"; Rec."Billing Year")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field(CNPC; Rec.CNPC)
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("P-Charge"; Rec."P-Charge")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Amount HT"; Rec."Amount HT")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Withholding Tax Rate"; Rec."Withholding Tax Rate")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("VAT Rate"; Rec."VAT Rate")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                    Visible = InclureVAT;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                    Visible = InclureVAT;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Montant RS"; Rec."Montant RS")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                // field("Tax additionnelle (Code)"; Rec."Tax additionnelle (Code)")
                // {
                //     ApplicationArea = All;
                //     Editable =IsEditable;
                //     StyleExpr = FieldStyle;
                //}
                // field("Tax additionnelle (taux)"; Rec."Tax additionnelle (taux)")
                // {
                //     ApplicationArea = All;
                //     Editable =IsEditable;
                //     StyleExpr = FieldStyle;
                // }
                field("Montant Net servi"; Rec."Montant Net servi")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Code devise"; Rec."Code devise")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Taux de change"; Rec."Taux de change")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                    DecimalPlaces = 0 : 5;
                }
                field("Montant RS devise"; Rec."Montant RS devise")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Total Currency Amount"; Rec."Total Currency Amount")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
                    StyleExpr = FieldStyle;
                }
                field("Net Amount in Currency"; Rec."Net Amount in Currency")
                {
                    ApplicationArea = All;
                    Editable = IsEditable;
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
                    lDeclarRS: Record "WDC Withholding Tax Decl";
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
        lDeclarRS: Record "WDC Withholding Tax Decl";
    begin

        lDeclarRS.DeleteAll();
        CompanyInformation.GET();
        GenLedgSetup.Get();
        IsEditable := GenLedgSetup."Column DEC RS Editable";
        InclureVAT := GenLedgSetup."Incl VAT Withholding Tax Decl"
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
        lVendLedgerEntr: Record "Vendor Ledger Entry";
        lVendLedgerEntr1: Record "Vendor Ledger Entry";
        lVendor: Record Vendor;
        lDetVendLedgEntr: Record "Detailed Vendor Ledg. Entry";
        lDeclarRS: Record "WDC Withholding Tax Decl";
        lDeclarRS1: Record "WDC Withholding Tax Decl";
        lCurrencyFactor: Decimal;
        lText003: TextConst FRA = 'Aucune écriture de retenue à la source n''a été trouvée entre le %1 et le %2',
                            ENU = 'No withholding tax entry was found between %1 and %2';
    begin
        GLSetup.get;
        lDeclarRS.DeleteAll();
        SeqNo := 1;
        CLEAR(GLEntry);
        GLEntry.SETCURRENTKEY("G/L Account No.", "Document No.", "Posting Date");
        GLEntry.SETFILTER("G/L Account No.", GenLedgSetup."Withholding Tax Accounts");
        GLEntry.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
        GLEntry.SETRANGE(Reversed, False);
        //GLEntry.SETRANGE("Entry Type", GLEntry."Entry Type"::Definitive);
        if DocNoFilter <> '' then
            GLEntry.SETRANGE("Document No.", DocNoFilter);
        //GLEntry.SetRange("Document No.", 'REG261599');
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
                    lVendLedgerEntr.Reset();
                    lVendLedgerEntr.SetCurrentKey("Document No.");
                    lVendLedgerEntr.SETRANGE("Document No.", GLEntry."Document No.");
                    lVendLedgerEntr.Setfilter("Vendor No.", '<>%1', 'FRS-00073');
                    IF lVendLedgerEntr.FindLast() THEN begin
                        lVendLedgerEntr.CALCFIELDS(Amount);
                        MntDoc += lVendLedgerEntr.Amount;
                    end;
                    IF MntDoc <> 0 THEN BEGIN
                        lDeclarRS.INIT;
                        lDeclarRS."Entry No." := SeqNo;
                        lDeclarRS.Attribute := 1;
                        lDeclarRS."Type of Company Identifier" := 1;
                        lDeclarRS."Taxpayer Category" := 'PM';
                        lDeclarRS."Company Identifier" := COPYSTR(CompanyInformation."VAT Registration No.", 1, 8);


                        if GenLedgSetup.CNPC = GenLedgSetup.CNPC::"l''opération de retenue à la source a été effectuée en vertu d''une convention de non double imposition" then
                            lDeclarRS.CNPC := 1
                        else
                            lDeclarRS.CNPC := 0;
                        If GenLedgSetup.P_Charge = GenLedgSetup.P_Charge::"La retenue à la source a été prise en charge" then
                            lDeclarRS."P-Charge" := 1
                        else
                            lDeclarRS."P-Charge" := 0;
                        if GenLedgSetup."Incl VAT Withholding Tax Decl" then begin
                            lDeclarRS."Tax additionnelle (Code)" := 'RSTVA100';
                            lDeclarRS."Tax additionnelle (taux)" := 100;
                        end;
                        //lDeclarRS."Deposit Year" := '20' + COPYSTR(FORMAT(GLEntry."Posting Date"), 7, 4);
                        lDeclarRS."Deposit Year" := FORMAT(DATE2DMY(GLEntry."Posting Date", 3));
                        lDeclarRS."Payment Month" := COPYSTR(FORMAT(GLEntry."Posting Date"), 4, 2);
                        GLAccount.GET(GLEntry."G/L Account No.");
                        lDeclarRS."ID Type Operation" := GLAccount."ID Type Operation";
                        IF FORMAT(GLAccount."Withholding Tax Code") <> '' THEN BEGIN
                            WithholdingTax.RESET;
                            WithholdingTax.SETRANGE(Code, GLAccount."Withholding Tax Code");
                            IF WithholdingTax.FINDFIRST() THEN
                                lDeclarRS."Withholding Tax Rate" := WithholdingTax."% Withholding Tax";
                            //EVALUATE(lDeclarRS."Withholding Tax Rate",DELCHR(FORMAT(GLAccount."Withholding Tax Code"),'=','%'));
                        END;
                        lDeclarRS."Document No." := GLEntry."Document No.";                                  //HD
                        lDeclarRS."TEJ Declaration No." := NoSeries.GetNextNo(GLSetup."TEJ Declaration No"); //HD
                        lDeclarRS."G/L Account No." := GLEntry."G/L Account No.";
                        lDeclarRS."Payment Date" := FORMAT(GLEntry."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>');

                        lVendLedgerEntr1.RESET;
                        lVendLedgerEntr1.SetCurrentKey("Document No.");
                        lVendLedgerEntr1.SETRANGE("Document No.", GLEntry."Document No.");
                        IF lVendLedgerEntr1.FINDLAST THEN BEGIN
                            lVendor.GET(lVendLedgerEntr1."Vendor No.");
                            lDeclarRS."Taxpayer Fiscal Number/ CIN" := COPYSTR(lVendor."VAT Registration No.", 1, 8);
                            if lVendor."Identification Type" = lVendor."Identification Type"::CIN then Begin
                                lVendor.TestField("Birth Date");
                                lDeclarRS."Birth Date" := lVendor."Birth Date";
                            End;
                            IF lVendor."Vendor Type" = lVendor."Vendor Type"::"Personne Morale" THEN Begin
                                lDeclarRS."Type of Beneficiary Identifier" := 1;
                                lDeclarRS."Taxpayer Category Beneficiary" := 'PM'
                            END ELSE IF lVendor."Vendor Type" = lVendor."Vendor Type"::"Personne Physique" THEN Begin
                                lDeclarRS."Type of Beneficiary Identifier" := 2;
                                lDeclarRS."Taxpayer Category Beneficiary" := 'PP';
                            End;
                            lDeclarRS."Name and First Name" := lVendor.Name;
                            if lVendor."Resident" = lVendor."Resident"::Resident then
                                lDeclarRS."Resident In Tunisia" := 1
                            else
                                lDeclarRS."Resident In Tunisia" := 0;
                            lDeclarRS.EMail := lVendor."E-Mail";
                            //lDeclarRS.Activity := lVendor.Activity;
                            lDeclarRS."Phone Number" := lVendor."Phone No.";
                            lDeclarRS.Address := lVendor.City;
                            lDeclarRS."Billing Year" := FORMAT(DATE2DMY(GLEntry."Posting Date", 3));
                            lDeclarRS.INSERT;

                            lDetVendLedgEntr.RESET;
                            lDetVendLedgEntr.SetCurrentKey("Document No.", "Document Type", "Posting Date");
                            lDetVendLedgEntr.SETRANGE("Document No.", lVendLedgerEntr1."Document No.");
                            lDetVendLedgEntr.SETRANGE("Entry Type", lDetVendLedgEntr."Entry Type"::Application);
                            lDetVendLedgEntr.SETRANGE("Initial Document Type", lDetVendLedgEntr."Initial Document Type"::Payment);
                            IF lDetVendLedgEntr.FINDSET THEN BEGIN
                                CreditAdded := FALSE;
                                // IF (lDetVendLedgEntr.COUNT = 1) THEN BEGIN
                                //     InsertInv(lVendLedgerEntr1, lDeclarRS);
                                // END ELSE BEGIN
                                //     InsertInvoiceFromVendorLedEntry(lDetVendLedgEntr, lDeclarRS);
                                // END;
                            END;//ELSE
                            InsertInv(lVendLedgerEntr1, lDeclarRS);
                        END;
                    END;

                    lDeclarRS1.RESET();
                    lDeclarRS1.SETRANGE("Document No.", GLEntry."Document No.");
                    lDeclarRS1.SETRANGE("G/L Account No.", GLEntry."G/L Account No.");
                    lDeclarRS1.SETFILTER("Invoice No.", '');
                    IF lDeclarRS1.FINDSET THEN BEGIN
                        if lVendLedgerEntr1."Currency Code" <> '' Then begin
                            lDeclarRS1."Code devise" := lVendLedgerEntr1."Currency Code";
                            lCurrencyFactor := 1 / lVendLedgerEntr.GetAdjustedCurrencyFactor();
                            lDeclarRS1."Taux de change" := lCurrencyFactor;
                            lDeclarRS1."Montant RS devise" := Abs(GLEntry."Source Currency Amount");
                            lDeclarRS1."Total Currency Amount" := lDeclarRS1."Montant RS devise" * 100 / lDeclarRS1."Withholding Tax Rate";
                            lDeclarRS1."Net Amount in Currency" := lDeclarRS1."Total Currency Amount" - lDeclarRS1."Montant RS devise";
                        end;
                        //<<HD02092026
                        lDeclarRS1."Montant RS" := Abs(GLEntry.Amount);
                        lDeclarRS1."Amount HT" := lDeclarRS1."Montant RS" * 100 / lDeclarRS1."Withholding Tax Rate";
                        lDeclarRS1."Total Amount" := lDeclarRS1."Amount HT" + lDeclarRS1."VAT Amount";
                        lDeclarRS1."Montant Net servi" := lDeclarRS1."Total Amount" - lDeclarRS1."Montant RS";

                        // TEJManagement.GetTotalPaymentAmount(GLEntry."Document No.",
                        //                                     lDeclarRS1."Amount HT",
                        //                                     lDeclarRS1."Montant RS",
                        //                                     lDeclarRS1."Total Amount",
                        //                                     lDeclarRS1."VAT Amount",
                        //                                     lDeclarRS1."Montant Net servi",
                        //                                     lDeclarRS1."Montant RS devise",
                        //                                     lDeclarRS1."Total Currency Amount",
                        //                                     lDeclarRS1."Net Amount in Currency");
                        //>>HD02092026
                        IF TotalMontantHT <> 0 THEN
                            lDeclarRS1."VAT Rate" := TotalMontantTVA * 100 / TotalMontantHT;
                        lDeclarRS1.MODIFY;
                    END;
                END;
                SeqNo += 1;
            UNTIL (GLEntry.NEXT = 0);
        END ELSE
            Message(lText003, FORMAT(StartDate), FORMAT(EndDate));
    end;


    LOCAL PROCEDURE InsertInv(pVendLedgerEntr: Record "Vendor Ledger Entry"; pDeclarRS: Record "WDC Withholding Tax Decl");
    VAR
        DetVendLedgEntr: Record "Detailed Vendor Ledg. Entry";
        DetVendLedgEntr1: Record "Detailed Vendor Ledg. Entry";
        lDetVendLedgEntr: Record "Detailed Vendor Ledg. Entry";
        lDetVendLedgEntr1: Record "Detailed Vendor Ledg. Entry";
        lDetVendLedgEntr2: Record "Detailed Vendor Ledg. Entry";
        pp: page 624;
    BEGIN
        CLEAR(DetVendLedgEntr);
        DetVendLedgEntr.SetCurrentKey("Document No.", "Document Type", "Posting Date");
        DetVendLedgEntr.SETRANGE("Document No.", pVendLedgerEntr."Document No.");
        DetVendLedgEntr.SETRANGE("Entry Type", DetVendLedgEntr."Entry Type"::Application);
        DetVendLedgEntr.SETRANGE("Initial Document Type", DetVendLedgEntr."Initial Document Type"::Invoice);
        DetVendLedgEntr.SETRANGE(Unapplied, FALSE);
        IF DetVendLedgEntr.FINDSET THEN BEGIN
            REPEAT
                InsertInvoiceFromVendorLedEntry(DetVendLedgEntr, pDeclarRS);
            UNTIL (DetVendLedgEntr.NEXT = 0);
        END
        // ELSE BEGIN
        //     // InsertFromPayment(pDeclarRS);
        //     CLEAR(DetVendLedgEntr);
        //     DetVendLedgEntr.SetCurrentKey("Document No.", "Document Type", "Posting Date");
        //     DetVendLedgEntr.SETRANGE("Document No.", pVendLedgerEntr."Document No.");
        //     if DetVendLedgEntr.FINDSET() then
        //         InsertInvoiceFromVendorLedEntry(DetVendLedgEntr, pDeclarRS);
        // END;
    END;

    LOCAL PROCEDURE InsertFromPurchInv(pDeclarRS: Record "WDC Withholding Tax Decl"; pDetVendLedgEntr: Record "Detailed Vendor Ledg. Entry");
    VAR
        lDeclarRS: Record "WDC Withholding Tax Decl";
        lPurchaseInvHeader: Record "Purch. Inv. Header";
        lPurchaseInvLine: Record "Purch. Inv. Line";
        lDetVendLedgEntr: Record "Detailed Vendor Ledg. Entry";
        lVendLegEntries: record "Vendor Ledger Entry";
        lGenLedgSetup: Record "General Ledger Setup";
        lAmountTTC: Decimal;
        CurrencyFactor: Decimal;
    BEGIN
        lGenLedgSetup.GET;
        SeqNo += 1;
        lDeclarRS.COPY(pDeclarRS);
        lDeclarRS."Entry No." := SeqNo;
        lDeclarRS."Invoice No." := pDetVendLedgEntr."Document No.";
        IF lPurchaseInvHeader.GET(pDetVendLedgEntr."Document No.") THEN BEGIN
            lDeclarRS."Amount HT" := 0;
            lDeclarRS."Montant Net servi" := 0;
            lDeclarRS."Net Amount in Currency" := 0;
            lDeclarRS."Montant RS devise" := 0;
            lDeclarRS."Total Amount" := 0;
            lDeclarRS."Total Currency Amount" := 0;
            lDeclarRS."VAT Amount" := 0;
            lPurchaseInvHeader.CALCFIELDS(Amount, "Amount Including VAT");
            CLEAR(lPurchaseInvLine);
            lPurchaseInvLine.SETRANGE("Document No.", lPurchaseInvHeader."No.");
            if lGenLedgSetup."Purch. Stamp Account No." <> '' then
                lPurchaseInvLine.SETFILTER("No.", '<>%1', lGenLedgSetup."Purch. Stamp Account No.");
            lPurchaseInvLine.SETFILTER(Amount, '<>%1', 0);
            IF lPurchaseInvLine.FINDSET THEN
                REPEAT
                    lDeclarRS."Amount HT" += lPurchaseInvLine.Amount;
                    lDeclarRS."Amount HT" := ROUND(lDeclarRS."Amount HT", 0.001, '<');
                    lDeclarRS."VAT Rate" := lPurchaseInvLine."VAT %";
                UNTIL lPurchaseInvLine.NEXT = 0;

            if lPurchaseInvHeader."Currency Factor" <> 0 then
                lDeclarRS."Amount HT" := lDeclarRS."Amount HT" / lPurchaseInvHeader."Currency Factor";//HD on a ajouté au pour les facture en devise
            lDeclarRS."Amount HT" := ROUND(lDeclarRS."Amount HT", 0.001, '<'); //HD

            lDeclarRS."VAT Amount" := ROUND(lDeclarRS."Amount HT", 0.001, '<') * lDeclarRS."VAT Rate" / 100;
            lDeclarRS."VAT Amount" := ROUND(lDeclarRS."VAT Amount", 0.001, '<');

            lDeclarRS."Total Amount" := ROUND(lDeclarRS."Amount HT", 0.001, '<') + ROUND(lDeclarRS."VAT Amount", 0.001, '<');
            lDeclarRS."Total Amount" := ROUND(lDeclarRS."Total Amount", 0.001, '<');

            lDeclarRS."Montant RS" := ROUND(lDeclarRS."Total Amount", 0.001, '<') * lDeclarRS."Withholding Tax Rate" / 100;
            lDeclarRS."Montant RS" := ROUND(lDeclarRS."Montant RS", 0.001, '<');

            lDeclarRS."Montant Net servi" := ROUND(lDeclarRS."Total Amount", 0.001, '<') - ROUND(lDeclarRS."Montant RS", 0.001, '<');
            lDeclarRS."Montant Net servi" := ROUND(lDeclarRS."Montant Net servi", 0.001, '<');

            lAmountTTC := 0;
            IF NOT CreditAdded THEN BEGIN
                lDetVendLedgEntr.RESET();
                lDetVendLedgEntr.SetCurrentKey("Document No.", "Document Type", "Posting Date");
                lDetVendLedgEntr.SETRANGE("Document No.", pDetVendLedgEntr."Document No.");
                lDetVendLedgEntr.SETRANGE("Initial Document Type", lDetVendLedgEntr."Initial Document Type"::"Credit Memo");
                lDetVendLedgEntr.SETRANGE("Transaction No.", pDetVendLedgEntr."Transaction No.");
                IF lDetVendLedgEntr.FINDSET() THEN BEGIN
                    REPEAT
                        //lAmountTTC += lDetVendLedgEntr.Amount; //Cmt HD
                        lAmountTTC += lDetVendLedgEntr."Amount (LCY)"; //HD
                    UNTIL (lDetVendLedgEntr.NEXT) = 0;
                    IF lAmountTTC < lDeclarRS."Total Amount" THEN BEGIN
                        CreditAdded := TRUE;
                        lDeclarRS."Total Amount" += lAmountTTC;
                        lDeclarRS."Total Amount" := ROUND(lDeclarRS."Total Amount", 0.001, '<');
                        lDeclarRS."Montant RS" := ROUND(lDeclarRS."Total Amount", 0.001, '<') * lDeclarRS."Withholding Tax Rate" / 100;
                        lDeclarRS."Montant RS" := ROUND(lDeclarRS."Montant RS", 0.001, '<');
                        lDeclarRS."Montant Net servi" := ROUND(lDeclarRS."Total Amount", 0.001, '<') - ROUND(lDeclarRS."Montant RS", 0.001, '<');
                        lDeclarRS."Montant Net servi" := ROUND(lDeclarRS."Montant Net servi", 0.001, '<');
                        lDeclarRS."Amount HT" := 100 * ROUND(lDeclarRS."Total Amount", 0.001, '<') / (100 + lDeclarRS."VAT Rate");
                        lDeclarRS."Amount HT" := ROUND(lDeclarRS."Amount HT", 0.001, '<');
                        lDeclarRS."VAT Amount" := ROUND(lDeclarRS."Amount HT", 0.001, '<') * lDeclarRS."VAT Rate" / 100;
                        lDeclarRS."VAT Amount" := ROUND(lDeclarRS."VAT Amount", 0.001, '<');
                        IF (ROUND(lDeclarRS."Amount HT", 0.001, '<') + ROUND(lDeclarRS."VAT Amount", 0.001, '<') <> ROUND(lDeclarRS."Total Amount", 0.001, '<')) THEN BEGIN
                            lDeclarRS."Total Amount" := ROUND(lDeclarRS."Amount HT", 0.001, '<') + ROUND(lDeclarRS."VAT Amount", 0.001, '<');
                            lDeclarRS."Montant RS" := lDeclarRS."Total Amount" * lDeclarRS."Withholding Tax Rate" / 100;
                            lDeclarRS."Montant RS" := ROUND(lDeclarRS."Montant RS", 0.001, '<');
                            lDeclarRS."Montant Net servi" := ROUND(lDeclarRS."Total Amount", 0.001, '<') - ROUND(lDeclarRS."Montant RS", 0.001, '<');
                            lDeclarRS."Montant Net servi" := ROUND(lDeclarRS."Montant Net servi", 0.001, '<');
                        END;
                    END;
                END;
            END;
            TotalMontantHT += ROUND(lDeclarRS."Amount HT", 0.001, '<');
            TotalMontantTVA += ROUND(lDeclarRS."VAT Amount", 0.001, '<');
            TotalMontantTTC += ROUND(lDeclarRS."Total Amount", 0.001, '<');
            TotalMontantRS += ROUND(lDeclarRS."Montant RS", 0.001, '<');
            TotalNetService += ROUND(lDeclarRS."Montant Net servi", 0.001, '<');
            lDeclarRS."Billing Year" := FORMAT(DATE2DMY(lPurchaseInvHeader."Posting Date", 3));
            CurrencyCode := lPurchaseInvHeader."Currency Code";
            IF CurrencyCode <> '' THEN BEGIN
                lVendLegEntries.RESET;
                lVendLegEntries.SetCurrentKey("Document No.");
                lVendLegEntries.SETRANGE("Document No.", lPurchaseInvHeader."No.");
                lVendLegEntries.SetRange("Document Type", lVendLegEntries."Document Type"::Invoice);
                IF lVendLegEntries.FINDSET THEN BEGIN
                    lDeclarRS."Code devise" := CurrencyCode;
                    CurrencyFactor := 1 / lVendLegEntries.GetAdjustedCurrencyFactor();
                    lDeclarRS."Taux de change" := CurrencyFactor;

                    //<< Cmt HD
                    //IF Currency.GET(CurrencyCode) THEN;
                    // CurrencyExchangeRate.RESET;
                    // CurrencyExchangeRate.SETRANGE("Currency Code", Currency.Code);
                    // IF CurrencyExchangeRate.FINDSET THEN BEGIN
                    //     lDeclarRS."Code devise" := Currency.Code;
                    //     lDeclarRS."Taux de change" := CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";

                    // lDeclarRS."Montant RS devise" := lDeclarRS."Montant RS" * CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";
                    // lDeclarRS."Montant RS devise" := ROUND(lDeclarRS."Montant RS devise", 0.001, '<');
                    // lDeclarRS."Total Currency Amount" := lDeclarRS."Total Amount" * CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";
                    // lDeclarRS."Total Currency Amount" := ROUND(lDeclarRS."Total Currency Amount", 0.001, '<');
                    // lDeclarRS."Net Amount in Currency" := lDeclarRS."Montant Net servi" * CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";
                    // lDeclarRS."Net Amount in Currency" := ROUND(lDeclarRS."Net Amount in Currency", 0.001, '<');
                    // TotalRSDevise += lDeclarRS."Montant RS devise";
                    // TotalTTCDevise += lDeclarRS."Total Currency Amount";
                    // TotalNetServiceDevise += lDeclarRS."Net Amount in Currency";
                    //>>Cmt HD

                    //<<HD
                    lDeclarRS."Montant RS devise" := ROUND(lPurchaseInvHeader."Amount Including VAT", 0.001, '<') * lDeclarRS."Withholding Tax Rate" / 100;
                    lDeclarRS."Montant RS devise" := ROUND(lDeclarRS."Montant RS devise", 0.001, '<');

                    lDeclarRS."Total Currency Amount" := lPurchaseInvHeader."Amount Including VAT";
                    lDeclarRS."Total Currency Amount" := ROUND(lDeclarRS."Total Currency Amount", 0.001, '<');

                    lDeclarRS."Net Amount in Currency" := lDeclarRS."Total Currency Amount" - lDeclarRS."Montant RS devise";
                    lDeclarRS."Net Amount in Currency" := ROUND(lDeclarRS."Net Amount in Currency", 0.001, '<');
                    TotalRSDevise += lDeclarRS."Montant RS devise";
                    TotalTTCDevise += lDeclarRS."Total Currency Amount";
                    TotalNetServiceDevise += lDeclarRS."Net Amount in Currency";
                    //>>HD
                END;
            END;
            lDeclarRS.INSERT;
        END;
    END;

    LOCAL PROCEDURE InsertInvoiceFromVendorLedEntry(pDetVendLedgEntr: Record "Detailed Vendor Ledg. Entry"; pDeclarRS: Record "WDC Withholding Tax Decl");
    VAR
        lDeclarRS: Record "WDC Withholding Tax Decl";
        lVendorLedgEntry: Record 25;
        lDetVendLedgEntr: Record 380;
        lDetVendLedgEntr1: Record 380;
        InvoiceNo: Code[20];
        MntTTc: Decimal;
        CurrencyFactor: Decimal;
    BEGIN
        //REPEAT
        IF lVendorLedgEntry.GET(pDetVendLedgEntr."Vendor Ledger Entry No.") THEN BEGIN
            SeqNo += 1;
            lDeclarRS.COPY(pDeclarRS);
            lDeclarRS."Entry No." := SeqNo;

            // CLEAR(lDetVendLedgEntr);
            // lDetVendLedgEntr.SETRANGE("Document No.", pDeclarRS."Document No.");
            // lDetVendLedgEntr.SETRANGE("Entry Type", lDetVendLedgEntr."Entry Type"::Application);
            // lDetVendLedgEntr.SETRANGE("Initial Document Type", lDetVendLedgEntr."Initial Document Type"::Invoice);
            // IF lDetVendLedgEntr.FINDSET THEN BEGIN
            //     lDetVendLedgEntr1.RESET;
            //     // lDetVendLedgEntr1.SETRANGE("Vendor Ledger Entry No.", lDetVendLedgEntr."Vendor Ledger Entry No.");
            //     // lDetVendLedgEntr1.SETRANGE("Ledger Entry Amount", TRUE);
            //     // lDetVendLedgEntr1.SETRANGE(Unapplied, FALSE);
            //     lDetVendLedgEntr1.SETRANGE("Document No.", pDeclarRS."Document No.");
            //     lDetVendLedgEntr1.SETRANGE("Vendor Ledger Entry No.", lDetVendLedgEntr."Applied Vend. Ledger Entry No.");
            //     lDetVendLedgEntr1.SETRANGE("Applied Vend. Ledger Entry No.", lDetVendLedgEntr."Applied Vend. Ledger Entry No.");
            //     lDetVendLedgEntr1.SETRANGE("Entry Type", lDetVendLedgEntr1."Entry Type"::Application);
            //     IF lDetVendLedgEntr1.FINDSET THEN
            //         MntTTc := Abs(lDetVendLedgEntr1."Amount (LCY)" * -1); //HD
            //     // InvoiceNo := lDetVendLedgEntr1."Document No."
            //     // ELSE
            //     // InvoiceNo := lVendorLedgEntry."Document No.";
            // END;
            MntTTc := Abs(pDetVendLedgEntr."Amount (LCY)" * -1); //HD
            InvoiceNo := pDetVendLedgEntr."Document No.";
            IF InvoiceNo = '' THEN
                lDeclarRS."Invoice No." := lVendorLedgEntry."Document No."
            ELSE
                lDeclarRS."Invoice No." := InvoiceNo;

            lDeclarRS."Montant RS" := 0;
            lDeclarRS."Amount HT" := 0;
            lDeclarRS."Montant Net servi" := 0;
            lDeclarRS."Total Amount" := 0;
            lDeclarRS."VAT Amount" := 0;

            lVendorLedgEntry.CALCFIELDS(Amount);
            lVendorLedgEntry.CALCFIELDS("Amount (LCY)");
            lDeclarRS."Billing Year" := FORMAT(DATE2DMY(lVendorLedgEntry."Posting Date", 3));
            //MntTTc := lVendorLedgEntry.Amount; //Cmt HD
            //MntTTc := lVendorLedgEntry."Amount (LCY)";//HD


            lDeclarRS."Total Amount" := MntTTc;

            lDeclarRS."Montant RS" := ROUND(lDeclarRS."Total Amount", 0.001, '<') * lDeclarRS."Withholding Tax Rate" / 100;
            lDeclarRS."Montant RS" := ROUND(lDeclarRS."Montant RS", 0.001, '<');

            lDeclarRS."Montant Net servi" := ROUND(lDeclarRS."Total Amount", 0.001, '<') - ROUND(lDeclarRS."Montant RS", 0.001, '<');
            lDeclarRS."Montant Net servi" := ROUND(lDeclarRS."Montant Net servi", 0.001, '<');

            lDeclarRS."VAT Rate" := 0;
            lDeclarRS."Amount HT" := 100 * ROUND(lDeclarRS."Total Amount", 0.001, '<') / (100 + lDeclarRS."VAT Rate");
            lDeclarRS."Amount HT" := ROUND(lDeclarRS."Amount HT", 0.001, '<');
            TotalMontantHT += ROUND(lDeclarRS."Amount HT", 0.001, '<');

            lDeclarRS."VAT Amount" := ROUND(lDeclarRS."Amount HT", 0.001, '<') * lDeclarRS."VAT Rate" / 100;
            lDeclarRS."VAT Amount" := ROUND(lDeclarRS."VAT Amount", 0.001, '<');
            TotalMontantTVA += ROUND(lDeclarRS."VAT Amount", 0.001, '<');
            //
            IF (ROUND(lDeclarRS."Amount HT", 0.001, '<') + ROUND(lDeclarRS."VAT Amount", 0.001, '<') <> ROUND(lDeclarRS."Total Amount", 0.001, '<')) THEN BEGIN
                lDeclarRS."Total Amount" := ROUND(lDeclarRS."Amount HT", 0.001, '<') + ROUND(lDeclarRS."VAT Amount", 0.001, '<');
                lDeclarRS."Montant RS" := lDeclarRS."Total Amount" * lDeclarRS."Withholding Tax Rate" / 100;
                lDeclarRS."Montant RS" := ROUND(lDeclarRS."Montant RS", 0.001, '<');
                lDeclarRS."Montant Net servi" := ROUND(lDeclarRS."Total Amount", 0.001, '<') - ROUND(lDeclarRS."Montant RS", 0.001, '<');
                lDeclarRS."Montant Net servi" := ROUND(lDeclarRS."Montant Net servi", 0.001, '<');
            END;
            CurrencyCode := lVendorLedgEntry."Currency Code";
            CurrencyFactor := 1 / lVendorLedgEntry.GetAdjustedCurrencyFactor();
            IF CurrencyCode <> '' THEN BEGIN
                // IF Currency.GET(CurrencyCode) THEN;
                // CurrencyExchangeRate.RESET;
                // CurrencyExchangeRate.SETRANGE("Currency Code", Currency.Code);
                // IF CurrencyExchangeRate.FINDSET THEN BEGIN
                //     lDeclarRS."Code devise" := Currency.Code;
                //lDeclarRS."Taux de change" := CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";
                // lDeclarRS."Montant RS devise" := lDeclarRS."Montant RS" * CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";
                // lDeclarRS."Montant RS devise" := ROUND(lDeclarRS."Montant RS devise", 0.001, '<');
                // lDeclarRS."Total Currency Amount" := lDeclarRS."Total Amount" * CurrencyExchangeRate."Relational Adjmt Exch Rate Amt"; //CMt HD
                // lDeclarRS."Total Currency Amount" := ROUND(lDeclarRS."Total Currency Amount", 0.001, '<');
                // lDeclarRS."Net Amount in Currency" := lDeclarRS."Montant Net servi" * CurrencyExchangeRate."Relational Adjmt Exch Rate Amt";
                lDeclarRS."Code devise" := CurrencyCode;
                lDeclarRS."Taux de change" := CurrencyFactor; //WDC05
                lDeclarRS."Montant RS devise" := lDeclarRS."Montant RS" * CurrencyFactor;
                lDeclarRS."Montant RS devise" := ROUND(lDeclarRS."Montant RS devise", 0.001, '<');
                lDeclarRS."Total Currency Amount" := lDeclarRS."Total Amount" * CurrencyFactor; //CMt HD
                lDeclarRS."Total Currency Amount" := ROUND(lDeclarRS."Total Currency Amount", 0.001, '<');
                lDeclarRS."Net Amount in Currency" := lDeclarRS."Montant Net servi" * CurrencyFactor;
                lDeclarRS."Net Amount in Currency" := ROUND(lDeclarRS."Net Amount in Currency", 0.001, '<');
                TotalRSDevise += lDeclarRS."Montant RS devise";
                TotalTTCDevise += lDeclarRS."Total Currency Amount";
                TotalNetServiceDevise += lDeclarRS."Net Amount in Currency";
                //END;
            END;

            TotalMontantTTC += ROUND(lDeclarRS."Total Amount", 0.001, '<');
            TotalMontantRS += ROUND(lDeclarRS."Montant RS", 0.001, '<');
            TotalNetService += ROUND(lDeclarRS."Montant Net servi", 0.001, '<');
            //
            lDeclarRS.INSERT;
        END;
        // UNTIL (pDetVendLedgEntr.NEXT) = 0;
    END;

    procedure createXMLFile()
    var
        Options: Text;
        NomFichier: Text;
        acteDepot: Integer;
        AcDep: Integer;
        DeclarRS: Record "WDC Withholding Tax Decl";
        DeclarRS1: Record "WDC Withholding Tax Decl";
        DeclarRS2: Record "WDC Withholding Tax Decl";
        FileName: File;
        FileManagement: Codeunit "File Management";
        tmpBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        CRLF: Text[2];
        lText001: textconst ENU = 'You have to select at least one record to generate the XML file.',
                            FRA = 'Vous devez sélectionner au moins un enregistrement pour générer le fichier XML.';
    begin
        DeclarRS.RESET;
        DeclarRS.SETRANGE(Export, TRUE);
        IF DeclarRS.FINDSET THEN BEGIN
            GenLedgSetup.get;
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
            OutStr.WriteText(PADSTR('', 2) + '<TypeIdentifiant>' + FORMAT(DeclarRS."Type of Company Identifier") + '</TypeIdentifiant>' + CRLF);
            OutStr.WriteText(PADSTR('', 2) + '<Identifiant>' + DeclarRS."Company Identifier" + '</Identifiant>' + CRLF);
            OutStr.WriteText(PADSTR('', 2) + '<CategorieContribuable>' + DeclarRS."Taxpayer Category" + '</CategorieContribuable>' + CRLF);
            OutStr.WriteText(PADSTR('', 1) + '</Declarant>' + CRLF);

            //@@@ ReferenceDeclaration(2)
            OutStr.WriteText(PADSTR('', 1) + '<ReferenceDeclaration>' + CRLF);
            OutStr.WriteText(PADSTR('', 2) + '<ActeDepot>' + FORMAT(AcDep) + '</ActeDepot>' + CRLF);
            OutStr.WriteText(PADSTR('', 2) + '<AnneeDepot>' + DeclarRS."Deposit Year" + '</AnneeDepot>' + CRLF);
            OutStr.WriteText(PADSTR('', 2) + '<MoisDepot>' + DeclarRS."Payment Month" + '</MoisDepot>' + CRLF);
            OutStr.WriteText(PADSTR('', 1) + '</ReferenceDeclaration>' + CRLF);
            //@@@ AjouterCertificats(I)
            OutStr.WriteText(PADSTR('', 1) + '<AjouterCertificats>' + CRLF);
            DeclarRS1.RESET;
            DeclarRS1.SETRANGE(Export, TRUE);
            DeclarRS1.SETRANGE("Invoice No.", '');
            IF DeclarRS1.FINDSET THEN BEGIN
                REPEAT
                    //@@@Certificat
                    OutStr.WriteText(PADSTR('', 2) + '<Certificat>' + CRLF);
                    OutStr.WriteText(PADSTR('', 3) + '<Beneficiaire>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<IdTaxpayer>' + CRLF);
                    IF DeclarRS1."Type of Beneficiary Identifier" = 1 THEN BEGIN
                        OutStr.WriteText(PADSTR('', 5) + '<MatriculeFiscal>' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<TypeIdentifiant>' + FORMAT(DeclarRS1."Type of Beneficiary Identifier") + '</TypeIdentifiant>' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<Identifiant>' + DeclarRS1."Taxpayer Fiscal Number/ CIN" + '</Identifiant>' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<CategorieContribuable>' + DeclarRS1."Taxpayer Category Beneficiary" + '</CategorieContribuable>' + CRLF);
                        OutStr.WriteText(PADSTR('', 5) + '</MatriculeFiscal>' + CRLF);
                    END ELSE BEGIN
                        OutStr.WriteText(PADSTR('', 5) + '<CIN>' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<TypeIdentifiant>' + FORMAT(DeclarRS1."Type of Beneficiary Identifier") + '</TypeIdentifiant>' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<Identifiant>' + DeclarRS1."Taxpayer Fiscal Number/ CIN" + '</Identifiant>' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<DateNaissance>' + FORMAT(DeclarRS1."Birth Date", 0, '<Day,2>/<Month,2>/<Year4,4>') + '</DateNaissance>' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<CategorieContribuable>' + DeclarRS1."Taxpayer Category Beneficiary" + '</CategorieContribuable>' + CRLF);
                        OutStr.WriteText(PADSTR('', 5) + '</CIN>' + CRLF);
                    END;

                    OutStr.WriteText(PADSTR('', 4) + '</IdTaxpayer>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<Resident>' + FORMAT(DeclarRS1."Resident In Tunisia") + '</Resident>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<NometprenonOuRaisonsociale>' + fncConvCaracSpec(DeclarRS1."Name and First Name") + '</NometprenonOuRaisonsociale>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<Adresse>' + fncConvCaracSpec(DeclarRS1.Address) + '</Adresse>' + CRLF);
                    // OutStr.WriteText(PADSTR('', 4) + '<Activite>' + fncConvCaracSpec(DeclarRS1.Activity) + '</Activite>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<InfosContact>' + CRLF);
                    OutStr.WriteText(PADSTR('', 5) + '<AdresseMail>' + fncConvCaracSpec(DeclarRS1.EMail) + '</AdresseMail>' + CRLF);
                    OutStr.WriteText(PADSTR('', 5) + '<NumTel>' + DeclarRS1."Phone Number" + '</NumTel>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '</InfosContact>' + CRLF);
                    OutStr.WriteText(PADSTR('', 3) + '</Beneficiaire>' + CRLF);
                    OutStr.WriteText(PADSTR('', 3) + '<DatePayement>' + DeclarRS1."Payment Date" + '</DatePayement>' + CRLF);
                    OutStr.WriteText(PADSTR('', 3) + '<Ref_certif_chez_declarant>' + DeclarRS1."TEJ Declaration No." + '</Ref_certif_chez_declarant>' + CRLF);
                    OutStr.WriteText(PADSTR('', 3) + '<ListeOperations>' + CRLF);

                    DeclarRS2.RESET;
                    DeclarRS2.SETRANGE("Document No.", DeclarRS1."Document No.");
                    DeclarRS2.SETFILTER("Invoice No.", '<>%1', '');
                    IF DeclarRS2.FINDSET THEN
                        REPEAT
                            OutStr.WriteText(PADSTR('', 4) + '<Operation IdTypeOperation=' + '"' + DeclarRS2."ID Type Operation" + '"' + '>' + CRLF);
                            OutStr.WriteText(PADSTR('', 5) + '<AnneeFacturation>' + DeclarRS2."Billing Year" + '</AnneeFacturation>' + CRLF);
                            OutStr.WriteText(PADSTR('', 5) + '<CNPC>' + FORMAT(DeclarRS2.CNPC) + '</CNPC>' + CRLF);
                            OutStr.WriteText(PADSTR('', 5) + '<P_Charge>' + FORMAT(DeclarRS2."P-Charge") + '</P_Charge>' + CRLF);
                            OutStr.WriteText(PADSTR('', 5) + '<MontantHT>' + DELCHR(FORMAT(ROUND(DeclarRS2."Amount HT" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantHT>' + CRLF);
                            OutStr.WriteText(PADSTR('', 5) + '<TauxRS>' + FormatAmount(FORMAT(DeclarRS2."Withholding Tax Rate"), 6) + '</TauxRS>' + CRLF);
                            //OutStr.WriteText(PADSTR('', 5) + '<TauxRS>' + DELCHR(FORMAT(ROUND(DeclarRS2."Withholding Tax Rate" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TauxRS>' + CRLF);

                            if GenLedgSetup."Incl VAT Withholding Tax Decl" then begin
                                OutStr.WriteText(PADSTR('', 5) + '<TauxTVA>' + FormatAmount(FORMAT(DeclarRS2."VAT Rate"), 6) + '</TauxTVA>' + CRLF);
                                //OutStr.WriteText(PADSTR('', 5) + '<TauxTVA>' + DELCHR(FORMAT(ROUND(DeclarRS2."VAT Rate" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TauxTVA>' + CRLF);
                                OutStr.WriteText(PADSTR('', 5) + '<MontantTVA>' + DELCHR(FORMAT(ROUND(DeclarRS2."VAT Amount" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantTVA>' + CRLF);
                            end;
                            OutStr.WriteText(PADSTR('', 5) + '<MontantTTC>' + DELCHR(FORMAT(ROUND(DeclarRS2."Total Amount" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantTTC>' + CRLF);
                            OutStr.WriteText(PADSTR('', 5) + '<MontantRS>' + DELCHR(FORMAT(ROUND(DeclarRS2."Montant RS" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantRS>' + CRLF);
                            //OutStr.WriteText(PADSTR('',5)+'<TaxeAdditionnelle Code='+Finance1."Tax additionnelle (Code)"+'Taux='+FORMAT(Finance1."Tax additionnelle (taux)")+'</TaxeAdditionnelle>');
                            OutStr.WriteText(PADSTR('', 5) + '<MontantNetServi>' + DELCHR(FORMAT(ROUND(DeclarRS2."Montant Net servi" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantNetServi>' + CRLF);
                            IF DeclarRS2."Code devise" <> '' THEN BEGIN
                                OutStr.WriteText(PADSTR('', 5) + '<Devise>' + CRLF);
                                OutStr.WriteText(PADSTR('', 6) + '<CodeDevise>' + DeclarRS2."Code devise" + '</CodeDevise>' + CRLF);
                                // OutStr.WriteText(PADSTR('', 5) + '<TauxChange>' + FormatAmount(FORMAT(DeclarRS2."Taux de change"), 6) + '</TauxChange>' + CRLF); //Cmt HD
                                OutStr.WriteText(PADSTR('', 5) + '<TauxChange>' + AmountToText(DeclarRS2."Taux de change", 0.000001) + '</TauxChange>' + CRLF);
                                OutStr.WriteText(PADSTR('', 6) + '<MontantRSDevise>' + DELCHR(FORMAT(ROUND(DeclarRS2."Montant RS devise" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantRSDevise>' + CRLF); //HD
                                OutStr.WriteText(PADSTR('', 6) + '<MontantTTCDevise>' + DELCHR(FORMAT(ROUND(DeclarRS2."Total Currency Amount" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantTTCDevise>' + CRLF);
                                OutStr.WriteText(PADSTR('', 6) + '<MontantNetServiDevise>' + DELCHR(FORMAT(ROUND(DeclarRS2."Net Amount in Currency" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</MontantNetServiDevise>' + CRLF);
                                // OutStr.WriteText(PADSTR('', 6) + '<MontantRSDevise>' + AmountToText(DeclarRS2."Montant RS devise") + '</MontantRSDevise>' + CRLF);
                                // OutStr.WriteText(PADSTR('', 6) + '<MontantTTCDevise>' + AmountToText(DeclarRS2."Total Currency Amount") + '</MontantTTCDevise>' + CRLF);
                                // OutStr.WriteText(PADSTR('', 6) + '<MontantNetServiDevise>' + AmountToText(DeclarRS2."Net Amount in Currency") + '</MontantNetServiDevise>' + CRLF);
                                OutStr.WriteText(PADSTR('', 5) + '</Devise>' + CRLF);
                            END;
                            OutStr.WriteText(PADSTR('', 4) + '</Operation>' + CRLF);
                        UNTIL (DeclarRS2.NEXT) = 0;
                    OutStr.WriteText(PADSTR('', 3) + '</ListeOperations>' + CRLF);
                    OutStr.WriteText(PADSTR('', 3) + '<TotalPayement>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<TotalMontantHT>' + DELCHR(FORMAT(ROUND(DeclarRS1."Amount HT" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantHT>' + CRLF);
                    if GenLedgSetup."Incl VAT Withholding Tax Decl" then
                        OutStr.WriteText(PADSTR('', 4) + '<TotalMontantTVA>' + DELCHR(FORMAT(ROUND(DeclarRS1."VAT Amount" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantTVA>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<TotalMontantTTC>' + DELCHR(FORMAT(ROUND(DeclarRS1."Total Amount" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantTTC>' + CRLF);
                    OutStr.WriteText(PADSTR('', 4) + '<TotalMontantRS>' + DELCHR(FORMAT(ROUND(DeclarRS1."Montant RS" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantRS>' + CRLF);
                    //IF (Finance."Total Taxe"<>0) THEN BEGIN
                    //FileName.WriteText(PADSTR('',4)+'<TotalTaxes>');
                    //FileName.WriteText(PADSTR('',4)+'</TotalTaxes>');
                    //END;
                    OutStr.WriteText(PADSTR('', 4) + '<TotalMontantNetServi>' + DELCHR(FORMAT(ROUND(DeclarRS1."Montant Net servi" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantNetServi>' + CRLF);
                    IF (DeclarRS1."Code devise" <> '') THEN BEGIN
                        OutStr.WriteText(PADSTR('', 4) + '<TotalDevise>' + CRLF);
                        OutStr.WriteText(PADSTR('', 5) + '<TotalMontantDevise Code="' + DeclarRS1."Code devise" + '">' + CRLF);
                        OutStr.WriteText(PADSTR('', 6) + '<TotalMontantRS>' + DELCHR(FORMAT(ROUND(DeclarRS1."Montant RS devise" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantRS>' + CRLF); //Cmt HD
                        OutStr.WriteText(PADSTR('', 6) + '<TotalMontantTTC>' + DELCHR(FORMAT(ROUND(DeclarRS1."Total Currency Amount" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantTTC>' + CRLF); //Cmt HD
                        OutStr.WriteText(PADSTR('', 6) + '<TotalMontantNetServi>' + DELCHR(FORMAT(ROUND(DeclarRS1."Net Amount in Currency" * 1000, 1), 0, '<Integer>'), '=', ',.') + '</TotalMontantNetServi>' + CRLF); //Cmt HD
                        // OutStr.WriteText(PADSTR('', 6) + '<TotalMontantRS>' + AmountToText(DeclarRS1."Montant RS devise") + '</TotalMontantRS>' + CRLF);
                        // OutStr.WriteText(PADSTR('', 6) + '<TotalMontantTTC>' + AmountToText(DeclarRS1."Total Currency Amount") + '</TotalMontantTTC>' + CRLF);
                        // OutStr.WriteText(PADSTR('', 6) + '<TotalMontantNetServi>' + AmountToText(DeclarRS1."Net Amount in Currency") + '</TotalMontantNetServi>' + CRLF);
                        OutStr.WriteText(PADSTR('', 5) + '</TotalMontantDevise>' + CRLF);
                        OutStr.WriteText(PADSTR('', 4) + '</TotalDevise>' + CRLF);
                    END;
                    OutStr.WriteText(PADSTR('', 3) + '</TotalPayement>' + CRLF);
                    OutStr.WriteText(PADSTR('', 2) + '</Certificat>' + CRLF);
                UNTIL DeclarRS1.NEXT = 0;
            END;
            OutStr.WriteText(PADSTR('', 1) + '</AjouterCertificats>' + CRLF);
            OutStr.WriteText('</DeclarationsRS>' + CRLF);

            NomFichier := COPYSTR(CompanyInformation."VAT Registration No.", 1, 8) + '-' + DeclarRS."Deposit Year" + '-' + DeclarRS."Payment Month" + '-' + FORMAT(AcDep) + '.xml';
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
        DocNoFilter: Code[20];
        CompGenNo: Code[20];
        InclureVAT: Boolean;
        GenLedgSetup: Record "General Ledger Setup";
        GLEntry: Record "G/L Entry";
        SeqNo: Integer;
        GLAccount: Record "G/L Account";
        // Currency: Record Currency;
        // CurrencyExchangeRate: Record "Currency Exchange Rate";
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
        IsEditable: Boolean;
        TEJManagement: Codeunit "TEJ Management";

}
