table 53001 "Location Transfert Scan "
{
    CaptionML = ENU = 'Location Transfert Scan ', FRA = 'Scan transfert magasin';
    DataClassification = ToBeClassified;
    fields
    {


        field(1; "Entry No."; Integer)
        {
            CaptionML = ENU = 'Entry No', FRA = 'N° séquence';
        }

        field(2; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        field(3; "User ID"; code[50])
        {
            CaptionML = ENU = 'User ID', FRA = 'ID utilisateur';
        }

        field(4; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        field(5; "Lot No."; Code[50])
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
        }
        field(6; "Expiry Date"; Date)
        {
            CaptionML = ENU = 'Expiry Date', FRA = 'Date d''expiration';
        }

        field(7; Quantity; Decimal)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }

        field(8; "From Location"; Code[10])
        {
            CaptionML = ENU = 'Source Location', FRA = 'Magasin source';
        }

        field(9; "To Location"; Code[10])
        {
            CaptionML = ENU = 'Destination Location', FRA = 'Magasin destination';
        }

        field(10; "Scan Datetime"; DateTime)
        {
            CaptionML = ENU = 'Scan Datetime', FRA = 'Scan Datetime';
        }

        field(11; "Inserted to Journal"; Boolean)
        {
            CaptionML = ENU = 'Inserted To Journal', FRA = 'Inséré dans Feuille';
            Editable = false;
        }
        field(12; "IsValidated"; Boolean)
        {
            CaptionML = ENU = 'IsValidated', FRA = 'Validée';
            Editable = false;
        }
        field(13; "Last Modified"; DateTime)
        {
            CaptionML = ENU = 'Last Modified', FRA = 'Dernière modification';
        }
        field(14; "work Center Code"; code[20])
        {
            CaptionML = ENU = 'Work Center Code', FRA = 'Centre de coût Code';
        }
        field(15; "Variant Code"; code[10])
        {

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
    end;

    trigger OnModify()
    begin
        "Last Modified" := CurrentDateTime();
    end;

    procedure GetNextEntryNo(): Integer
    var
        lScannBuffer: Record "Location Transfert Scan ";
    begin
        lScannBuffer.Reset();
        if lScannBuffer.FindLast() then
            exit(lScannBuffer."Entry No." + 1)
        else
            exit(1);
    end;
}
