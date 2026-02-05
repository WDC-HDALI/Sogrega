
tableextension 50005 "WDC Posted Whse. Shp Header" extends "Posted Whse. Shipment Header"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create the current object
    //WDC02  HG   29/08/2025 ADD "Customer No." field 

    fields
    {

        field(50000; "Gross Weight"; Decimal)
        {
            CaptionML = ENG = 'Gross Weight(Kg)', FRA = 'Poid brut(Kg)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Net Weight"; Decimal)
        {
            CaptionML = ENG = 'Net Weight(Kg)', FRA = 'Poid net(Kg)';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "Number of Packages"; Decimal)
        {
            CaptionML = ENG = 'Number of Packages', FRA = 'Nombre des colis';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Packing Type"; Text[250])
        {
            CaptionML = ENU = 'Packing Type', FRA = 'Type de colisage';
            Editable = false;
        }
        //<<WDC02
        field(50004; "Customer No."; code[20])
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° Client';
            Editable = false;
        }
        //>>WDC02

    }

}