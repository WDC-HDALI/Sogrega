report 50007 "WDC Sales Invoice"
{
    /**********************************Documentation*********************
    //WDC01     WDC.HG    25/03/2025        Creation of "sales Invoice" report 
    *********************************************************************/
    RDLCLayout = './.vscode/src/Report/RDLC/SalesInvoice.rdl';
    CaptionML = ENU = 'Sales Invoice', FRA = 'Facture vente';
    Description = 'Facture vente';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Basic, Suite;
    DefaultLayout = RDLC;
    EnableHyperlinks = true;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(InvoiceNo; "No.") { }
            column(MethodTransport; Header."Transport Method") { }
            column(ItemCategDescr; ItemCateg.Description) { }
            column(DocumentExt; Header."External Document No.") { }
            column(TotalRemiseFacture; Header."Invoice Discount Amount") { }
            column(MtTtLettres; MtTtLettres) { }
            column(CompanyCity; CompanyInfo.City) { }
            column(Groupe; Groupe) { }
            column(NumeroLigne; NumeroDescription) { }
            column(CompanyName; CompanyInfo."Name") { }
            column(FaxNo; FaxNo) { }
            column(PhoneNo; PhoneNo) { }
            column(CompanyPostCod; CompanyInfo."Post Code") { }
            column(CompanyAdress; CompanyInfo.Address) { }
            column(CompanyAdress2; CompanyInfo."Address 2") { }
            column(CompanyTVAINTRA; CompanyInfo."VAT Registration No.") { }
            column(CompanySIRET; CompanyInfo."Registration No.") { }
            column(Posting_Date; "Posting Date") { }
            column(TVA_Intra; Cust."VAT Registration No.") { }
            column(CompanyAddress1; CompanyAddr[1]) { }
            column(CompanyAddress2; CompanyAddr[2]) { }
            column(CompanyAddress3; CompanyAddr[3]) { }
            column(CompanyAddress4; CompanyAddr[4]) { }
            column(CompanyAddress5; CompanyAddr[5]) { }
            column(CompanyAddress6; CompanyAddr[6]) { }
            column(CompanyAddress7; CompanyAddr[7]) { }
            column(CompanyAddress8; CompanyAddr[8]) { }
            column(CompanyEMail; CompanyInfo."E-Mail") { }
            column(BDMRCompanyPicture; CompanyInfo.Picture) { }
            column(CompanyPicture; CompanyInfo.Picture) { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyIBANN; CompanyInfo.IBAN) { }
            column(CompanyGiroNo; CompanyInfo."Giro No.") { }
            column(CompanyBankName; BankAccount.Name) { }
            column(CompanyBankBranchNo; CompanyInfo."Bank Branch No.") { }
            column(CompanyBankAccountNo; CompanyInfo."Bank Account No.") { }
            column(CompanyIBAN; BankAccount.IBAN) { }
            column(CompanySWIFT; BankAccount."SWIFT Code") { }
            column(CompanyLogoPosition; CompanyLogoPosition) { }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber) { }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber) { }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber) { }
            column(CompanyLegalStatement; GetLegalStatement) { }
            column(CustomerAddress1; CustAddr[1]) { }
            column(CustomerAddress2; CustAddr[2]) { }
            column(CustomerAddress3; CustAddr[3]) { }
            column(CustomerAddress4; CustAddr[4]) { }
            column(CustomerAddress5; CustAddr[5]) { }
            column(CustomerAddress6; CustAddr[6]) { }
            column(CustomerAddress7; CustAddr[7]) { }
            column(CustomerAddress8; CustAddr[8]) { }
            column(ShiptoCountryRegion; "Ship-to Country/Region Code") { }
            column(YourReference; "Your Reference") { }
            column(ShipmentMethodDescription; ShipmentMethod.Description) { }
            column(ShipmentMethodCode; "Shipment Method Code") { }
            column(ShipmentDate; Format("Shipment Date", 0, 4)) { }
            column(ShowShippingAddress; ShowShippingAddr) { }
            column(ShipToName; "Ship-to Name") { }
            column(ShipToAddress; "Ship-to Address") { }
            column(ShipToCode; "Ship-to Post Code") { }
            column(ShipToCity; "Ship-to City") { }
            column(ShipToContact; "Ship-to Contact") { }
            column(ShipToCountry; "Ship-to County") { }
            column(BillToName; "Bill-to Name") { }
            column(BillToAddress; "Bill-to Address") { }
            column(country; Country."Name") { }
            column(BillToPostCode; "Bill-to Post Code") { }
            column(BillToCity; "Bill-to City") { }
            column(BillToContact; "Bill-to Contact") { }
            column(BillToCountry; "Bill-to County") { }
            column(ShipToAddress1; ShipToAddr[1]) { }
            column(ShipToAddress2; ShipToAddr[2]) { }
            column(ShipToAddress3; ShipToAddr[3]) { }
            column(ShipToAddress4; ShipToAddr[4]) { }
            column(ShipToAddress5; ShipToAddr[5]) { }
            column(ShipToAddress6; ShipToAddr[6]) { }
            column(ShipToAddress7; ShipToAddr[7]) { }
            column(ShipToAddress8; ShipToAddr[8]) { }
            column(SellToNo; SellToContact."No.") { }
            column(SellToContactPhoneNo; SellToContact."Phone No.") { }
            column(SellToContactFaxNo; SellToContact."Fax No.") { }
            column(SellToContactEmail; SellToContact."E-Mail") { }
            column(BillToContactPhoneNo; BillToContact."Phone No.") { }
            column(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.") { }
            column(BillToContactFaxNo; BillToContact."Fax No.") { }
            column(BillToContactEmail; BillToContact."E-Mail") { }
            column(PaymentTermsDescription; PaymentTerms.Description) { }
            column(PaymentMethodDescription; PaymentMethod.Description) { }
            column(BilltoCustumerNo; "Bill-to Customer No.") { }
            column(DocumentDate; Format("Document Date", 0, 4)) { }
            column(DueDate; Format("Due Date", 0, 4)) { }
            column(DocumentNo; "No.") { }
            column(SelltoCustomerNo; "Sell-to Customer No.") { }
            column(SelltoCustomerName; "Sell-to Customer Name") { }
            column(VATRegistrationNo; GetCustomerVATRegistrationNumber) { }
            column(SellToFaxNo; GetSellToCustomerFaxNo) { }
            column(SellToPhoneNo; "Sell-to Phone No.") { }
            column(ShippingAgentCode; "Shipping Agent Code") { }
            column(PaymentInstructions_Txt; PaymentInstructionsTxt) { }
            column(ExternalDocumentNo; "External Document No.") { }
            column(TotalEmballage; TotalEmballage) { }
            column(PoidBrut; PostedWhsShipmentheader."Gross Weight") { }
            column(PoidNet; PostedWhsShipmentheader."Net Weight") { }
            column(Nbcolis; PostedWhsShipmentheader."Number of Packages") { }
            column(Typecolis; PostedWhsShipmentheader."Packing Type") { }
            column(codeTransport; PostedWhsShipmentheader."Shipping Agent Code") { }
            column(ShippingNo; PostedWhsShipmentheader."No.") { }
            column(companyAdr; TextAdr) { }
            column(NbPalettes; NbPalette) { }
            column(PieceNumber; PieceNumber) { }
            column(Quantitétotal; Quantitétotal) { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Country_Region_Code; Country1.Name) { }

            dataitem(Line; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = Header;
                DataItemTableView = SORTING("Document No.", "Line No.");

                column(Emballage; Emballage) { }
                column(ItemNoDescription; ItemNoDescription)
                {

                }
                column(CustomerOrderNo; CustomerOrderNo)
                {
                }
                column(Position; RPosition)
                {
                }
                column(transport_cost; transport_cost) { }
                column(TvaNotNull; TvaNotNull) { }
                column(LineNo_Line; "Line No.") { }
                column(LineAmount; Line."Line Amount") { }
                column(AmountExcludingVAT_Line; Amount)
                {
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatType = 1;
                }

                column(Description_Line; DescriptionText) { }
                column(LineDiscountPercent_Line; "Line Discount %") { }
                column(LineDiscountPercentText_Line; LineDiscountPctText) { }
                column(LineAmount_Line; FormattedLineAmount)
                {
                    AutoFormatType = 1;
                }
                column(ItemNo_Line; "Item Reference No.") { }
                column(ItemReferenceNo_Line; "Item Reference No.") { }
                column(ShipmentDate_Line; Format("Shipment Date")) { }
                column(Quantity_Line; FormattedQuantity) { }
                column(Type_Line; Format(Type)) { }
                column(UnitPrice; "Unit Price")
                {
                    AutoFormatType = 2;
                }
                column(UnitOfMeasure; "Unit of Measure Code") { }
                column(VATIdentifier_Line; "VAT Identifier") { }
                column(VATPct_Line; FormattedVATPct) { }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(Net_Weight; "Net Weight") { }
                column(LineQuantity; "Quantity") { }
                column(BCCStyle; gras) { }


                trigger OnAfterGetRecord()
                var
                    lItem: Record Item;
                    lsalesinvoiceline: record "sales invoice line";

                begin
                    DescriptionTextlength := 0;
                    gras := false;
                    ItemNoDescription := '';

                    if "Cust. Order No." <> '' then
                        CustomerOrderNo := "Cust. Order No.";

                    if (Type = type::" ") then
                        if SalesLine."Line No." = 10000 then
                            RPosition := 10000
                        else
                            RPosition := "Line No.";

                    ItemNoDescription := "Item Reference No." + Description;

                    if Line.Type = Line.Type::Item then begin
                        Item.Get(Line."No.");

                        if Item."Gen. Prod. Posting Group" = 'MOULE' then
                            DescriptionText := Item."Technical Description"
                        else
                            DescriptionText := Description
                    end else
                        DescriptionText := Description;

                    DescriptionTextlength := StrLen(DescriptionText);
                    //<<
                    SalesLineTemp.SetRange("Document No.", Line."Document No.");
                    SalesLineTemp.SetRange("Document Type", SalesLineTemp."Document Type"::Invoice);
                    SalesLineTemp.SetRange(Type, SalesLineTemp.Type::Item);
                    SalesLineTemp.SetRange(Description, Line.Description);
                    SalesLineTemp.SetRange(Position, RPosition);
                    if Not SalesLineTemp.FindFirst() then begin
                        SalesLineTemp.TransferFields(Line);
                        SalesLineTemp.Position := RPosition;
                        SalesLineTemp.Insert();
                        if DescriptionTextlength >= 72 then begin
                            if (DescriptionTextlength mod 36) <> 0 then
                                NumeroDescription += (DescriptionTextlength div 36) + 1
                            else
                                NumeroDescription += (DescriptionTextlength div 36)
                        end else begin
                            if DescriptionTextlength >= 36 then
                                NumeroDescription += 2
                            else
                                NumeroDescription += 1;
                        end;
                    end;
                    Groupe := ((NumeroDescription - 1) div 39) + 1;


                    transport_cost := false;
                    Emballage := false;

                    if Line.Type = Line.Type::Item then begin
                        if lItem.Get(Line."No.") then begin
                            if ShipmentNo <> "Shipment No." then
                                ShipmentNo := "Shipment No.";
                        end;
                    end;

                    if Line.Type = Line.Type::" " then
                        gras := true;
                end;

                trigger OnPreDataItem()
                begin
                    MoreLines := Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        MoreLines := Next(-1) <> 0;

                    if not MoreLines then
                        CurrReport.Break();

                    SetRange("Line No.", 0, "Line No.");
                    TransHeaderAmount := 0;
                    DummyCompanyInfo.Picture := CompanyInfo.Picture;
                    Quantitétotal := 0;
                end;
            }

            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number);
                DataItemLinkReference = Header;

                column(NumeroAjouter; NumeroDescription + Number) { }

                trigger OnAfterGetRecord()
                begin
                    //Groupe := ((NumeroDescription - 1) div 23) + 1;
                    Groupe := ((NumeroDescription - 1) div 39) + 1;
                end;

                trigger OnPreDataItem()
                begin
                    // if (NumeroDescription = 32) THEN
                    //     SETRANGE(Number, 1, 0)
                    // if (((NumeroDescription mod 29) <= 24) and (NumeroDescription mod 29 <> 0)) then
                    //     SetRange(Number, 1, 24 - (NumeroDescription mod 29))
                    // else
                    //     if (NumeroDescription mod 29 > 24) and (NumeroDescription mod 29 < 28) then
                    //         SetRange(Number, 1, (29 - (NumeroDescription mod 29)) mod 29)
                    //     else
                    //         if (NumeroDescription mod 29) = 0 then
                    //             SetRange(Number, 1, 0)

                    if (Groupe = 1) then Begin
                        if (NumeroDescription > 34) then
                            SetRange(Number, 1, 23 - (NumeroDescription mod 39))
                        else
                            SetRange(Number, 1, 23 - NumeroDescription);
                    End ELse if (Groupe > 1) then Begin
                        if (NumeroDescription mod 39 = 0) then
                            SetRange(Number, 1, 39)
                        else if (NumeroDescription mod 39 > 34) then
                            SetRange(Number, 1, 39 - (NumeroDescription mod 39))
                        else
                            SetRange(Number, 1, 23 - (NumeroDescription));
                    End;

                    // if (((NumeroDescription mod 29) <= 24) and (NumeroDescription mod 29 <> 0)) then
                    //     SetRange(Number, 1, 24 - (NumeroDescription mod 29))
                    // else
                    //     if (NumeroDescription mod 29 > 24) and (NumeroDescription mod 29 < 28) then
                    //         SetRange(Number, 1, (29 - (NumeroDescription mod 29)) mod 29)
                    //     else
                    //         if (NumeroDescription mod 29) = 0 then
                    //             SetRange(Number, 1, 0)
                end;
            }

            trigger OnAfterGetRecord()
            var
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                lItem: Record Item;
            begin
                if BankAccount.Get(Header."Company Bank Account Code") then;

                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue;
                Clear(PaymentInstructionsTxt);

                // GsalesLine.SetRange("Document No.", "No.");
                // if GsalesLine.FindSet then begin
                //     NbInvoiceLine := GsalesLine.Count;
                //     TotPage := Round(NbInvoiceLine / 23, 1, '>');
                //     repeat
                //         if (GsalesLine.Type = GsalesLine.Type::Item) and (GsalesLine."Gen. Prod. Posting Group" = 'PF') then
                //             if lItem.Get(GsalesLine."No.") then
                //                 if ItemCateg.Get(lItem."Item Category Code") then;
                //     until GsalesLine.Next() = 0;
                // end;

                FormatDocumentFields(Header);

                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                end;

                GetLineFeeNoteOnReportHist("No.");
                Country.Get("VAT Country/Region Code");
                Country1.Get("Ship-to Country/Region Code");

                CalcFields("Amount Including VAT");


                if not CustSell.Get("Sell-to Customer No.") then
                    CustSell.Reset();

                SalesLine.Reset();
                SalesLine.SetRange(SalesLine."Document No.", "No.");
                SalesLine.SetRange(SalesLine.Type, SalesLine.Type::Item);
                if SalesLine.FindFirst() then begin
                    PostedWhsShipmentLine.Reset();
                    PostedWhsShipmentLine.SetRange(PostedWhsShipmentLine."Posted Source Document", PostedWhsShipmentLine."Posted Source Document"::"Posted Shipment");
                    PostedWhsShipmentLine.SetRange(PostedWhsShipmentLine."Posted Source No.", SalesLine."Shipment No.");
                    if PostedWhsShipmentLine.FindFirst() then
                        PostedWhsShipmentheader.Get(PostedWhsShipmentLine."No.");
                    repeat
                        PieceNumber += SalesLine.Quantity;
                    until SalesLine.Next() = 0;
                end;

                TextAdr := '';
                if "Shortcut Dimension 1 Code" = 'MJ' then
                    TextAdr := 'Zone Industrielle Menzel jemil , Menzel Jemil , Bizerte';
                if "Shortcut Dimension 1 Code" = 'BA' then
                    TextAdr := 'Zone Industrielle Bouargoub , Bouargoub , Nabeul';
            end;

        }
    }



    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.SetAutoCalcFields(Picture);
        Clear(PhoneNo);
        Clear(FaxNo);
        Clear(NumeroDescription);
        Clear(LineToAdd);
        Clear(NumeroWorkDescription);
        CompanyInfo.Get();
        PhoneNo := CompanyInfo."Phone No.";
        FaxNo := CompanyInfo."Fax No.";
        CompanyInfo.CalcFields(Picture);
        SalesSetup.Get();
        CompanyInfo.VerifyAndSetPaymentInfo();
        TvaNotNull := false;
    end;

    var
        CustomerOrderNo: Code[35];
        RPosition: Integer;
        ItemNoDescription: Text;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        DummyCompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        SellToContact: Record Contact;
        BillToContact: Record Contact;
        BankAccount: Record "Bank Account";
        ItemCateg: Record "Item Category";
        CustSell: Record Customer;
        Country: Record "Country/Region";
        Country1: Record "Country/Region";
        PostedWhsShipmentheader: Record "Posted Whse. Shipment Header";
        PostedWhsShipmentLine: Record "Posted Whse. Shipment Line";
        SalesLine: Record "Sales Line";
        GsalesLine: Record "Sales Line";
        Item: Record Item;
        FormatDocument: Codeunit "Format Document";
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        SalesPersonText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        LineDiscountPctText: Text;
        FormattedVATPct: Text;
        FormattedQuantity: Text;
        FormattedLineAmount: Text;
        PaymentInstructionsTxt: Text;
        DescriptionText: Text[512];
        TextAdr: Text[250];
        MonthTxt: Text;
        PhoneNo: Text[30];
        FaxNo: Text[30];
        MtTtLettres: Text;
        ShipmentNo: Code[15];
        MoreLines: Boolean;
        ShowWorkDescription: Boolean;
        ShowShippingAddr: Boolean;
        Emballage: Boolean;
        transport_cost: Boolean;
        TvaNotNull: Boolean;
        gras: Boolean;
        TransHeaderAmount: Decimal;
        CalculatedExchRate: Decimal;
        TotalEmballage: Decimal;
        NbPalette: Decimal;
        CompanyLogoPosition: Integer;
        NumeroDescription: Integer;
        LineToAdd: Integer;
        NumeroWorkDescription: Integer;
        Groupe: Integer;
        NbInvoiceLine: Integer;
        TotPage: Integer;
        DescriptionTextlength: Integer;
        PieceNumber: Integer;
        Quantitétotal: Integer;
        SalesLineTemp: Record "Sales Line" temporary;


    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[15])
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
    begin
        TempLineFeeNoteOnReportHist.DeleteAll();
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeaderNo);
        if not CustLedgerEntry.FindFirst() then
            exit;

        if not Customer.Get(CustLedgerEntry."Customer No.") then
            exit;

    end;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        FormatDocument.SetTotalLabels(SalesHeader.GetCurrencySymbol(), TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesHeader."Payment Terms Code", SalesHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesHeader."Payment Method Code", SalesHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");
    end;
}
