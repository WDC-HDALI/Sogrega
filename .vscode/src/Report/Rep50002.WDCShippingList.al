report 50002 "WDC Shipping List"
{
    /**********************************Documentation*********************
    //WDC01     WDC.HG            Creation of "Shipping List" report 
    //WDC02     WDC.IM            Add "Destination No."
    *********************************************************************/
    RDLCLayout = './.vscode/src/Report/RDLC/ShippingList.rdlc';
    ApplicationArea = Basic, Suite;
    UsageCategory = ReportsAndAnalysis;
    CaptionML = ENU = 'Shipping List ', FRA = 'Expédition entrepôt';

    dataset
    {
        dataitem(PostedWhseShpttHeader; "Posted Whse. Shipment Header")
        {
            RequestFilterFields = "No.";
            column(ColisageNo; "No.")
            {
            }
            column(date; "Posting Date")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAdr; CompanyInfo.Address)
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
            column(NetWeight; PostedWhseShpttHeader."Net Weight")
            {
            }
            column(GrossWeight; PostedWhseShpttHeader."Gross Weight")
            {
            }
            column(num; NumLineNotEmpty)
            {
            }
            Column(PageNumber; PageNumber)
            {
            }
            dataitem("PostedWhseShipmentLine"; "Posted Whse. Shipment Line")
            {
                DataItemLink = "No." = field("NO.");
                DataItemLinkReference = PostedWhseShpttHeader;
                DataItemTableView = SORTING("No.", "Line No.");
                column(Article; ItemRef."Reference No.")
                {
                }
                column(Description; "Description")
                {
                }
                column(UM; "Unit of Measure Code")
                {
                }
                column(LineNo; "Line No.")
                {
                }
                //<<WDC02
                column(destinataireNo; customer."No.")
                { }
                //>>WDC02
                column(destinataire; customer."Name")
                {
                }
                column(Address; customer."Address")
                {
                }
                column(country; country."Name")
                {
                }
                column(CF; customer."VAT Registration No.")
                {
                }
                column(Qty; "Quantity")
                {
                }
                column(PhoneNumber; customer."Phone No.")
                {
                }
                column(Qtytotal; Qty)
                {
                }
                column(Matricule; Matricule)
                {
                }
                column(companyAddress; TextAdr)
                {
                }
                column(BCCNo; BCCNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if StrLen(Description) >= 45 then
                        NumLineNotEmpty += 2
                    else
                        NumLineNotEmpty += 1;
                    PageNumber := ((NumLineNotEmpty - 1) div 26) + 1;
                    salesheader.reset;
                    if salesheader.get(salesheader."Document Type"::Order, "Source No.") then begin
                        customer.get(salesheader."Sell-to Customer No.");
                        country.Get(customer."Country/Region Code");
                        if BCCNo <> salesheader."External Document No." then
                            NumLineNotEmpty += 1;
                        BCCNo := salesheader."External Document No.";

                    end;
                    item.Get(PostedWhseShipmentLine."Item No.");
                    IF SalesShipmentHeader.get("Posted Source No.") THEN begin
                        ItemRef.Reset();
                        ItemRef.SetRange("Reference Type", ItemRef."Reference Type"::Customer);
                        ItemRef.SetRange("Reference Type No.", SalesShipmentHeader."Sell-to Customer No.");
                        ItemRef.SetRange("Item No.", PostedWhseShipmentLine."Item No.");
                        if ItemRef.FindFirst() then;

                        if SalesShipmentHeader."Shortcut Dimension 1 Code" = 'MJ' then
                            TextAdr := 'Zone Industrielle Menzel jemil , Menzel Jemil , Bizerte';
                        if SalesShipmentHeader."Shortcut Dimension 1 Code" = 'BA' then
                            TextAdr := 'Zone Industrielle Bouargoub , Bouargoub , Nabeul';
                    end;


                end;
            }
            dataitem(integer; integer)
            {
                DataItemTableView = SORTING(Number);

                Column(NumLineNotEmpty; NumLineNotEmpty + Number)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    PageNumber := ((NumLineNotEmpty - 1) div 26) + 1;
                end;

                trigger OnPreDataItem()
                begin
                    if (((NumLineNotEmpty mod 26) < 22) and (NumLineNotEmpty mod 26 <> 0)) THEN
                        SETRANGE(Number, 1, 22 - (NumLineNotEmpty mod 26))
                    Else if (NumLineNotEmpty mod 26 >= 22) then
                        SETRANGE(Number, 1, (26 - (NumLineNotEmpty mod 26)))
                    else if ((NumLineNotEmpty mod 26) = 0) then
                        SETRANGE(Number, 0)


                end;
            }
            trigger OnPreDataItem()
            begin
                Qty := 0;
                TextAdr := '';
            end;

        }
    }

    trigger OnPreReport()

    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
    end;

    trigger OnInitReport()

    begin
        clear(NumLineNotEmpty);
    end;

    var
        CompanyInfo: record 79;
        customer: Record 18;
        salesheader: record 36;
        Item: record 27;
        NumLineNotEmpty: Integer;
        PageNumber: Integer;
        Qty: Integer;
        country: record 9;
        SalesShipmentHeader: Record "Sales Shipment Header";
        TextAdr: text[250];
        BCCNo: code[50];
        ItemRef: Record "Item Reference";

}
