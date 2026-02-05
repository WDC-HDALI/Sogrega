namespace sogrega.sogrega;

using Microsoft.Purchases.History;
//********************Documentation**********************
//WDC01  WDC.HG  18/06/2025  Add vendor Name 

pageextension 50067 "WDC PostedPurchaseReceiptLine" extends "Posted Purchase Receipt Lines"
{
    layout
    {
        addafter("Buy-from Vendor No.")
        {
            field(VendorName; Rec.VendorName)
            {
                ApplicationArea = all;
                DrillDown = false;

            }
        }
    }

}
