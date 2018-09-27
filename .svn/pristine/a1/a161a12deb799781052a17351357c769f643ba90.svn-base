unit vTemplate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Buttons, RzButton, ExtCtrls, ppDB,
  RzPanel, DBISAMTb, ppComm, ppRelatv, ppDBPipe, StdCtrls, RzDBEdit, IniFiles, DB, Grids, DBGrids, RzDBGrid, StrUtils,
  DBCtrls;

type
  TfmTemplate = class(TForm)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    btnSelect: TRzToolbarButton;
    btnCancel: TRzToolbarButton;
    btnLoad: TRzToolbarButton;
    btnDelete: TRzToolbarButton;
    tbTemplate: TDBISAMTable;
    dsTemplate: TDataSource;
    tbTemplateTempName: TStringField;
    tbTemplateReportID: TStringField;
    tbTemplateGroupID: TStringField;
    tbTemplateTempMark: TStringField;
    tbTemplateReportFile: TBlobField;
    tbTemplateSysFlag: TIntegerField;
    tbTemplateBaseMap: TIntegerField;
    tbTemplateDefaultReport: TBooleanField;
    btnSetDefault: TRzToolbarButton;
    dbpTemplate: TppDBPipeline;
    cxDBMemo1: TRzDBMemo;
    tbTemplateTempDefault: TBooleanField;
    RzDBGrid1: TRzDBGrid;
    tbTemplateDefaultReport_V: TStringField;
    procedure btnSelectClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnSetDefaultClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxGrid1DBTableView1DblClick(Sender: TObject);
    procedure tbTemplateCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    vOwner: TForm;
    FIniFile: TIniFile;
    fGroupID, fReportID, fTemplateTableName: string;
    procedure CreateTemplateData;
    procedure SetGroupID(const Value: string);
    procedure SetReportID(const Value: string);
    procedure ClearDefaultReport;
    procedure ReSetDefault;
    function CheckDefaultReport: Boolean;
    function GetDefaultReport: string;
    function GetINIDefaultReport: string;
    function GetTableDefaultReport: string;
  public
    { Public declarations }
    function CheckName(AName: string): string;
    procedure GetTempName(var AName: string);
    function GetTemplateData(const _ID: string): Boolean;
    function AddRptTemplate(AName, AFileName, ARemark: string;
                            ASysFlag: integer = 0; ADefault: Boolean=False): Boolean; overload;
    function AddRptTemplate(AName, ARemark: string; ATemplateStream:TMemoryStream;
                            ASysFlag: integer = 0; ADefault: Boolean=False): Boolean; overload;
    function UpdateRptTemplate(AName: string; ATemplateStream:TMemoryStream): Boolean;
    function GetDataFileName(const _ID: string): string;
    function  GetTemplateID(const TemplateFileName: string): string;
    property ReportID: string read fReportID write SetReportID;
    property GroupID: string read fGroupID write SetGroupID;
  end;

  function Execute(AOwner: TComponent; AReportID, AGroupID: string; ATemplate: string=''): string;
  function GetDefault(AOwner: TComponent; AReportID, AGroupID: string): string;
  function GetTemplateManager(AOwner: TComponent; AReportID, AGroupID: string): TfmTemplate;

var
  fmTemplate: TfmTemplate;

implementation

uses vGetTemplateFile, cDLL_Base100, cDLL_Base210, cUtility, cController;

