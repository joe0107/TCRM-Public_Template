unit DLL_PUBLIC;

interface

uses
  Sysutils, classes, dbtables, windows, shellapi, Dialogs, Forms, BDE;

type
  TDllRptCallback = function (pcParam: PChar; iParam: Integer): Integer; stdcall;
  TSetCallbackFunc = procedure(DllRptCallback: TDllRptCallback); stdcall;

  TDbNode = record
    DbName: string;
    DB: TDatabase;
  end;

  TDbList = array of TDbNode;

  TParamNode = record
    Name: string;
    Value: string;
  end;

  TParamList = array of TParamNode;

  TDllParams = class
  private
    FItems: TParamList;
  public
    property  Items: TParamList read FItems;
    procedure Clear;
    function  IndexOfParam(ParamName: string): Integer;
    procedure Add(ParamName, Value: string);
    function  GetParam(ParamName: string; var Value: string): Integer;
    function  GetParamAsString(ParamName: string): string;
    function  GetParamAsInteger(ParamName: string): Integer;
    function  GetParamAsFloat(ParamName: string): Extended; overload;
    function  GetParamAsBoolean(ParamName: string): Boolean;
  end;

  TDatabaseList = class
  private
    FItems: TDbList;
    function  GetCount: Integer;
    procedure DatabaseLogin(Database: TDatabase; LoginParams: TStrings);
  public
    destructor Destroy; override;
    property  Items: TDbList read FItems;
    property  Count: Integer read GetCount;
    function  Find(DbName: string; hDB: HDBIDB): Boolean;
    procedure Add(DbName: string; hDB: HDBIDB);
    procedure SetParams(DbName, ParamName, Value: string);
    function  GetDb(DbName: string; var Db: TDataBase): Integer;
    function  MapDataSet(DataSet: TDbDataSet): Boolean;
    function  UnMapDataSet(DataSet: TDbDataSet): Boolean;
  end;

  TLogFile = class
  private
    FFileHandle: TextFile;
    FFileName: string;
    procedure SetFileName(const Value: string);
    procedure Open;
    procedure Close;
  public
    constructor Create(FileName: string = '');
    property  FileName: string write SetFileName;
    procedure Write(Msg: string);
    procedure WriteDevideLine(Msg: string = ''; LineChar: Char = '-');
    procedure WriteLine(LineChar: Char = '=');
  end;

var
  CallerWnd: HWND;
  //DbList: TDatabaseList; j08 920520
  DllParams: TDllParams;
  DebugMode: Boolean = False;
  ShowModalReport: Boolean = False;
  RptCallback: TDllRptCallback = nil;
  FileVerDesc : string;

implementation

//*********************************************************
// 內部公用 procedure/function
//*********************************************************

{ TLogFile }
constructor TLogFile.Create(FileName: string);
begin
  inherited Create;
  FFileName := Trim(FileName);
  if Length(FFileName) = 0 then
    FFileName := ChangeFileExt(Application.ExeName, '.Log');
end;

procedure TLogFile.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure TLogFile.Write(Msg: string);
begin
  Open;
  Writeln(FFileHandle, DateTimeToStr(Now)+' : '+Msg);
  Close;
end;

procedure TLogFile.WriteLine(LineChar: Char);
begin
  Open;
  Writeln(FFileHandle, StringOfChar(LineChar, 80));
  Close;
end;

procedure TLogFile.Close;
begin
  Flush(FFileHandle);
  CloseFile(FFileHandle);
end;

procedure TLogFile.Open;
begin
  AssignFile(FFileHandle, FFileName);
  if FileExists(FFileName) then
    Append(FFileHandle)
  else
    Rewrite(FFileHandle);
end;

procedure TLogFile.WriteDevideLine(Msg: string; LineChar: Char);
var
  i, j, k: Integer;
begin
  k := 80-Length(DateTimeToStr(Now)+' : ');
  i := Length(Msg);
  j := (k-i) div 2;
  Msg := StringOfChar(LineChar, j)+Msg;
  Msg := Msg+StringOfChar(LineChar, k-Length(Msg));
  Write(Msg);
end;

{ TDllParams }

procedure TDllParams.Add(ParamName, Value: string);
var
  i: Integer;
begin
  i := IndexOfParam(ParamName);
  if (i = -1) then
  begin
    i := Length(FItems);
    SetLength(FItems, i+1);
  end;
  FItems[i].Name := ParamName;
  FItems[i].Value := Value;
end;

procedure TDllParams.Clear;
begin
  SetLength(FItems, 0);
end;

function TDllParams.GetParam(ParamName: string;
  var Value: string): Integer;
begin
  Result := IndexOfParam(ParamName);
  if (Result <> -1) then
    Value := FItems[Result].Value;
end;

function TDllParams.GetParamAsBoolean(ParamName: string): Boolean;
var
  ParamValue: string;
begin
  if (GetParam(ParamName, ParamValue) = -1) then
    Result := False
  else
  begin
    ParamValue := Trim(ParamValue);
    if (ParamValue <> '0') then
      Result := True
    else
      Result := False;
  end;
end;

function TDllParams.GetParamAsFloat(ParamName: string): Extended;
var
  ParamValue: string;
begin
  GetParam(ParamName, ParamValue);
  try
    Result := StrToFloat(ParamValue);
  except
    Result := 0;
  end;
