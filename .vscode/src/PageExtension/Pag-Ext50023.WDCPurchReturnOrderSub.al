
pageextension 50023 "WDC Purch. Return Order Sub" extends "Purchase Return Order Subform"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    layout
    {
        modify("Direct Unit Cost")
        {
            Editable = rec.type <> rec.type::Item;

        }

        modify("Line Amount")
        {
            Editable = rec.type <> rec.type::Item;

        }
    }
}
