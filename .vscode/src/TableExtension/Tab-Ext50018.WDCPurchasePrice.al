namespace SogregaDev.SogregaDev;

using Microsoft.Purchases.Pricing;
using System.Security.User;
/**********************************Documentation*********************
 //WDC01     WDC.HG  03/12/2024          create current object 
 //WDC02     WDC.HG  11/12/2024          add control to "Direct Unit Cost"
 *********************************************************************/

tableextension 50018 "WDC Purchase Price" extends "Purchase Price"
{
    fields
    {
        field(50000; "Minimum Purchase Quantity"; Decimal)
        {
            CaptionML = ENU = 'Minimum Purchase Quantity', FRA = 'Quantité minimum d''achat ';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        //<<WDC02
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            begin
                if (rec."Direct Unit Cost" <> xRec."Direct Unit Cost") and (xRec."Direct Unit Cost" <> 0) then begin
                    UserSetup.get(UserId);
                    UserSetup.TestField("Update Purchase Price");
                end;

            end;
        }
        //>>WDC02
    }
    var
        UserSetup: record "User Setup"; //WDC02
}
