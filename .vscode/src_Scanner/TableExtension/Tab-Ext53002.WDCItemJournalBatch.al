namespace sogrega.sogrega;

using Microsoft.Inventory.Journal;

tableextension 53002 "WDC Item Journal Batch" extends "Item Journal Batch"
{
    fields
    {
        field(53000; "Scanner Sheet"; Boolean)
        {
            CaptionML = ENU = 'Scanner Transfer Sheet', FRA = 'Feuille scanner transfert';
            DataClassification = ToBeClassified;
        }
        field(53001; "Scanner Inventory sheet"; Boolean)
        {
            CaptionML = ENU = 'Scanner Inventory Sheet', FRA = 'Feuille scanner inventaire';
            DataClassification = ToBeClassified;
        }
    }
}
