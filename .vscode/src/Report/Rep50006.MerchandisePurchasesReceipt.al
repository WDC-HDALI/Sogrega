namespace sogrega.sogrega;

using Microsoft.Inventory.Ledger;
using Microsoft.Finance.GeneralLedger.Setup;

report 50006 "Merchandise Purchases Receipt"
{
    RDLCLayout = './.vscode/src/Report/RDLC/ReceptionMagasin.rdlc';
    CaptionML = FRA = 'Réceptions achat marchandises',
                ENU = 'Merchandise Purchases Receipt';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Basic, Suite;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    EnableHyperlinks = true;
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Posting Date") WHERE("Entry Type" = FILTER(Purchase), "Document Type" = filter("Purchase Receipt"), Quantity = filter(> 0), "Source Type" = filter(vendor));
            RequestFilterFields = "Location Code", "Posting Date", "Source No.", "Item No.";
            column(CompanyPicture; CompanyInfo.Picture)
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
            column(filtertext; filtertext + '  ')
            {

            }
            column(filterGrComptproduit; 'Groupe compta. produit : ' + ' ' + format(GenProdPostingGroup))
            {

            }
            column(PostingDate; "Posting Date")
            {

            }
            column(ItemNo; "Item No.")
            {

            }
            column(Description; Item.Description)
            {

            }
            column(PostingGroup; Item."Gen. Prod. Posting Group")
            {

            }
            column(GenProdPostingGroup; GenProdPostingGroup)
            {

            }


            column(locationcode; "Location Code")
            {

            }
            column(Nlot; "Lot No.")
            {

            }
            column(VendorNo; "Source No.")
            {

            }
            column(VendorName; Vendor.Name)
            {

            }

            column(quantity; "Quantity")
            {

            }
            column(DocumentNo; "Document No.")
            {

            }
            column(Cost_Amount__Actual_; cout)
            {

            }
            trigger OnAfterGetRecord()
            var
            begin
                CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                cout := 0;
                Item.reset();
                if Item.get("Item No.") then
                    if GenProdPostingGroup <> '' then
                        if Item."Gen. Prod. Posting Group" <> GenProdPostingGroup then
                            CurrReport.skip();
                Vendor.reset();
                if Vendor.get("Source No.") then;
                if ItemLedgerEntry."Cost Amount (Actual)" = 0 then
                    cout := ItemLedgerEntry."Cost Amount (Expected)"
                else
                    cout := ItemLedgerEntry."Cost Amount (Actual)";

            end;

            trigger OnPreDataItem()
            begin
                filtertext := ItemLedgerEntry.GetFilters;
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(GenProdPostingGroup; GenProdPostingGroup)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = FRA = 'Groupe compta. produit', ENU = 'Gen. Prod. Posting Group';
                        TableRelation = "Gen. Product Posting Group";
                    }

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
        CompanyInfo: record 79;
        filtertext: text;
        Item: record 27;
        Vendor: record 23;
        GenProdPostingGroup: code[20];
        cout: Decimal;


}

