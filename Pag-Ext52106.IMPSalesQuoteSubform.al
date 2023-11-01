pageextension 52106 "IMP Sales Quote Subform" extends "Sales Quote Subform"
{
    layout
    {
        modify("Description 2")
        {
            Visible = true;
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            action(IMP_ExplodeBOM)
            {
                ApplicationArea = Suite;
                Caption = 'IMP E&xplode BOM';
                Image = ExplodeBOM;
                Enabled = Rec.Type = Rec.Type::Item;
                trigger OnAction()
                begin
                    IMPExplodeBOM();
                end;
            }
        }
    }
    procedure IMPExplodeBOM()
    begin
        if Rec."Prepmt. Amt. Inv." <> 0 then
            Error(Text52100);
        CODEUNIT.Run(CODEUNIT::"IMP Sales-Explode BOM", Rec);
        DocumentTotals.SalesDocTotalsNotUpToDate();
    end;

    var
        DocumentTotals: Codeunit "Document Totals";
        Text52100: Label 'You cannot use the Explode BOM function because a prepayment of the sales quote is there.';
}
