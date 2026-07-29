table 53002 "Inventory Scan Buffer"
{
    Caption = 'InventoryScanBuffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            CaptionML = ENU = 'Entry No', FRA = 'N° séquence';
        }
        field(2; "Journal Template Name"; Code[10])
        {

        }
        field(3; "Journal Batch Name"; code[10])
        {

        }
        field(4; "Document NO."; code[20])
        {

        }
        field(5; "Item No."; code[20])
        {

        }
        field(6; "Lot No."; code[20])
        {

        }
        field(7; "Location Code"; code[10])
        {

        }
        field(8; Inventory; decimal)
        {

        }
        field(9; "Scanned Inventory"; decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Qty Diff." := "Scanned Inventory" - Inventory;

            end;

        }
        field(10; "Qty Diff."; Decimal)
        {

        }
        field(11; "is Scanned "; Boolean)
        {

        }

        field(12; "USERID "; code[20])
        {

        }

        field(13; "Inventory Date"; Date)
        {

        }
        field(14; ScanDate; Datetime)
        {

        }
        field(15; "Journal Line No."; Integer)
        {

        }
        field(16; "InsertedFromScan"; Boolean)
        {

        }
        field(17; "Is Imported"; Boolean)
        {

        }
        field(18; "Variant Item"; Boolean)
        {

        }
        field(19; Description; text[100])
        {

        }
        field(20; "Expiry Date"; date)
        {

        }
        field(21; "Variant Code"; code[10])
        {

        }

    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(key2; "Journal Template Name", "Journal Batch Name", "Location Code", "Document No.", "Item No.", "Lot No.", "Is Imported")
        {

        }
    }
    trigger OnInsert()
    begin
        ScanDate := CurrentDateTime();
    end;

    trigger OnModify()
    begin
        ScanDate := CurrentDateTime();
    end;

    procedure GetNextEntryNo(): Integer
    var
        lScannBuffer: Record "Inventory Scan Buffer";
    begin
        lScannBuffer.Reset();
        if lScannBuffer.FindLast() then
            exit(lScannBuffer."Entry No." + 1)
        else
            exit(1);
    end;
}
