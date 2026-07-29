namespace SogregaDev.SogregaDev;

using Microsoft.Inventory.Item;
using Sogrega.Sogrega;

pageextension 53005 "WDC-SC Item List" extends "Item List"
{
    actions
    {
        addafter(PrintLabel)
        {
            action(PrintLabel2)
            {
                CaptionML = ENU = 'Print Label BC', FRA = 'Imprimer étiquette CAB';
                RunObject = report "Inventory Label";
                Image = Print;
                ApplicationArea = all;
            }
        }
    }
}
