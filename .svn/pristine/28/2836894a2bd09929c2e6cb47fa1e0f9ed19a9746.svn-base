unit cDLLDm;

interface

uses
  SysUtils, Classes, DB, DBClient, ScktComp, Forms, Dialogs, ADODB;

type
  TdmcDLL = class(TDataModule)
    cdsLogin: TClientDataSet;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmcDLL: TdmcDLL;
  FShow_Modal: Integer;
  FService_NO: Integer;
  {FMainConnection, FTestConnection: TAstaClientSocket;}
  FMainADOConnection: TADOConnection;

  procedure SetDataSet(DataSet: TDataSet; ConnNdx: Integer); stdcall;
  {procedure SetAstaClientSocket(DbConn: TAstaClientSocket; ConnNdx: Integer); stdcall;}
  procedure SetADOConnection(DbConn: TADOConnection; ConnNdx: Integer); stdcall;

implementation

{$R *.dfm}

procedure SetDataSet(DataSet: TDataSet; ConnNdx: Integer);
begin
   if not Assigned(DataSet) then Exit;
   if not Assigned(dmcDLL) then dmcDLL := TdmcDLL.Create(Application);
   with dmcDLL do
   begin
      case ConnNdx of
      0:  cdsLogin.Data := TClientDataSet(DataSet).Data;  //傳入登入資料
      end;
   end;
end;
(*
procedure SetAstaClientSocket(DbConn: TAstaClientSocket; ConnNdx: Integer); stdcall;
begin
   if not Assigned(DbConn) then Exit;
   if not Assigned(dmcDLL) then dmcDLL := TdmcDLL.Create(Application);
   with dmcDLL do
   begin
      case ConnNdx of
        0: FMainConnection := DBConn;                            //傳入所使用的AstaClientSocket
        1: FTestConnection := DBConn;                            //傳入所使用的Test 網站 AstaClientSocket
      end;
   end;
end;
*)
procedure SetADOConnection(DbConn: TADOConnection; ConnNdx: Integer); stdcall;
begin
   if not Assigned(DbConn) then Exit;
   if not Assigned(dmcDLL) then dmcDLL := TdmcDLL.Create(Application);
   with dmcDLL do
   begin
      case ConnNdx of
        0: FMainADOConnection := DBConn;                         //傳入所使用的ADOConnection
      end;
   end;
end;

procedure TdmcDLL.DataModuleDestroy(Sender: TObject);
begin
   dmcDLL := nil;
   inherited;
end;

procedure TdmcDLL.DataModuleCreate(Sender: TObject);
begin
//   acsMain.Active := False;
//   acsTest.Active := False;
   //ADOMain.Connected := False;
end;

initialization
   dmcDLL := TdmcDLL.Create(Application);
finalization
   dmcDLL.Free;

end.
