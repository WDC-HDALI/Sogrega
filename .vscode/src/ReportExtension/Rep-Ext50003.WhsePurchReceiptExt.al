namespace Sogrega.Sogrega;

using Microsoft.Warehouse.History;

reportextension 50003 WhsePurchReceiptExt extends "Whse. - Posted Receipt"
{
    dataset
    {
        add("Posted Whse. Receipt Header")
        {
            column(PostingDate; Format("Posted Whse. Receipt Header"."Posting Date", 0, 4))
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
