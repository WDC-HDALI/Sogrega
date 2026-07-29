namespace sogrega.sogrega;

using Microsoft.Inventory.Journal;

tableextension 53001 "WDC Item Journal Line " extends "Item Journal Line"
{
    fields
    {
        field(53000; "Applied Scan Entry No."; Integer)
        {
            CaptionML = ENU = 'Applied Scan Entry No.', FRA = 'N° séquence scan appliqué';
            DataClassification = ToBeClassified;
        }
        field(53001; "IsScanned"; Boolean)
        {
            CaptionML = ENU = 'IsScanned', FRA = 'Est scannée';
            DataClassification = ToBeClassified;
        }
        field(53002; "Is Inventory Inserted"; Boolean)
        {
            CaptionML = ENU = 'Inventory Inserted', FRA = 'Inventaire inséré';
            DataClassification = ToBeClassified;
        }
        field(53003; "Is Imported"; Boolean)
        {
            CaptionML = ENU = 'Inventory Imported', FRA = 'Inventaire Importé';
            DataClassification = ToBeClassified;
        }
        field(53004; "From Scan"; boolean)
        {
            CaptionML = ENU = 'From Scan', FRA = 'à partir de Scan';
            DataClassification = ToBeClassified;
        }
        field(53005; "Inventory correction"; Boolean)
        {
            CaptionML = ENU = 'Inventory Correction', FRA = 'Correction stock';
            DataClassification = ToBeClassified;
        }

    }
    trigger OnAfterDelete()
    var
        lLocationTransfertScan: record "Location Transfert Scan ";
    begin
        if rec."Journal Template Name" = 'TRANSFERT' then begin
            if (rec.IsScanned = true) and (rec."Applied Scan Entry No." <> 0) then
                if lLocationTransfertScan.get(rec."Applied Scan Entry No.") then
                    lLocationTransfertScan.Delete();
        end;
    end;
}
