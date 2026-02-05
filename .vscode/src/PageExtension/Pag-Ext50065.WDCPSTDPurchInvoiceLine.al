pageextension 50065 "WDC PSTD Purch. Invoice Line" extends "Posted Purchase Invoice Lines"
{

    layout
    {
        modify("Job No.")
        {
            Visible = false;

        }

        addafter("Inv. Discount Amount")
        {
            field("Receipt No."; Rec."Receipt No.")
            {
                ApplicationArea = all;
            }

            field("Order No. WDC"; Rec."Order No.")
            {
                ApplicationArea = all;
            }
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = all;
            }
        }

    }
}
