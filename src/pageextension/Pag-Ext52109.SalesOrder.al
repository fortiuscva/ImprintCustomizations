pageextension 52109 "IMP Sales Order" extends "Sales Order"
{
    layout
    {
        addafter(Status)
        {
            field("IMP Last Release Date"; Rec."IMP Last Release Date")
            {
                ApplicationArea = All;
                ToolTip = 'When Sales Order is Released, Last Release Date is updated with Work Date.';
            }
        }
    }
    actions
    {
        addafter("&Order Confirmation")
        {
            action("IMP SalesOrderInternal")
            {
                Caption = 'IMP Sales Order Internal';
                ApplicationArea = Basic, Suite;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    CurrPage.SetSelectionFilter(SalesHeader);
                    Report.RunModal(Report::"IMP Sales Order Internal", true, false, SalesHeader);
                end;
            }
        }
    }
}
