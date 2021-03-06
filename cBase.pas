unit cBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, StdCtrls,
  cxEdit, DB, DBTables, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxGridStrs,
  JcCxGridResStr, cxTextEdit, cxMemo, cxButtonEdit, ADODB, cxGridBandedTableView,
  cxGridDBBandedTableView, cxPropertiesStore;

type
  TfmcBase = class(TForm)
    cxPropertiesStore: TcxPropertiesStore;
    JcCxGridResStr1: TJcCxGridResStr;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations}
    FIniFile : TIniFile;
    FMemIniFile: TMemIniFile;
  protected
    FAppPath, FSysDataPath: string;
    FFixIniFile: string;
    FCanCloseForm, FAutoFieldDisplayLabel: boolean;
    procedure Loaded; override;
    procedure DoDestroy; override;
    procedure InitializationValues; virtual;
    procedure ReSetINI;
    function ReadIniString(const Section, Ident: string; ADefault: String = ''): string;
    procedure WriteIniString(const Section, Ident, Values: String);
    function ReadIniInteger(const Section, Ident: String; ADefault: Integer = 0): Integer;
    procedure WriteIniInteger(const Section, Ident: String; Values: Integer);
    function ReadIniBoolean(const Section, Ident: String; ADefault: Boolean = False): Boolean;
    procedure WriteIniBoolean(const Section, Ident: String; Values: Boolean);
    procedure BeforeNextControl(aActiveControl:TWinControl; var aChange: Boolean); virtual;
    procedure BeforePrjorControl(aActiveControl:TWinControl; var aChange: Boolean); virtual;
    procedure cSetFocus(aWinControl: TWinControl);
    function ReadCanEdit: Boolean; virtual;
    //procedure WCRMRefresh(aDataSet: TAstaClientDataset); overload;
    procedure WCRMRefresh(aDataSet: TCustomADODataSet); overload;
  public
    { Public declarations }
  end;

var
  fmcBase: TfmcBase;

implementation

uses cUtility, cDB_Manager, DLL_COMMON;

{$R *.dfm}

procedure TfmcBase.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if not FCanCloseForm then
      ShowMessage('目前視窗狀態是不允許關閉!!');
   CanClose := FCanCloseForm;
end;

function TfmcBase.ReadIniString(const Section, Ident: string; ADefault: String): string;
begin
   if not Assigned(FMemIniFile) then
   begin
      if FFixIniFile = ''then
         FMemIniFile := TMemIniFile.Create(GetIniFileName)
      else
         FMemIniFile := TMemIniFile.Create(FAppPath + FFixIniFile)
   end;   
   Result := FMemIniFile.ReadString(Section, Ident, ADefault);
end;

procedure TfmcBase.WriteIniString(const Section, Ident, Values: String);
begin
   if not Assigned(FIniFile) then 
   begin
      if FFixIniFile = ''then
         FIniFile := TIniFile.Create(GetIniFileName)
      else
         FIniFile := TIniFile.Create(FAppPath + FFixIniFile)
   end;   
   FIniFile.WriteString(Section, Ident, Values);
end;

procedure TfmcBase.FormDestroy(Sender: TObject);
//var
//  K: Integer;
begin
(*
   for K := 0 to ComponentCount - 1 do
   begin
     if Components[K] is TxQuery then
     begin
       if TxQuery(Components[K]).Active then
          TxQuery(Components[K]).Close;
     end;
   end;
*)   
   FreeAndNil(FIniFile);
   FreeAndNil(FMemIniFile);
   Inherited;
end;

function TfmcBase.ReadIniInteger(const Section, Ident: String; ADefault: Integer): Integer;
begin
   if not Assigned(FMemIniFile) then
   begin
      if FFixIniFile = ''then
         FMemIniFile := TMemIniFile.Create(GetIniFileName)
      else
         FMemIniFile := TMemIniFile.Create(FAppPath + FFixIniFile)
   end;   
   Result := FMemIniFile.ReadInteger(Section, Ident, ADefault);
end;

procedure TfmcBase.WriteIniInteger(const Section, Ident: String; Values: Integer);
begin
   if not Assigned(FIniFile) then 
   begin
      if FFixIniFile = ''then
         FIniFile := TIniFile.Create(GetIniFileName)
      else
         FIniFile := TIniFile.Create(FAppPath + FFixIniFile)
   end;   
   FIniFile.WriteInteger(Section, Ident, Values);
end;

function TfmcBase.ReadIniBoolean(const Section, Ident: String;  ADefault: Boolean): Boolean;
begin
   if not Assigned(FMemIniFile) then
   begin
      if FFixIniFile = ''then
         FMemIniFile := TMemIniFile.Create(GetIniFileName)
      else
         FMemIniFile := TMemIniFile.Create(FAppPath + FFixIniFile)
   end;   
   Result := FMemIniFile.ReadBool(Section, Ident, ADefault);
end;

procedure TfmcBase.WriteIniBoolean(const Section, Ident: String; Values: Boolean);
begin
   if not Assigned(FIniFile) then 
   begin
      if FFixIniFile = ''then
         FIniFile := TIniFile.Create(GetIniFileName)
      else
         FIniFile := TIniFile.Create(FAppPath + FFixIniFile)
   end;   
   FIniFile.WriteBool(Section, Ident, Values);
