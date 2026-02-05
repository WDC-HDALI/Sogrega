pageextension 50001 "WDC Sales Order List" extends "Sales Order List"
{
    //*************Documentation***************************
    //WDC01  CHG  22/08/2024  Create this current object
    //WDC02  HG   10/12/2024  add action "importer commande client"

    layout
    {

        addbefore("Location Code")
        {
            field("Shortcut Dimension 1 Code1"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = all;
                Editable = Rec.Status <> Rec.Status::Released;
            }
            field("Order Closed"; Rec."Order Closed")
            {
                ApplicationArea = all;
                Editable = Rec.Status <> Rec.Status::Released;
            }
        }
    }

    //<<WDC02

    actions
    {
        addlast(processing)
        {
            action(CloseOrder)
            {
                CaptionML = ENU = 'Close Order', FRA = 'Clôturer la commande';
                Image = Close;
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                var
                    lText01: TextConst ENU = 'Do you want to close the order?', FRA = 'Voulez-vous clôturer la commande?';
                begin
                    if Confirm(lText01) then begin
                        Rec."Order Closed" := true;
                        Rec.Modify;
                    end;
                end;
            }
        }

        addlast(processing)
        {
            group(import)
            {
                action(Importsanlorenzo)
                {

                    CaptionML = ENU = 'Import "Sanlorenzo" Order', FRA = 'Importer commande "Sanlorenzo" ';
                    Image = Import;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        Xmlport.Run(50002, false, true);

                    end;
                }

                action(Importcantiere)
                {

                    CaptionML = ENU = 'Import "Cantiere del pardo" Order', FRA = 'Importer commande "Cantiere del pardo"';
                    Image = Import;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        Xmlport.Run(50003, false, true);
                    end;
                }
                action(ImportNaylComposite)
                {

                    CaptionML = ENU = 'Import "Nayl Composite" Order', FRA = 'Importer commande "Nayl Composite" ';
                    Image = Import;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        Xmlport.Run(50004, false, true);

                    end;
                }
                action(ImportAzimutFano)
                {

                    CaptionML = ENU = 'Import "Azimut Fano" Order', FRA = 'Importer commande "Azimut Fano"';
                    Image = Import;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        Xmlport.Run(50005, false, true);
                    end;
                }
                action(ImportAzimutAvigliana)
                {

                    CaptionML = ENU = 'Import "Azimut Avigliana" Order', FRA = 'Importer commande "Azimut Avigliana" ';
                    Image = Import;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        Xmlport.Run(50006, false, true);
                    end;
                }
                action(ImportStandardTemplate)
                {

                    CaptionML = ENU = 'Import "Standard Template" Order', FRA = 'Importer commande "Modéle Standard" ';
                    Image = Import;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    begin
                        Xmlport.Run(50007, false, true);
                    end;
                }
            }
        }



        addafter(Category_Category7)
        {

            group(importorder)
            {
                CaptionML = ENU = 'Import Customers Orders', FRA = 'Importer commande clients';
                Image = Import;
                actionref("ImportsanlorenzoOrder"; "Importsanlorenzo")
                {
                }
                actionref(ImportcantiereOrder; Importcantiere)
                {
                }
                actionref("ImportNaylCompositeOrder"; "ImportNaylComposite")
                {
                }
                actionref("ImportAzimutFanoOrder"; "ImportAzimutFano")
                {
                }
                actionref("ImportAzimutAviglianaOrder"; "ImportAzimutAvigliana")
                {
                }
                actionref("ImportStandardTemplateOrder"; "ImportStandardTemplate")
                {
                }
            }

        }

        //>>WDC02
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Order Closed", false);
    end;
}
