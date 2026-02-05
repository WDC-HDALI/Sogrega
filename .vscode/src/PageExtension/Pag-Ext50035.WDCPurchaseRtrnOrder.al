pageextension 50035 "WDC Purchase Rtrn Order" extends "Purchase Return Order"
{
    //*************Documentation***************************
    //WDC01  HD  29/08/2024  Create the current object

    layout
    {
        // addbefore(Status)
        // {
        //     field("ShortcutDimension1Code1"; Rec."Shortcut Dimension 1 Code")
        //     {
        //         ApplicationArea = all;
        //         ShowMandatory = true;
        //         Editable = Rec.Status <> Rec.Status::Released;
        //     }
        // }
    }
}