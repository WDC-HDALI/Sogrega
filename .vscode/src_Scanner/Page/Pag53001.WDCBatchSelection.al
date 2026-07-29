namespace sogrega.sogrega;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Location;
using System.Globalization;

page 53001 " WDC Scanneer Batch Selection"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    CaptionML = ENU = 'Scan Location Transfert', FRA = 'Scan transfert magasin';
    RefreshOnActivate = false;
    UsageCategory = tasks;

    layout
    {
        area(content)
        {
            field("Journal Batch Name"; BatchName)
            {
                ApplicationArea = All;
                CaptionML = ENU = 'Batch Name', FRA = 'Nom Feuille';
                TableRelation = "Item Journal Batch".name where("Journal Template Name" = filter('TRANSFERT'), "Scanner Sheet" = const(true));
                trigger OnValidate()
                var
                    lScannerMgt: Codeunit "WDC Scanner Management";

                begin
                    lScannerMgt.ClearBatch(BatchName);
                end;

            }
            field("From Location"; FromLocation)
            {
                Captionml = ENU = 'Source Location', FRA = 'Magasin Source';
                TableRelation = Location;
                ApplicationArea = All;
            }
            field(ToLocation; ToLocation)
            {
                ApplicationArea = all;
                TableRelation = Location;
                CaptionML = ENU = 'Destination Location', FRA = 'Magasin destination';
                trigger OnValidate()
                var
                    lerr02: TextConst ENU = 'The source location and the destination locatoion must be different.', FRA = 'Le magasin source et le magasin destination doivent être différents.';
                begin
                    if ToLocation = FromLocation then
                        Error(lerr02);
                end;
            }
        }
    }
    // procedure CheckBatchConflict(pBatchName: Code[10])
    // var
    //     lScanBuffer: Record "Reception Scan Buffer";
    //     lErr01: TextConst ENU = 'Sheet %1 is already in use by another user', FRA = 'La feuille %1 est déjà utilisée par un autre utilisateur';
    // begin
    //     lScanBuffer.Reset();
    //     lScanBuffer.SetRange("Journal Batch Name", pBatchName);
    //     if lScanBuffer.FindFirst() then
    //         Error('La feuille %1 est déjà utilisée par un autre utilisateur', pBatchName);
    // end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        lErr01: TextConst ENU = 'You must specify the name of the sheet',
                          FRA = 'Vous devez préciser le nom de la feuille';
        lErr02: TextConst ENU = 'You must specify source Location',
                          FRA = 'Veuillez saisir le magasin source';
        lerr03: TextConst ENU = 'You must specify Destination Location',
                          FRA = 'Veuillez saisir le magasin destination';
        lScanTransferLinePage: page "WDC Scan Transfer Lines";

    begin
        if CloseAction <> Action::OK then
            exit(true);
        if BatchName = '' then
            error(lErr01);
        if FromLocation = '' then
            error(lerr02);
        if ToLocation = '' then
            error(lerr03);
        lScanTransferLinePage.SetBatchNameAndLocationFrom(BatchName, FromLocation, ToLocation);
        lScanTransferLinePage.Run();
        exit(true);

    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        batchname := '';
        FromLocation := '';
        ToLocation := '';

    end;

    var
        BatchName: Code[10];
        FromLocation: Code[10];
        ToLocation: code[10];

}
