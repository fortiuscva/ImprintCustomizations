pageextension 52101 "IMP Sales Return Order-RO" extends "Sales Return Order-RO"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("IMP Purchaser Code"; Rec."Purchaser Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchaser Code field.';
            }
        }
    }
}
