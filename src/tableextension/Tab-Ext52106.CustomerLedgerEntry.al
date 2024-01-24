tableextension 52106 "IMP Customer Ledger Entry" extends "Cust. Ledger Entry"
{
    fields
    {
        field(52100; "IMP Payment Terms From Doc."; Code[30])
        {
            Caption = 'Payment Terms From Doc.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}
