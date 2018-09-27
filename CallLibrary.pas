{***************************************************************
 * �椸�W��  : DynaCallLibrary
 * �ت��γ~  : �I�s DLL
 * �@    ��  : Joe Lee
 * �������  : V 1.0, 2001/4/23 15:46
 * �ק���{  :
 ****************************************************************}

unit CallLibrary;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms;

type
  TRegisterForm = procedure (fFun: TForm) of Object;

  TDynaCallLibrary = class(TComponent)
  private
    FLibName: string;
    FLibHandle: THandle;
    procedure SetLibName(const Value: string);
    procedure SetLibHandle(const Value: THandle);
  protected
    procedure DoGetProcAddress; virtual;
  public
    property  LibName: string read FLibName write SetLibName;
    property LibHandle: THandle read FLibHandle write SetLibHandle;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function  LoadLib(LibraryName: string = ''): Boolean; virtual;
    function  UnLoadLib: Boolean; virtual;
    function  LibIsLoaded: Boolean;
  end;

var
  ADD_FUNCTION: TRegisterForm;
  DEL_FUNCTION: TRegisterForm;
  SET_FUNCTION: TRegisterForm;

implementation

{ TDynaCallLibrary }

constructor TDynaCallLibrary.Create(AOwner: TComponent);
begin
  inherited;
  FLibName := '';
  FLibHandle := 0;
end;

destructor TDynaCallLibrary.Destroy;
begin
  UnLoadLib;
  inherited;
end;

procedure TDynaCallLibrary.DoGetProcAddress;
begin
  //�b�o�̨��oDLL�����{�Ǧ�}
end;

function TDynaCallLibrary.LibIsLoaded: Boolean;
begin
  Result := (FLibHandle <> 0);
end;

function TDynaCallLibrary.LoadLib(LibraryName: string): Boolean;
begin
  Result := True;
  //�{���w�w���J
  if (FLibHandle <> 0) then Exit;
  if Length(LibraryName) > 0 then
    FLibName := LibraryName;
  if not FileExists(LibraryName) then
  begin
    Result := False;
    raise Exception.CreateFmt('�䤣��{���w %s ', [FLibName]);    
  end;
  FLibHandle := LoadLibrary(PChar(FLibName));
  Result := (FLibHandle <> 0);
  if (FLibHandle = 0) then
    raise Exception.CreateFmt('�{���w %s ���J����', [FLibName]);
  DoGetProcAddress;
end;

procedure TDynaCallLibrary.SetLibHandle(const Value: THandle);
begin
  FLibHandle := Value;
end;

procedure TDynaCallLibrary.SetLibName(const Value: string);
begin
  if LibIsLoaded then UnLoadLib;
  FLibName := Value;
end;

function TDynaCallLibrary.UnLoadLib: Boolean;
begin
  Result := True;
  if (FLibHandle = 0) then Exit;
  try
    Result := FreeLibrary(FLibHandle);
    if Result then
      FLibHandle := 0
    else
      raise Exception.CreateFmt('�{���w %s ��������', [FLibName]);
  finally

  end;
end;

end.
