pageextension 52107 "IMP Recent Sales Invoice Lines" extends "Recent Sales Invoice Lines"
{
    layout
    {
        addafter("No.")
        {
            field("IMP Item Reference No."; Rec."Item Reference No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the referenced item number.';
            }
        }
    }
}