{$R *.dfm}
function Execute(AOwner: TComponent; AReportID, AGroupID: string; ATemplate: string=''): string;
begin
   Result := ATemplate;
   if AOwner is TfmcDLL_Base210 then
   begin
      if not Assigned(TfmcDLL_Base210(AOwner).FTemplate) then
         TfmcDLL_Base210(AOwner).FTemplate := TfmTemplate.Create(AOwner);
      with TfmcDLL_Base210(AOwner).FTemplate do
      begin
         vOwner := TForm(AOWner);
         ReportID := AReportID;
         GroupID := AGroupID;
         tbTemplate.Filtered := False;
         tbTemplate.Filter := 'ReportID = '''+ReportID+''' And GroupID = '''+ GroupID + '''';
         tbTemplate.Filtered := True;
         if ATemplate > '' then tbTemplate.Locate('TempName', ATemplate, []);
         if ShowModal = mrOK then
            Result := tbTemplate.FieldByName('TempName').AsString;
         TfmcDLL_Base210(AOwner).DefaultTemplate := GetDefaultReport;
         if tbTemplate.IsEmpty then Result := '';
      end;
   end
   else
   begin
      if AOwner is TfmcDLL_Base100 then
      begin
         if not Assigned(TfmcDLL_Base100(AOwner).FTemplate) then
            TfmcDLL_Base100(AOwner).FTemplate := TfmTemplate.Create(AOwner);
         with TfmcDLL_Base100(AOwner).FTemplate do
         begin
            vOwner := TForm(AOWner);
            ReportID := AReportID;
            GroupID := AGroupID;
            tbTemplate.Filtered := False;
            tbTemplate.Filter := 'ReportID = '''+ReportID+''' And GroupID = '''+ GroupID + '''';
            tbTemplate.Filtered := True;
            if ATemplate > '' then tbTemplate.Locate('TempName', ATemplate, []);
            if ShowModal = mrOK then
               Result := tbTemplate.FieldByName('TempName').AsString;
            TfmcDLL_Base100(AOwner).DefaultTemplate := GetDefaultReport;
            if tbTemplate.IsEmpty then Result := '';
         end;
      end
      else
      begin
         if not Assigned(fmTemplate) then
            fmTemplate := TfmTemplate.Create(AOwner);
         with fmTemplate do
         begin
            ReportID := AReportID;
            GroupID := AGroupID;
            tbTemplate.Filtered := False;
            tbTemplate.Filter := 'ReportID = '''+ReportID+''' And GroupID = '''+ GroupID + '''';
            tbTemplate.Filtered := True;
            if ATemplate > '' then tbTemplate.Locate('TempName', ATemplate, []);
            if ShowModal = mrOK then Result := tbTemplate.FieldByName('TempName').AsString;
            if tbTemplate.IsEmpty then Result := '';
         end;
      end;
   end;
end;

function GetDefault(AOwner: TComponent; AReportID, AGroupID: string): string;
begin
   Result := '';
   if AOwner is TfmcDLL_Base210 then
   begin
      if not Assigned(TfmcDLL_Base210(AOwner).FTemplate) then
         TfmcDLL_Base210(AOwner).FTemplate := TfmTemplate.Create(AOwner);
      with TfmcDLL_Base210(AOwner).FTemplate do
      begin
         vOWner := TForm(AOWner);
         ReportID := AReportID;
         GroupID := AGroupID;
         tbTemplate.Filtered := False;
         tbTemplate.Filter := 'ReportID = '''+ReportID+''' And GroupID = '''+ GroupID + '''';
         tbTemplate.Filtered := True;
         Result := GetDefaultReport;
      end;
   end
   else
   begin
      if AOwner is TfmcDLL_Base100 then
      begin
         if not Assigned(TfmcDLL_Base100(AOwner).FTemplate) then
            TfmcDLL_Base100(AOwner).FTemplate := TfmTemplate.Create(AOwner);
         with TfmcDLL_Base100(AOwner).FTemplate do
         begin
            vOWner := TForm(AOWner);
            ReportID := AReportID;
            GroupID := AGroupID;
            tbTemplate.Filtered := False;
            tbTemplate.Filter := 'ReportID = '''+ReportID+''' And GroupID = '''+ GroupID + '''';
            tbTemplate.Filtered := True;
            Result := GetDefaultReport;
         end;
      end
      else
      begin
      end;
   end;
end;

function GetTemplateManager(AOwner: TComponent; AReportID, AGroupID: string): TfmTemplate;
begin
   Result := nil;
   if AOwner is TfmcDLL_Base210 then
   begin
      if not Assigned(TfmcDLL_Base210(AOwner).FTemplate) then
         TfmcDLL_Base210(AOwner).FTemplate := TfmTemplate.Create(AOwner);
      with TfmcDLL_Base210(AOwner).FTemplate do
      begin
         vOWner := TForm(AOWner);
         ReportID := AReportID;
         GroupID := AGroupID;
         tbTemplate.Filtered := False;
         tbTemplate.Filter := 'ReportID = '''+ReportID+''' And GroupID = '''+ GroupID + '''';
         tbTemplate.Filtered := True;
      end;
      Result := TfmcDLL_Base210(AOwner).FTemplate;
   end
   else
   begin
      if AOwner is TfmcDLL_Base100 then
      begin
         if not Assigned(TfmcDLL_Base100(AOwner).FTemplate) then
            TfmcDLL_Base100(AOwner).FTemplate := TfmTemplate.Create(AOwner);
         with TfmcDLL_Base100(AOwner).FTemplate do
         begin
            vOWner := TForm(AOWner);
            ReportID := AReportID;
            GroupID := AGroupID;
            tbTemplate.Filtered := False;
            tbTemplate.Filter := 'ReportID = '''+ReportID+''' And GroupID = '''+ GroupID + '''';
            tbTemplate.Filtered := True;
         end;
         Result := TfmcDLL_Base100(AOwner).FTemplate;
      end
      else
      begin
         if not Assigned(fmTemplate) then
         fmTemplate := TfmTemplate.Create(AOwner);
         with fmTemplate do
         begin
            ReportID := AReportID;
            GroupID := AGroupID;
            tbTemplate.Filtered := False;
            tbTemplate.Filter := 'ReportID = '''+ReportID+''' And GroupID = '''+ GroupID + '''';
            tbTemplate.Filtered := True;
         end;
         Result := fmTemplate;
      end;         
   end;
end;

procedure TfmTemplate.btnSelectClick(Sender: TObject);
begin
   ModalResult := mrOK;
end;

procedure TfmTemplate.btnCancelClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TfmTemplate.FormCreate(Sender: TObject);
begin
   fTemplateTableName := 'TemplateMan';
   CreateTemplateData;
end;

procedure TfmTemplate.CreateTemplateData;
var
   xIniFile : TIniFile;
begin
   xIniFile := TIniFile.Create(GetIniFileName);
   with tbTemplate do
   begin
      if Active then Close;
      DataBaseName := IncludeTrailingBackslash(xIniFile.ReadString('SERVER_INFO', 'TEMPLATE_PATH', GetAppPath + 'Template'));
      TableName := fTemplateTableName;
      if not FileExists(DataBaseName + TableName + '.Dat') then
      begin
         FieldDefs.clear;
         FieldDefs.Add('TempName', ftString, 60, True);   //範本名稱
         FieldDefs.Add('ReportID', ftString, 20, True);   //所屬報表
         FieldDefs.Add('GroupID', ftString, 10, True);    //所屬報表的Group
         FieldDefs.Add('TempMark', ftString, 60, False);  //報表說明
         FieldDefs.Add('ReportFile', ftBLOB, 0, False);   //報表檔內容
         FieldDefs.Add('SysFlag', ftInteger, 0, False);   //系統報表註記
         FieldDefs.Add('BaseMap', ftInteger, 0, False);   //底圖註記
         FieldDefs.Add('DefaultReport', ftBoolean, 0, False);  //內定範本
         IndexDefs.Clear;
         IndexDefs.Add('Temp_PRIM', 'TempName', [ixPrimary]);
         IndexDefs.Add('Temp_KEY1', 'ReportID;GroupID;TempName', []);
         CreateTable;
      end;
      Open;
   end;
end;

procedure TfmTemplate.SetGroupID(const Value: string);
begin
   fGroupID := Value;
end;

procedure TfmTemplate.SetReportID(const Value: string);
begin
  fReportID := Value;
end;

procedure TfmTemplate.btnLoadClick(Sender: TObject);
   function GetInvialdTemp: boolean;
   begin
      Result := False;
      if not FileExists(fmGetTemplateFile.RzButtonEdit1.Text) then Exit;
      if fmGetTemplateFile.RzEdit1.Text = '' then Exit;
      Result := True;
   end;
begin
   if vGetTemplateFile.Execute(Self) then
   begin
      if GetInvialdTemp then
      begin
         if fmGetTemplateFile.RzCheckBox1.Checked then
            ClearDefaultReport;
         AddRptTemplate(fmGetTemplateFile.RzEdit1.Text, fmGetTemplateFile.RzButtonEdit1.Text,
                        fmGetTemplateFile.RzMemo1.Text, 0, fmGetTemplateFile.RzCheckBox1.Checked);
      end;
   end;
end;

procedure TfmTemplate.btnSetDefaultClick(Sender: TObject);
begin
  if (FReportID = '') or (FGroupID = '') then exit;
  if not Assigned(FIniFile) then
    FIniFile := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\DefaultReport.INI');
  FIniFile.WriteString(FReportID, FGroupID, tbTemplate.FieldByName('TempName').AsString);
  tbTemplate.Refresh;
   {
   ClearDefaultReport;
   tbTemplate.Edit;
   tbTemplate['DefaultReport'] := True;
   tbTemplate.Post;
   }
end;

procedure TfmTemplate.ClearDefaultReport;
var
  xB: TBookMark;
begin
  (*
  tbTempLate.DisableControls;
  xB := tbTempLate.GetBookmark;
  try
    with xQuery1 do
    begin
       if Active then Close;
       SQL.Clear;
       SQL.Add('UpDate tbTemplate Set DefaultReport = False where ReportID = :ReportID and GroupID = :GroupID ');
       Params.ParamValues['ReportID'] := fReportID;
       Params.ParamValues['GroupID'] := fGroupID;
       ExecSQL;
       if tbTempLate.BookmarkValid(xB) then
         tbTempLate.GotoBookmark(xB);
    end;
  finally
    tbTempLate.FreeBookmark(xB);
    tbTempLate.EnableControls;
  end;
  *)
end;

procedure TfmTemplate.btnDeleteClick(Sender: TObject);
var
   vDelDefault: Boolean;
   S: string;
begin
   vDelDefault := tbTemplate.FieldByName('DefaultReport').AsBoolean;
   if vDelDefault then
      S := '您確定要刪除預設範本嗎?如果刪除,系統會重新指定預設範本'
   else
      S := '您確定要將此範本刪除嗎?';
   if xMsgConfirmation(S) = mrYes then
   begin
      tbTemplate.Delete;
      ReSetDefault;
   end;
end;

procedure TfmTemplate.ReSetDefault;
var
  xB: TBookMark;
begin
  if tbTemplate.IsEmpty then exit;
  tbTempLate.DisableControls;
  xB := tbTempLate.GetBookmark;
  try
     tbTemplate.First;
     tbTemplate.Edit;
     tbTemplate['DefaultReport'] := True;
     tbTemplate.Post;
     if tbTempLate.BookmarkValid(xB) then
       tbTempLate.GotoBookmark(xB);
  finally
    tbTempLate.FreeBookmark(xB);
    tbTempLate.EnableControls;
  end;
end;

function TfmTemplate.CheckDefaultReport: Boolean;
var
  xDefaultReport: String;
begin
  xDefaultReport := '';
  if not ((FReportID = '') or (FGroupID = '')) then
  begin
    if not Assigned(FIniFile) then
      FIniFile := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\DefaultReport.INI');
    xDefaultReport := FIniFile.ReadString(FReportID, FGroupID, '');
  end;  
  if xDefaultReport = '' then  xDefaultReport := GetTableDefaultReport;
  Result := (xDefaultReport > '');
end;

{var
  xB: TBookMark;
begin
  Result := False;
  tbTempLate.DisableControls;
  xB := tbTempLate.GetBookmark;
   try
      with xQuery1 do
      begin
         if Active then Close;
         SQL.Clear;
         SQL.Add('Select TempName From tbTemplate where ReportID = :ReportID and GroupID = :GroupID and DefaultReport ');
         Params.ParamValues['ReportID'] := fReportID;
         Params.ParamValues['GroupID'] := fGroupID;
         Open;
         Result := not IsEmpty;
         Close;
      end;
      if tbTempLate.BookmarkValid(xB) then
         tbTempLate.GotoBookmark(xB);
  finally
    tbTempLate.FreeBookmark(xB);
    tbTempLate.EnableControls;
  end;
end;
}

function TfmTemplate.GetDefaultReport: string;
begin
  Result := GetINIDefaultReport;
  if Result = '' then Result := GetTableDefaultReport;
end;

function TfmTemplate.GetINIDefaultReport: string;
begin
  Result := '';
  if (FReportID = '') or (FGroupID = '') then exit;
  if not Assigned(FIniFile) then
    FIniFile := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\DefaultReport.INI');
  Result := FIniFile.ReadString(FReportID, FGroupID, '');
end;

function TfmTemplate.GetTableDefaultReport: string;
var
  xB: TBookMark;
begin
  (*
  Result := '';
  tbTempLate.DisableControls;
  xB := tbTempLate.GetBookmark;
  try
    with xQuery1 do
    begin
      if Active then Close;
      SQL.Clear;
      SQL.Add('Select TempName From tbTemplate where ReportID = :ReportID and GroupID = :GroupID and DefaultReport ');
      Params.ParamValues['ReportID'] := fReportID;
      Params.ParamValues['GroupID'] := fGroupID;
      Open;
      First;
      if not Eof then Result := FieldByName('TempName').AsString;
    end;
    if tbTempLate.BookmarkValid(xB) then
      tbTempLate.GotoBookmark(xB);
  finally
    tbTempLate.FreeBookmark(xB);
    tbTempLate.EnableControls;
  end;
  *)
end;


procedure TfmTemplate.FormDestroy(Sender: TObject);
begin
   if Assigned(FIniFile) then
     FIniFile.Free;
   if vOwner is TfmcDLL_Base210 then
   begin
     TfmcDLL_Base210(vOwner).FTemplate := nil;
   end
   else
   begin
     if Assigned(fmTemplate) then
       fmTemplate := nil;
   end;
   Inherited;
end;

function TfmTemplate.CheckName(AName: string): string;
var
   RecName, OldFilter, OldName: string;
begin
   RecName := AName;
   with tbTemplate do
   begin
      DisableControls;
      OldFilter :=  Filter;
      OldName := FieldByName('TempName').AsString;
      if Locate('TempName', AName, []) then
      begin
         try
            Filter := 'TempName = ' + QuotedStr(AName + '*' );
            Open;
            if not Eof then RecName:= AName+ IntToStr(RecordCount);
         finally
            Filter := OldFilter;
            Open;
            Locate('TempName', OldName, []);
         end;
      end;
      Result := RecName;
   end;
end;

procedure TfmTemplate.GetTempName(var AName: string);
var
   iPos: Integer;
begin
   iPos := Pos('.', AName);
   if iPos>0 then AName := Copy(AName, 1, iPos-1);
end;

function TfmTemplate.AddRptTemplate(AName, AFileName, ARemark: string;
                                    ASysFlag: integer = 0; ADefault: Boolean=False): Boolean;
begin
   Result := False;
   if tbTemplate.Locate('TempName', AName, []) then
   begin
     xMsgError('這個範本名稱重複,無法存檔');
     exit;
   end;
   try
      tbTemplate.Append;
      tbTemplate['TempName'] :=  AName;
      tbTemplate['ReportID'] :=  fReportID;
      tbTemplate['GroupID'] :=  fGroupID;
      tbTemplate['TempMark'] :=  AReMark;
      tbTemplate['SysFlag'] :=  ASysFlag;
      tbTemplate['BaseMap'] :=  0;
      tbTemplate['DefaultReport'] := ADefault;
      tbTemplateReportFile.LoadFromFile(AFileName);
      tbTemplate.post;
      if not CheckDefaultReport then ReSetDefault;
      Result := True;
   except
      Exit;
   end;
end;

function TfmTemplate.AddRptTemplate(AName, ARemark: string; ATemplateStream: TMemoryStream;
                                    ASysFlag: integer; ADefault: Boolean): Boolean;
begin
   Result := False;
   if tbTemplate.Locate('TempName', AName, []) then
   begin
     xMsgError('這個範本名稱重複,無法存檔');
     exit;
   end;
   try
      tbTemplate.Append;
      tbTemplate['TempName'] :=  AName;
      tbTemplate['ReportID'] :=  fReportID;
      tbTemplate['GroupID'] :=  fGroupID;
      tbTemplate['TempMark'] :=  AReMark;
      tbTemplate['SysFlag'] :=  ASysFlag;
      tbTemplate['BaseMap'] :=  0;
      tbTemplate['DefaultReport'] := ADefault;
      tbTemplateReportFile.LoadFromStream(ATemplateStream);
      tbTemplate.post;
      Result := True;
   except
      Exit;
   end;
   if not CheckDefaultReport then ReSetDefault;
end;

function TfmTemplate.UpdateRptTemplate(AName: string; ATemplateStream: TMemoryStream): Boolean;
begin
   Result := False;
   with tbTemplate do
   begin
      if not Active then Exit;
      if not Locate('TempName', AName, []) then Exit;
      Edit;
      tbTemplateReportFile.LoadFromStream(ATemplateStream);
      Post;
   end;
   Result := True;
end;

function TfmTemplate.GetTemplateData(const _ID: string): Boolean;
begin
   Result := False;
   if not Assigned(tbTemplate) then exit;
   with tbTemplate do
   begin
      if Active then Close;
      filter:='TempName=' + QuotedStr(_ID);
      Open;
      Result := not IsEmpty;
   end;
end;

function TfmTemplate.GetDataFileName(const _ID: string): string;
begin
   Result := IncludeTrailingBackslash(GetSysTempPath) + _ID;
end;

function TfmTemplate.GetTemplateID(const TemplateFileName: string): string;
begin
  if Length(TemplateFileName) > 0 then
    Result := Trim(ExtractFileName(TemplateFileName))
  else
    Result := '';
end;

procedure TfmTemplate.cxGrid1DBTableView1DblClick(Sender: TObject);
begin
   btnSelect.Click;
end;

procedure TfmTemplate.tbTemplateCalcFields(DataSet: TDataSet);

  function GetTempDefault(aTempName:String; aDefault: Boolean): Boolean;
  var
    xDefault: String;
  begin
    xDefault := GetINIDefaultReport;
    if xDefault = '' then
      Result := aDefault
    else
      Result := (aTempName = xDefault);
  end;

begin
  with DataSet do
  begin
    DataSet['TempDefault'] := GetTempDefault(FieldByName('TempName').AsString, FieldByName('DefaultReport').AsBoolean);
    DataSet['DefaultReport_V'] := IfThen(FieldByName('DefaultReport').AsBoolean, 'V', '');
  end;
end;

end.
