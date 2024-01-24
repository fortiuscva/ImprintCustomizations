codeunit 52100 "IMP Event& Subscriptions"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateNo', '', false, false)]
    local procedure Tab36_OnBeforeValidateNo(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean);
    begin
        SalesLine.TestField("Purchase Order No.", '');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateType', '', false, false)]
    local procedure Tab36_OnBeforeValidateType(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean);
    begin
        SalesLine.TestField("Purchase Order No.", '');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateDropShipmentOnBeforeTestJobNo', '', false, false)]
    local procedure Tab36_OnValidateDropShipmentOnBeforeTestJobNo(var SalesLine: Record "Sales Line"; var IsHandled: Boolean);
    begin
        SalesLine.TestField("Purchase Order No.", '');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidatePurchasingCode', '', false, false)]
    local procedure Tab36_OnBeforeValidatePurchasingCode(var SalesLine: Record "Sales Line"; var IsHandled: Boolean);
    begin
        SalesLine.TestField("Purchase Order No.", '');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateUnitCostLCY', '', false, false)]
    local procedure Tab36_OnBeforeValidateUnitCostLCY(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean);
    var
        UpdateFromDSVarLcl: Boolean;
    begin
        UpdateFromDSVarLcl := SingleInstanceCUGbl.GetUpdateFromDropShip();
        if not UpdateFromDSVarLcl then SalesLine.TestField("Purchase Order No.", '');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeUpdateSalesCost', '', false, false)]
    local procedure OnBeforeUpdateSalesCost(var PurchaseLine: Record "Purchase Line"; var SalesOrderLine: Record "Sales Line"; var IsHandled: Boolean);
    begin
        SingleInstanceCUGbl.SetUpdateFromDropShip(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnCheckICDocumentDuplicatePostingOnAfterCalcShouldCheckPosted', '', false, false)]
    local procedure Cod90_OnCheckICDocumentDuplicatePostingOnAfterCalcShouldCheckPosted(PurchHeader: Record "Purchase Header"; var ShouldCheckPosted: Boolean);
    begin
        ShouldCheckPosted := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeValidateEmail', '', false, false)]
    local procedure Customer_OnBeforeValidateEmail(var Customer: Record Customer; var IsHandled: Boolean; xCustomer: Record Customer)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Mail Management", 'OnBeforeCheckValidEmailAddresses', '', false, false)]
    local procedure MailMgt_OnBeforeCheckValidEmailAddresses(Recipients: Text; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure ReleaseSalesDoc_OnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    begin
        SalesHeader."IMP Last Release Date" := Today;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure OnAfterReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean; SkipWhseRequestOperations: Boolean)
    begin
        // Update Sales Statistic Entries
        SalesStatMgt.UpdateStatSalesDoc(SalesHeader, FALSE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesLines', '', false, false)]
    local procedure OnAfterPostSalesLines(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; WhseShip: Boolean; WhseReceive: Boolean; var SalesLinesProcessed: Boolean; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean; var TempSalesLineGlobal: Record "Sales Line" temporary)
    begin
        WITH SalesHeader DO BEGIN
            CASE TRUE OF
                "Document Type" IN ["Document Type"::Order, "Document Type"::Invoice]:
                    SalesStatMgt.UpdateStatPostedInv(SalesInvoiceHeader);
                "Document Type" = "Document Type"::"Credit Memo":
                    SalesStatMgt.UpdateStatPostedCrMemo(SalesCrMemoHeader);
            END;
            SalesStatMgt.UpdateStatSalesDoc(SalesHeader, EverythingInvoiced);
        END;
    end;

    var
        SingleInstanceCUGbl: Codeunit "IMP Single Instance";
        SalesStatMgt: Codeunit "Sales Statistics Management";

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeConfirmBillToContactNoChange', '', false, false)]
    local procedure Table36_OnBeforeConfirmBillToContactNoChange(var SalesHeader: Record "Sales Header"; var xSalesHeader: Record "Sales Header"; CurrentFieldNo: Integer; var Confirmed: Boolean; var IsHandled: Boolean);
    begin
        if CurrentFieldNo = 5052 then begin
            if (SalesHeader."Sell-to Customer No." = SalesHeader."Bill-to Customer No.") or
               (SalesHeader."Bill-to Customer No." = '')
            then begin
                Confirmed := false;
                IsHandled := true;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCustLedgEntryInsert', '', false, false)]
    local procedure OnBeforeCustLedgEntryInsert(var CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; GLRegister: Record "G/L Register"; var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; var NextEntryNo: Integer)
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ServiceInvoiceHeader: Record "Service Invoice Header";
    begin
        case GenJournalLine."Document Type" of
            GenJournalLine."Document Type"::Invoice:
                begin
                    if SalesInvoiceHeader.Get(GenJournalLine."Document No.") then
                        CustLedgerEntry."IMP Payment Terms From Doc." := SalesInvoiceHeader."Payment Terms Code"
                    else
                        if ServiceInvoiceHeader.Get(CustLedgerEntry."Document No.") then
                            CustLedgerEntry."IMP Payment Terms From Doc." := ServiceInvoiceHeader."Payment Terms Code"
                end;
            GenJournalLine."Document Type"::"Credit Memo":
                begin
                    if SalesCrMemoHeader.Get(GenJournalLine."Document No.") then
                        CustLedgerEntry."IMP Payment Terms From Doc." := SalesCrMemoHeader."Payment Terms Code";
                end;
        end;
    end;
}
