namespace sogrega.sogrega;
enum 54100 "WDC Identification Type"
{
    Extensible = true;

    value(0; "Tax Identification Number")
    {
        Captionml = ENU = 'Tax Identification Number', FRA = 'Matricule fiscal';
    }
    value(1; CIN)
    {
        Captionml = ENU = 'CIN', FRA = 'CIN';
    }
}