end;

procedure TfmcBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   vChange: Boolean;
   xWinControl: TWinControl;
   xEditKind: Integer;
begin
   if ReadCanEdit then //編輯狀態
   begin
      if (Shift = []) then
      begin
         case Key of
         VK_F4: 
            begin
               xWinControl := nil;
               xEditKind := 0;
               //判斷是從cxCustomTextEdit長出來的物件
               if HasClass(ActiveControl, TcxCustomTextEdit) then
               begin
                  xWinControl := ActiveControl.Parent;
                  if TcxTextEdit(xWinControl).Properties.ReadOnly then
                  begin
                     Key := $0;
                     exit;
                  end;
                  xEditKind := 1;
               end
               //判斷是從CustomEdit長出來的物件
               else if (ActiveControl is TCustomEdit) then
               begin
                  xWinControl := ActiveControl;
                  xEditKind := 2;
               end;
               if Assigned(xWinControl) then
               begin
                  QueryPH(xWinControl, xEditKind);
                  Key := $0;
                  exit;
               end;
            end;
         VK_F3:
            begin
               //判斷是從TcxButtonEdit長出來的物件
               if HasClass(ActiveControl, TcxCustomButtonEdit) then
               begin
                  TcxButtonEdit(ActiveControl.Parent).Properties.OnButtonClick(ActiveControl.Parent, -1);
                  Key := $0;
                  exit;
               end;
            end;
         end;   
      end; 
   end;       
   if (Shift = []) then
   begin
      case Key of
         VK_RETURN:
         begin
            if not HasClass(ActiveControl, TcxCustomMemo) then
            begin   
               vChange := True;
               BeforeNextControl(TWinControl(ActiveControl), vChange);
               if vChange then
               begin
                  SelectNext(ActiveControl, True, True);
                  Key := $0;
                  exit;
               end;
            end;    
         end;
      end;
   end;
   Inherited;   
end;

procedure TfmcBase.BeforeNextControl(aActiveControl: TWinControl;
  var aChange: Boolean);
begin
   aChange := not (HasClass(aActiveControl, TcxCustomGrid));
end;

procedure TfmcBase.BeforePrjorControl(aActiveControl: TWinControl;
  var aChange: Boolean);
begin
   aChange := not (HasClass(aActiveControl, TcxCustomGrid));
end;

procedure TfmcBase.cSetFocus(aWinControl: TWinControl);
begin
   if not Showing then Exit;
   if aWinControl.CanFocus then
      aWinControl.SetFocus;
end;

procedure TfmcBase.Loaded;
begin
   inherited;
   InitializationValues;
   cxPropertiesStore.StorageName := FSysDataPath+Name+'.INI';
end;

procedure TfmcBase.DoDestroy;
begin
  inherited;
end;

procedure TfmcBase.ReSetINI;
begin
   if Assigned(FMemIniFile) then FMemIniFile.Free;
   if FFixIniFile = ''then
      FMemIniFile := TMemIniFile.Create(GetIniFileName)
   else
      FMemIniFile := TMemIniFile.Create(FAppPath + FFixIniFile)
end;

procedure TfmcBase.InitializationValues;
begin
   FCanCloseForm := True;
   FAppPath := GetAppPath;
   FSysDataPath := GetSysDataPath;
   FAutoFieldDisplayLabel := False;
   FFixIniFile := '';
end;

function TfmcBase.ReadCanEdit: Boolean;
begin
   Result := True;
end;
(*
procedure TfmcBase.WCRMRefresh(aDataSet: TAstaClientDataset);
var
   xB: TBookMark;
   xIsEnabledControls: Boolean;
begin
   if not Assigned(aDataSet) then exit;
   if not aDataSet.Active then exit;
   with aDataSet do
   begin
      xIsEnabledControls := not ControlsDisabled;
      if xIsEnabledControls then DisableControls;
      xB := GetBookmark;
      try
         ReFireSQL;
         if BookmarkValid(xB) then
            GotoBookmark(xB);
      finally
         FreeBookmark(xB);
         if xIsEnabledControls then
            EnableControls;
      end;
   end;
end;
*)
procedure TfmcBase.WCRMRefresh(aDataSet: TCustomADODataSet);
var
   xB: TBookMark;
   xIsEnabledControls: Boolean;
begin
   if not Assigned(aDataSet) then exit;
   if not aDataSet.Active then exit;
   with aDataSet do
   begin
      xIsEnabledControls := not ControlsDisabled;
      if xIsEnabledControls then DisableControls;
      xB := GetBookmark;
      try
         Requery([]);
         if BookmarkValid(xB) then
            GotoBookmark(xB);
      finally
         FreeBookmark(xB);
         if xIsEnabledControls then EnableControls;
      end;
   end;
end;

procedure TfmcBase.FormCreate(Sender: TObject);
var
  aMonitor: TMonitor;
begin
  // Added by Joe 2018/07/17 10:38:59
  // 針對雙螢幕顯示進行調整
  if (CallerApp <> nil) and (CallerApp.MainForm <> nil) then
  begin
    aMonitor := CallerApp.MainForm.Monitor;
    Self.Left := aMonitor.Left + (aMonitor.Width - Self.Width) div 2;
    Self.Top := (aMonitor.Height - Self.Height) div 2;
  end;
end;

end.
