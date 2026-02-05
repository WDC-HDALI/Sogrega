namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Document;

report 50003 "WDC Suivi consommation"
{
    /**********************************Documentation*********************
   //WDC01     WDC.HG    03/12/2024        Creation "Suivi consommation" report
   *********************************************************************/
    RDLCLayout = './.vscode/src/Report/RDLC/SuiviConsommation.rdlc';
    CaptionML = FRA = 'Suivi consommation', ENU = 'Consumption Follow up';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Basic, Suite;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    EnableHyperlinks = true;

    dataset
    {
        dataitem("Prod. Order Component"; "Prod. Order Component")
        {
            DataItemTableView = sorting("Item No.") WHERE(Status = FILTER(released));
            RequestFilterFields = "Shortcut Dimension 1 Code", "Prod. Order No.", "Due Date", "Item No.";

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
            column(ItemNo; "Item No.")
            {
            }
            column(ProdOrderNo; "Prod. Order No.")
            {
            }
            column(Quantity; "Expected Quantity")
            {
            }
            column(RemainingQuantity; "Remaining Quantity")
            {
            }
            column(Description; Description)
            {
            }
            column(UnitofMeasureCode; "Unit of Measure Code")
            {
            }
            trigger OnAfterGetRecord()
            begin

            end;

            trigger OnPreDataItem()
            begin
                filtertext := "Prod. Order Component".GetFilters;
            end;


        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
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
}
