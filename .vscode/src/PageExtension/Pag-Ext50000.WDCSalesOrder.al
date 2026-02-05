pageextension 50000 "WDC Sales Order" extends "Sales Order"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

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

        addlast(processing)
        {
            action(CloseOrder)
            {
                CaptionML = ENU = 'Close Order', FRA = 'Clôturer la commande';
                Image = Close;
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                var
                    lText01: TextConst ENU = 'Do you want to close the order?', FRA = 'Voulez-vous clôturer la commande?';
                begin
                    if Confirm(lText01) then begin
                        Rec."Order Closed" := true;
                        Rec.Modify;
                    end;
                end;
            }
        }
        modify("Pla&nning")
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField(Status, rec.status::Released);
            end;
        }
        modify(Post)
        {
            Visible = false;
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if rec."Sell-to Customer No." = 'CLT-00001' then
            CurrPage.SalesLines.Page.SetVisibility(true);
    end;
}

