namespace SogregaDev.SogregaDev;

using Microsoft.Finance.GeneralLedger.Account;
using System.Security.User;
/**********************************Documentation*********************
 //WDC01     WDC.HG  11/12/2024          create current object 
 *********************************************************************/
pageextension 50054 "WDC Chart of Accounts" extends "Chart of Accounts"
{
    trigger OnOpenPage()
    var
        lUserSetup: Record "User Setup";
        lText01: TextConst ENU = 'You are not allowed to check this menu', FRA = 'Vous n"avez pas le droit d"ouvrir ce menu';
    begin
        lUserSetup.get(UserId);
        if not lUserSetup."Check Accounting" then
            Error(lText01);
    end;

    trigger OnAfterGetRecord()
    var
        lUserSetup: Record "User Setup";
        lText01: TextConst ENU = 'You are not allowed to check this menu', FRA = 'Vous n"avez pas le droit d"ouvrir ce menu';
    begin
        lUserSetup.get(UserId);
        if not lUserSetup."Check Accounting" then
            Error(lText01);
    end;
}

