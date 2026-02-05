namespace Sogrega.Sogrega;

using Microsoft.Purchases.History;

pageextension 50061 "WDC Get Receipt Lines" extends "Get Receipt Lines"
{
    layout
    {
        addbefore("Document No.")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
