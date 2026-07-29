report 50008 "WDC Posted Sales Credit Memo"
{
    /**********************************Documentation*********************
    //WDC01     WDC.HG            Creation of "posted sales Invoice" report 
    //WDC02     WDC.IM            Add Shipping Adress
    //WDC03     WDC.HG            Add technical description of moule to the report 
    //WDC04     WDC.HG             26/03/2026 Display Credit Memo No.
    *********************************************************************/
    RDLCLayout = './.vscode/src/Report/RDLC/PostedSalesCrMemo.rdl';
    CaptionML = ENU = 'Posted Sales Credit Memo', FRA = 'Avoir vente enregistré';
    Description = 'Avoir vente enregistré';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Basic, Suite;
    DefaultLayout = RDLC;
    EnableHyperlinks = true;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Posted Sales Credit Memo';
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
            column(CompanyCity; companyinfo.City)
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
            column(CompanyTVAINTRA; companyinfo."VAT Registration No.")
            {
            }
            column(CompanySIRET; companyinfo."Registration No.")
            {
            }

            column(Paiement; Paiement)
            {
            }
            // column(BDMRInvoiceNo; BDMRInvoiceNo)
            // {
            // }
            //<<WDC04
            column(BDMRInvoiceNo; "No.")
            {
            }
            //>>WDC04
            column(Posting_Date; "Posting Date")
            {
            }
            column(TVA_Intra; Cust."VAT Registration No.")
            {
            }
            column(EORI; Cust."EORI Number")
            {
            }

            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyAddress7; CompanyAddr[7])
            {
            }
            column(CompanyAddress8; CompanyAddr[8])
            {
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
            }
            column(BDMRCompanyPicture; CompanyInfo.Picture)
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
            column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoLbl)
            {
            }
            column(CompanyGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyGiroNo_Lbl; CompanyInfoGiroNoLbl)
            {
            }
            column(CompanyBankName; BankAccount.Name)
            {
            }
            column(CompanyBankName_Lbl; CompanyInfoBankNameLbl)
            {
            }
            column(CompanyBankBranchNo; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyBankBranchNo_Lbl; CompanyInfo.FieldCaption("Bank Branch No."))
            {
            }
            column(CompanyBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoLbl)
            {
            }
            column(CompanyIBAN; BankAccount.IBAN)
            {
            }
            column(CompanyIBAN_Lbl; CompanyInfo.FieldCaption(IBAN))
            {
            }
            column(CompanySWIFT; BankAccount."SWIFT Code")
            {
            }
            column(CompanySWIFT_Lbl; CompanyInfo.FieldCaption("SWIFT Code"))
            {
            }
            column(CompanyLogoPosition; CompanyLogoPosition)
            {
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber)
            {
            }
            column(CompanyRegistrationNumber_Lbl; CompanyInfo.GetRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegistrationNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }

            column(CompanyLegalStatement; GetLegalStatement)
            {
            }
            column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
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

            // column(CustomerPostalBarCode; FormatAddr.PostalBarCode(1))
            // {
            // }
            column(YourReference; "Your Reference")
            {
            }
            column(YourReference_Lbl; FieldCaption("Your Reference"))
            {
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }

            column(ShipmentMethodDescription_Lbl; ShptMethodDescLbl)
            {
            }
            column(ShipmentMethodCode; "Shipment Method Code")
            {
            }

            column(ShipmentDate; Format("Shipment Date", 0, 4))
            {
            }
            column(ShipmentDate_Lbl; FieldCaption("Shipment Date"))
            {
            }
            column(Shipment_Lbl; ShipmentLbl)
            {
            }
            column(ShowShippingAddress; ShowShippingAddr)
            {
            }
            column(ShipToAddress_Lbl; ShiptoAddrLbl)
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
            column(SellToContactPhoneNoLbl; SellToContactPhoneNoLbl)
            {
            }
            column(SellToContactMobilePhoneNoLbl; SellToContactMobilePhoneNoLbl)
            {
            }
            column(SellToContactEmailLbl; SellToContactEmailLbl)
            {
            }

            column(BillToContactPhoneNoLbl; BillToContactPhoneNoLbl)
            {
            }
            column(BillToContactMobilePhoneNoLbl; BillToContactMobilePhoneNoLbl)
            {
            }
            column(BillToContactEmailLbl; BillToContactEmailLbl)
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
            column(PaymentTermsDescription_Lbl; PaymentTermsDescLbl)
            {
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            column(PaymentMethodDescription_Lbl; PaymentMethodDescLbl)
            {
            }
            column(BilltoCustumerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoCustomerNo_Lbl; FieldCaption("Bill-to Customer No."))
            {
            }
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(DocumentDate_Lbl; FieldCaption("Document Date"))
            {
            }
            column(DueDate; Format("Due Date", 0, 4))
            {
            }
            column(DueDate_Lbl; FieldCaption("Due Date"))
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(DocumentNo_Lbl; InvNoLbl)
            {
            }
            column(PricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(PricesIncludingVAT_Lbl; FieldCaption("Prices Including VAT"))
            {
            }
            column(PricesIncludingVATYesNo; Format("Prices Including VAT"))
            {
            }
            column(SalesPerson_Lbl; SalespersonLbl)
            {
            }
            column(SalesPersonBlank_Lbl; SalesPersonText)
            {
            }
            column(SalesPersonName; SalespersonPurchaser.Name)
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerName; "Sell-to Customer Name")
            {
            }
            column(SelltoCustomerNo_Lbl; FieldCaption("Sell-to Customer No."))
            {
            }
            column(VATRegistrationNo; GetCustomerVATRegistrationNumber)
            {
            }
            column(VATRegistrationNo_Lbl; GetCustomerVATRegistrationNumberLbl)
            {
            }

            column(SellToPhoneNo; "Sell-to Phone No.")
            {
            }
            column(From_Lbl; FromLbl)
            {
            }
            column(BilledTo_Lbl; BilledToLbl)
            {
            }
            column(ChecksPayable_Lbl; ChecksPayableText)
            {
            }

            column(LegalEntityType; Cust.GetLegalEntityType)
            {
            }
            column(LegalEntityType_Lbl; Cust.GetLegalEntityTypeLbl)
            {
            }
            column(Copy_Lbl; CopyLbl)
            {
            }
            column(EMail_Header_Lbl; EMailLbl)
            {
            }
            column(HomePage_Header_Lbl; HomePageLbl)
            {
            }
            column(InvoiceDiscountBaseAmount_Lbl; InvDiscBaseAmtLbl)
            {
            }
            column(InvoiceDiscountAmount_Lbl; InvDiscountAmtLbl)
            {
            }
            column(LineAmountAfterInvoiceDiscount_Lbl; LineAmtAfterInvDiscLbl)
            {
            }
            column(LocalCurrency_Lbl; LocalCurrencyLbl)
            {
            }
            column(ExchangeRateAsText; ExchangeRateText)
            {
            }
            column(Page_Lbl; PageLbl)
            {
            }
            column(SalesInvoiceLineDiscount_Lbl; SalesInvLineDiscLbl)
            {
            }
            column(Questions_Lbl; QuestionsLbl)
            {
            }
            column(Contact_Lbl; CompanyInfo.GetContactUsText)
            {
            }
            column(DocumentTitle_Lbl; DocumentCaption)
            {
            }
            column(YourDocumentTitle_Lbl; YourSalesInvoiceLbl)
            {
            }
            column(Thanks_Lbl; ThanksLbl)
            {
            }
            column(ShowWorkDescription; ShowWorkDescription)
            {
            }
            column(RemainingAmount; RemainingAmount)
            {
            }
            column(RemainingAmountText; RemainingAmountTxt)
            {
            }
            column(Subtotal_Lbl; SubtotalLbl)
            {
            }
            column(Total_Lbl; TotalLbl)
            {
            }
            column(VATAmount_Lbl; VATAmtLbl)
            {
            }
            column(VATBase_Lbl; VATBaseLbl)
            {
            }
            column(VATAmountSpecification_Lbl; VATAmtSpecificationLbl)
            {
            }
            column(VATClauses_Lbl; VATClausesLbl)
            {
            }
            column(VATIdentifier_Lbl; VATIdentifierLbl)
            {
            }
            column(VATPercentage_Lbl; VATPercentageLbl)
            {
            }
            column(VATClause_Lbl; VATClause.TableCaption)
            {
            }
            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }
            column(ShippingAgentCode_Lbl; FieldCaption("Shipping Agent Code"))
            {
            }
            column(PaymentInstructions_Txt; PaymentInstructionsTxt)
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(ExternalDocumentNo_Lbl; FieldCaption("External Document No."))
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
            dataitem(Line; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = Header;
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(Emballage; Emballage)
                {
                }
                column(transport_cost; transport_cost)
                {
                }
                column(TotalRemise; TotalRemise)
                {
                }
                column(TvaNotNull; TvaNotNull)
                {
                }
                column(LineNo_Line; "Line No.")
                {
                }

                column(LineAmount; Line."Line Amount")
                {
                }
                column(AmountExcludingVAT_Line; Amount)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountExcludingVAT_Line_Lbl; FieldCaption(Amount))
                {
                }
                column(AmountIncludingVAT_Line; "Amount Including VAT")
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountIncludingVAT_Line_Lbl; FieldCaption("Amount Including VAT"))
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(Description_Line; descriptionText)
                {
                }
                column(Description_Line_Lbl; FieldCaption(Description))
                {
                }
                column(LineDiscountPercent_Line; "Line Discount %")
                {
                }
                column(LineDiscountPercentText_Line; LineDiscountPctText)
                {
                }
                column(LineAmount_Line; FormattedLineAmount)
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(LineAmount_Line_Lbl; FieldCaption("Line Amount"))
                {
                }
                column(ItemNo_Line; "Item Reference No.")
                {
                }
                column(ItemNo_Line_Lbl; FieldCaption("No."))
                {
                }

                column(ItemReferenceNo_Line; "Item Reference No.")
                {
                }
                column(ItemReferenceNo_Line_Lbl; FieldCaption("Item Reference No."))
                {
                }
                column(ShipmentDate_Line; Format("Shipment Date"))
                {
                }
                column(ShipmentDate_Line_Lbl; PostedShipmentDateLbl)
                {
                }
                column(Quantity_Line; FormattedQuantity)
                {
                }
                column(Quantity_Line_Lbl; FieldCaption(Quantity))
                {
                }
                column(Type_Line; Format(Type))
                {
                }
                column(UnitPrice; "Unit Price")
                {
                    AutoFormatExpression = GetCurrencyCode();
                    AutoFormatType = 2;
                }
                column(UnitPrice_Lbl; FieldCaption("Unit Price"))
                {
                }
                column(UnitOfMeasure; "Unit of Measure")
                {
                }
                column(UnitOfMeasure_Lbl; FieldCaption("Unit of Measure"))
                {
                }
                column(VATIdentifier_Line; "VAT Identifier")
                {
                }
                column(VATIdentifier_Line_Lbl; FieldCaption("VAT Identifier"))
                {
                }
                column(VATPct_Line; FormattedVATPct)
                {
                }
                column(VATPct_Line_Lbl; FieldCaption("VAT %"))
                {
                }
                column(TransHeaderAmount; TransHeaderAmount)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(JobTaskNo_Lbl; JobTaskNoLbl)
                {
                }
                column(JobTaskNo; JobTaskNo)
                {
                }
                column(JobTaskDescription; JobTaskDescription)
                {
                }
                column(JobTaskDesc_Lbl; JobTaskDescLbl)
                {
                }
                column(JobNo_Lbl; JobNoLbl)
                {
                }
                column(JobNo; JobNo)
                {
                }
                column(Unit_Lbl; UnitLbl)
                {
                }
                column(Qty_Lbl; QtyLbl)
                {
                }
                column(Price_Lbl; PriceLbl)
                {
                }
                column(PricePer_Lbl; PricePerLbl)
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


                dataitem(ShipmentLine; "Sales Shipment Buffer")
                {
                    DataItemTableView = SORTING("Document No.", "Line No.", "Entry No.");
                    UseTemporary = true;
                    column(DocumentNo_ShipmentLine; "Document No.")
                    {
                    }
                    column(PostingDate_ShipmentLine; "Posting Date")
                    {
                    }
                    column(PostingDate_ShipmentLine_Lbl; FieldCaption("Posting Date"))
                    {
                    }
                    column(Quantity_ShipmentLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(Quantity_ShipmentLine_Lbl; FieldCaption(Quantity))
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        SetRange("Line No.", Line."Line No.");
                    end;

                    trigger OnAfterGetRecord()

                    begin

                    end;
                }

                dataitem(AssemblyLine; "Posted Assembly Line")
                {
                    DataItemTableView = SORTING("Document No.", "Line No.");
                    UseTemporary = true;
                    column(LineNo_AssemblyLine; "No.")
                    {
                    }
                    column(Description_AssemblyLine; Description)
                    {
                    }
                    column(Quantity_AssemblyLine; Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(UnitOfMeasure_AssemblyLine; GetUOMText("Unit of Measure Code"))
                    {
                    }
                    column(VariantCode_AssemblyLine; "Variant Code")
                    {
                    }


                    trigger OnPreDataItem()
                    var
                        ValueEntry: Record "Value Entry";
                    begin
                        Clear(AssemblyLine);
                        if not DisplayAssemblyInformation then
                            CurrReport.Break();
                        GetAssemblyLinesForDocument(
                          AssemblyLine, ValueEntry."Document Type"::"Sales Invoice", Line."Document No.", Line."Line No.");
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    lItem: record Item;
                begin
                    DescriptionTextlength := 0;
                    gras := false;
                    if "Line Discount %" = 0 then
                        LineDiscountPctText := ''
                    else
                        LineDiscountPctText := StrSubstNo('%1%', -Round("Line Discount %", 0.1));
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

                    // if StrLen(Description) >= 45 then
                    //     NumeroDescription += 2
                    // else
                    //     NumeroDescription += 1; //CMT BY WDC03
                    if DescriptionTextlength >= 90 then
                        if (DescriptionTextlength mod 45) <> 0 then
                            NumeroDescription += (DescriptionTextlength div 45) + 1
                        else
                            NumeroDescription += (DescriptionTextlength div 45)
                    else if DescriptionTextlength >= 45 then
                        NumeroDescription += 2
                    else
                        NumeroDescription += 1;

                    //>>WDC03

                    Groupe := ((NumeroDescription - 1) div 23) + 1;
                    //<<FS
                    // VATAmountLine.Init();
                    // VATAmountLine."VAT Identifier" := "VAT Identifier";
                    // VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                    // VATAmountLine."Tax Group Code" := "Tax Group Code";
                    // VATAmountLine."VAT %" := "VAT %";
                    // VATAmountLine."VAT Base" := Amount;
                    // VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                    // VATAmountLine."Line Amount" := "Line Amount";
                    // if "Allow Invoice Disc." then
                    //     VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                    // VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                    // VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                    // VATAmountLine.InsertLine();
                    //>>FS
                    TransHeaderAmount += PrevLineAmount;
                    PrevLineAmount := "Line Amount";
                    TotalSubTotal += "Line Amount";
                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                    TotalAmountVAT += "Amount Including VAT" - Amount;
                    TotalAmountInclVAT += "Amount Including VAT";
                    TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                    If TotalAmountVAT <> 0 then TvaNotNull := True;
                    if FirstLineHasBeenOutput then
                        Clear(DummyCompanyInfo.Picture);
                    FirstLineHasBeenOutput := true;
                    transport_cost := false;
                    Emballage := false;

                    if Line.Type = Line.Type::" " then
                        gras := true;

                    FormatDocument.SetSalesCrMemoLine(Line, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);


                End;

                trigger OnPreDataItem()
                begin
                    //<<FS
                    // VATAmountLine.DeleteAll();
                    // VATClauseLine.DeleteAll();
                    ShipmentLine.Reset();
                    ShipmentLine.DeleteAll();
                    MoreLines := Find('+');
                    while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                        MoreLines := Next(-1) <> 0;
                    if not MoreLines then
                        CurrReport.Break();
                    SetRange("Line No.", 0, "Line No.");
                    TransHeaderAmount := 0;
                    PrevLineAmount := 0;
                    FirstLineHasBeenOutput := false;
                    DummyCompanyInfo.Picture := CompanyInfo.Picture;
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

                    Groupe := ((NumeroDescription - 1) div 23) + 1;

                end;

                trigger OnPreDataItem()
                begin
                    if (((NumeroDescription mod 23) < 19) and (NumeroDescription mod 23 <> 0)) THEN
                        SETRANGE(Number, 1, 18 - (NumeroDescription mod 23))
                    Else if (NumeroDescription mod 23 > 19) and (NumeroDescription mod 23 < 24) then
                        SETRANGE(Number, 1, (23 - (NumeroDescription mod 23)) mod 23);
                end;
            }
            //<<FS
            // dataitem(VATAmountLine; "VAT Amount Line")
            // {
            //     DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
            //     UseTemporary = true;
            //     column(InvoiceDiscountAmount_VATAmountLine; "Invoice Discount Amount")
            //     {
            //         AutoFormatExpression = Header."Currency Code";
            //         AutoFormatType = 1;
            //     }
            //     column(InvoiceDiscountAmount_VATAmountLine_Lbl; FieldCaption("Invoice Discount Amount"))
            //     {
            //     }
            //     column(InvoiceDiscountBaseAmount_VATAmountLine; "Inv. Disc. Base Amount")
            //     {
            //         AutoFormatExpression = Header."Currency Code";
            //         AutoFormatType = 1;
            //     }
            //     column(InvoiceDiscountBaseAmount_VATAmountLine_Lbl; FieldCaption("Inv. Disc. Base Amount"))
            //     {
            //     }
            //     column(LineAmount_VatAmountLine; "Line Amount")
            //     {
            //         AutoFormatExpression = Header."Currency Code";
            //         AutoFormatType = 1;
            //     }
            //     column(LineAmount_VatAmountLine_Lbl; FieldCaption("Line Amount"))
            //     {
            //     }
            //     column(VATAmount_VatAmountLine; "VAT Amount")
            //     {
            //         AutoFormatExpression = Header."Currency Code";
            //         AutoFormatType = 1;
            //     }
            //     column(VATAmount_VatAmountLine_Lbl; FieldCaption("VAT Amount"))
            //     {
            //     }
            //     column(VATAmountLCY_VATAmountLine; VATAmountLCY)
            //     {
            //     }
            //     column(VATAmountLCY_VATAmountLine_Lbl; VATAmountLCYLbl)
            //     {
            //     }
            //     column(VATBase_VatAmountLine; "VAT Base")
            //     {
            //         AutoFormatExpression = Line.GetCurrencyCode();
            //         AutoFormatType = 1;
            //     }
            //     column(VATBase_VatAmountLine_Lbl; FieldCaption("VAT Base"))
            //     {
            //     }
            //     column(VATBaseLCY_VATAmountLine; VATBaseLCY)
            //     {
            //     }
            //     column(VATBaseLCY_VATAmountLine_Lbl; VATBaseLCYLbl)
            //     {
            //     }
            //     column(VATIdentifier_VatAmountLine; "VAT Identifier")
            //     {
            //     }
            //     column(VATIdentifier_VatAmountLine_Lbl; FieldCaption("VAT Identifier"))
            //     {
            //     }
            //     column(VATPct_VatAmountLine; "VAT %")
            //     {
            //         DecimalPlaces = 0 : 5;
            //     }
            //     column(VATPct_VatAmountLine_Lbl; FieldCaption("VAT %"))
            //     {
            //     }
            //     column(NoOfVATIdentifiers; Count)
            //     {
            //     }

            //     trigger OnAfterGetRecord()
            //     begin
            //         VATBaseLCY :=
            //           GetBaseLCY(
            //             Header."Posting Date", Header."Currency Code",
            //             Header."Currency Factor");
            //         VATAmountLCY :=
            //           GetAmountLCY(
            //             Header."Posting Date", Header."Currency Code",
            //             Header."Currency Factor");

            //         TotalVATBaseLCY += VATBaseLCY;
            //         TotalVATAmountLCY += VATAmountLCY;

            //         // if ShowVATClause("VAT Clause Code") then begin
            //         //     VATClauseLine := VATAmountLine;
            //         //     if VATClauseLine.Insert() then;
            //         // end;
            //     end;

            //     trigger OnPreDataItem()
            //     begin
            //         Clear(VATBaseLCY);
            //         Clear(VATAmountLCY);

            //         TotalVATBaseLCY := 0;
            //         TotalVATAmountLCY := 0;
            //     end;
            // }
            // dataitem(VATClauseLine; "VAT Amount Line")
            // {
            //     DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
            //     UseTemporary = true;
            //     column(VATClausesHeader; VATClausesText)
            //     {
            //     }
            //     column(VATIdentifier_VATClauseLine; "VAT Identifier")
            //     {
            //     }
            //     column(Code_VATClauseLine; VATClause.Code)
            //     {
            //     }
            //     column(Code_VATClauseLine_Lbl; VATClause.FieldCaption(Code))
            //     {
            //     }
            //     column(Description_VATClauseLine; VATClause.Description)
            //     {
            //     }
            //     column(Description2_VATClauseLine; VATClause."Description 2")
            //     {
            //     }
            //     column(VATAmount_VATClauseLine; "VAT Amount")
            //     {
            //         AutoFormatExpression = Header."Currency Code";
            //         AutoFormatType = 1;
            //     }
            //     column(NoOfVATClauses; Count)
            //     {
            //     }


            //     trigger OnAfterGetRecord()
            //     begin
            //         if "VAT Clause Code" = '' then
            //             CurrReport.Skip();
            //         if not VATClause.Get("VAT Clause Code") then
            //             CurrReport.Skip();
            //         // VATClause.GetDescription(Header);
            //     end;

            //     trigger OnPreDataItem()
            //     begin
            //         if Count = 0 then
            //             VATClausesText := ''
            //         else
            //             VATClausesText := VATClausesLbl;
            //     end;
            // }

            // trigger OnAfterGetRecord()
            // var

            //     CurrencyExchangeRate: Record "Currency Exchange Rate";
            //     lItem: Record Item;
            // begin
            //     if BankAccount.get(Header."Company Bank Account Code") then;

            //     CalcFields("Work Description");
            //     ShowWorkDescription := "Work Description".HasValue;
            //     Clear(PaymentInstructionsTxt);
            //     CLEAR(TotalRemise);
            //     GsalesLine.SetRange("Document No.", "No.");
            //     if GsalesLine.FindSet then Begin
            //         NbInvoiceLine := GsalesLine.Count;
            //         TotPage := round(NbInvoiceLine / 23, 1, '>');
            //         repeat
            //             TotalRemise += GsalesLine."Line Discount Amount";
            //             If (GsalesLine.Type = GsalesLine.Type::Item) and (GsalesLine."Gen. Prod. Posting Group" = 'PF') then
            //                 if lItem.Get(GsalesLine."No.") Then
            //                     If ItemCateg.get(lItem."Item Category Code") Then;
            //         until GsalesLine.Next = 0;
            //     End;
            //     ChecksPayableText := StrSubstNo(ChecksPayableLbl, CompanyInfo.Name);
            //     // FormatAddressFields(Header);
            //     //FormatDocumentFields(Header);
            //     if SellToContact.Get("Sell-to Contact No.") then;
            //     if BillToContact.Get("Bill-to Contact No.") then;

            //     if not Cust.Get("Bill-to Customer No.") then
            //         Clear(Cust);


            //     if "Currency Code" <> '' then begin
            //         CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
            //         CalculatedExchRate :=
            //           Round(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
            //         ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
            //     end;

            //     GetLineFeeNoteOnReportHist("No.");
            //     country.Get("VAT Country/Region Code");
            //     if country1.Get("Ship-to Country/Region Code") then;//WDC03


            //     CalcFields("Amount Including VAT");
            //     //RemainingAmount := GetRemainingAmount;
            //     if RemainingAmount = 0 then
            //         RemainingAmountTxt := AlreadyPaidLbl
            //     else
            //         if RemainingAmount <> "Amount Including VAT" then
            //             RemainingAmountTxt := StrSubstNo(PartiallyPaidLbl, Format(RemainingAmount, 0, '<Precision,2><Standard Format,0>'))
            //         else
            //             RemainingAmountTxt := '';

            //     TotalSubTotal := 0;
            //     TotalInvDiscAmount := 0;
            //     TotalAmount := 0;
            //     TotalAmountVAT := 0;
            //     TotalAmountInclVAT := 0;
            //     TotalPaymentDiscOnVAT := 0;
            //     MonthTxt := Format(DATE2DMY("Posting Date", 2));
            //     IF StrLen(MonthTxt) <> 2 then
            //         MonthTxt := '0' + MonthTxt;
            //     BDMRInvoiceNo := "No.";

            //     IF NOT CustSell.Get("Sell-to Customer No.") then
            //         CustSell.Reset();

            //     Clear(Paiement);
            //     if "Payment Method Code" = 'PRLVT' then
            //         Paiement := 'Prélèvement le ' + Format("Due Date")
            //     else
            //         Paiement := "Payment Method Code" + ' ' + PaymentTerms.Description;
            //     //<<WDC 
            //     salesinvoiceline.Reset();
            //     salesinvoiceline.SetRange(salesinvoiceline."Document No.", "No.");
            //     salesinvoiceline.SetRange(salesinvoiceline.Type, salesinvoiceline.Type::Item);
            //     if salesinvoiceline.FindFirst() then begin
            //         PostedWhsShipmentLine.reset();
            //         PostedWhsShipmentLine.SetRange(PostedWhsShipmentLine."Posted Source Document", PostedWhsShipmentLine."Posted Source Document"::"Posted Shipment");
            //         PostedWhsShipmentLine.SetRange(PostedWhsShipmentLine."Posted Source No.", salesinvoiceline."Shipment No.");
            //         if PostedWhsShipmentLine.FindFirst() then
            //             PostedWhsShipmentheader.get(PostedWhsShipmentLine."No.");
            //         repeat
            //             PieceNumber += salesinvoiceline.Quantity;
            //         until salesinvoiceline.Next() = 0;
            //     end;
            //     //>>WDC
            //     TextAdr := '';
            //     if "Shortcut Dimension 1 Code" = 'MJ' then
            //         TextAdr := 'Zone Industrielle Menzel jemil , Menzel Jemil , Bizerte';
            //     if "Shortcut Dimension 1 Code" = 'BA' then
            //         TextAdr := 'Zone Industrielle Bouargoub , Bouargoub , Nabeul';
            //     //>>WDC
            // end;

            // trigger OnPreDataItem()
            // begin
            //     FirstLineHasBeenOutput := false;
            // end;
            //>>FS
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
                    Visible = false;
                    Caption = 'Options';
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                    }
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Show Assembly Components';
                        ToolTip = 'Specifies if you want the report to include information about components that were used in linked assembly orders that supplied the item(s) being sold. (Only possible for RDLC report layout.)';
                    }
                    field(DisplayShipmentInformation; DisplayShipmentInformation)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Shipments';
                        ToolTip = 'Specifies that shipments are shown on the document.';
                    }
                    field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Additional Fee Note';
                        ToolTip = 'Specifies if you want notes about additional fees to be shown on the document.';
                    }
                }
            }
        }
        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }
    labels
    {
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
        CompanyInfo.VerifyAndSetPaymentInfo;
        TvaNotNull := false;


    end;

    trigger OnPostReport()
    begin
        if LogInteraction and not IsReportInPreviewMode then
            if Header.FindSet then
                repeat
                    if Header."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          4, Header."No.", 0, 0, DATABASE::Contact, Header."Bill-to Contact No.", Header."Salesperson Code",
                          Header."Campaign No.", Header."Posting Description", '')
                    else
                        SegManagement.LogDocument(
                          4, Header."No.", 0, 0, DATABASE::Customer, Header."Bill-to Customer No.", Header."Salesperson Code",
                          Header."Campaign No.", Header."Posting Description", '');
                until Header.Next() = 0;

    end;

    trigger OnPreReport()
    begin
        if Header.GetFilters = '' then
            Error(NoFilterSetErr);

        if not CurrReport.UseRequestPage then
            InitLogInteraction;

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;

    var
        Quantitétotal: Integer;
        ShipmentNo: Code[15];
        Emballage: Boolean;
        transport_cost: Boolean;
        ItemCateg: Record "Item Category";
        MtTtLettres: Text;
        TotalEmballage: Decimal;
        NbCartons: Decimal;
        NbPalette: Decimal;
        NbPieces: Decimal;
        TvaNotNull: Boolean;
        NbInvoiceLine: Integer;
        TotPage: Integer;
        Paiement: Text;
        CustSell: Record Customer;
        MonthTxt: Text;
        BankAccount: Record 270;
        BDMRInvoiceNo: Text;
        NumeroDescription: integer;
        LineToAdd: Integer;
        NumeroWorkDescription: integer;
        Groupe: Integer;
        TotalRemise: Decimal;
        GsalesLine: Record "Sales invoice line";
        PhoneNo: Text[30];
        FaxNo: Text[30];
        country: record 9;
        country1: record 9;
        SalespersonLbl: Label 'Salesperson';
        CompanyInfoBankAccNoLbl: Label 'Account No.';
        CompanyInfoBankNameLbl: Label 'Bank';
        CompanyInfoGiroNoLbl: Label 'Giro No.';
        CompanyInfoPhoneNoLbl: Label 'Phone No.';
        CopyLbl: Label 'Copy';
        EMailLbl: Label 'Email';
        HomePageLbl: Label 'Home Page';
        InvDiscBaseAmtLbl: Label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: Label 'Invoice Discount';
        InvNoLbl: Label 'Invoice No.';
        LineAmtAfterInvDiscLbl: Label 'Payment Discount on VAT';
        LocalCurrencyLbl: Label 'Local Currency';
        PageLbl: Label 'Page';
        PaymentTermsDescLbl: Label 'Payment Terms';
        PaymentMethodDescLbl: Label 'Payment Method';
        PostedShipmentDateLbl: Label 'Shipment Date';
        SalesInvLineDiscLbl: Label 'Discount %';
        SalesInvoiceLbl: Label 'Invoice';
        YourSalesInvoiceLbl: Label 'Your Invoice';
        ShipmentLbl: Label 'Shipment';
        ShiptoAddrLbl: Label 'Ship-to Address';
        ShptMethodDescLbl: Label 'Shipment Method';
        SubtotalLbl: Label 'Subtotal';
        TotalLbl: Label 'Total';
        VATAmtSpecificationLbl: Label 'VAT Amount Specification';
        VATAmtLbl: Label 'VAT Amount';
        VATAmountLCYLbl: Label 'VAT Amount (LCY)';
        VATBaseLbl: Label 'VAT Base';
        VATBaseLCYLbl: Label 'VAT Base (LCY)';
        VATClausesLbl: Label 'VAT Clause';
        VATIdentifierLbl: Label 'VAT Identifier';
        VATPercentageLbl: Label 'VAT %';
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        SalesHeader: Record "Sales Header";
        DummyCompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        RespCenter: Record "Responsibility Center";
        VATClause: Record "VAT Clause";
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        SellToContact: Record Contact;
        BillToContact: Record Contact;
        // Language: Codeunit Language;
        // FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        WorkDescriptionInstream: InStream;
        JobNo: Code[15];
        JobTaskNo: Code[15];
        WorkDescriptionLine: Text;
        CustAddr: array[8] of Text[100];
        ChecksPayableText: Text;
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        SalesPersonText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        LineDiscountPctText: Text;
        RemainingAmountTxt: Text;
        JobNoLbl: Text;
        JobTaskNoLbl: Text;
        FormattedVATPct: Text;
        FormattedUnitPrice: Text;
        FormattedQuantity: Text;
        FormattedLineAmount: Text;
        MoreLines: Boolean;
        ShowWorkDescription: Boolean;
        ShowShippingAddr: Boolean;
        LogInteraction: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        RemainingAmount: Decimal;
        TransHeaderAmount: Decimal;
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        DisplayShipmentInformation: Boolean;
        CompanyLogoPosition: Integer;
        FirstLineHasBeenOutput: Boolean;
        CalculatedExchRate: Decimal;
        PaymentInstructionsTxt: Text;
        ExchangeRateText: Text;
        ExchangeRateTxt: Label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        PrevLineAmount: Decimal;
        NoFilterSetErr: Label 'You must specify one or more filters to avoid accidently printing all documents.';
        DisplayAdditionalFeeNote: Boolean;
        AlreadyPaidLbl: Label 'The invoice has been paid.';
        PartiallyPaidLbl: Label 'The invoice has been partially paid. The remaining amount is %1', Comment = '%1=an amount';
        FromLbl: Label 'From';
        BilledToLbl: Label 'Billed to';
        ChecksPayableLbl: Label 'Please make checks payable to %1', Comment = '%1 = company name';
        QuestionsLbl: Label 'Questions?';
        ThanksLbl: Label 'Thank You!';
        JobTaskDescription: Text[100];
        JobTaskDescLbl: Label 'Job Task Description';
        UnitLbl: Label 'Unit';
        VATClausesText: Text;
        QtyLbl: Label 'Qty', Comment = 'Short form of Quantity';
        PriceLbl: Label 'Price';
        PricePerLbl: Label 'Price per';
        WarehouseShipmentLine: record "Warehouse Shipment Line";
        WarehouseShipmentHeader: record "Warehouse Shipment Header";
        PostedWhsShipmentheader: record "Posted Whse. Shipment Header";
        PostedWhsShipmentLine: record "Posted Whse. Shipment Line";
        salesinvoiceline: record "sales invoice line";
        TextAdr: Text[250];
        gras: Boolean;
        DescriptionText: Text[512];
        Item: record item;
        DescriptionTextlength: Integer;
        PieceNumber: Integer;



    local procedure InitLogInteraction()
    begin
        // LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;



    local procedure DocumentCaption(): Text[150]
    var
        DocCaption: Text;
    begin
        if DocCaption <> '' then
            exit(DocCaption);
        exit(SalesInvoiceLbl);
    end;



    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody);
    end;

    local procedure GetUOMText(UOMCode: Code[10]): Text[50]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;


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
            //LineFeeNoteOnReportHist.SetRange("Language Code", Language.GetUserLanguageCode);
            if LineFeeNoteOnReportHist.FindSet then
                repeat
                    TempLineFeeNoteOnReportHist.Init();
                    TempLineFeeNoteOnReportHist.Copy(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.Insert();
                until LineFeeNoteOnReportHist.Next() = 0;
        end;
    end;



    // local procedure FillNameValueTable(var NameValueBuffer: Record "Name/Value Buffer"; Name: Text; Value: Text)
    // var
    //     KeyIndex: Integer;
    // begin
    //     if Value <> '' then begin
    //         Clear(NameValueBuffer);
    //         if NameValueBuffer.FindLast then
    //             KeyIndex := NameValueBuffer.ID + 1;
    //         NameValueBuffer.Init();
    //         NameValueBuffer.ID := KeyIndex;
    //         NameValueBuffer.Name := CopyStr(Name, 1, MaxStrLen(NameValueBuffer.Name));
    //         NameValueBuffer.Value := CopyStr(Value, 1, MaxStrLen(NameValueBuffer.Value));
    //         NameValueBuffer.Insert();
    //     end;
    // end;

    // local procedure FormatAddressFields(var SalesInvoiceHeader: Record "Sales Invoice Header")
    // begin
    //     FormatAddr.GetCompanyAddr(SalesInvoiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
    //     FormatAddr.SalesInvBillTo(CustAddr, SalesInvoiceHeader);
    // end;

    local procedure FormatDocumentFields(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        FormatDocument.SetTotalLabels(SalesInvoiceHeader.GetCurrencySymbol, TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesInvoiceHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesInvoiceHeader."Payment Terms Code", SalesInvoiceHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesInvoiceHeader."Payment Method Code", SalesInvoiceHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesInvoiceHeader."Shipment Method Code", SalesInvoiceHeader."Language Code");
    end;
}

