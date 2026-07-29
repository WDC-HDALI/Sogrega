namespace sogrega.sogrega;

page 53003 "WDC LocationTransfertScanLine"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Scanned Location Transfer Lines', FRA = 'Lignes transfert magasin scannées';
    PageType = List;
    SourceTable = "Location Transfert Scan ";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("From Location"; Rec."From Location")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("To Location"; Rec."To Location")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(" work Center Code"; Rec."work Center Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Scan Datetime"; Rec."Scan Datetime")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Inserted to Journal"; Rec."Inserted to Journal")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(IsValidated; Rec.IsValidated)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }
}
