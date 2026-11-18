namespace sogrega.sogrega;

using Microsoft.HumanResources.Employee;

tableextension 56003 "WDC Employee" extends Employee
{
    fields
    {
        field(56000; "Carte Séjour"; Boolean)
        {
            CaptionML = ENU = 'Residence Permit', FRA = 'Carte séjour';
            DataClassification = ToBeClassified;
        }
        field(56001; "National Identity Card No."; code[10])
        {
            CaptionML = ENU = 'National Identity Card No.', FRA = 'Numéro de carte d''identité nationale';
            DataClassification = ToBeClassified;
        }
        field(56002; "Marital Status"; option)
        {
            CaptionML = ENU = 'Marital Status', FRA = 'Situation de famille';
            DataClassification = ToBeClassified;
            OptionMembers = ,Célibataire,Marié,Divorcé,Veuf;
            optionCaptionMl = ENU = ' ,Célibataire,Marié,Divorcé,Veuf', FRA = ' ,Célibataire,Marié,Divorcé,Veuf';
        }
        field(56003; "Loaded childs"; Integer)
        {
            CaptionML = ENU = 'Number of Children', FRA = 'Enfants à charge';
            fieldClass = FlowField;
            calcformula = Count("Employee Relative" WHERE("Employee No." = FIELD("No.")));
        }
        field(56004; "Code Direction"; Code[10])
        {
            CaptionML = ENU = 'Direction Code', FRA = 'Code Direction';
            DataClassification = ToBeClassified;
            //TableRelation="Employee Direction";
        }
    }
}
