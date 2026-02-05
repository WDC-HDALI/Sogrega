namespace sogrega.sogrega;

using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Location;

report 50005 "WDC Inter-site goods transfers"
{
    RDLCLayout = './.vscode/src/Report/RDLC/IntersiteTransfer.rdlc';
    CaptionML = FRA = 'Transferts marchandises inter-site', ENU = 'Inter-site goods transfers';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Basic, Suite;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    EnableHyperlinks = true;
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Posting Date") WHERE("Entry Type" = FILTER(transfer), Quantity = filter(> 0));
            RequestFilterFields = "Posting Date", "Item No.";
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
            column(filtertext; filtertext)
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
            column(locationcode; "Location Code")
            {

            }
            column(Nlot; "Lot No.")
            {

            }
            column(quantity; "Quantity")
            {

            }
            column(Cost_Amount__Actual_; "Cost Amount (Actual)")
            {

            }
            column(filtertext1; Textfilter2 + format(SourceLocation))
            {

            }
            column(filtertext2; Textfilter1 + format(DestinationLocation))
            {

            }

            trigger OnAfterGetRecord()
            var

            begin
                Item.reset();
                if Item.get("Item No.") then;
                if ItemLedgerEntry."Location Code" <> DestinationLocation then
                    CurrReport.skip;
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
                    field(DestinationLocation; DestinationLocation)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = FRA = 'Magasin destination', ENU = 'Destination Location';
                        TableRelation = Location;
                    }
                }
            }
        }
    }
    trigger OnPreReport()

    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
        if DestinationLocation = '' THEN ERROR(text001);
        if DestinationLocation = SourceLocation THEN ERROR(text003);
    end;

    var
        CompanyInfo: record 79;

        Item: record 27;
        location: record Location;
        SourceLocation: code[10];
        DestinationLocation: code[10];
        filtertext: text;
        Text001: TextConst FRA = 'Le magasin destination est obligatoire',
                           ENU = 'The destination location is mandatory';
        Text003: TextConst FRA = 'Magasin source et magasin destination doivent être differents',
                           ENU = 'The source and destination locations must be different';
        Textfilter1: TextConst FRA = 'Magasin destination : ',
                               ENU = 'Destination Location ';
        Textfilter2: TextConst FRA = 'Magasin source : ',
                               ENU = 'Source Location : ';

}
