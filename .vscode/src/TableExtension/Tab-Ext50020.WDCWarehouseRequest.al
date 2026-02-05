namespace SogregaDev.SogregaDev;

using Microsoft.Warehouse.Request;
using Microsoft.Sales.Customer;

tableextension 50020 "WDC Warehouse Request" extends "Warehouse Request"
/**********************************Documentation*********************
//WDC01     WDC.IM            Create Current Object
*********************************************************************/
{
    fields
    {
        field(50000; "Destination Name"; Text[100])
        {
            CaptionML = ENU = 'Destination Name', FRA = 'Nom destination';
            DataClassification = ToBeClassified;

        }
    }
}
