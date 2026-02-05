pageextension 50064 "WDC Purchase Lines" extends "Purchase Lines"
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
            field("Order No. WDC"; Rec."Order No.")
            {
                ApplicationArea = all;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = all;
            }
        }

    }
}
