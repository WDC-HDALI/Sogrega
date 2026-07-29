pageextension 50003 "WDC Purchase Order" extends "Purchase Order"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object
    //WDC02  CHG  05/02/2026  add print QR action

    layout
    {
        movebefore(Status; "Shortcut Dimension 1 Code")
        modify("Shortcut Dimension 1 Code")
        {

            Editable = Rec.Status <> Rec.Status::Released;
            ShowMandatory = true;
        }

    }
    actions
    {
        modify(Post)
        {
            Visible = false;
        }


        addlast(processing)
        {
            action(PrintOrderCAB)
            {
                ApplicationArea = All;
                CaptionML = FRA = 'Imprimer CAB', ENU = 'Print Bar Code';
                Image = Print;
                trigger OnAction()
                var
                    purchaseheader: record "Purchase Header";
                begin
                    purchaseheader.reset();
                    purchaseheader.SetRange("Document Type", purchaseheader."Document Type"::Order);
                    purchaseheader.SetRange("No.", rec."No.");
                    purchaseheader.setrange("Buy-from Vendor No.", rec."Buy-from Vendor No.");
                    if purchaseheader.FindSet() then
                        report.run(405, true, false, purchaseheader);
                end;
            }
        }
        addafter(Category_Category10)
        {
            actionref(pintOrderCAB; PrintOrderCAB)
            {

            }

        }


    }

}
