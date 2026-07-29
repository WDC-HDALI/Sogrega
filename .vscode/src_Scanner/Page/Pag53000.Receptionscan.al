namespace sogrega.sogrega;
using Microsoft.Purchases.Document;
using Microsoft.Integration.Entity;
//***************Documentation**********************
//WDC01  WDC.HG  06/09/2025 Create current object : Scanner flux
page 53000 "WDC Reception scan"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Goods Reception scan', FRA = 'Scan reception marchandises';
    PageType = NavigatePage;
    UsageCategory = Tasks;


    layout
    {
        area(Content)
        {
            group(" ")
            {
                //CaptionML = ENU = 'Reception scan', FRA = 'Scan reception';
                field(PurchaseOrderNo; PurchaseOrderNo)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Purchase Order No.', FRA = 'N° Commande achat';
                    trigger OnValidate()
                    var
                        ReceptionScanManagement: Codeunit "WDC Scanner Management";
                    begin
                        ReceptionScanManagement.CheckPurchaseOrderStatuts(PurchaseOrderNo);
                    end;
                }
                field(VendorBL; VendorBL)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Vendor Shipment No.', FRA = 'N° B.L. fournisseur';
                }
                field(LineNo; LineNo)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Line No.', FRA = 'N° ligne';

                    trigger OnValidate()
                    var
                        lReceptionScanManagement: Codeunit "WDC Scanner Management";
                        lPurchaseLine: record "Purchase Line";
                    begin
                        //lReceptionScanManagement.CheckConflictReception(PurchaseOrderNo, LineNo);
                        lReceptionScanManagement.CheckItemReceptionValidation(PurchaseOrderNo, LineNo);
                        if lPurchaseLine.get(lPurchaseLine."Document Type"::Order, PurchaseOrderNo, LineNo) then begin
                            ItemNo := lPurchaseLine."No.";
                            ShowVaraintCode := lReceptionScanManagement.IsVariantItem(lPurchaseLine."No.");
                            VariantCode := lPurchaseLine."Variant Code";
                            ShowLotNo := lReceptionScanManagement.IsItemLotTracked(lPurchaseLine."No.");
                            QtyTotalToRecieve := lPurchaseLine."Outstanding Quantity";
                        end;
                        CurrPage.Update();
                    end;
                }
                field(ItemNo; ItemNo)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Item No.', FRA = 'N° article';
                    Editable = false;
                }
                group(variant)
                {
                    Visible = ShowVaraintCode;
                    ShowCaption = false;
                    Editable = false;
                    field(VariantCode; VariantCode)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Variant Code', FRA = 'Code Variante';
                    }
                }

                group(Lot)
                {
                    Visible = ShowLotNo;
                    ShowCaption = false;

                    field(LotNo; LotNo)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Lot No.', FRA = 'N° lot';

                    }
                    field(ExpiryDateText; ExpiryDateTxt)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Expiry Date', FRA = 'Date d''Expiration';
                        trigger OnValidate()
                        var
                            lDate: Date;
                        begin
                            if not Evaluate(lDate, ExpiryDateTxt) then
                                Error('Invalid date format');

                            ExpiryDate := lDate;
                        end;
                    }
                }
                field(QtyTotalToRecieve; QtyTotalToRecieve)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Quantity To Receive', FRA = 'Quantité à recevoir';
                    trigger OnValidate()
                    var
                        lReceptionScanManagement: Codeunit "WDC Scanner Management";
                    begin
                        lReceptionScanManagement.checkQuantityToReceive(PurchaseOrderNo, LineNo, QtyTotalToRecieve);
                    end;
                }
                field(QtyPar; QtyPar)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Qty Par', FRA = 'Qty Per';
                }
                field(LabelCount; LabelCount)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Label Count', FRA = 'Nombre d''Étiquettes';
                    trigger OnValidate()
                    var
                        lerr01: TextConst ENU = 'Please enter the "Quantity per" before continuing.', FRA = 'Veuillez saisir la « Quantité par » avant de continuer.';
                        lerr02: TextConst ENU = 'The total quantity (%1 * %2) is different from the quantity to receive %3',
                       FRA = 'La quantité totale (%1 * %2) est différente de la quantité à recevoir %3';
                    begin
                        if QtyPar = 0 then
                            error(lerr01);
                        if (LabelCount * QtyPar) <> QtyTotalToRecieve then
                            error(lerr02, QtyPar, LabelCount, QtyTotalToRecieve);

                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ValidateScan)
            {
                CaptionML = ENU = 'Validate', FRA = 'Valider';
                image = Approve;
                InFooterBar = true;

                trigger OnAction()
                var
                    lErr01: TextConst ENU = 'You must specify the Purchase Order Number',
                          FRA = 'Vous devez préciser le numéro de commande achat';
                    lErr02: TextConst ENU = 'You must specify the line No.',
                          FRA = 'Veuillez saisir le numéro de ligne';
                    lerr03: TextConst ENU = 'You must specify the quantity to recieve',
                          FRA = 'Veuillez saisir la quantité à recevoir';
                    lErr04: TextConst ENU = 'You must specify the quantity per',
                          FRA = 'Vous devez préciser la quantité par';
                    lErr05: TextConst ENU = 'You must specify the label number',
                          FRA = 'Veuillez saisir le nombre d''Étiquettes';
                    lerr06: TextConst ENU = 'You must specify the Lot No.',
                          FRA = 'Veuillez saisir le numéro de Lot';
                    lerr07: TextConst ENU = 'You must specify the expiry date',
                          FRA = 'Veuillez saisir la date d''expiration';
                    lReceptionScanManagement: Codeunit "WDC Scanner Management";
                    lScanReceptionBuffer: record "Reception Scan Buffer";
                    lReceptionScan: page "WDC Reception scan";
                    lText001: TextConst ENU = 'do you want to post this Receipt ?',
                                        FRA = 'Voulez-vous valider cette réception ?';
                begin
                    ScanReceptionEntryNo := 0;
                    if PurchaseOrderNo = '' then
                        error(lErr01);
                    if LineNo = 0 then
                        error(lerr02);
                    if QtyTotalToRecieve = 0 then
                        error(lerr03);
                    if QtyPar = 0 then
                        error(lerr04);
                    if LabelCount = 0 then
                        Error(lerr05);
                    if ShowLotNo = true then begin
                        if LotNo = '' then
                            error(lerr06);
                        if ExpiryDate = 0D then
                            error(lerr07);
                    end;
                    if not Confirm(lText001) then
                        exit;
                    lReceptionScanManagement.CreateAndPostWarehouseReceipt(PurchaseOrderNo, LineNo, LotNo, ExpiryDate, QtyTotalToRecieve, LabelCount, QtyPar, VendorBL);
                    PurchaseOrderNo := '';
                    VendorBL := '';
                    LineNo := 0;
                    LotNo := '';
                    ItemNo := '';
                    ExpiryDate := 0D;
                    ExpiryDateTxt := '';
                    QtyTotalToRecieve := 0;
                    QtyPar := 0;
                    LabelCount := 0;
                    ShowLotNo := false;
                    ShowVaraintCode := false;
                    VariantCode := '';
                    CurrPage.update(true);
                end;
            }
        }

    }

    trigger OnOpenPage()
    var
    begin
        ShowLotNo := false;
        ShowVaraintCode := false;
        CurrPage.update(false);
    end;

    var
        ShowLotNo: Boolean;
        PurchaseOrderNo: code[20];
        VendorBL: code[35];
        LineNo: integer;
        LotNo: code[50];
        ExpiryDate: date;
        QtyTotalToRecieve: decimal;
        LabelCount: integer;
        QtyPar: decimal;
        ScanReceptionEntryNo: integer;
        ShowVaraintCode: Boolean;
        VariantCode: code[10];
        ExpiryDateTxt: Text;
        ItemNo: code[20];


}


