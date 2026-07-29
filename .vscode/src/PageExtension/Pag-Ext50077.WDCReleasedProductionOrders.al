namespace sogrega.sogrega;

using Microsoft.Manufacturing.Document;
//*************Documentation***************
//WDC01  WDC.HG  22/04/26  Create Current Object 

pageextension 50077 "WDC Released Production Orders" extends "Released Production Orders"
{
    actions
    {
        addafter("&Update Unit Cost")
        {
            action(PrintQualityLabel)
            {
                Captionml = ENU = 'Print finished product label', FRA = 'Imprimer étiquette produit fini';
                Image = PrintInstallment;
                ApplicationArea = all;
                trigger OnAction()
                var
                    FinishedProductLabel: report "WDC Finished Product Label";
                    ProductionOrder: record "Production Order";

                begin
                    ProductionOrder.reset();
                    ProductionOrder.setrange(Status, rec.Status);
                    ProductionOrder.SetRange("No.", rec."No.");
                    if ProductionOrder.FindSet() then begin
                        FinishedProductLabel.SetTableView(ProductionOrder);
                        FinishedProductLabel.run();
                    end
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref(Qualitylabel; PrintQualityLabel)
            {

            }
        }
    }
}
