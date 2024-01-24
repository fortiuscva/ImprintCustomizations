pageextension 52114 "IMP Customer Ledger Entries" extends "Customer Ledger Entries"
{
    layout
    {
        addbefore("Customer No.")
        {
            field("IMP Payment Terms From Doc."; Rec."IMP Payment Terms From Doc.")
            {
                ApplicationArea = All;
            }
        }
    }
}
