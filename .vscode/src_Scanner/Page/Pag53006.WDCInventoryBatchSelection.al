namespace sogrega.sogrega;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Location;

page 53006 "WDC Inventory Batch Selection"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    CaptionML = ENU = 'Inventory Scan', FRA = 'Scan Inventaire';
    RefreshOnActivate = false;
    UsageCategory = tasks;

    layout
    {
        area(content)
        {
            field("Inventory Location"; InventoryLocation)
            {
                Captionml = ENU = 'Location Code', FRA = 'Code Magasin';
                TableRelation = Location;
                ApplicationArea = All;
                trigger OnValidate()
                var
                    lLocation: record Location;
                begin
                    if lLocation.get(InventoryLocation) then
                        if lLocation."Inventory Batch Name" <> '' then
                            InventoryBatchName := lLocation."Inventory Batch Name";

                end;
            }
            field("Journal Batch Name"; InventoryBatchName)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Inventory Batch Name', FRA = 'Nom Feuille d''inventaire';
                TableRelation = "Item Journal Batch".name where("Journal Template Name" = filter('INVENTAIRE'), "Scanner Inventory sheet" = const(true));
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        lErr01: TextConst ENU = 'You must specify the name of the Inventory sheet',
                          FRA = 'Vous devez préciser le nom de la feuille d''inventaire';
        lErr02: TextConst ENU = 'You must specify the Location code',
                          FRA = 'Veuillez saisir le code magasin';
        lScanInventoryLines: page "WDC Scan inventory Lines";

    begin
        if CloseAction <> Action::OK then
            exit(true);
        if inventoryBatchName = '' then
            error(lErr01);
        if InventoryLocation = '' then
            error(lerr02);
        lScanInventoryLines.SetInventoryBatchNameAndLocationcode(inventoryBatchName, inventoryLocation);
        lScanInventoryLines.RunModal();
        exit(true);

    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        InventoryBatchName := '';
        InventoryLocation := '';

    end;

    var
        InventoryBatchName: Code[10];
        InventoryLocation: Code[10];
}
