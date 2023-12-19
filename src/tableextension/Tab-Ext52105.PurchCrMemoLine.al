tableextension 52105 "IMP PurchCrMemoLine" extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(52100; "IMP Label Quantity"; Decimal)
        {
            Caption = 'Label Quantity';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Editable = true;
        }
    }
}
