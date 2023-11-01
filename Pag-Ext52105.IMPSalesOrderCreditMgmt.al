pageextension 52105 "IMP Sales Order- Credit Mgmt" extends "Sales Order- Credit Mgmt"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(ZddWebClient; "Zetadocs Web Rel. Docs. Page")
            {
                ApplicationArea = All;
                Visible = ZddIsFactboxVisible;
            }
        }
    }
    var ItemNoFilterVarGbl: Text;
    ItemRecGbl: Record Item;
    ZddPrevRecID: RecordID;
    ZddIsFactboxVisible: Boolean;
    ZddIsActionsVisible: Boolean;
    ZddIsOnAfterGetCurrRecordInitialised: Boolean;
    trigger OnAfterGetCurrRecord()
    var
        ZdCommon: Codeunit "Zetadocs Common";
        ZdRecRef: RecordRef;
    begin
        if not ZddIsOnAfterGetCurrRecordInitialised then begin
            // Inside OnAfterGetCurrRecord to work around BC sometimes not triggering it 
            ZddIsOnAfterGetCurrRecordInitialised:=true;
            ZddIsFactboxVisible:=ZdCommon.IsFactboxVisibleForPage(CurrPage.OBJECTID(FALSE));
        end;
        if GuiAllowed then begin
            ZdRecRef.GetTable(Rec);
            if ZdRecRef.Get(ZdRecRef.RecordId) and (ZdRecRef.RecordId <> ZddPrevRecID)then begin
                ZddPrevRecID:=ZdRecRef.RecordId;
                CurrPage.ZddWebClient.PAGE.SetRecordID(ZdRecRef.RecordId);
                CurrPage.ZddWebClient.PAGE.Update(false);
            end;
        end;
    end;
}
