namespace sogrega.sogrega;

using Microsoft.Finance.RoleCenters;

pageextension 56005 "WDC Accountant Role Center" extends "Accountant Role Center"
{
    actions
    {
        addafter(Action172)
        {
            group("Employee Declaration")
            {
                captionML = ENU = 'Employee Declaration', FRA = 'Déclaration employeur';
                action("Annex 1")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Annex 1', FRA = 'Annexe 1';
                    Image = Action;
                    RunObject = Page "WDC ANNEX I";
                }
                action("Annex 2")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Annex 2', FRA = 'Annexe 2';
                    Image = Action;
                    RunObject = Page "WDC ANNEX II";
                }
                // action("Annex 4")
                // {
                //     ApplicationArea = All;
                //     CaptionML = ENU = 'Annex 4', FRA = 'Annexe 4';
                //     Image = Action;
                //     RunObject = Page "WDC ANNEX IV";
                // }
                action("Annex 5")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Annex 5', FRA = 'Annexe 5';
                    Image = Action;
                    RunObject = Page "WDC ANNEX V";
                }
                action("Annex 6")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Annex 6', FRA = 'Annexe 6';
                    Image = Action;
                    RunObject = Page "WDC ANNEX VI";
                }
            }
        }
    }
}
