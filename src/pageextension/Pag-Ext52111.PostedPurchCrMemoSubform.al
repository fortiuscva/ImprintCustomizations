pageextension 52111 "IMP PostedPurchCrMemoSubform" extends "Posted Purch. Cr. Memo Subform"
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
