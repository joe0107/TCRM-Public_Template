unit DLL_SERVICE;

interface

uses
  Classes, StdVcl, SysUtils, Dialogs, Windows, DB, DbTables, Forms, SqlExpr, CallLibrary,
  AstaClientSocket, ADODB;

type
  TCallBackProc = function(aServiceNo: Integer; ParamValues: OleVariant): OleVariant; stdcall;
  TSimpleProc = procedure; stdcall;
  TInitializeLibProc = procedure(AP: TApplication); stdcall;
  TSetAstaClientSocket = procedure (DbConn: TAstaClientSocket; ConnNdx: Integer); stdcall;
  TSetADOConnection = procedure (DbConn: TADOConnection; ConnNdx: Integer); stdcall;
  TSetDataSet = procedure (DataSet: TDataSet; ConnNdx: Integer); stdcall;
  TCreateService = procedure; stdcall;
  TStartService = function(ParamValues: OleVariant): Integer; stdcall;
  TGetFoundValue = function (ParamValues: OleVariant): OleVariant; stdcall;
  TClearParam = Procedure; stdcall;
  TStopService = function: Integer; stdcall;
  TSetParam = procedure(ParamName, Value: PChar); stdcall;
  TSetCallBackProc = procedure(CallBackProc: TCallBackProc); stdcall;

  TServiceLib = class(TDynaCallLibrary)
  protected
    procedure DoGetProcAddress; override;
  public
    InitializeLib: TInitializeLibProc;
    FinalizeLib: TSimpleProc;
    SetDataSet: TSetDataSet;
    SetAstaClientSocket: TSetAstaClientSocket;
    SetADOConnection: TSetADOConnection;
    CreateService: TCreateService;
    StartService: TStartService;
    GetFoundValue: TGetFoundValue;
    ClearParam: TClearParam;
    StopService: TStopService;
    SetParam: TSetParam;
    SetCallBackProc: TSetCallBackProc;
    RemoteCallBackProc: TCallBackProc;
  public
    function  LoadLib(LibraryName: string = ''): Boolean; override;
    function  UnLoadLib: Boolean; override;
  end;

  TCommonServices = class(TComponent)
  private
    function GetCount: Integer;
  protected
    FServiceNames: array of string;
    FServices: array of TServiceLib;
  public
    constructor Create(AOwner: TComponent);  override;
    destructor Destroy; override;
  public
    property Count: Integer read GetCount;
    function  GetServiceFullName(ServiceName: string): string;
    function FindService(ServiceName: string): Integer;
    function GetService(ServiceName: string): TServiceLib;
    function ServiceOfIndex(Index: Integer): TServiceLib;
    function LoadService(ServiceName: string; Params: OleVariant;
      CallBackProc: TCallBackProc): TServiceLib;
    function CreateService(ServiceName: string): Integer;
    procedure StopServices(ServiceName: string);
    procedure ShutDown;
    procedure UnloadLib;
  end;

  TProgramServices = class(TCommonServices)

  end;

  TReportServices = class(TCommonServices)

  end;

implementation

uses DLL_COMMON;

{ TServiceLib }
procedure TServiceLib.DoGetProcAddress;
begin
  inherited;
  @InitializeLib := GetProcAddress(LibHandle, 'InitializeLib');
  @FinalizeLib := GetProcAddress(LibHandle, 'FinalizeLib');
  @SetAstaClientSocket := GetProcAddress(LibHandle, 'SetAstaClientSocket');
  @SetADOConnection := GetProcAddress(LibHandle, 'SetADOConnection');
  @SetDataSet := GetProcAddress(LibHandle, 'SetDataSet');
  @CreateService := GetProcAddress(LibHandle, 'CreateService');
  @StartService := GetProcAddress(LibHandle, 'StartService');
  @GetFoundValue:= GetProcAddress(LibHandle, 'GetFoundValue');
  @ClearParam := GetProcAddress(LibHandle, 'ClearParam');
  @StopService := GetProcAddress(LibHandle, 'StopService');
  @SetParam := GetProcAddress(LibHandle, 'SetParam');
  @SetCallBackProc := GetProcAddress(LibHandle, 'SetCallBackProc');
  @RemoteCallBackProc := GetProcAddress(LibHandle, 'RemoteCallBackProc');
