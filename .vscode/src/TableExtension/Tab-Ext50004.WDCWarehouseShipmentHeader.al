
tableextension 50004 "WDC Warehouse Shipment Header" extends "Warehouse Shipment Header"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object
    //WDC02  HG   29/08/2025 ADD "Customer No." field 

    fields
    {
        field(50000; "Gross Weight"; Decimal)
        {
            CaptionML = ENG = 'Gross Weight(Kg)', FRA = 'Poid brut(Kg)';
            DataClassification = ToBeClassified;
        }
        field(50001; "Net Weight"; Decimal)
        {
            CaptionML = ENG = 'Net Weight(Kg)', FRA = 'Poid net(Kg)';
            DataClassification = ToBeClassified;
        }
        field(50002; "Number of Packages"; Integer)
        {
            CaptionML = ENG = 'Number of Packages', FRA = 'Nombre des colis';
            DataClassification = ToBeClassified;
        }
        field(50003; "Packing Type"; Text[250])
        {
            CaptionML = ENU = 'Packing Type', FRA = 'Type de colisage';

        }
        //<<WDC02
        field(50004; "Customer No."; code[20])
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° Client';
        }
        //>>WDC02

    }

    trigger OnAfterModify()
    var
        lPurchHeader: Record "purchase Header";
    begin
    end;

}