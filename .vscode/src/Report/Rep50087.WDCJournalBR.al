report 50087 "Journal BR"
/**********************************Documentation*********************
//WDC01     WDC.FS   09/01/2026        Creation of "Journal BR" report 
*********************************************************************/
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    CaptionML = ENU = 'BR Journal', FRA = 'Journal BR';
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src/report/RDLC/JournalBR.rdl';
    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            //DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(GLAccountNo; "G/L Account"."No.")
            {

            }
            column(GLAccountName; "G/L Account"."Name")
            {

            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(GLEntry_GlAccountNo; GLEntry."G/L Account No.")
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(companyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(Companytel; CompanyInfo."Phone No.")
            {
            }
            column(BanqueName; CompanyInfo."Bank Name")
            {
            }
            column(IBNA; CompanyInfo.IBAN)
            {
            }
            column(CodeFiscalCompany; CompanyInfo."VAT Registration No.")
            {
            }
            column(Registration_No_; CompanyInfo."Registration No.")
            {
            }

            dataitem(GLEntry; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = field("No.");
                DataItemTableView = SORTING("G/L Account No.", "Posting Date");

                column(SourceType; "Source Type")
                {
                }
                column(SourceNo; "Source No.")
                {
                }
                column(SourceName; SourceName)
                {
                }
                column(PostingDate; "Posting Date")
                {
                }
                column(Document_No; "Document No.")
                {
                }
                column(Ext_Document_No; "External Document No.")
                {
                }
                column(JournalCode; JournalCode)
                {
                }
                column(DebitAmount; "Debit Amount")
                {
                }
                column(CreditAmount; "Credit Amount")
                {
                }
                column(Amount; Amount)
                {

                }
                column(CreditCurrencyAmount; CreditCurrencyAmount)
                {

                }
                column(DebitCurrencyAmount; DebitCurrencyAmount)
                {

                }
                column(filtertext; filtertext + '  ')
                {
                }
                trigger OnAfterGetRecord()
                var
                    lVendor: Record Vendor;
                    lCustomer: Record Customer;
                    lBankAccount: Record "Bank Account";
                begin
                    CreditCurrencyAmount := 0;
                    DebitCurrencyAmount := 0;

                    JournalCode := '';
                    SourceName := '';
                    if "Source Type" = "Source Type"::"Fixed Asset" then
                        JournalCode := GLEntry."Gen. Bus. Posting Group"
                    else if "Source Type" = "Source Type"::Vendor then begin
                        if lVendor.Get("Source No.") then
                            SourceName := lVendor.Name;
                        if GLEntry."Gen. Bus. Posting Group" <> '' then
                            JournalCode := GLEntry."Gen. Bus. Posting Group"
                        else
                            JournalCode := lVendor."Gen. Bus. Posting Group"
                    end else
                        if "Source Type" = "Source Type"::Customer then begin
                            if lCustomer.Get("Source No.") then
                                SourceName := lCustomer.Name;
                            JournalCode := 'VTE';
                        end else
                            if "Source Type" = "Source Type"::"Bank Account" then begin
                                if lBankAccount.Get("Source No.") then
                                    SourceName := lBankAccount.Name;
                                JournalCode := GLEntry."Source No.";
                            end Else begin
                                if GLEntry."Journal Batch Name" <> 'DEFAUT' then
                                    JournalCode := GLEntry."Journal Batch Name";
                                if CopyStr(GLEntry."G/L Account No.", 1, 3) = '432' then
                                    JournalCode := 'R/S FRS';
                                if GLEntry."No. Series" = 'SAL' then
                                    JournalCode := 'SAL';
                                if GLEntry."No. Series" = 'OD' then
                                    JournalCode := 'OD';
                            end;

                    if "Credit Amount" <> 0 then
                        CreditCurrencyAmount := "Source Currency Amount" * -1
                    else
                        DebitCurrencyAmount := "Source Currency Amount";
                end;

                trigger OnPreDataItem()
                begin

                    if (StartDatefilter <> 0D) and (EndDatefilter <> 0D) then
                        SetRange("Posting Date", StartDatefilter, EndDatefilter);

                    if GlAccountNofilter <> '' then
                        SetFilter("G/L Account No.", GlAccountNofilter);

                    FilterText := PostingText + Format(StartDatefilter) + ' | ' + GlentryText + GlaccountNofilter;
                end;


            }
            trigger OnPreDataItem()
            begin
                if GlaccountNofilter <> '' then
                    "G/L Account".SetRange("No.", GlAccountNofilter);
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filtres)
                {
                    field(StartDatefilter; StartDatefilter)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Start date', FRA = 'Date  début';
                    }
                    field(EndDatefilter; EndDatefilter)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'End date', FRA = 'Date fin';
                    }
                    // field(GlaccountNofilter; GlaccountNofilter)
                    // {
                    //     ApplicationArea = all;
                    //     Captionml = ENU = 'G/L Account No.', FRA = 'N° compte général';
                    //     TableRelation = "G/L Account";
                    // }

                }
            }
        }
    }
    trigger OnPreReport()

    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        DebitCurrencyAmount: Decimal;
        CreditCurrencyAmount: Decimal;
        SourceName: Text[100];
        CompanyInfo: Record "Company Information";
        JournalCode: Text;
        filtertext: Text[200];
        Totalamount: Decimal;
        StartDatefilter: date;
        EndDatefilter: date;
        GlAccountNofilter: code[20];
        PostingText: textConst ENU = 'Posting Date: ', FRA = ' Date comptabilisation: ';
        GlentryText: textConst ENU = 'G/L Account No.: ', FRA = 'N° compte général: ';

}
