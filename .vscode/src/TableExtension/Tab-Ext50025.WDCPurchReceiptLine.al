namespace sogrega.sogrega;

using Microsoft.Purchases.History;
using Microsoft.Purchases.Vendor;
//********************Documentation**********************
//WDC01  WDC.HG  18/06/2025  Add vendor Name 

tableextension 50025 "WDC PurchReceiptLine" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50000; "VendorName"; text[100])
        {
            CaptionML = ENU = 'Vendor Name', FRA = 'Nom fournisseur';
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Buy-from Vendor No.")));
            Editable = false;
        }
    }
}