end;

function TDllParams.GetParamAsInteger(ParamName: string): Integer;
var
  ParamValue: string;
begin
  GetParam(ParamName, ParamValue);
  try
    Result := Trunc(StrToFloat(ParamValue));
  except
    Result := 0;
  end;
end;

function TDllParams.GetParamAsString(ParamName: string): string;
var
  Value: string;
begin
  if (GetParam(ParamName, Value) = -1) then
    Result := ''
  else
    Result := Value;
end;

function TDllParams.IndexOfParam(ParamName: string): Integer;
var
  i: Integer;
begin
  for i := 0 to Length(FItems)-1 do
  begin
    if (FItems[i].Name = ParamName) then
    begin
      Result := i;
      Exit;
    end
  end;
  Result := -1;
end;

{ TDatabaseList }

procedure TDatabaseList.Add(DbName: string; hDB: HDBIDB);
var
  DbNameCount: Integer;
  i: Integer;
  TempDb: TDatabase;
begin
  DbNameCount := 0;
  i := GetDb(DbName, TempDb);
  if (i <> -1) then
  begin
    //重複名稱的資料庫連線
    FItems[i].DB.CloseDataSets;
    if FItems[i].DB.Connected then
      FItems[i].DB.Connected := False;
  end
  else
  begin
    //新名稱的資料庫連線
    i := Length(FItems);
    SetLength(FItems, i+1);
    FItems[i].DbName := Uppercase(DbName);
    TempDb := TDatabase.Create(nil);
    TempDb.LoginPrompt := False;
    TempDb.OnLogin := DatabaseLogin;
    if (DbNameCount = 0) then
      DbNameCount := Round(TimeStampToMSecs(DateTimeToTimeStamp(Now)))
    else
      Inc(DbNameCount);
    TempDb.DatabaseName := Format('_DB_%d', [DbNameCount]);
    FItems[i].DB := TempDb;
  end;
end;

procedure TDatabaseList.DatabaseLogin(Database: TDatabase;
  LoginParams: TStrings);
begin
  with Database do
  begin
    if Params.IndexOfName('User Name') <> -1 then
      LoginParams.Values['User Name'] := Params.Values['User Name']
    else
      LoginParams.Values['User Name'] := 'SYSDBA';

    if Params.IndexOfName('PassWord') <> -1 then
      LoginParams.Values['PassWord'] := Params.Values['PassWord']
    else
      LoginParams.Values['PassWord'] := 'masterkey';
  end;
end;

destructor TDatabaseList.Destroy;
var
  i: Integer;
begin
  for i := 0 to Length(FItems)-1 do
  begin
    FITems[i].DB.Free;
  end;
  inherited;
end;

function TDatabaseList.Find(DbName: string; hDB: HDBIDB): Boolean;
var
  i: Integer;
begin
  DbName := Uppercase(DbName);
  for i := 0 to Length(FItems)-1 do
  begin
    if (FItems[i].DB.Handle = hDB) and
       (FItems[i].DbName = DbName) then
    begin
      Result := True;
      Exit;
    end
  end;
  Result := False;
end;

function TDatabaseList.GetCount: Integer;
begin
  Result := Length(FItems);
end;

function TDatabaseList.GetDb(DbName: string; var Db: TDataBase): Integer;
var
  i: Integer;
begin
  DbName := Uppercase(DbName);
  for i := 0 to Length(FItems)-1 do
  begin
    if (FItems[i].DbName = DbName) then
    begin
      DB := FItems[i].DB;
      Result := i;
      Exit;
    end
  end;
  DB := nil;
  Result := -1;
end;

function TDatabaseList.MapDataSet(DataSet: TDbDataSet): Boolean;
var
  Db: TDatabase;
begin
  GetDb(DataSet.DatabaseName, Db);

  if not Assigned(Db) then
  begin
    Result := False;
    Exit;
  end;

  with DataSet do
  begin
    DatabaseName := Db.DatabaseName;
    SessionName := Db.SessionName;
  end;

  Result := True;
end;

procedure TDatabaseList.SetParams(DbName, ParamName, Value: string);
var
  i: Integer;
  Db: TDatabase;
begin
  i := GetDb(DbName, Db);
  if (i = -1) then Exit;

  ParamName := UpperCase(ParamName);
  if (ParamName = 'ALIAS') then
    FItems[i].DB.AliasName := Value
  else if (ParamName = 'DRIVER') then
    FItems[i].DB.DriverName := Value
  else if (ParamName = 'CLEAR_PARAMS') then
    FItems[i].DB.Params.Clear
  else if (ParamName = 'ADD_PARAM') then
    FItems[i].DB.Params.Add(Value);
end;

function TDatabaseList.UnMapDataSet(DataSet: TDbDataSet): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Length(FItems)-1 do
  begin
    if (FItems[i].DB.DatabaseName = DataSet.DatabaseName) then
    begin
      if DataSet.Active then DataSet.Close;
      DataSet.DatabaseName := FItems[i].DbName;
      Result := True;
      Exit;
    end
  end;
end;

initialization
  DllParams := TDllParams.Create;
  //DbList := TDatabaseList.Create;

finalization
  if Assigned(DllParams) then DllParams.Free;
  //if Assigned(DbList) then DbList.Free;
end.











