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
        SalesHeader."Last Release Date" := Today;
    end;

    var
        SingleInstanceCUGbl: Codeunit "IMP Single Instance";
}
