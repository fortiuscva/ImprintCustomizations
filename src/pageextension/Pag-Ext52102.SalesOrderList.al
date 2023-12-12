pageextension 52102 "IMP Sales Order List" extends "Sales Order List"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("IMP Override Credit"; Rec."Override Credit")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Override Credit field.';
            }
        }
        addafter("No.")
        {
            field("IMP No. Printed"; Rec."No. Printed")
            {
                ApplicationArea = All;
            }
        }
    }
}
