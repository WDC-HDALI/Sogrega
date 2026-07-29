pageextension 54101 WDCVendor extends "Vendor Card"
{
    layout
    {
        addbefore("VAT Registration No.")
        {
            field("Identification Type"; Rec."Identification Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Company Size Code")
        {
            // field("VAT Registration No."; Rec."VAT Registration No.")
            // {
            //     ApplicationArea = All;
            // }
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = All;
            }
            field("Resident"; Rec."Resident")
            {
                ApplicationArea = All;
            }
            field("Birth Date"; Rec."Birth Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
