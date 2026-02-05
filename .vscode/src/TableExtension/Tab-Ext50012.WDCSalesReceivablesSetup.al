tableextension 50012 WDCSalesReceivablesSetup extends "Sales & Receivables Setup"
{
    //*************Documentation***************************
    //WDC01  CHG 03/09/2024 create this current object
    //WDC02  HG  19/12/2024 Add fields 

    fields
    {
        field(50000; "Last Shipping Date Filter"; DateFormula)
        {
            CaptionML = ENG = 'Last Shipping Date Filter', FRA = 'Filtre date d''expédition';
            DataClassification = ToBeClassified;
        }
        //>>WDC02
        field(50001; "Location Code Bouargoub"; code[10])
        {
            CaptionML = ENG = 'Location Code Bouargoub', FRA = 'Code magasin Bouargoub';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50002; "Location code Menzel Jmil"; code[10])
        {
            CaptionML = ENG = 'Location code Menzel Jmil', FRA = 'Code magasion Menzel Jmil ';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50003; "Site Code Bouargoub"; code[20])
        {
            CaptionML = ENG = 'Site Code Bouargoub', FRA = 'Site Code Bouargoub';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
        }
        field(50004; "Site code Menzel Jmil"; code[20])
        {
            CaptionML = ENG = 'Site code Menzel Jmil', FRA = 'Site Code  Menzel Jmil ';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));

        }
        field(50005; "Controle Qty to invoice"; Boolean)
        {
            CaptionML = ENG = 'Controle Qty to invoice', FRA = 'Contrôle quantité à facturer';
            DataClassification = ToBeClassified;
        }
        //<<WDC02
    }
}