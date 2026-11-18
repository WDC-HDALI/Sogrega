namespace sogrega.sogrega;

using Microsoft.Foundation.Company;

tableextension 56001 "WDC Company Information" extends "Company Information"
{
    fields
    {
        field(56001; Activity; Code[100])
        {
            CaptionML = ENU = 'Activity', FRA = 'Activité';
            DataClassification = ToBeClassified;
        }
    }
}
