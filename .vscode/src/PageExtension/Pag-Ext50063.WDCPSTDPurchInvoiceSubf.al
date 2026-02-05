pageextension 50063 "WDC PSTD Purch. Invoice Subf" extends "Posted Purch. Invoice Subform"
{

    layout
    {
        modify("Job No.")
        {
            Visible = false;

        }

        addafter("Line Amount")
        {
            field("Receipt No."; Rec."Receipt No.")
            {
                ApplicationArea = all;
            }
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = all;
            }
        }

    }
}
