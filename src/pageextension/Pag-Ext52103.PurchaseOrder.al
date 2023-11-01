pageextension 52103 "IMP Purchase Order" extends "Purchase Order"
{
    layout
    {
        modify("Ship-to Contact")
        {
            Editable = true;
        }
    }
}
