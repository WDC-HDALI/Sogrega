
tableextension 50013 "WDC Item" extends Item
{
    //*************Documentation***************************
    //WDC01  HD  07/10/2024  Create the current object
    //WDC02  HG  13/12/2024  add fields 
    //WDC03  WDC.IM  27/12/2024 Add Field "Reference No."
    //WDC04  WDC.HG  18/03/2026 Add field Tolerance Poid Difference 

    fields
    {
        field(50000; "Production Moule Date"; Date)
        {
            CaptionML = ENG = 'Production Moule Date', FRA = 'Date fabrication Moule';
            DataClassification = ToBeClassified;
        }
        field(50001; "Technical Description"; Text[512])
        {
            CaptionML = ENG = 'Technical Description', FRA = 'Description technique';
            DataClassification = ToBeClassified;
        }
        //<<WDC02
        field(50002; "Inventory-BA"; decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = filter('BA*'),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter")));
            Captionml = ENU = 'Inventory-BA', FRA = 'Stock-BA';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Inventory-MJ"; decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                  "Location Code" = filter('MJ*'),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Lot No." = field("Lot No. Filter"),
                                                                  "Serial No." = field("Serial No. Filter")));
            Captionml = ENU = 'Inventory-MJ', FRA = 'Stock-MJ';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        //>>WDC03
        field(50004; "Reference No."; Code[50])
        {
            CaptionML = ENU = 'Refrence No.', FRA = 'N° référence';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Reference"."Reference No." where("Item No." = field("No."), "Reference Type" = filter("Item Reference Type"::Customer)));
        }
        //>>WDC03
        //<<WDC04
        field(50005; "Positive Weight Tolerance %"; Decimal)
        {
            Captionml = ENU = 'Positive Weight Tolerance %', FRA = 'Tolérance positive poids %';
            DataClassification = ToBeClassified;
        }

        field(50006; "Negative Weight Tolerance %"; Decimal)
        {
            Captionml = ENU = 'Negative Weight Tolerance %', FRA = 'Tolérance négative poids %';
            DataClassification = ToBeClassified;
        }
        //>>WDC04
    }
}