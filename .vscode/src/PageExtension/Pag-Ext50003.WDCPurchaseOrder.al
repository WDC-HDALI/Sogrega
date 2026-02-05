pageextension 50003 "WDC Purchase Order" extends "Purchase Order"
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
        modify(Post)
        {
            Visible = false;
        }
    }

}
