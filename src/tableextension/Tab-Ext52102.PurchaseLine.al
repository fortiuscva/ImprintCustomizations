tableextension 52102 "IMP PurchaseLine" extends "Purchase Line"
{
    fields
    {
        field(52100; "IMP Label Quantity"; Decimal)
        {
            Caption = 'Label Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
    }
}
