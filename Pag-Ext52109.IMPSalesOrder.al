pageextension 52109 "IMP Sales Order" extends "Sales Order"
{
    layout
    {
        addafter(Status)
        {
            field("Last Release Date"; Rec."Last Release Date")
            {
                ApplicationArea = All;
                ToolTip = 'When Sales Order is Released, Last Release Date is updated with Work Date.';
            }
        }
    }
}
