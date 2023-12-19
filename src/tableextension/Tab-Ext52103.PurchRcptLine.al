tableextension 52103 "IMP PurchRcptLine" extends "Purch. Rcpt. Line"
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
