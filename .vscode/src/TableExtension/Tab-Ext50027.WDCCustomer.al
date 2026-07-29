namespace Sogrega.Sogrega;

using Microsoft.Sales.Customer;
using Microsoft.Sales.Receivables;

tableextension 50027 "WDC Customer" extends Customer
{
    fields
    {
        field(50000; "Customer Balance"; Decimal)
        {
            CaptionML = ENU = 'Customer Balance', FRA = 'Solde client';

            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("No."),
                                                                         "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                         "Posting Date" = field("Date Filter"),
                                                                         "Currency Code" = field("Currency Filter")));
            Editable = false;
            FieldClass = FlowField;
        }

        field(50001; "Customer Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = field("Date Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            CaptionML = ENU = 'Customer Balance LCY', FRA = 'Solde client DS';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
