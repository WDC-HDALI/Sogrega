namespace sogrega.sogrega;

using Microsoft.HumanResources.Employee;

pageextension 56003 "WDC Employee Card" extends "Employee Card"
{
    layout
    {
        addlast(General)
        {
            field("Carte Séjour"; Rec."Carte Séjour")
            {
                ApplicationArea = All;
            }
            field("National Identity Card No."; Rec."National Identity Card No.")
            {
                ApplicationArea = ALL;
            }
            field("Marital Status"; Rec."Marital Status")
            {
                ApplicationArea = ALL;
            }
            field("Loaded childs"; Rec."Loaded childs")
            {
                ApplicationArea = ALL;
            }
            field("Code Direction"; Rec."Code Direction")
            {
                ApplicationArea = ALL;
            }
        }
    }
}
