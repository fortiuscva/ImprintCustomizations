pageextension 52112 "IMP PostedPurchInvoiceSubform" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("IMP Label Quantity"; Rec."IMP Label Quantity")
            {
                ApplicationArea = All;
                BlankZero = true;
            }
        }
    }
}
