namespace sogrega.sogrega;

using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;

report 50095 "WDC Purchase Order Receipt"
{
    Captionml = ENU = 'Purchase Order Receipt', FRA = 'Réception Commande Achat';
    RDLCLayout = './.vscode/src/Report/RDLC/PurchaseOrderReceipts.rdlc';
    Description = 'Facture vente';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Basic, Suite;
    DefaultLayout = RDLC;
    EnableHyperlinks = true;
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")

        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            column(FORMATTODAY04; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {

            }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
            {
            }

            column(CompanyInfoEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {

            }
            column(CompanyInfoCity; CompanyInfo.City)
            {

            }
            column(CompanyInfoPostcode; CompanyInfo."Post Code")
            {

            }
            column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyInfoBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
            {
            }

            column(No_; "No.")
            {

            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {

            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(Buy_from_Address; "Buy-from Address")
            {

            }
            column(Buy_from_City; "Buy-from City")
            {

            }
            column(Buy_from_Post_Code; "Buy-from Post Code")
            {

            }
            column(Document_Date; "Document Date")
            {

            }
            column(VendorNoLBL; VendorNoLBL)
            {

            }
            column(vendorNameLBL; vendorNameLBL)
            {

            }
            column(DocumentDateLBL; DocumentDateLBL)
            {

            }
            column(OrderNoLBL; OrderNoLBL)
            {

            }
            column(CompanyPhoneNumberLBL; CompanyPhoneNumberLBL)
            {

            }
            column(CompanyEmailLBL; CompanyEmailLBL)
            {

            }
            column(CompanyIdentifLBL; CompanyIdentifLBL)
            {

            }
            column(CompanyCCPLBL; CompanyCCPLBL)
            {

            }
            column(CompanyBankLBL; CompanyBankLBL)
            {

            }
            column(CompanyBankNumberLBL; CompanyBankNumberLBL)
            {

            }
            column(TitleLBL; TitleLBL)
            {

            }
            column(VendorAddressLBL; VendorAddressLBL)
            {

            }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Order No." = field("No.");
                DataItemLinkReference = PurchaseHeader;
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(ItemNo; "No.")
                {

                }
                column(Description; Description)
                {

                }
                column(Document_No_; "Document No.")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Location_Code; "Location Code")
                {

                }
                column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
                {

                }
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
                {

                }
                column(Order_No_; "Order No.")
                {

                }
                column(UOM_PurchRcptLine; "Unit of Measure Code")
                {

                }
                column(LineNo_PurchRcptLine; "Line No.")
                {
                }
                column(ReceptionNoLBL; ReceptionNoLBL)
                {

                }
                column(ItemNoLBL; ItemNoLBL)
                {

                }
                column(DescriptionLBL; DescriptionLBL)
                {

                }
                column(QuantityLBL; QuantityLBL)
                {

                }
                column(UOMLBL; UOMLBL)
                {

                }
            }

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
        VendorNoLBL: TextConst ENU = 'Pay to Vendor No.', FRA = 'N° fournisseur à payer';
        DocumentDateLBL: TextConst ENU = 'Docuemnt Date', FRA = 'Date document';

        OrderNoLBL: TextConst ENU = 'Order No.', FRA = 'N° commande';


        CompanyPhoneNumberLBL: TextConst ENU = 'Phone No.', FRA = 'N° téléphone';


        CompanyEmailLBL: TextConst ENU = 'E-mail', FRA = 'E-mail';

        CompanyIdentifLBL: TextConst ENU = 'N° identif.', FRA = 'N° identif.';

        CompanyCCPLBL: TextConst ENU = 'N° CCP', FRA = 'N° CCP';

        CompanyBankLBL: TextConst ENU = 'Bank', FRA = 'Banque';

        CompanyBankNumberLBL: TextConst ENU = 'Bank No.', FRA = 'N° Banque';

        ReceptionNoLBL: TextConst ENU = 'Receipt No.', FRA = 'N° réception';
        ItemNoLBL: TextConst ENU = 'No.', FRA = 'N°';
        DescriptionLBL: TextConst ENU = 'Description', FRA = 'Description';
        QuantityLBL: TextConst ENU = 'Quantity', FRA = 'Quantité';
        UOMLBL: TextConst ENU = 'UOM', FRA = 'unité';
        vendorNameLBL: TextConst ENU = 'Pay to Vendor Name', FRA = 'Nom fournisseur à payer';
        TitleLBL: TextConst ENU = 'Purchase : Receipts', FRA = 'Achats : Réceptions';
        VendorAddressLBL: TextConst ENU = 'Address', FRA = 'Adresse';




}

