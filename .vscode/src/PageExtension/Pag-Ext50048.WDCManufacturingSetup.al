namespace SogregaDev.SogregaDev;

using Microsoft.Manufacturing.Setup;

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
    }
}
