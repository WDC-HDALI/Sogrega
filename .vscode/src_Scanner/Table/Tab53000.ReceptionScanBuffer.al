//***************Documentation**********************
//WDC01  WDC.HG  06/09/2025 Create current object : Scanner flux
table 53000 "Reception Scan Buffer"
{
    CaptionML = ENU = 'Reception Scan Buffer', FRA = 'Tampon Scan Réception';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {


        }
        field(2; "Document Type"; Enum "Reception Document Type")
        {

        }


        field(3; "Document No."; Code[20])
        {
        }

        field(4; "Line No."; Integer)
        {
        }
        field(5; "Site Code"; Code[10])
        {

        }
        field(6; "User ID"; Code[50])
        {

        }

        field(7; "Lot No."; Code[50])
        {

        }
        field(8; "Expiry Date"; Date)
        {

        }

        field(9; "Quantity to Receive"; Decimal)
        {

        }

        field(10; "No. of Labels"; Integer)
        {

        }

        field(11; "Created DateTime"; DateTime)
        {

        }

        field(12; "Last Modified"; DateTime)
        {

        }

        field(13; "Is Validated"; Boolean)
        {

        }
        field(14; "Posted Reception No."; code[20])
        {
            CaptionML = FRA = 'N° Reception', ENU = 'Receipt No.';
        }
        field(15; "Item No."; code[20])
        {
            CaptionML = FRA = 'N° article', ENU = 'Item No.';
        }
        field(16; "Qty Par"; decimal)
        {
            CaptionML = FRA = 'Qty par', ENU = 'Qty Per';
        }
        field(17; "Location Code"; code[20])
        {
            CaptionML = FRA = 'Code magasin', ENU = 'Location Code';
        }
        field(18; "Vendor Shipment No."; code[35])
        {
            CaptionML = FRA = 'N° B.L. fournisseur', ENU = 'Vendor Shipment No.';
        }
        field(19; "Variante Code"; code[10])
        {
            CaptionML = FRA = 'Code variante', ENU = 'Variant Code';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Last Modified" := CurrentDateTime();
        "Created DateTime" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Last Modified" := CurrentDateTime();
    end;

    procedure GetNextEntryNo(): Integer
    var
        ScanBuf: Record "Reception Scan Buffer";
    begin
        if ScanBuf.FindLast() then
            exit(ScanBuf."Entry No." + 1)
        else
            exit(1);
    end;


}
