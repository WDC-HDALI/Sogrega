//*************Documentation*****************************
//WDC01     WDC.HG    18/12/2025        Show field "External Sales Order No."
page 50008 "WDC Released Prod. Order Lines"
{
    AutoSplitKey = true;
    CaptionML = ENU = 'Released Prod. Order Lines', FRA = 'Lignes O.F lancées';
    ApplicationArea = All;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Prod. Order Line";
    Editable = false;
    SourceTableView = where(Status = const(Released));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                ShowCaption = false;
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the number of the production order.';
                    ShowMandatory = true;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the number of the item that is to be produced.';

                    trigger OnValidate()
                    var
                        Item: Record "Item";
                    begin
                        if Rec."Variant Code" = '' then
                            VariantCodeMandatory := Item.IsVariantMandatory(true, Rec."Item No.");
                    end;
                }



                field(Description; Rec.Description)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the value of the Description field on the item card. If you enter a variant code, the variant description is copied to this field instead.';
                }


                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the location code, if the produced items should be stored in a specific location.';
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the quantity to be produced if you manually fill in this line.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = Reservation;
                    ToolTip = 'Specifies how many units of this item have been reserved.';
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies how each unit of the item is measured, such as in pieces or tons. By default, the value in the Base Unit of Measure field on the item card is inserted. It will be changed if you switch Product BOM or Production BOM Version.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Finished Quantity"; Rec."Finished Quantity")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies how much of the quantity on this line has been produced.';
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the difference between the finished and planned quantities, or zero if the finished quantity is greater than the remaining quantity.';
                }

                field("Starting Date-Time"; Rec."Starting Date-Time")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the starting date and the starting time, which are combined in a format called "starting date-time".';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Starting Time"; StartingTime)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the entry''s starting time, which is retrieved from the production order routing.';
                    Visible = DateAndTimeFieldVisible;

                    trigger OnValidate()
                    begin
                        Rec.Validate("Starting Time", StartingTime);
                        CurrPage.Update(true);
                    end;
                }
                field("Starting Date"; StartingDate)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the entry''s starting date, which is retrieved from the production order routing.';
                    Visible = DateAndTimeFieldVisible;

                    trigger OnValidate()
                    begin
                        Rec.Validate("Starting Date", StartingDate);
                        CurrPage.Update(true);
                    end;
                }
                field("Ending Date-Time"; Rec."Ending Date-Time")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the ending date and the ending time, which are combined in a format called "ending date-time".';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Ending Time"; EndingTime)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the entry''s ending time, which is retrieved from the production order routing.';
                    Visible = DateAndTimeFieldVisible;

                    trigger OnValidate()
                    begin
                        Rec.Validate("Ending Time", EndingTime);
                        CurrPage.Update(true);
                    end;
                }
                field("Ending Date"; EndingDate)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the entry''s ending date, which is retrieved from the production order routing.';
                    Visible = DateAndTimeFieldVisible;

                    trigger OnValidate()
                    begin
                        Rec.Validate("Ending Date", EndingDate);
                        CurrPage.Update(true);
                    end;
                }
                field("Scrap %"; Rec."Scrap %")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the percentage of the item that you expect to be scrapped in the production process.';
                    Visible = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the total cost on the line by multiplying the unit cost by the quantity.';
                }
                //<<WDC01
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = all;
                }
                field("External Sales Order No."; Rec."External Sales Order No.")
                {
                    ApplicationArea = all;
                }
                //>>WDC01
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                                  "Dimension Value Type" = const(Standard),
                                                                  Blocked = const(false));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        Item: Record Item;
        lProdOrder: record "Production Order";
    begin
        DescriptionIndent := 0;
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        DescriptionOnFormat();
        if Rec."Variant Code" = '' then
            VariantCodeMandatory := Item.IsVariantMandatory(true, Rec."Item No.");
        //<<WDC01
        if (rec."External Sales Order No." = '') or (rec."Sales Order No." = '') then begin
            if lProdOrder.get(rec.Status, rec."Prod. Order No.") then begin
                lProdOrder.CalcFields("External Sales Order No.");
                rec."Sales Order No." := lProdOrder."Sales Order No.";
                rec."External Sales Order No." := lProdOrder."External Sales Order No.";
                rec.modify();
                CurrPage.update(false);
            end;
        end;
        //<<WDC01
    end;



    trigger OnInit()
    begin
        DateAndTimeFieldVisible := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    begin
        DateAndTimeFieldVisible := false;
    end;

    var
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        DescriptionIndent: Integer;
        StartingTime: Time;
        EndingTime: Time;
        StartingDate: Date;
        EndingDate: Date;
        DateAndTimeFieldVisible: Boolean;
        VariantCodeMandatory: Boolean;

    protected var
        ShortcutDimCode: array[8] of Code[20];



    local procedure DescriptionOnFormat()
    begin
        DescriptionIndent := Rec."Planning Level Code";
    end;


}

