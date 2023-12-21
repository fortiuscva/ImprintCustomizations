pageextension 52113 "IMP PostedPurchaseRcptSubform" extends "Posted Purchase Rcpt. Subform"
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
