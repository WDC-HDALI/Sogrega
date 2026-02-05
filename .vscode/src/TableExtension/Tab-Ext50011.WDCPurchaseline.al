
tableextension 50011 "WDC Purchase line" extends "Purchase line"
{
    //*************Documentation***************************
    //WDC01  HD  29/08/2024  Create the current object
    //WDC02  HG  03/12/2024  Add condition for the Quantity field 
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if UserSetup.get(UserId) then begin
                    If UserSetup."Site Code" <> '' then
                        rec.Validate("Shortcut Dimension 1 Code", UserSetup."Site Code");
                end;
            end;
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                Err01: TextConst FRA = 'Location Code %1 doit commencer par une valeur similaire aux site code  %2- ', ENU = 'Location Code %1 must start with a value similar to the site code  %2-';
                lPurchHeader: record "Purchase Header";
            begin
                if lPurchHeader.get(rec."Document Type", rec."Document No.") then
                    if (rec."Location Code" <> '') AND (rec."Shortcut Dimension 1 Code" <> '') then
                        if (CopyStr(rec."Location Code", 1, 2) <> rec."Shortcut Dimension 1 Code") OR (CopyStr(rec."Location Code", 1, 2) <> lPurchHeader."Shortcut Dimension 1 Code") then
                            Error(Err01, rec."Location Code", lPurchHeader."Shortcut Dimension 1 Code");
            end;
        }
        modify("Shortcut Dimension 1 Code")
        {


            trigger OnAfterValidate()
            var
                Err01: TextConst FRA = 'site code %1 doit avoir une valeur similaire à %2 ', ENU = 'site code %1 must have a value similar to %2';
                lPurshHeader: record "Purchase Header";
            begin
                if lPurshHeader.get(rec."Document Type", rec."Document No.") then
                    if rec."Location Code" <> '' then
                        if (rec."Shortcut Dimension 1 Code" <> CopyStr(rec."Location Code", 1, 2)) OR (rec."Shortcut Dimension 1 Code" <> CopyStr(lPurshHeader."Location Code", 1, 2)) then
                            Error(Err01, rec."Shortcut Dimension 1 Code", CopyStr(rec."Location Code", 1, 2));
            end;
        }
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            begin
                if (rec."Direct Unit Cost" <> xRec."Direct Unit Cost") and (xRec."Direct Unit Cost" <> 0) then begin
                    UserSetup.get(UserId);
                    UserSetup.TestField("Update Purchase Price");
                end;

            end;
        }
        modify("Line Amount")
        {
            trigger OnAfterValidate()
            begin
                UserSetup.get(UserId);
                UserSetup.TestField("Update Purchase Price");

            end;
        }
        //<<WDC02
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                PurchasePrice: record 7012;
            begin
                if (rec."No." <> '') and (rec.Quantity <> 0) and (rec.Type = rec.type::Item) then begin
                    PurchasePrice.reset;
                    PurchasePrice.SetRange("Item No.", "No.");
                    PurchasePrice.setrange("Vendor No.", "Buy-from Vendor No.");
                    PurchasePrice.SetRange("Unit of Measure Code", "Unit of Measure Code");
                    if PurchasePrice.FindFirst() then begin
                        if (PurchasePrice."Minimum Purchase Quantity" <> 0) then
                            if Quantity < PurchasePrice."Minimum Purchase Quantity" then
                                error(text001, PurchasePrice."Minimum Purchase Quantity");
                    end;
                end;

            end;
        }
        //>>WDC02

    }

    var
        UserSetup: record "User Setup";
        text001: TextConst FRA = 'La quantité doit être supérieure à la quantité minimale d''achat %1 ', ENU = 'The quantity must be greater than the minimum purchase quantity %1 '; //WDC02
}