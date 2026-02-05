namespace SogregaDev.SogregaDev;

using Microsoft.Warehouse.Request;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;

pageextension 50056 "WDC Source Documents" extends "Source Documents"
/**********************************Documentation*********************
//WDC01     WDC.IM            Create Current Object
*********************************************************************/
{
    layout
    {
        addafter("Destination No.")
        {
            field("Destination Name"; Rec."Destination Name")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        lVendor: Record Vendor;
        lCustomer: Record Customer;
    begin
        if Rec."Destination Type" = Rec."Destination Type"::Vendor then
            if lVendor.get(Rec."Destination No.") then begin
                Rec."Destination Name" := lVendor.Name;
                Rec.Modify();
            end
            else
                if lCustomer.get(Rec."Destination No.") then begin
                    Rec."Destination Name" := lCustomer.Name;
                    Rec.Modify();
                end;
    end;
}
