namespace sogrega.sogrega;

using Microsoft.Foundation.Company;

pageextension 56001 "WDC Company Information" extends "Company Information"
{
    layout
    {
        addlast(General)
        {
            field(Activity; Rec.Activity)
            {
                ApplicationArea = ALL;
            }
        }
    }
    var
}
