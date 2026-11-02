//*************Documentation***************
//WDC01  WDC.SH  30/09/26  Create Current Object 
namespace Sogrega.Sogrega;

using Microsoft.Purchases.History;

reportextension 50002 PurchaseReceiptExt extends "Purchase - Receipt"
{
    dataset
    {
        add("Purch. Rcpt. Header")
        {
            column(PostingDate; Format("Purch. Rcpt. Header"."Posting Date", 0, 4))
            {
            }

            column(PostingDateCaption; PostingDateCaption)
            {
            }

        }
    }
    var
        PostingDateCaption: TextConst FRA = 'Date comptabilisation', ENU = 'Posting Date';
}
