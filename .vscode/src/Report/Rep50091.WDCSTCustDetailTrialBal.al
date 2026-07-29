report 50091 "WDC-ST Cust Detail Trial Bal."
//****************Documentation*********************
//WDC01   WDC.FS   02/03/2026  Edit Report 
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src/report/RDLC/CustomerDetailTrialBalance.rdlc';
    ApplicationArea = Basic, Suite;
    Caption = 'Grand livre client Sogrega';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(STRSUBSTNO_Text003_USERID_; StrSubstNo(Text003, UserId))
            {
            }
            column(STRSUBSTNO_Text004_PreviousStartDate_; StrSubstNo(Text004, PreviousStartDate))
            {
            }
            column(PageCaption; StrSubstNo(Text005, ''))
            {
            }
            column(PrintedByCaption; StrSubstNo(Text003, ''))
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(Customer_TABLECAPTION__________Filter; Customer.TableCaption + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(ReportDebitAmountLCY; ReportDebitAmountLCY)
            {
            }
            column(ReportCreditAmountLCY; ReportCreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_ReportCreditAmountLCY; ReportDebitAmountLCY - ReportCreditAmountLCY)
            {
            }
            column(STRSUBSTNO_Text006_PreviousEndDate_; StrSubstNo(Text006, PreviousEndDate))
            {
            }
            column(PreviousDebitAmountLCY; PreviousDebitAmountLCY)
            {
            }
            Column(PreviousDebitAmount; PreviousDebitAmount)
            {

            }
            column(PreviousCreditAmountLCY; PreviousCreditAmountLCY)
            {
            }
            //<<WDC01
            column(PreviousCreditAmount; PreviousCreditAmount)
            {
            }
            //>>WDC01
            column(PreviousDebitAmountLCY_PreviousCreditAmountLCY; PreviousDebitAmountLCY - PreviousCreditAmountLCY)
            {
            }
            //<<WDC01
            column(PreviousDebitAmount_PreviousCreditAmount; PreviousDebitAmount - PreviousCreditAmount)
            {
            }
            //>>WDC01
            column(ReportDebitAmountLCY_Control1120062; ReportDebitAmountLCY)
            {
            }
            column(ReportCreditAmountLCY_Control1120064; ReportCreditAmountLCY)
            {
            }
            column(ReportDebitAmountLCY_ReportCreditAmountLCY_Control1120066; ReportDebitAmountLCY - ReportCreditAmountLCY)
            {
            }
            column(GeneralDebitAmountLCY; GeneralDebitAmountLCY)
            {
            }
            //<<WDC01
            column(GeneralDebitAmount; GeneralDebitAmount)
            {
            }
            column(GeneralCreditAmount; GeneralCreditAmount)
            {
            }
            //>>WDC01
            column(GeneralCreditAmountLCY; GeneralCreditAmountLCY)
            {
            }
            column(GeneralDebitAmountLCY_GeneralCreditAmountLCY; GeneralDebitAmountLCY - GeneralCreditAmountLCY)
            {
            }
            //<<WDC01
            column(GeneralDebitAmount_GeneralCreditAmount; GeneralDebitAmount - GeneralCreditAmount)
            {
            }
            //>>WDC01
            column(Customer_Date_Filter; "Date Filter")
            {
            }
            column(Customer_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(Customer_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(Customer_Currency_Filter; "Currency Filter")
            {
            }
            column(Customer_Detail_Trial_BalanceCaption; Customer_Detail_Trial_BalanceCaptionLbl)
            {
            }
            column(This_report_also_includes_customers_that_only_have_balances_Caption; This_report_also_includes_customers_that_only_have_balances_CaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Source_CodeCaption; Source_CodeCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(External_Document_No_Caption; External_Document_No_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(ContinuedCaption; ContinuedCaptionLbl)
            {
            }
            column(DebitDeviselbl; DebitDeviselbl)
            {
            }
            column(CreditDeviselbl; CreditDeviselbl)
            {
            }
            column(balanceDeviselbl; balanceDeviselbl)
            {
            }

            column(To_be_continuedCaption; To_be_continuedCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            dataitem(Date; Date)
            {
                DataItemTableView = SORTING("Period Type");
                column(DebitPeriodAmount_PreviousDebitAmountLCY___CreditPeriodAmount_PreviousCreditAmountLCY_; (DebitPeriodAmount + PreviousDebitAmountLCY) - (CreditPeriodAmount + PreviousCreditAmountLCY))
                {
                }
                //<<WDC01
                column(DebitPeriodAmount_PreviousDebitAmount___CreditPeriodAmount_PreviousCreditAmount_; (DebitPeriodAmnt + PreviousDebitAmount) - (CreditPeriodAmnt + PreviousCreditAmount))
                {
                }
                //>>WDC01
                column(CreditPeriodAmount_PreviousCreditAmountLCY; CreditPeriodAmount + PreviousCreditAmountLCY)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmountLCY; DebitPeriodAmount + PreviousDebitAmountLCY)
                {
                }
                //<<WDC01
                column(CreditPeriodAmount_PreviousCreditAmount; CreditPeriodAmnt + PreviousCreditAmount)
                {
                }
                column(DebitPeriodAmount_PreviousDebitAmount; DebitPeriodAmnt + PreviousDebitAmount)
                {
                }
                //>>WDC01
                column(STRSUBSTNO_Text006_EndDate_; StrSubstNo(Text006, EndDate))
                {
                }
                column(STRSUBSTNO_Text007_EndDate_; StrSubstNo(Text007, EndDate))
                {
                }
                column(DebitPeriodAmount; DebitPeriodAmount)
                {
                }
                //<<WDC01
                column(DebitPeriodAmnt; DebitPeriodAmnt)
                {

                }
                //>>WDC01
                column(DebitPeriodAmount_PreviousDebitAmountLCY_Control1120082; DebitPeriodAmount + PreviousDebitAmountLCY)
                {
                }
                column(CreditPeriodAmount; CreditPeriodAmount)
                {
                }
                //<<WDC01
                column(CreditPeriodAmnt; CreditPeriodAmnt)
                {
                }
                //>>WDC01
                column(CreditPeriodAmount_PreviousCreditAmountLCY_Control1120086; CreditPeriodAmount + PreviousCreditAmountLCY)
                {
                }
                column(DebitPeriodAmount_CreditPeriodAmount; DebitPeriodAmount - CreditPeriodAmount)
                {
                }
                //<<WDC01
                column(DebitPeriodAmnt_CreditPeriodAmnt; DebitPeriodAmnt - CreditPeriodAmnt)
                {
                }
                //>>WDC01
                column(DebitPeriodAmount_PreviousDebitAmountLCY___CreditPeriodAmount_PreviousCreditAmountLCY__Control1120090; (DebitPeriodAmount + PreviousDebitAmountLCY) - (CreditPeriodAmount + PreviousCreditAmountLCY))
                {
                }
                column(Date_Period_Type; "Period Type")
                {
                }
                column(Date_Period_Start; "Period Start")
                {
                }
                column(Total_Date_RangeCaption; Total_Date_RangeCaptionLbl)
                {
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Customer No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"), "Currency Code" = FIELD("Currency Filter");
                    DataItemLinkReference = Customer;
                    DataItemTableView = SORTING("Customer No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code") WHERE("Entry Type" = FILTER(<> Application));
                    //<<WDC01
                    Column(DebitAmount; "Debit Amount")
                    {

                    }
                    Column(CreditAmount; "Credit Amount")
                    {

                    }
                    //>>WDC01
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY__; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY__; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY__; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Posting_Date_; Format("Posting Date"))
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Source_Code_; "Source Code")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Document_No__; "Document No.")
                    {
                    }
                    column(OriginalLedgerEntry__External_Document_No__; OriginalLedgerEntry."External Document No.")
                    {
                    }
                    column(OriginalLedgerEntry_Description; OriginalLedgerEntry.Description)
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY___Control1120116; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY___Control1120119; "Credit Amount (LCY)")
                    {
                    }
                    column(BalanceLCY; BalanceLCY)
                    {
                    }
                    //<<WDC01
                    column(Balance; Balance1)
                    {
                    }
                    //>>WDC01
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY___Control1120126; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY___Control1120128; "Credit Amount (LCY)")
                    {
                    }
                    column(Debit_Amount__LCY______Credit_Amount__LCY___Control1120130; "Debit Amount (LCY)" - "Credit Amount (LCY)")
                    {
                    }
                    column(Text008_________FORMAT_Date__Period_Type___________Date__Period_Name_; Text008 + ' ' + Format(Date."Period Type") + ' ' + Date."Period Name")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Debit_Amount__LCY___Control1120136; "Debit Amount (LCY)")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry__Credit_Amount__LCY___Control1120139; "Credit Amount (LCY)")
                    {
                    }
                    column(BalanceLCY_Control1120142; BalanceLCY)
                    {
                    }
                    column(DatePeriodTypeInt; DatePeriodTypeInt)
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Customer_No_; "Customer No.")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Posting_Date; "Posting Date")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Initial_Entry_Global_Dim__1; "Initial Entry Global Dim. 1")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Initial_Entry_Global_Dim__2; "Initial Entry Global Dim. 2")
                    {
                    }
                    column(Detailed_Cust__Ledg__Entry_Currency_Code; "Currency Code")
                    {
                    }
                    column(Previous_pageCaption; Previous_pageCaptionLbl)
                    {
                    }
                    column(Current_pageCaption; Current_pageCaptionLbl)
                    {
                    }
                    column(PostingYearValue; Format(Date2DMY("Posting Date", 3)))
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if ("Debit Amount (LCY)" = 0) and
                           ("Credit Amount (LCY)" = 0)
                        then
                            CurrReport.Skip();
                        //<<WDC01
                        if ("Debit Amount" = 0) and ("Credit Amount" = 0)
                        then
                            CurrReport.Skip();

                        OriginalLedgerEntry.Get("Cust. Ledger Entry No.");
                        OriginalLedgerEntry.CalcFields("Debit Amount (LCY)", "Credit Amount (LCY)");
                        BalanceLCY := BalanceLCY + OriginalLedgerEntry."Debit Amount (LCY)" - OriginalLedgerEntry."Credit Amount (LCY)";
                        //BalanceLCY := BalanceLCY + "Amount (LCY)";
                        Balance1 := Balance1 + "Amount";
                        //>>WDC01

                        GeneralDebitAmountLCY := GeneralDebitAmountLCY + OriginalLedgerEntry."Debit Amount (LCY)";
                        GeneralCreditAmountLCY := GeneralCreditAmountLCY + OriginalLedgerEntry."Credit Amount (LCY)";
                        //<<WDC01
                        GeneralDebitAmount := GeneralDebitAmount + "Debit Amount";
                        GeneralCreditAmount := GeneralCreditAmount + "Credit Amount";
                        //>>WDC01
                        DebitPeriodAmount := DebitPeriodAmount + OriginalLedgerEntry."Debit Amount (LCY)";
                        CreditPeriodAmount := CreditPeriodAmount + OriginalLedgerEntry."Credit Amount (LCY)";
                        //<<WDC01
                        DebitPeriodAmnt := DebitPeriodAmnt + "Debit Amount";
                        CreditPeriodAmnt := CreditPeriodAmnt + "Credit Amount";
                        //>>WDC01
                    end;

                    trigger OnPostDataItem()
                    begin
                        ReportDebitAmountLCY := ReportDebitAmountLCY + "Debit Amount (LCY)";
                        ReportCreditAmountLCY := ReportCreditAmountLCY + "Credit Amount (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        if DocNumSort then
                            SetCurrentKey("Customer No.", "Document No.", "Posting Date");
                        if StartDate > Date."Period Start" then
                            Date."Period Start" := StartDate;
                        if EndDate < Date."Period End" then
                            Date."Period End" := EndDate;
                        SetRange("Posting Date", Date."Period Start", Date."Period End");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    DatePeriodTypeInt := Date."Period Type";
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Period Type", TotalBy);
                    SetRange("Period Start", CalcDate('<-CM>', StartDate), ClosingDate(EndDate));
                    //PrintOnlyIfDetail := ExcludeBalanceOnly or (BalanceLCY = 0);
                    PrintOnlyIfDetail := ExcludeBalanceOnly or (BalanceLCY = 0) or (balance1 = 0); //WDC01
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CustLedgEntry.SetCurrentKey(
                  "Customer No.", "Posting Date", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
                CustLedgEntry.SetRange("Customer No.", "No.");
                CustLedgEntry.SetRange("Posting Date", 0D, PreviousEndDate);
                CustLedgEntry.SetFilter(
                  "Entry Type",
                  '<>%1&<>%2',
                  CustLedgEntry."Entry Type"::Application,
                  CustLedgEntry."Entry Type"::"Appln. Rounding");

                CustLedgEntry.CalcSums("Debit Amount (LCY)", "Credit Amount (LCY)", "Debit Amount", "Credit Amount");
                PreviousDebitAmountLCY := CustLedgEntry."Debit Amount (LCY)";
                PreviousCreditAmountLCY := CustLedgEntry."Credit Amount (LCY)";
                //<<WDC01

                PreviousDebitAmount := CustLedgEntry."Debit Amount";
                PreviousCreditAmount := CustLedgEntry."Credit Amount";
                //>>WDC01

                CustLedgEntry2.CopyFilters(CustLedgEntry);
                CustLedgEntry2.SetRange("Posting Date", StartDate, EndDate);
                if not (ExcludeBalanceOnly and CustLedgEntry2.IsEmpty) then begin
                    GeneralDebitAmountLCY := GeneralDebitAmountLCY + PreviousDebitAmountLCY;
                    GeneralCreditAmountLCY := GeneralCreditAmountLCY + PreviousCreditAmountLCY;
                    //<<WDC01
                    GeneralDebitAmount := GeneralDebitAmount + PreviousDebitAmount;
                    GeneralCreditAmount := GeneralCreditAmount + PreviousCreditAmount;
                    //>>WDC01
                end;
                BalanceLCY := PreviousDebitAmountLCY - PreviousCreditAmountLCY;
                Balance1 := PreviousDebitAmount - PreviousCreditAmount; //WDC01
                DebitPeriodAmount := 0;
                CreditPeriodAmount := 0;
                //<<WDC01
                DebitPeriodAmnt := 0;
                CreditPeriodAmnt := 0;
                //>>WDC01
                //PrintOnlyIfDetail := ExcludeBalanceOnly or (BalanceLCY = 0);
                PrintOnlyIfDetail := ExcludeBalanceOnly or (BalanceLCY = 0) or (balance1 = 0);
            end;

            trigger OnPreDataItem()
            begin
                if GetFilter("Date Filter") = '' then
                    Error(Text001, FieldCaption("Date Filter"));
                if CopyStr(GetFilter("Date Filter"), 1, 1) = '.' then
                    Error(Text002);
                StartDate := GetRangeMin("Date Filter");
                PreviousEndDate := ClosingDate(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := ConvertStr(TextDate, '.', ',');
                FiltreDateCalc.VerifiyDateFilter(TextDate);
                TextDate := CopyStr(TextDate, 1, 8);
                Evaluate(PreviousStartDate, TextDate);
                if CopyStr(GetFilter("Date Filter"), StrLen(GetFilter("Date Filter")), 1) = '.' then
                    EndDate := 0D
                else
                    EndDate := GetRangeMax("Date Filter");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DocNumSort; DocNumSort)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sorted by Document No.';
                        ToolTip = 'Specifies criteria for arranging information in the report.';
                    }
                    field(ExcludeBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Exclude Customers That Have a Balance Only';
                        MultiLine = true;
                        ToolTip = 'Specifies if you do not want to display entries for customers who have a balance but do not have a net change during the selected time period.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        TotalBy := TotalBy::Month;
    end;

    trigger OnPreReport()
    begin
        Filter := Customer.GetFilters;
    end;

    var
        Text001: TextConst ENU = 'You must fill in the %1 field.', FRA = 'Vous devez remplir le champ %1';
        Text002: TextConst ENU = 'You must specify a Starting Date.', FRA = 'Vous devez spécifier une date de début.';
        Text003: TextCOnst ENU = 'Printed by %1', FRA = 'Imprimé par %1';
        Text004: TextConst ENU = 'Fiscal Year Start Date : %1', FRA = 'Date de début de l exercice financier : %1';
        Text005: TextConst ENU = 'Page %1', FRA = 'Page %1';
        Text006: TextConst ENU = 'Balance at %1 ', FRA = 'Solde à %1';
        Text007: TextConst ENU = 'Balance at %1 ', FRA = 'Solde à %1';
        Text008: TextConst ENU = 'Total', FRA = 'Total';
        CustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        OriginalLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        // FiltreDateCalc: Codeunit "DateFilter-Calc";
        FiltreDateCalc: Codeunit "WDC DateFilter-Calc";
        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        PreviousEndDate: Date;
        TextDate: Text;
        BalanceLCY: Decimal;
        Balance1: Decimal;
        TotalBy: Option Date,Week,Month,Quarter,Year;
        DocNumSort: Boolean;
        "Filter": Text;
        PreviousDebitAmountLCY: Decimal;
        PreviousDebitAmount: Decimal;
        PreviousCreditAmount: Decimal;
        PreviousCreditAmountLCY: Decimal;
        GeneralDebitAmountLCY: Decimal;
        GeneralDebitAmount: Decimal;
        GeneralCreditAmount: Decimal;
        GeneralCreditAmountLCY: Decimal;
        ReportDebitAmountLCY: Decimal;
        ReportCreditAmountLCY: Decimal;
        DebitPeriodAmount: Decimal;
        CreditPeriodAmount: Decimal;
        DebitPeriodAmnt: Decimal;
        CreditPeriodAmnt: Decimal;
        ExcludeBalanceOnly: Boolean;
        DatePeriodTypeInt: Integer;
        Customer_Detail_Trial_BalanceCaptionLbl: TextConst ENU = 'Customer Detail Trial Balance', FRA = 'Grand livre client détaillé';
        This_report_also_includes_customers_that_only_have_balances_CaptionLbl: TExtConst ENU = 'This report also includes customers that only have balances.', FRA = 'Ce rapport inclut également les clients qui ont uniquement des soldes.';
        Posting_DateCaptionLbl: TextConst ENU = 'Posting Date', FRA = 'Date de publication';
        Source_CodeCaptionLbl: TextConst ENU = 'Source Code', FRA = 'Code source';
        Document_No_CaptionLbl: TextConst ENU = 'Document No.', FRA = 'N° document';
        External_Document_No_CaptionLbl: TextConst ENU = 'External Document No.', FRA = 'N° document externe';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Description';
        DebitCaptionLbl: TextConst ENU = 'Debit', FRA = 'Débit';
        CreditCaptionLbl: TextConst ENU = 'Credit', FRA = 'Crédit';
        BalanceCaptionLbl: TextConst ENU = 'Balance', FRA = 'Solde';
        ContinuedCaptionLbl: TextConst ENU = 'Continued', FRA = 'Suite';
        To_be_continuedCaptionLbl: TextConst ENU = 'To be continued', FRA = 'À suivre';
        Grand_TotalCaptionLbl: TextConst ENU = 'Grand Total', FRA = 'Total général';
        Total_Date_RangeCaptionLbl: TextConst ENU = 'Total Date Range', FRA = 'Total période';
        Previous_pageCaptionLbl: TextConst ENU = 'Previous page', FRA = 'Page précédente';
        Current_pageCaptionLbl: TextConst ENU = 'Current page', FRA = 'Page actuelle';
        PrintOnlyIfDetails: Boolean;
        DebitDeviselbl: TextConst ENU = 'Currency Debit', FRA = 'Débit en devise';
        CreditDeviselbl: TextConst ENU = 'Currency Credit', FRA = 'Credit en devise';
        BalanceDeviselbl: TextConst ENU = 'Currency balance', FRA = 'Solde en devise';


}

