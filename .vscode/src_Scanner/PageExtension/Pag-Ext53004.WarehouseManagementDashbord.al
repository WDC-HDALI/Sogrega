namespace sogrega.sogrega;

using Microsoft.Warehouse.RoleCenters;

pageextension 53004 WarehouseManagementDashbord extends "Whse. WMS Role Center"
{
    actions
    {
        addbefore("Whse. &Shipment")
        {
            action(ScanReception)
            {
                ApplicationArea = Warehouse;
                CaptionML = ENU = 'Goods Reception scan', FRA = 'Scan reception marchandises';
                Image = Receipt;
                RunObject = Page "WDC Reception scan";
            }
            action(ScanTransfert)
            {
                ApplicationArea = Warehouse;
                CaptionML = ENU = 'Scan Location Transfert', FRA = 'Scan transfert magasin';
                image = TransferFunds;
                RunObject = Page " WDC Scanneer Batch Selection";
            }
            action(ScanInventaire)
            {
                ApplicationArea = Warehouse;
                CaptionML = ENU = 'Scan Inventaire', FRA = 'Scan Inventory';
                image = InventoryCalculation;
                RunObject = Page "WDC Inventory Batch Selection";
            }
        }
    }
}
