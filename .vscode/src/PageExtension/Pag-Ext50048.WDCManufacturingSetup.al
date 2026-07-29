namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Setup;
//**************Documentation*************
//WDC01  WDC.HG  27/04/2026  add Import Onedrive Fields 

pageextension 50048 WDCManufacturingSetup extends "Manufacturing Setup"
{
    layout
    {
        addafter("Cost Incl. Setup")
        {
            field("BA Consuption Location"; Rec."BA Consuption Location")
            {
                ApplicationArea = all;
            }
            field("MJ Consuption Location"; Rec."MJ Consuption Location")
            {
                ApplicationArea = all;
            }
            field("Mandatory Output Weight"; Rec."Mandatory Output Weight")
            {
                ApplicationArea = all;
            }
        }
        //<<WDC01
        addafter(Planning)
        {
            group("Import Weight Setup")
            {
                CaptionML = ENU = 'Import Weight Setup', FRA = 'Configuration d''import poids';
                field("Tenant ID"; Rec."Tenant ID")
                {
                    ApplicationArea = all;
                }
                field("Client ID"; Rec."Client ID")
                {
                    ApplicationArea = all;
                }
                field("Client Secret"; Rec."Client Secret")
                {
                    ApplicationArea = all;
                }
                field("Drive ID"; Rec."Drive ID")
                {
                    ApplicationArea = all;
                }
            }
        }
        //>>WDC01
    }
}