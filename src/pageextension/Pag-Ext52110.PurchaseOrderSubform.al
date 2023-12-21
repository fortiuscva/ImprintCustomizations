pageextension 52110 "IMP PurchaseOrderSubform" extends "Purchase Order Subform"
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
