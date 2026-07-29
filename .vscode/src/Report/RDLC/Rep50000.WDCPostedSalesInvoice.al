report 50000 "WDC Posted Sales Invoice"
{
    /**********************************Documentation*********************
    //WDC01     WDC.HG            Creation of "posted sales Invoice" report 
    //WDC02     WDC.IM            Add Shipping Adress
    //WDC03     WDC.HG            Add technical description of moule to the report 
    *********************************************************************/
    RDLCLayout = './.vscode/src/Report/RDLC/PostedSalesInvoice.rdl';
    CaptionML = ENU = 'Posted Sales Invoice', FRA = 'Facture vente';
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
        dataitem(Header; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(InvoiceNo; "No.")
            {
            }
            column(MethodTransport; Header."Transport Method")
            {
            }
            column(ItemCategDescr; ItemCateg.Description)
            {

            }
            column(DocumentExt; Header."External Document No.")
            {
            }
            column(TotalRemiseFacture; Header."Invoice Discount Amount")
            {
            }
            column(MtTtLettres; MtTtLettres)
            {
            }
            column(Groupe; Groupe)
            {
            }
            column(NumeroLigne; NumeroDescription)
            {
            }
            column(CompanyName; CompanyInfo."Name")
            {
            }
            column(FaxNo; FaxNo)
            {
            }
            column(PhoneNo; PhoneNo)
            {
            }
            column(CompanyPostCod; companyinfo."Post Code")
            {
            }
            column(CompanyAdress; companyinfo.Address)
            {
            }
            column(CompanyAdress2; companyinfo."Address 2")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(TVA_Intra; Cust."VAT Registration No.")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }

            column(CompanyIBANN; CompanyInfo.IBAN)
            {
            }

            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber)
            {
            }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CustomerAddress1; CustAddr[1])
            {
            }
            column(CustomerAddress2; CustAddr[2])
            {
            }
            column(CustomerAddress3; CustAddr[3])
            {
            }
            column(CustomerAddress4; CustAddr[4])
            {
            }
            column(CustomerAddress5; CustAddr[5])
            {
            }
            column(CustomerAddress6; CustAddr[6])
            {
            }
            column(CustomerAddress7; CustAddr[7])
            {
            }
            column(CustomerAddress8; CustAddr[8])
            {
            }
            column(ShiptoCountryRegion; "Ship-to Country/Region Code")
            {
            }

            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }

            column(ShipmentMethodCode; "Shipment Method Code")
            {
            }

            column(ShowShippingAddress; ShowShippingAddr)
            {
            }
            column(ShipToName; "Ship-to Name")
            {

            }
            column(ShipToAddress; "Ship-to Address")
            {

            }
            column(ShipToCode; "Ship-to Post Code")
            {

            }
            column(ShipToCity; "Ship-to City")
            {

            }
            column(ShipToContact; "Ship-to Contact")
            {

            }
            column(ShipToCountry; "Ship-to County")
            {

            }
            column(BillToName; "Bill-to Name")
            {

            }
            column(BillToAddress; "Bill-to Address")
            {

            }
            column(country; country."Name")
            {
            }
            column(BillToPostCode; "Bill-to Post Code")
            {

            }
            column(BillToCity; "Bill-to City")
            {

            }
            column(BillToContact; "Bill-to Contact")
            {

            }
            column(BillToCountry; "Bill-to County")
            {

            }


            column(ShipToAddress1; ShipToAddr[1])
            {
            }
            column(ShipToAddress2; ShipToAddr[2])
            {
            }
            column(ShipToAddress3; ShipToAddr[3])
            {
            }
            column(ShipToAddress4; ShipToAddr[4])
            {
            }
            column(ShipToAddress5; ShipToAddr[5])
            {
            }
            column(ShipToAddress6; ShipToAddr[6])
            {
            }
            column(ShipToAddress7; ShipToAddr[7])
            {
            }
            column(ShipToAddress8; ShipToAddr[8])
            {
            }

            column(SellToNo; SellToContact."No.")
            {
            }
            column(SellToContactPhoneNo; SellToContact."Phone No.")
            {
            }
            column(SellToContactFaxNo; SellToContact."Fax No.")
            {
            }
            column(SellToContactMobilePhoneNo; SellToContact."Mobile Phone No.")
            {
            }
            column(SellToContactEmail; SellToContact."E-Mail")
            {
            }
            column(BillToContactPhoneNo; BillToContact."Phone No.")
            {
            }
            column(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.")
            {
            }
            column(BillToContactFaxNo; BillToContact."Fax No.")
            {
            }
            column(BillToContactEmail; BillToContact."E-Mail")
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }

            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }

            column(BilltoCustumerNo; "Bill-to Customer No.")
            {
            }

            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(DueDate; Format("Due Date", 0, 4))
            {
            }
            column(DocumentNo; "No.")
            {
            }
            // column(OrderNo; "Order No.")
            // {
            // }

            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(VATRegistrationNo; GetCustomerVATRegistrationNumber)
            {
            }

            column(SellToFaxNo; GetSellToCustomerFaxNo)
            {
            }
            column(SellToPhoneNo; "Sell-to Phone No.")
            {
            }
            column(PaymentReference; GetPaymentReference)
            {
            }

            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }

            column(ExternalDocumentNo; "External Document No.")
            {
            }

            column(TotalEmballage; TotalEmballage)
            {

            }
            column(PoidBrut; PostedWhsShipmentheader."Gross Weight")
            {

            }
            column(PoidNet; PostedWhsShipmentheader."Net Weight")
            {

            }
            column(Nbcolis; PostedWhsShipmentheader."Number of Packages")
            {

            }
            column(Typecolis; PostedWhsShipmentheader."Packing Type")
            {

            }
            column(codeTransport; PostedWhsShipmentheader."Shipping Agent Code")
            {

            }
            column(ShippingNo; PostedWhsShipmentheader."No.")
            {

            }

            column(companyAdr; "TextAdr")
            {

            }

            column(NbPalettes; NbPalette)
            {

            }
            column(PieceNumber; PieceNumber)
            {

            }
            column(Quantitétotal; Quantitétotal)
            {

            }
            //<<WDC03
            column(Ship_to_Name; "Ship-to Name")
            {

            }
            column(Ship_to_Address; "Ship-to Address")
            {

            }
            column(Ship_to_Country_Region_Code; Country1.Name)
            {

            }
            //>>WDC03
            dataitem(Line; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = Header;
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(Emballage; Emballage)
                {
                }
                column(ItemNoDescription; ItemNoDescription)
                {

                }
                column(CustomerOrderNo; CustomerOrderNo)
                {

                }
                column(Position; RPosition)
                {

                }

                column(transport_cost; transport_cost)
                {
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }

                column(Description_Line; descriptionText)
                {
                }

                column(ItemNo_Line; "Item Reference No.")
                {
                }
                column(UnitPrice; "Unit Price")
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 2;
                }
                column(UnitOfMeasure; "Unit of Measure Code")
                {
                }
                column(Net_Weight; "Net Weight")
                {
                }
                column(LineQuantity; "Quantity")
                {

                }
                column(BCCStyle; gras)
                {

                }

                trigger OnAfterGetRecord()
                var
                    lItem: record Item;
                //lsalesinvoiceline: record "sales invoice line";

                begin

                    DescriptionTextlength := 0;
                    gras := false;

                    ItemNoDescription := '';
                    DescriptionTextlength := 0;

                    if "Cust. Order No." <> '' then
                        CustomerOrderNo := "Cust. Order No.";

                    if (Type = type::" ") then
                        if Line."Line No." = 10000 then
                            RPosition := 10000
                        else
                            RPosition := "Line No.";

                    ItemNoDescription := "Item Reference No." + Description;

                    //<<WDC03
                    Item.reset();
                    if Line.Type = Line.type::Item then begin
                        Item.get(line."No.");

                        if item."Gen. Prod. Posting Group" = 'MOULE' then
                            DescriptionText := Item."Technical Description"//MAX 512 CHARACTER
                        else
                            DescriptionText := Description
                    end
                    else
                        DescriptionText := Description;
                    DescriptionTextlength := StrLen(DescriptionText);
                    SalesInvLineTemp.SetRange(Type, SalesInvLineTemp.Type::Item);//Remplir la table temporaire pour regrouper les lignes avec meme description
                    SalesInvLineTemp.SetRange("Document No.", Line."Document No.");
                    SalesInvLineTemp.SetRange(Description, Line.Description);
                    SalesInvLineTemp.SetRange(Position, RPosition);
                    if Not SalesInvLineTemp.FindFirst() then begin
                        SalesInvLineTemp.Init();
                        SalesInvLineTemp.TransferFields(Line);
                        SalesInvLineTemp.Position := RPosition;
                        SalesInvLineTemp.Insert();
                        if DescriptionTextlength >= 78 then
                            if (DescriptionTextlength mod 39) <> 0 then
                                NumeroDescription += (DescriptionTextlength div 39) + 1
                            else
                                NumeroDescription += (DescriptionTextlength div 39)
                        else if DescriptionTextlength >= 39 then
                            NumeroDescription += 2
                        else
                            NumeroDescription += 1;
                    end;
                    //>>WDC03

                    Groupe := ((NumeroDescription - 1) div 39) + 1;


                    transport_cost := false;
                    Emballage := false;
                    if Line.Type = Line.type::Item then begin
                        if lItem.Get(Line."No.") then BEGIN
                            if ShipmentNo <> "Shipment No." then begin
                                ShipmentNo := "Shipment No.";
                            end;
                        END;
                    end;
                    if Line.Type = Line.Type::" " then
                        gras := true;

                    FormatDocument.SetSalesInvoiceLine(Line, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);
                End;

                trigger OnPreDataItem()
                begin
                    MoreLines := Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        MoreLines := Next(-1) <> 0;
                    if not MoreLines then
                        CurrReport.Break();
                    SetRange("Line No.", 0, "Line No.");
                    Quantitétotal := 0;
                end;


            }
            dataitem(integer; integer)
            {
                DataItemTableView = SORTING(Number);
                DataItemLinkReference = Header;
                Column(NumeroAjouter; NumeroDescription + Number)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    // Groupe := ((NumeroDescription - 1) div 26) + 1;
                    Groupe := ((NumeroDescription - 1) div 39) + 1;
                end;

                trigger OnPreDataItem()
                begin
                    // if (NumeroDescription = 26) THEN
                    //     SETRANGE(Number, 1, 0)
                    // Else if (((NumeroDescription mod 23) <= 19) and (NumeroDescription mod 23 <> 0)) THEN
                    //     SETRANGE(Number, 1, 18 - (NumeroDescription mod 23))
                    // Else if (NumeroDescription mod 23 > 19) and (NumeroDescription mod 23 < 24) then
                    //     SETRANGE(Number, 1, (23 - (NumeroDescription mod 23)) mod 23)
                    // else if (NumeroDescription mod 23) = 0 then
                    //     SETRANGE(Number, 1, 0)

                    if (Groupe = 1) then Begin //Pour la page 1
                        if (NumeroDescription > 34) then
                            SetRange(Number, 1, 23 - (NumeroDescription mod 39)) //Page cotient plus que 34 lignes
                        else
                            SetRange(Number, 1, 23 - NumeroDescription); //Page cotient moins que 23 lignes
                    End ELse if (Groupe > 1) then Begin //pour les autre page
                        if (NumeroDescription mod 39 = 0) then
                            SetRange(Number, 1, 39)
                        else if (NumeroDescription mod 39 > 34) then
                            SetRange(Number, 1, 39 - (NumeroDescription mod 39))
                        else
                            SetRange(Number, 1, 23 - (NumeroDescription));
                    End;

                end;
            }
            trigger OnAfterGetRecord()
            var

                CurrencyExchangeRate: Record "Currency Exchange Rate";
                lItem: Record Item;
            begin
                if BankAccount.get(Header."Company Bank Account Code") then;

                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue;
                CLEAR(TotalRemise);
                GsalesLine.SetRange("Document No.", "No.");
                if GsalesLine.FindSet then Begin
                    NbInvoiceLine := GsalesLine.Count;
                    TotPage := round(NbInvoiceLine / 23, 1, '>');
                    repeat
                        TotalRemise += GsalesLine."Line Discount Amount";
                        If (GsalesLine.Type = GsalesLine.Type::Item) and (GsalesLine."Gen. Prod. Posting Group" = 'PF') then
                            if lItem.Get(GsalesLine."No.") Then
                                If ItemCateg.get(lItem."Item Category Code") Then;
                    until GsalesLine.Next = 0;
                End;
                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                GetLineFeeNoteOnReportHist("No.");
                country.Get("VAT Country/Region Code");
                country1.Get("Ship-to Country/Region Code");//WDC03

                CalcFields("Amount Including VAT");

                IF NOT CustSell.Get("Sell-to Customer No.") then
                    CustSell.Reset();
                //<<WDC 
                salesinvoiceline.Reset();
                salesinvoiceline.SetRange(salesinvoiceline."Document No.", "No.");
                salesinvoiceline.SetRange(salesinvoiceline.Type, salesinvoiceline.Type::Item);
                if salesinvoiceline.FindFirst() then begin
                    PostedWhsShipmentLine.reset();
                    PostedWhsShipmentLine.SetRange(PostedWhsShipmentLine."Posted Source Document", PostedWhsShipmentLine."Posted Source Document"::"Posted Shipment");
                    PostedWhsShipmentLine.SetRange(PostedWhsShipmentLine."Posted Source No.", salesinvoiceline."Shipment No.");
                    if PostedWhsShipmentLine.FindFirst() then
                        PostedWhsShipmentheader.get(PostedWhsShipmentLine."No.");
                    repeat
                        PieceNumber += salesinvoiceline.Quantity;
                    until salesinvoiceline.Next() = 0;
                end;
                //>>WDC
                TextAdr := '';
                if "Shortcut Dimension 1 Code" = 'MJ' then
                    TextAdr := 'Zone Industrielle Menzel jemil , Menzel Jemil , Bizerte';
                if "Shortcut Dimension 1 Code" = 'BA' then
                    TextAdr := 'Zone Industrielle Bouargoub , Bouargoub , Nabeul';
                //>>WDC
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
        CompanyInfo.CalcFields(Picture);
        SalesSetup.Get();
        CompanyInfo.VerifyAndSetPaymentInfo;
        TvaNotNull := false;
        PhoneNo := CompanyInfo."Phone No.";
        FaxNo := CompanyInfo."Fax No.";
    end;

    var
        CustomerOrderNo: Code[35];
        RPosition: Integer;
        ItemNoDescription: Text;
        Quantitétotal: Integer;
        ShipmentNo: Code[15];
        Emballage: Boolean;
        transport_cost: Boolean;
        ItemCateg: Record "Item Category";
        MtTtLettres: Text;
        TotalEmballage: Decimal;
        NbPalette: Decimal;
        TvaNotNull: Boolean;
        NbInvoiceLine: Integer;
        TotPage: Integer;
        Paiement: Text;
        CustSell: Record Customer;
        BankAccount: Record 270;
        BDMRInvoiceNo: Text;
        NumeroDescription: integer;
        LineToAdd: Integer;
        NumeroWorkDescription: integer;
        Groupe: Integer;
        TotalRemise: Decimal;
        GsalesLine: Record "Sales invoice line";
        country: record 9;
        country1: record 9;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        SellToContact: Record Contact;
        BillToContact: Record Contact;
        FormatDocument: Codeunit "Format Document";
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        SalesPersonText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        LineDiscountPctText: Text;
        FormattedVATPct: Text;
        FormattedUnitPrice: Text;
        FormattedQuantity: Text;
        FormattedLineAmount: Text;
        MoreLines: Boolean;
        ShowWorkDescription: Boolean;
        ShowShippingAddr: Boolean;
        PostedWhsShipmentheader: record "Posted Whse. Shipment Header";
        PostedWhsShipmentLine: record "Posted Whse. Shipment Line";
        salesinvoiceline: record "sales invoice line";
        TextAdr: Text[250];
        gras: Boolean;
        DescriptionText: Text[512];
        Item: record item;
        DescriptionTextlength: Integer;
        PieceNumber: Decimal;
        PhoneNo: Text[30];
        FaxNo: Text[30];
        SalesInvLineTemp: record "Sales Invoice Line" temporary;


    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[15])
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
    begin
        TempLineFeeNoteOnReportHist.DeleteAll();
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Document No.", SalesInvoiceHeaderNo);
        if not CustLedgerEntry.FindFirst then
            exit;

        if not Customer.Get(CustLedgerEntry."Customer No.") then
            exit;

        LineFeeNoteOnReportHist.SetRange("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SetRange("Language Code", Customer."Language Code");
        if LineFeeNoteOnReportHist.FindSet then begin
            repeat
                TempLineFeeNoteOnReportHist.Init();
                TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.Insert();
            until LineFeeNoteOnReportHist.Next() = 0;
        end else begin
            if LineFeeNoteOnReportHist.FindSet then
                repeat
                    TempLineFeeNoteOnReportHist.Init();
                    TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.Insert();
                until LineFeeNoteOnReportHist.Next() = 0;
        end;
    end;

    local procedure FormatDocumentFields(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        FormatDocument.SetTotalLabels(SalesInvoiceHeader.GetCurrencySymbol, TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesInvoiceHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesInvoiceHeader."Payment Terms Code", SalesInvoiceHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesInvoiceHeader."Payment Method Code", SalesInvoiceHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesInvoiceHeader."Shipment Method Code", SalesInvoiceHeader."Language Code");
    end;
}

