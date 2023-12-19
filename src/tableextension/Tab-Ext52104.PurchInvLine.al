tableextension 52104 "IMP PurchInvLine" extends "Purch. Inv. Line"
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
