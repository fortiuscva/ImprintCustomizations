tableextension 52101 "IMP Sales Header" extends "Sales Header"
{
    fields
    {
        field(52100; "Last Release Date"; Date)
        {
            Caption = 'Last Release Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
}
