report 52107 "Update CLE Pay. Terms Frm.Doc."
{
    ApplicationArea = All;
    Caption = 'IMP Update CLE Pay. Terms Frm.Doc.';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {
            RequestFilterFields = "Posting Date";
            trigger OnAfterGetRecord()
            var
                SalesInvoiceHeader: Record "Sales Invoice Header";
                SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                ServiceInvoiceHeader: Record "Service Invoice Header";
            begin
                case CustLedgerEntry."Document Type" of
                    CustLedgerEntry."Document Type"::Invoice:
                        begin
                            if SalesInvoiceHeader.Get(CustLedgerEntry."Document No.") then
                                CustLedgerEntry."IMP Payment Terms From Doc." := SalesInvoiceHeader."Payment Terms Code"
                            else
                                if ServiceInvoiceHeader.Get(CustLedgerEntry."Document No.") then
                                    CustLedgerEntry."IMP Payment Terms From Doc." := ServiceInvoiceHeader."Payment Terms Code";
                        end;
                    CustLedgerEntry."Document Type"::"Credit Memo":
                        begin
                            if SalesCrMemoHeader.Get(CustLedgerEntry."Document No.") then
                                CustLedgerEntry."IMP Payment Terms From Doc." := SalesCrMemoHeader."Payment Terms Code";
                        end;
                end;

                if CustLedgerEntry.Modify() then
                    Counter += 1;
            end;
        }
    }
    var
        Counter: Integer;

    trigger OnPostReport()
    begin
        if Counter > 0 then
            Message('%1 records updated successfully', Counter);
    end;
}
