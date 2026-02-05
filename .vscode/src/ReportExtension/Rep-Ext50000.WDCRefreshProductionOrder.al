namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Document;

reportextension 50000 WDCRefreshProductionOrder extends "Refresh Production Order"
{
    dataset
    {
        modify("Production Order")
        {
            trigger OnAfterAfterGetRecord()
            begin
                TestField("Shortcut Dimension 1 Code");
            end;
        }
    }
}