end;

function TServiceLib.LoadLib(LibraryName: string): Boolean;
begin
  Result := inherited LoadLib(LibraryName);
  InitializeLib(Application);
end;

function TServiceLib.UnLoadLib: Boolean;
begin
  if LibIsLoaded then
    FinalizeLib;
  Result := inherited UnLoadLib;
end;

{ TCommonServices }

constructor TCommonServices.Create(AOwner: TComponent);
begin
  inherited;
  SetLength(FServiceNames, 0);
  SetLength(FServices, 0);
end;

function TCommonServices.CreateService(ServiceName: string): Integer;
var
  Path:string;
  ServiceClass: string;
  ServiceLib: TServiceLib;
begin
  try
    Path:=IncludeTrailingBackslash(ExtractFileDir(Application.ExeName));
    ServiceClass := UpperCase(Copy(ServiceName, 1, 3));
    ServiceLib := TServiceLib.Create(Self);
    with ServiceLib do
    begin
      LoadLib(Path + ServiceName + '.DLL');
    end;
    Result := Length(FServiceNames);
    SetLength(FServiceNames, Result+1);
    SetLength(FServices, Result+1);
    FServiceNames[Result] := ServiceName;
    FServices[Result] := ServiceLib;
  finally

  end;
end;

destructor TCommonServices.Destroy;
begin
  ShutDown;
  inherited;
end;

function TCommonServices.FindService(ServiceName: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  if Length(FServiceNames) = 0 then Exit;
  ServiceName := UpperCase(ServiceName);
  for i := 0 to Length(FServiceNames)-1 do
  begin
    if (FServiceNames[i] = ServiceName) then
    begin
      Result := i;
      break;
    end;
  end;
end;

function TCommonServices.GetCount: Integer;
begin
  Result := Length(FServices);
end;

function TCommonServices.GetService(ServiceName: string): TServiceLib;
var
  i: Integer;
begin
  try
    ServiceName := UpperCase(ServiceName);
    i := FindService(ServiceName);
    if (i <> -1) then
      Result := FServices[i]
    else
      Result := nil;
  finally

  end;
end;

function TCommonServices.GetServiceFullName(ServiceName: string): string;
begin
  Result := Format('%s.DLL', [ServiceName]);
end;

function TCommonServices.LoadService(ServiceName: string;
  Params: OleVariant; CallBackProc: TCallBackProc): TServiceLib;
var
  i: Integer;
begin
  try
    ServiceName := UpperCase(ServiceName);
    i := FindService(ServiceName);
    if (i = -1) then
      i := CreateService(ServiceName);
    Result := FServices[i];
    with Result do
    begin
      if Assigned(SetCallBackProc) then  SetCallBackProc(CallBackProc);
      CreateService;
    end;
  finally

  end;
end;

function TCommonServices.ServiceOfIndex(Index: Integer): TServiceLib;
begin
  if (Index < 0) or (Index > (Count - 1)) then
     Result := nil
  else
     Result := FServices[Index];
end;

procedure TCommonServices.ShutDown;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
  begin
    FServices[i].StopService;
    Application.ProcessMessages;
  end;
  SetLength(FServiceNames, 0);
  SetLength(FServices, 0);
end;

procedure TCommonServices.StopServices(ServiceName: string);
var
  i: Integer;
begin
  ServiceName := UpperCase(ServiceName);
  i := FindService(ServiceName);
  if (i = -1) then Exit;
  FServices[i].StopService;
end;

procedure TCommonServices.UnloadLib;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
  begin
    FServices[i].StopService;
    Application.ProcessMessages;
    FServices[I].UnLoadLib;
    Application.ProcessMessages;
  end;
  SetLength(FServiceNames, 0);
  SetLength(FServices, 0);
end;

end.
