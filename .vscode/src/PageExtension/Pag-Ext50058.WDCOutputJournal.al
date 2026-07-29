namespace SogregaDev.SogregaDev;

using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Journal;
using Microsoft.Manufacturing.Document;
using Sogrega.Sogrega;
using Microsoft.Inventory.Ledger;
//**************Documentation*************
//WDC01  WDC.HG  27/04/2026  Import Weight from Onedrive 


pageextension 50058 "WDC Output Journal" extends "Output Journal"
{
    layout
    {
        modify("Document No.")
        {
            Visible = false;
        }
        modify("Run Time")
        {
            Visible = false;
        }
        modify("Cap. Unit of Measure Code")
        {
            Visible = false;
        }
        modify("Applies-to Entry")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify(Finished)
        {
            Visible = false;
        }

        addafter("Output Quantity")
        {
            field("Net weight"; Rec."Net weight")
            {
                ApplicationArea = All;
                //Editable = false;
            }
        }
    }
    //<<WDC01
    actions
    {
        addafter("Explode &Routing")
        {
            action(ImportWeighing)
            {
                CaptionML = ENU = 'Import Weight', FRA = 'Importer poids';
                Image = Import;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Mgt: Codeunit "WDC Weight Management";
                begin

                    begin
                        Mgt.ImportPoidsLine(Rec);
                    end;
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref(ImportPoid; ImportWeighing)
            {

            }
        }
    }
    //>>WDC01
}