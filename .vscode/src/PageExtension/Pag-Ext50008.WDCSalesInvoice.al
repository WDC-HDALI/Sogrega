pageextension 50008 "WDC Sales Invoice" extends "Sales Invoice"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object
    //WDC02  IM  25/03/2025  Create Action GetShipmentLines2

    layout
    {
        movebefore(Status; "Shortcut Dimension 1 Code")
        modify("Shortcut Dimension 1 Code")
        {

            Editable = Rec.Status <> Rec.Status::Released;
            ShowMandatory = true;
        }
    }
    //<<WDC01
    actions
    {
        addafter("Move Negative Lines")
        {
            action(GetShipmentLines2)
            {
                AccessByPermission = TableData "Sales Shipment Header" = R;
                ApplicationArea = All;
                CaptionML = ENU = 'Get &Shipment to Invoiced', FRA = 'Extraire expédition à facturer';
                Ellipsis = true;
                Image = Shipment;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Promoted = true;
                Visible = false;
                trigger OnAction()
                var
                    lGetShipments: Page "WDC Get Shipment Header";
                begin
                    Rec.TestField("Document Type", Rec."Document Type"::Invoice);
                    Rec.TestField(Status, Rec.Status::Open);

                    lGetShipments.SetSalesHerder(Rec);
                    lGetShipments.LookupMode := true;
                    if lGetShipments.RunModal() <> ACTION::Cancel then;

                end;
            }
        }
    }
    //>>WDC01
}