tableextension 50002 "WDC Sales Header" extends "Sales Header"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object
    fields
    {
        field(50000; "Matricule"; Code[50])
        {
            Caption = 'Matricule';
            DataClassification = ToBeClassified;
        }
        field(50001; "Order Closed"; Boolean)
        {
            CaptionML = ENU = 'Order Closed', FRA = 'Commande clôturée';
            DataClassification = ToBeClassified;
        }

    }

    trigger OnAfterInsert()
    var
        lSalesHeader: Record "Sales Header";
    begin
        if lSalesHeader.get(rec."Document Type", rec."No.") Then begin
            if UserSetup.get(UserId) then
                If UserSetup."Site Code" <> '' then begin
                    lSalesHeader.validate("Shortcut Dimension 1 Code", UserSetup."Site Code");
                    lSalesHeader.Modify(true);
                end;
        end;
    end;

    trigger OnAfterModify()
    var
        lSalesHeader: Record "Sales Header";
    begin
        if lSalesHeader.get(rec."Document Type", rec."No.") Then begin
            if UserSetup.get(UserId) then
                If UserSetup."Site Code" <> '' then begin
                    lSalesHeader.validate("Shortcut Dimension 1 Code", UserSetup."Site Code");
                end;
        end;
    end;



    var
        UserSetup: record "User Setup";
}
