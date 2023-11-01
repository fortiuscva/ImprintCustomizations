pageextension 52100 "IMP Item List" extends "Item List"
{
    Editable = true;

    layout
    {
        modify(Control1)
        {
            Editable = false;
        }
        addfirst(content)
        {
            field("IMP ItemNoFilterVarGbl"; ItemNoFilterVarGbl)
            {
                Caption = 'Item No. Filter';
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    If ItemNoFilterVarGbl <> '' then Rec.SetFilter("No.", ItemNoFilterVarGbl)
                    else
                        Rec.setrange("No.");
                    CurrPage.Update(false);
                end;
            }
        }
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
