namespace Sogrega.Sogrega;

using Microsoft.Sales.Customer;

pageextension 50075 "WDC Customer List" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field("Customer Balance"; Rec."Customer Balance")
            {
                ApplicationArea = All;
            }
            field("Customer Balance (LCY)"; Rec."Customer Balance (LCY)")
            {
                ApplicationArea = All;
            }
        }
    }
}
