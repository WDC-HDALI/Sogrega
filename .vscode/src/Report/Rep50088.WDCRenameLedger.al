
namespace CRC.CRC;
using Microsoft.Purchases.History;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.VAT.Ledger;
using Microsoft.Purchases.Vendor;
using Microsoft.Purchases.Payables;
report 50088 "WDC Correct Purch Entries"
/**********************************Documentation*********************
WDC01     WDC.FS   12/01/2026        Creation of "Correct Vendor Infos" 
*********************************************************************/
{
    CaptionML = ENU = 'Correct Posted Purchase Entries',
                FRA = 'Corriger écritures achat enregistrées';
    ProcessingOnly = true;
    UsageCategory = Administration;
    ApplicationArea = All;
    Permissions =
        tabledata "Purch. Inv. Header" = RIM,
        tabledata "G/L Entry" = RIM,
        tabledata "VAT Entry" = RIM,
        tabledata "Vendor Ledger Entry" = RIM,
        tabledata "Detailed Vendor Ledg. Entry" = RIM;
    dataset
    {
        dataitem(PurchInvHeader; "Purch. Inv. Header")
        {
            DataItemTableView = sorting("No.");

            trigger OnPreDataItem()
            var
                lText001: TextConst ENU = 'Please enter a valid Document No.',
                                    FRA = 'veuillez sasir un numéro de document valide.';
            begin

                if DocumentNoFilter <> '' then
                    PurchInvHeader.SetRange("No.", DocumentNoFilter)
                else
                    Error(lText001);
            end;

            trigger OnAfterGetRecord()
            var
                GLEntry: Record "G/L Entry";
                VATEntry: Record "VAT Entry";
                VendLedgEntry: Record "Vendor Ledger Entry";
                DetVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
            begin
                PurchInvHeader.Validate("Pay-to Vendor No.", NewVendorNo);
                PurchInvHeader.Validate("Pay-to Name", NewPayToName);
                PurchInvHeader.Validate("Pay-to address", Vendor.Address);
                PurchInvHeader.Validate("Pay-to city", Vendor."City");
                PurchInvHeader.Modify();

                GLEntry.RESET;
                GLEntry.SetRange("Document No.", PurchInvHeader."No.");
                if GLEntry.FindSet() then
                    repeat
                        GLEntry.Validate("Source No.", NewVendorNo);
                        GLEntry.Modify(true);
                    until GLEntry.Next() = 0;

                VATEntry.RESET;
                VATEntry.SetRange("Document No.", PurchInvHeader."No.");
                if VATEntry.FindSet() then
                    repeat
                        VATEntry.Validate("Bill-to/Pay-to No.", NewVendorNo);
                        VATEntry.Modify(true);
                    until VATEntry.Next() = 0;

                VendLedgEntry.RESET;
                VendLedgEntry.SetRange("Document No.", PurchInvHeader."No.");
                if VendLedgEntry.FindSet() then
                    repeat
                        VendLedgEntry.Validate("Vendor No.", NewVendorNo);
                        VendLedgEntry.Validate("Vendor Name", NewPayToName);
                        VendLedgEntry.Modify(true);
                    until VendLedgEntry.Next() = 0;

                DetVendLedgEntry.RESET;
                DetVendLedgEntry.SetRange("Document No.", PurchInvHeader."No.");
                if DetVendLedgEntry.FindSet() then
                    repeat
                        DetVendLedgEntry.Validate("Vendor No.", NewVendorNo);
                        DetVendLedgEntry.Modify(true);
                    until DetVendLedgEntry.Next() = 0;
            end;

            trigger OnPostDataItem()
            begin
                Message(Text001);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Parameters)
                {
                    Caption = 'Correction Parameters';
                    field(DocumentNoFilter; DocumentNoFilter)
                    {
                        CaptionML = ENU = 'Document No. Filter', FRA = 'Filtre no. facture';
                        ApplicationArea = All;
                        TableRelation = "Purch. Inv. Header"."No.";
                    }
                    field(NewVendorNo; NewVendorNo)
                    {
                        CaptionML = ENU = 'New Vendor No.', FRA = 'Nouveau N° fournisseur';
                        ApplicationArea = All;
                        TableRelation = Vendor."No.";
                        trigger OnValidate()
                        var

                        begin
                            if Vendor.Get(NewVendorNo) then
                                NewPayToName := Vendor.Name;
                        end;
                    }
                    field(NewPayToName; NewPayToName)
                    {
                        CaptionML = ENU = 'New Pay-to Name ', FRA = 'Nouveau nom de paiement';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    var
        Vendor: Record Vendor;
        DocumentNoFilter: Code[20];
        NewVendorNo: Code[20];
        NewPayToName: Text[100];
        Text001: TextConst ENU = 'Script correction successfully completed.',
                           FRA = 'Correction des écritures terminée avec succès.';
}
