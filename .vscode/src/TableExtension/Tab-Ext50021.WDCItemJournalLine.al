namespace SogregaDev.SogregaDev;

using Microsoft.Warehouse.Request;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Inventory.Journal;
using Microsoft.Sales.Customer;
//***************Documentation***********************
//WDC01  WDC.HG 08/09/2025  Add "reference No" for PF Journal
//WDC02  WDC.HG 18/03/2026  Add tolerance weight Variation 
//WDC03  WDC.HG 07/04/2026  Add controle of OrderNo Occurence
//WDC04  WDC.HG 18/06/2026  Add Import Weight Indicator
tableextension 50021 "WDC Item Journal Line" extends "Item Journal Line"

{
    fields
    {
        field(50000; "Net Weight"; Decimal)
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
            DataClassification = ToBeClassified;
            //<<WDC02
            trigger OnValidate()
            var
                lItem: Record Item;
                lproductionorder: record "Production Order";
                lMaxWeight: Decimal;
                lMinWeight: Decimal;
                text01: TextConst ENU = 'The weight variation exceeds the permitted positive tolerance %1 %. Do you want to correct it?',
                                  FRA = 'La variation de poids dépasse la tolérance positive autorisée %1 %. Voulez-vous la corriger ?';
                text02: TextConst ENU = 'The weight variation is less than the permitted negative tolerance %1 %. Do you want to correct it?',
                                 FRA = 'La variation de  poids est inférieur à la tolérance négative autorisée %1 %. Voulez-vous la corriger ?';
                err01: TextConst ENU = 'Please correct the weight.', FRA = 'Veuillez corriger le poids.';

            begin
                if rec."Entry Type" = rec."Entry Type"::Output then begin
                    lproductionorder.reset();
                    if lproductionorder.get(lproductionorder.Status::Released, rec."Order No.") then begin
                        if lItem.Get(lproductionorder."Source No.") then begin
                            if lItem."Net Weight" <> 0 then begin
                                lMaxWeight := lItem."Net Weight" * (1 + (lItem."Positive Weight Tolerance %" / 100));
                                lMinWeight := lItem."Net Weight" * (1 - (lItem."Negative Weight Tolerance %" / 100));
                                if rec."Net Weight" > lMaxWeight then
                                    if Confirm(text01, true, lItem."Positive Weight Tolerance %") then
                                        Error(err01);
                                if rec."Net Weight" < lMinWeight then
                                    if not confirm(text02, true, lItem."Negative Weight Tolerance %") then
                                        error(err01);
                            end;
                        end;
                    end;
                end;
            end;
            //>>WDC02
        }
        field(50001; "Qty Checked"; Boolean)
        {
            CaptionML = ENU = 'Qty Checked', FRA = 'Quantité Vérifiée';
            DataClassification = ToBeClassified;
        }
        modify("Qty. (Phys. Inventory)")
        {
            trigger OnAfterValidate()
            begin

                If Rec."Qty. (Phys. Inventory)" <> Rec."Qty. (Calculated)" then
                    Rec."Qty Checked" := true;
            end;
        }
        field(50002; "Reference No."; Code[50])
        {
            CaptionML = ENU = 'Refrence No.', FRA = 'N° référence';
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                lItemReference: record "Item Reference";
            begin

                if "Inventory Posting Group" = 'PF' then begin
                    lItemReference.reset();
                    lItemReference.SetRange("Item No.", "Item No.");
                    lItemReference.setrange("Reference Type", "Item Reference Type"::Customer);
                    if lItemReference.FindSet() then
                        "Reference No." := lItemReference."Reference No.";
                end

            end;
        }
        //<<WDC03
        modify("Order No.")
        {
            trigger OnAfterValidate()
            var
                ItemJournalLine: record "Item Journal Line";
                ProdOrderHeader: record "Production Order";
                ProdOrderLine: record "Prod. Order Line";
                err01: TextConst FRA = 'Cet of est déjà totalement déclaré.', ENU = 'This Production Order is already finished';
                err02: TextConst FRA = 'Cet of est déjà présent dans le journal. Impossible de l''insérer une deuxième fois.', ENU = 'This Production Order is already present in the journal. It cannot be inserted a second time.';

            begin
                if rec."Entry Type" = rec."Entry Type"::Output then begin
                    if ProdOrderHeader.get(ProdOrderHeader.Status::Released, rec."Order No.") then begin
                        ProdOrderLine.reset();
                        ProdOrderLine.SetRange(Status, ProdOrderHeader.Status);
                        ProdOrderLine.SetRange("Prod. Order No.", ProdOrderHeader."No.");
                        ProdOrderLine.SetRange("Item No.", ProdOrderHeader."Source No.");
                        if ProdOrderLine.FindFirst() then
                            if ProdOrderLine.Quantity = ProdOrderLine."Finished Quantity" then
                                error(err01);
                    end;
                    ItemJournalLine.Reset();
                    ItemJournalLine.SetRange("Journal Template Name", rec."Journal Template Name");
                    ItemJournalLine.SetRange("Journal Batch Name", rec."Journal Batch Name");
                    ItemJournalLine.SetRange("Entry Type", rec."Entry Type");
                    ItemJournalLine.SetRange("Order No.", rec."Order No.");
                    if ItemJournalLine.FindSet() then
                        error(err02);
                end;
            end;
        }
        //>>WDC03
        //<<WDC01
        //<<WDC04
        field(50003; "Weight Imported From Scale"; Boolean)
        {
            CaptionML = ENU = 'Weight Imported From Scale', FRA = 'Poids importé de la balance';
            DataClassification = ToBeClassified;
        }
        //>>WDC04
    }
}
