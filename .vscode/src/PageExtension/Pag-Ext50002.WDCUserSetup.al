pageextension 50002 "WDC User Setup" extends "User Setup"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object
    //WDC02  HG   11/12/2024  show field 
    //WDC03  HG   12/05/2026  Show field "Allow weight import"

    layout
    {
        addafter("Allow Deferral Posting From")
        {
            field("Site Code"; Rec."Site Code")
            {
                ApplicationArea = all;
                TableRelation = "Dimension Value".Code where("Dimension Code" = const('SITE'));
            }
            field("Default Sales Location Code"; Rec."Default Sales Location Code")
            {
                ApplicationArea = all;
            }
            field("Default Receipt Location Code"; Rec."Default Receipt Location Code")
            {
                ApplicationArea = all;
            }
            field("Default Shp Location Code"; Rec."Default Shp Location Code")
            {
                ApplicationArea = all;
            }
            field("Update Purchase Price"; Rec."Update Purchase Price")
            {
                ApplicationArea = all;
            }
            //WDC02
            field("Check Accounting"; Rec."Check Accounting")
            {
                ApplicationArea = all;
            }
            //<<WDC03
            field("Allow Weight Import"; Rec."Allow Weight Import")
            {
                ApplicationArea = All;
            }
            //>>WDC03

            // field("Update BOM"; Rec."Update BOM")
            // {
            //     ApplicationArea = all;
            // }
            // field("Update Routing"; Rec."Update BOM")
            // {
            //     ApplicationArea = all;
            // }
            //WDC02

        }

    }

}
