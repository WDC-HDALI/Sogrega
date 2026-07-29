report 50094 "WDC Fix Vendor GLEntries"
{
    CaptionML = ENU = 'Fix Vendor GL Entries', FRA = 'Correction des écritures comptables des fournisseurs';
    ProcessingOnly = true;
    ApplicationArea = All;
    Permissions =
    TableData "G/L Entry" = rimd;
    dataset
    {
        dataitem(GLEntry; "G/L Entry")
        {
            DataItemTableView = where("Source Type" = const(Vendor));

            trigger OnPreDataItem()
            begin
                SetFilter("G/L Account No.", '401000*');
            end;

            trigger OnAfterGetRecord()
            var
                lVendor: Record Vendor;
                lVendorPostingGroup: Record "Vendor Posting Group";
            begin
                if lVendor.Get("Source No.") then begin
                    if lVendorPostingGroup.Get(lVendor."Vendor Posting Group") then begin

                        if "G/L Account No." <> lVendorPostingGroup."Payables Account" then begin
                            "G/L Account No." := lVendorPostingGroup."Payables Account";
                            Modify();
                        end;
                    end;
                end;
            end;
        }
    }
}