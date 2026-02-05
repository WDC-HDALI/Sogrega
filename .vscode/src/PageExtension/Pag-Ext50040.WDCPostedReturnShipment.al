pageextension 50040 "WDC Posted Return Shipment" extends "Posted Return Shipment"
{
    //*************Documentation***************************
    //WDC01  CHG 17/09/2024 Create the current object

    layout
    {
        moveAfter("Responsibility Center"; "Shortcut Dimension 1 Code")
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = all;
            ShowMandatory = true;
            Editable = false;
        }
    }
}