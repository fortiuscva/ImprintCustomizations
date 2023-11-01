tableextension 52100 "IMP Sales Line" extends "Sales Line"
{
    fields
    {
        modify("Unit of Measure Code")
        {
            trigger OnBeforeValidate()
            begin
                Rec.TestField("Purchase Order No.", '');
            end;
        }
    }
    trigger OnBeforeDelete()
    begin
        if (Rec."Qty. Shipped Not Invd. (Base)" <> 0) or (Quantity <> "Quantity Shipped") then Rec.TestField("Purchase Order No.", '');
    end;
}
