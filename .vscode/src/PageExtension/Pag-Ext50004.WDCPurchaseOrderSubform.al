pageextension 50004 "WDC Purchase Order Subform" extends "Purchase Order Subform"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object

    layout
    {
        // modify("Direct Unit Cost")
        // {
        //     Editable = rec.type <> rec.type::Item;

        // }
        // modify("Line Amount")
        // {
        //     Editable = rec.type <> rec.type::Item;
        // }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }


    }
}
