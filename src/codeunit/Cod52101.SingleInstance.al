codeunit 52101 "IMP Single Instance"
{
    SingleInstance = true;

    procedure SetUpdateFromDropShip(UpdateFromDropShipPar: Boolean)
    begin
        UpdateFromDropShipVarGbl:=UpdateFromDropShipPar;
    end;
    procedure GetUpdateFromDropShip(): Boolean begin
        exit(UpdateFromDropShipVarGbl);
    end;
    var UpdateFromDropShipVarGbl: Boolean;
}
