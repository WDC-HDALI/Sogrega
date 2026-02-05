namespace SogregaDev.SogregaDev;
using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Setup;
using Microsoft.Inventory.Posting;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Journal;
using Microsoft.Sales.Document;
//WDC02   WDC.HG  25/12/2024         show "site code" field in prod order component list
//WDC03   WDC.HG     08/09/2025      Take Line No from sales line
//WDC04   WDC.HG     18/12/2025  Add New field "External Sales Order No."

codeunit 50003 WDCPlanif_ProdSubscribers
{
    //****************************************************Planification************************************************************///
    [EventSubscriber(ObjectType::Page, Page::"Sales Order Planning", OnCreateProdOrderOnAfterGetParameters, '', false, false)]
    local procedure OnBeforeCreateOrder(var SalesPlanningLine: Record "Sales Planning Line"; var NewStatus: Enum "Production Order Status"; var NewOrderType: Enum "Create Production Order Type")
    var

    begin
        SalesPlanningLine.SetRange("Selected Line", true);

    end;
    //<<HD 17032025
    [EventSubscriber(ObjectType::Page, Page::"Sales Order Planning", OnAfterCreateProdOrder, '', false, false)]
    local procedure OnAfterCreateProdOrder(var SalesPlanningLine: Record "Sales Planning Line")
    var
    begin
        SalesPlanningLine."Selected Line" := false;
    end;
    //>>HD 17032025
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order from Sale", OnAfterCreateProdOrderFromSalesLine, '', false, false)]
    local procedure OnAfterCreateProdOrderFromSalesLine(var ProdOrder: Record "Production Order"; var SalesLine: Record "Sales Line")
    var
        SalesHeader: record "Sales Header";
    begin
        ProdOrder.validate("Shortcut Dimension 1 Code", SalesLine."Shortcut Dimension 1 Code");
        ProdOrder."Sales Order No." := SalesLine."Document No.";
        ProdOrder."Sales Line No." := SalesLine."Line No.";//WDC03
        //<<WDC04
        // if SalesHeader.get(SalesHeader."Document Type"::Order, SalesLine."Document No.") then
        //     ProdOrder."External Sales Order No." := SalesHeader."External Document No.";
        //>>WDC04

    end;
    //<<WDC04
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order from Sale", OnCreateProductionOrderOnAfterProdOrderLineModify, '', false, false)]
    // local procedure OnCreateProductionOrderOnAfterProdOrderLineModify(var ProdOrderLine: Record "Prod. Order Line"; var SalesLine: Record "Sales Line")
    // var
    //     SalesHeader: record "Sales Header";
    // begin
    //     if SalesHeader.get(SalesHeader."Document Type"::Order, SalesLine."Document No.") then begin
    //         ProdOrderLine."External Sales Order No." := SalesHeader."External Document No.";
    //         ProdOrderLine.Modify();
    //     end

    // end;
    //>>WDC04

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", OnAfterTransferBOMComponent, '', false, false)]
    local procedure OnAfterTransferBOMComponent(var ProdOrderComponent: Record "Prod. Order Component"; var ProdOrderLine: Record "Prod. Order Line")
    var
        ManufSetup: Record "Manufacturing Setup";
        p99000823: Page 99000823;
    begin
        ManufSetup.get;
        if ProdOrderLine."Shortcut Dimension 1 Code" = 'MJ' then
            ProdOrderComponent.Validate("Location Code", ManufSetup."MJ Consuption Location")
        else
            ProdOrderComponent.Validate("Location Code", ManufSetup."BA Consuption Location");
        ProdOrderComponent."Shortcut Dimension 1 Code" := ProdOrderLine."Shortcut Dimension 1 Code"; //WDC02
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post", OnBeforeCode, '', false, false)]
    // local procedure OnBeforeCode(var ItemJournalLine: Record "Item Journal Line"; var HideDialog: Boolean; var SuppressCommit: Boolean; var IsHandled: Boolean)
    // begin
    //     if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Output then begin

    //     end;
    // end;


}
