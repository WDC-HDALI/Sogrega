codeunit 54100 "TEJ Management"
{
    procedure GetTotalPaymentAmount(pDocumentNo: Code[20];
                                    Var pAmountHT: Decimal;
                                    Var pMontantRS: Decimal;
                                    Var pTotalAmount: Decimal;
                                    Var pVATAmount: Decimal;
                                    Var pMontantNetServi: Decimal;
                                    Var pMontantRSDevise: Decimal;
                                    Var pTotalCurrencyAmount: Decimal;
                                    Var pNetAmountInCurrency: Decimal);
    begin
        GLSetup.Get();
        GlEntries.Reset();
        GlEntries.SetCurrentKey("Document No.");
        GlEntries.SetFilter("Document No.", pDocumentNo);
        GlEntries.SetRange("Source Type", GlEntries."Source Type"::Vendor);
        GlEntries.SetFilter("G/L Account No.", '%1|%2|%3', GLSetup."Vendor Payment Accounts No.", GLSetup."Foreign exch. earn. acc. No.", GLSetup."Loss accounts No.");
        IF GlEntries.FINDSET THEN
            repeat
                pAmountHT += GlEntries.Amount;
                pVATAmount += GlEntries."VAT Amount";
                pTotalAmount += GlEntries.Amount;
                pMontantNetServi := pTotalAmount - (Abs(pMontantRS));
                if GlEntries."Source Currency Code" <> '' Then Begin
                    pTotalCurrencyAmount += ABS(GlEntries."Source Currency Amount");
                    pNetAmountInCurrency += GlEntries."Source Currency Amount" - Abs(pMontantRSDevise);
                end;
            until glEntries.Next() = 0;
    end;



    procedure CalcTotalPaymentAmountFromRSAmount(pDocumentNo: Code[20];
                                                Var pAmountHT: Decimal;
                                                Var pMontantRS: Decimal;
                                                Var pTotalAmount: Decimal;
                                                Var pVATAmount: Decimal;
                                                Var pMontantNetServi: Decimal;
                                                Var pMontantRSDevise: Decimal;
                                                Var pTotalCurrencyAmount: Decimal;
                                                Var pNetAmountInCurrency: Decimal;
                                                Var pRsRate: Decimal);
    begin
        GLSetup.Get();
        GlEntries.Reset();
        GlEntries.SetCurrentKey("Document No.");
        GlEntries.SetFilter("Document No.", pDocumentNo);
        GlEntries.SetFilter("G/L Account No.", GLSetup."Withholding Tax Accounts");
        IF GlEntries.FINDSET THEN
            repeat
                pAmountHT += GlEntries.Amount;
                pVATAmount += GlEntries."VAT Amount";
                pTotalAmount += GlEntries.Amount;
                pMontantNetServi := pTotalAmount - (Abs(pMontantRS));
                if GlEntries."Source Currency Code" <> '' Then Begin
                    pTotalCurrencyAmount += ABS(GlEntries."Source Currency Amount");
                    pNetAmountInCurrency += GlEntries."Source Currency Amount" - Abs(pMontantRSDevise);
                end;
            until glEntries.Next() = 0;
    end;

    Var
        GlEntries: Record "G/L Entry";
        GLSetup: Record "General Ledger Setup";
}
