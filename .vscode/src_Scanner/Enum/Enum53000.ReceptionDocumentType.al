namespace sogrega.sogrega;
//***************Documentation**********************
//WDC01  WDC.HG  06/09/2025 Create current object : Scanner flux
enum 53000 "Reception Document Type"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; "Reception")
    {
        Captionml = ENU = 'Reception', FRA = 'Réception';
    }
    value(1; "Transfer")
    {
        Captionml = ENU = 'Location Transfer', FRA = 'Transfert magasin';
    }

}