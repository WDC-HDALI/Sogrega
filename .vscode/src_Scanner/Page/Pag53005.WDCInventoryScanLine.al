namespace sogrega.sogrega;

page 53005 "WDC Inventory Scan Line"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Scanned Inventory Lines', FRA = 'Lignes Inventaire Scannées';
    PageType = List;
    SourceTable = "Inventory Scan Buffer";
    UsageCategory = Lists;
    //Editable = false;

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
                    CaptionML = ENU = 'Document No.', FRA = 'N° document';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = ENU = 'Item No.', FRA = 'N° article';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = ENU = 'Description', FRA = 'Description';
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = ENU = 'Variant Code', FRA = 'Code Variante';
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = ENU = 'Expiry Date', FRA = 'Date d''expiration';
                }
                field("Journal Line No."; Rec."Journal Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = ENU = 'Qty (Calculated)', FRA = 'Qté (calculée)';
                }
                field("Scanned Inventory"; Rec."Scanned Inventory")
                {
                    ApplicationArea = all;
                    Editable = false;

                    CaptionML = ENU = 'Qty (Scanned)', FRA = 'Qté (scannée)';
                }
                field("Qty Diff."; Rec."Qty Diff.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = ENU = 'Qty Diff.', FRA = 'Qty Diff.';
                }
                field(" is Scanned "; Rec."is Scanned ")
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = ENU = 'Scanned', FRA = 'scannée';
                }
                field(InsertedFromScan; Rec.InsertedFromScan)
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = ENU = 'New Item Inserted By Scan', FRA = 'Nouv Article Inserée par scan';
                }
                field("Inventory Date"; Rec."Inventory Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = ENU = 'Inventory Date', FRA = 'Date inventaire';
                }
                field(ScanDate; Rec.ScanDate)
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = ENU = 'Scan Date', FRA = 'Date Scan';
                }
                field("Is Imported"; Rec."Is Imported")
                {
                    ApplicationArea = all;
                    CaptionML = ENU = '  Item Imported', FRA = 'Article importé';
                    editable = true;
                }



            }
        }
    }

}
