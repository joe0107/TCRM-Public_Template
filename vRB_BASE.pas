{***************************************************************
 * 程式代號:  vRB_BASE(ReportBuilder 基底表單)
 * 版    本:  Delphi 7 & CRM
 * 建立日期:  2003/05/12
 * 修改歷程:
 ****************************************************************}
unit vRB_BASE;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppDB, ppDBPipe, Db, ppBands, ppCtrls, ppVar, ppPrnabl, ppClass, ppCache,
  ppComm, ppRelatv, ppProd, ppReport, ppRegion, dbtables, ExtCtrls, Printers,
  ppViewr, ppTypes, DLL_PUBLIC, IniFiles, ppEndUsr, Raide, Menus, FileCtrl,
  CallLibrary, DBISAMTb, ppDBJIT, DBClient, ShellAPI, vTemplate, dxmdaset;

type
  TSecurityType = (sctAppend, sctEdit, sctDelete, sctPrint, sctPreview, sctRun, sctExport, sctCount);
  TSimpleProc = procedure; stdcall;
  TNewRptTemplateID = function: PChar; stdcall;
  TfmvRBBase = class(TForm)
    dsMaster: TDataSource;
    ppDBPipeline1: TppDBPipeline;
    ppViewer1: TppViewer;
    ppDesigner1: TppDesigner;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    miLoadTemplate: TMenuItem;
    miSaveTemplate: TMenuItem;
    miSaveAsTemplate: TMenuItem;
    tbFieldMap: TDBISAMTable;
    ppJITPipeline2: TppJITPipeline;
    cdsMaster: TdxMemData;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miLoadTemplateClick(Sender: TObject);
    procedure miSaveTemplateClick(Sender: TObject);
    procedure miSaveAsTemplateClick(Sender: TObject);
  private
    FPrintCrossColor: Boolean;
    FDeltaMarginLeft, FDeltaMarginRight, FDeltaMarginTop, FDeltaMarginBottom: Integer;
    FDeltaMarginTopDetail, FDeltaMarginLeftDetail: Integer;
    FPrinterName, FExtraFilterSQL, FActivePaperName, FReportID, FGroupID, FUseTemplate: string;
    FExtraFilterParams: Variant;
    FActiveReport: TppReport;
    FvOwner: TForm;
    FRptCallbackFunc: TDllRptCallback;
    procedure OnCrossColorRegionPrint(Sender: TObject);
    procedure SetFDeltaMarginLeft(const Value: Integer);
    procedure SetFDeltaMarginRight(const Value: Integer);
    procedure SetFDeltaMarginTop(const Value: Integer);
    procedure SetFDeltaMarginBottom(const Value: Integer);
    procedure SetFDeltaMarginLeftDetail(const Value: Integer);
    procedure SetFDeltaMarginTopDetail(const Value: Integer);
    procedure SetFPrinterName(const Value: string);
    procedure SetExtraFilterSQL(const Value: string);
    procedure SetRptCallbackFunc(const Value: TDllRptCallback);
    procedure SetActiveReport(const Value: TppReport);
    procedure SetActivePaperName(const Value: string);
    procedure SetExtraFilterParams(const Value: Variant);
    procedure SetReportID(const Value: string);
    procedure SetGroupID(const Value: string);
    procedure SetvOwner(const Value: TForm);
    procedure SetUseTemplate(const Value: string);
    function GetDefaultTemplate: string;

  protected

    FTemplateChanged: Boolean;
    FDefaultTemplateStream, STemplateStream:TMemoryStream;
    FOrgMarginLeft, FOrgMarginRight, FOrgMarginTop, FOrgMarginBottom: Single;

    procedure TranslateFieldName(DBPipeLine: TppDBPipeLine); virtual;
    procedure TranslateFieldNames; virtual;
    procedure SetReport; virtual;
    procedure PickTemplate; virtual;
    procedure LoadTemplate(ID: string); virtual;
    procedure DisplayTemplateName(const Name: string); virtual;
    function SaveRptTemplate(_Name, _Remark: string): Boolean;
    function GetActiveTemplateManager: TfmTemplate;

  public
    FCallerType: Integer;  
    MM_PER_CHAR: Extended;
    procedure SetCrossColorRegion(Value: TppRegion; CrossColor: Boolean = True);
    procedure PrintOut(Viewer: TppViewer; ShowDialog: Boolean);
    procedure ZoomViewerSize(Viewer: TppViewer; ZoomPercentage: Integer);
    procedure PrintToFile(FileType, FileName: string);
    procedure PrintToWord(FileName: string);
    procedure PrintToExcel(FileName: string);
    procedure PrintToHTML(FileName: string);
    procedure PrintToText(FileName: string);
    procedure FindExportHtmlFiles(const MainFileName: string; HtmlFileList, ImgFileList: TStringList);
    procedure OpenExportFile(iFileType: Integer; sFileName: string);

    procedure SaveTemplate(AReport: TppCustomReport; NewTemplate: Boolean = False); virtual;
    procedure PrepareReportData(var Accept: Boolean); virtual;
    procedure PrintReport(const ShowDialog: Boolean; PrepareData:Boolean=true); virtual;
    function CopyCDSStruct(aDataSet: TDataSet; aCDS: TdxmemData = nil): Boolean;
    function CopyCDSData(aDataSet: TDataSet; aCDS: TdxmemData = nil): Boolean;
    function ReportDataIsEmpty: Boolean; virtual;
    function CheckReportCanRun: Boolean; virtual;

    property ReportID: string read FReportID write SetReportID;
    property GroupID: string read FGroupID write SetGroupID;
    property ActiveReport: TppReport read FActiveReport write SetActiveReport;
    property ActiveTemplateManager: TfmTemplate read GetActiveTemplateManager;
    property DefaultTemplate: string read GetDefaultTemplate;
    property ActivePaperName: string read FActivePaperName write SetActivePaperName;
    property RptCallbackFunc: TDllRptCallback read FRptCallbackFunc write SetRptCallbackFunc;
    property PrintCrossColor: Boolean read FPrintCrossColor write FPrintCrossColor;
    property DeltaMarginTop: Integer read FDeltaMarginTop write SetFDeltaMarginTop;
    property DeltaMarginBottom: Integer read FDeltaMarginBottom write SetFDeltaMarginBottom;
    property DeltaMarginLeft: Integer read FDeltaMarginLeft write SetFDeltaMarginLeft;
    property DeltaMarginRight: Integer read FDeltaMarginRight write SetFDeltaMarginRight;
    property DeltaMarginTopDetail: Integer read FDeltaMarginTopDetail write SetFDeltaMarginTopDetail;
    property DeltaMarginLeftDetail: Integer read FDeltaMarginLeftDetail write SetFDeltaMarginLeftDetail;
    property ExtraFilterSQL: string read FExtraFilterSQL write SetExtraFilterSQL;
    property ExtraFilterParams: Variant read FExtraFilterParams write SetExtraFilterParams;
    property Printer: string read FPrinterName write SetFPrinterName;
    property vOwner: TForm read fvOwner write SetvOwner;
    property UseTemplate: string read fUseTemplate write SetUseTemplate;
    class procedure CreateService(AOwner: TComponent); virtual;
  end;

const
  PAPER_NAME_A4_PORTRAIT = 'A4直印';
  PAPER_NAME_A4_LANDSCAPE = 'A4橫印';
  PAPER_NAME_80_PORTRAIT = '80';
  PAPER_NAME_132_PORTRAIT = '132';
  PAPER_NAME_OVER_PRINT = '套版';
  PAPER_NAME_CUSTOM = '自訂';

  {對應的NT，98報表紙名稱}
  PAPER_A4_9X = 'A4 210 x 297 mm';
  PAPER_A4_NT = 'A4';
  PAPER_LETTER_9X = 'Letter 8 1/2 x 11 in';
  PAPER_LETTER_NT = 'Letter';
  PAPER_OVER_PRINT_NT = 'Custom';
  PAPER_OVER_PRINT_9X = 'Custom';
  PAPER_CUSTOM_NT = 'Custom';
  PAPER_CUSTOM_9X = 'Custom';

  EFT_RTF = 0;
  EFT_EXCEL = 1;
  EFT_HTML = 2;
  EFT_TEXT = 3;

var
  fmvRBBase: TfmvRBBase;

implementation

uses
   DLL_COMMON, cUtility, vGetTemplateFile;

{$R *.DFM}

{ TfrmRBBase }
procedure TfmvRBBase.OnCrossColorRegionPrint(Sender: TObject);
const
   iRowNdx: Integer = 1;
begin
   if (not (Sender is TppRegion)) or (not PrintCrossColor) then Exit;
   with TppRegion(Sender) do
   begin
      if (Tag mod 2) = 1 then
         TppRegion(Sender).Brush.Color := $00E8E8E8
      else
         TppRegion(Sender).Brush.Color := clWhite;
      Tag := Tag + 1;
   end;
end;

procedure TfmvRBBase.FormCreate(Sender: TObject);
var
  sParamValue: string;
  aMonitor: TMonitor; // Added by Joe 2018/07/17 10:47:41
begin
  inherited;
  ppDesigner1.IniStorageName := ExtractFilePath(Application.ExeName) + 'RBDesigner.Ini';
  FDefaultTemplateStream := TMemoryStream.Create;
  ActiveReport := nil;
  vOwner := nil;
  FReportID := ''; FGroupID := '';
  FTemplateChanged := False;
  FUseTemplate := '';
  FExtraFilterSQL := '';
  Printer := 'Default';

  if PixelsPerInch = 96 then
    MM_PER_CHAR := 2.0585
  else
    MM_PER_CHAR := 2.0585 * 96 / 120;
  // Added by Joe 2018/07/17 10:38:59
  // 針對雙螢幕顯示進行調整
  if (CallerApp <> nil) and (CallerApp.MainForm <> nil) then
  begin
    aMonitor := CallerApp.MainForm.Monitor;
    Self.Left := aMonitor.Left + (aMonitor.Width - Self.Width) div 2;
    Self.Top := (aMonitor.Height - Self.Height) div 2;
  end;
end;

procedure TfmvRBBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caHide;
end;

procedure TfmvRBBase.FormDestroy(Sender: TObject);
var
   RepName:string;
begin
   FDefaultTemplateStream.Free; FDefaultTemplateStream := nil;
   STemplateStream.Free; STemplateStream := nil;
   Inherited;
end;

procedure TfmvRBBase.SetFDeltaMarginLeft(const Value: Integer);
begin
   if Value < 0 then Exit;
   FDeltaMarginLeft := Value;
end;

procedure TfmvRBBase.SetFDeltaMarginRight(const Value: Integer);
begin
   if Value < 0 then Exit;
   FDeltaMarginRight := Value;
end;

procedure TfmvRBBase.SetFDeltaMarginTop(const Value: Integer);
begin
   if Value < 0 then Exit;
   FDeltaMarginTop := Value;
end;

procedure TfmvRBBase.SetFDeltaMarginBottom(const Value: Integer);
begin
   if Value < 0 then Exit;
   FDeltaMarginBottom := Value;
end;

procedure TfmvRBBase.SetFDeltaMarginLeftDetail(const Value: Integer);
begin
   if Value < 0 then Exit;
   FDeltaMarginLeftDetail := Value;
end;

procedure TfmvRBBase.SetFDeltaMarginTopDetail(const Value: Integer);
begin
   if Value < 0 then Exit;
   FDeltaMarginTopDetail := Value;
end;

procedure TfmvRBBase.SetFPrinterName(const Value: string);
var
   i: Integer;
   TempPrinterName: string;
begin
   FPrinterName := Value;
   if (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) then //95-98
   begin
      TempPrinterName := FPrinterName;
      i := Pos(' on ', TempPrinterName);
      if i > 0 then TempPrinterName := Trim(Copy(TempPrinterName, 1, i - 1));
      i := LastDelimiter('\', TempPrinterName);
      if (i > 0) then TempPrinterName := Copy(TempPrinterName, i + 1, Length(TempPrinterName) - i);
      if Assigned(FActiveReport) then 
        ActiveReport.PrinterSetup.PrinterName := TempPrinterName;
   end
   else
      if Assigned(FActiveReport) then 
        ActiveReport.PrinterSetup.PrinterName := FPrinterName;
end;

procedure TfmvRBBase.PrintReport(const ShowDialog: Boolean; PrepareData:Boolean=true);
var
	bOrgShowPrintDialog, xAccept: Boolean;
  sOrgDeviceType: string;
begin
	if not CheckReportCanRun then Exit;
  	xAccept:= True;

  if PrepareData then
  	PrepareReportData(xAccept);

  if not xAccept then
  	Exit;

  if ReportDataIsEmpty then
  begin
    xShowMessage('沒有資料可以列印');
    Exit;
  end;

  SetReport;

	if Assigned(FActiveReport) then
  begin
  	with ActiveReport do
    begin
      sOrgDeviceType := DeviceType;
      DeviceType := 'Printer';
      bOrgShowPrintDialog := ShowPrintDialog;
      ShowPrintDialog := ShowDialog;
      Print;
      ShowPrintDialog := bOrgShowPrintDialog;
      DeviceType := sOrgDeviceType;
    end;
   end;
end;

procedure TfmvRBBase.SetExtraFilterSQL(const Value: string);
begin
   FExtraFilterSQL := Trim(Value);
end;

procedure TfmvRBBase.SetCrossColorRegion(Value: TppRegion; CrossColor: Boolean);
begin
   if Assigned(Value) and (Value is TppRegion) then
   begin
      if CrossColor then
      begin
         TppRegion(Value).OnPrint := OnCrossColorRegionPrint;
         TppRegion(Value).Tag := 0;
      end
      else
      begin
         TppRegion(Value).OnPrint := nil;
      end;
   end;
end;

procedure TfmvRBBase.SetRptCallbackFunc(const Value: TDllRptCallback);
begin
   FRptCallbackFunc := Value;
end;

function TfmvRBBase.CheckReportCanRun: Boolean;
begin
   Result := True;
end;

function TfmvRBBase.ReportDataIsEmpty: Boolean;
begin
   Result := False;
   {
   if Assigned(ActiveReport.DataPipeline) then
      if Assigned(TppDbPipeLine(ActiveReport.DataPipeline).DataSource) then
        if Assigned(TppDbPipeLine(ActiveReport.DataPipeline).DataSource.DataSet) then
           Result := TppDbPipeLine(ActiveReport.DataPipeline).DataSource.DataSet.IsEmpty;
   }        
end;

procedure TfmvRBBase.PrintOut(Viewer: TppViewer; ShowDialog: Boolean);
var
   OldDeviceType: string;
begin
   with Viewer do
   begin
      OldDeviceType := Report.DeviceType;
      Report.ShowPrintDialog := ShowDialog;
      Report.DeviceType := 'Printer';
      Print;
      Report.DeviceType := OldDeviceType;
   end;
end;

procedure TfmvRBBase.SetActiveReport(const Value: TppReport);
begin
   if not Assigned(Value) then
      FActiveReport := nil
   else
      FActiveReport := Value;
   ppViewer1.Report := FActiveReport;
   ppDesigner1.Report := FActiveReport;
   FDefaultTemplateStream.Clear;
   FOrgMarginLeft := 0;
   FOrgMarginRight := 0;
   FOrgMarginTop := 0;
   FOrgMarginBottom := 0;
   if Assigned(FActiveReport) then
   begin
      FActiveReport.Units := utMillimeters;
      FActiveReport.Language := lgCustom;
      FActiveReport.Template.SaveToStream(FDefaultTemplateStream);
      FOrgMarginLeft := ActiveReport.PrinterSetup.MarginLeft;
      FOrgMarginRight := ActiveReport.PrinterSetup.MarginRight;
      FOrgMarginTop := ActiveReport.PrinterSetup.MarginTop;
      FOrgMarginBottom := ActiveReport.PrinterSetup.MarginBottom;
   end;
end;

procedure TfmvRBBase.SetActivePaperName(const Value: string);
begin
   FActivePaperName := Value;
end;

procedure TfmvRBBase.SetReport;
begin

end;

procedure TfmvRBBase.ZoomViewerSize(Viewer: TppViewer; ZoomPercentage: Integer);
begin
   if (ZoomPercentage < 0) then
   begin
      case ZoomPercentage of
      -1: Viewer.ZoomSetting := zsPageWidth;
      -2: Viewer.ZoomSetting := zsWholePage;
      end;
   end
   else
      Viewer.ZoomPercentage := ZoomPercentage;
end;

class procedure TfmvRBBase.CreateService(AOwner: TComponent);
begin

end;

procedure TfmvRBBase.PickTemplate;
var
   OldTemplateID, NewTemplateID: string;
begin
   if Assigned(FActiveReport) then
   begin
      with FActiveReport do
      begin
         if Assigned(ActiveTemplateManager) then
         begin
            OldTemplateID := ActiveTemplateManager.GetTemplateID(Template.DatabaseSettings.Name);
            NewTemplateID := vTemplate.Execute(vOwner, FReportID, FGroupID, UseTemplate);
            if (Length(NewTemplateID) > 0) then 
               UseTemplate := NewTemplateID;
         end;
      end;
   end;
end;

procedure TfmvRBBase.LoadTemplate(ID: string);
var
   pTemplateName: PChar;
   temp:TMemoryStream;
begin
   if Assigned(ActiveTemplateManager) then
   begin
      ActiveTemplateManager.tbTemplate.filter:='';

      if not ActiveTemplateManager.tbTemplate.Active then ActiveTemplateManager.tbTemplate.open;
      if Assigned(FActiveReport) then
      begin
         with ActiveReport do
         begin
            Template.DatabaseSettings.DataPipeline:=ActiveTemplateManager.dbpTemplate;
            Template.DatabaseSettings.NameField:='TempName';
            Template.DatabaseSettings.TemplateField:='ReportFile';
            Template.DatabaseSettings.Name:=ID;
            Template.LoadFromDatabase;
            DeviceType := 'Screen';
            if Assigned(dsMaster.DataSet) then
              PrintToDevices;
         end;
         Caption := ActiveReport.PrinterSetup.DocumentName;
         UpDate;
         Application.ProcessMessages;
      end;
   end;
end;

procedure TfmvRBBase.miLoadTemplateClick(Sender: TObject);
begin
   PickTemplate;
end;

procedure TfmvRBBase.miSaveTemplateClick(Sender: TObject);
begin
   SaveTemplate(ActiveReport);
end;

procedure TfmvRBBase.SaveTemplate(AReport: TppCustomReport; NewTemplate: Boolean);
var
   _ID, _Name, _Remark: string;
begin
   if not Assigned(AReport) then exit;
   with AReport do
   begin
      try
         _Name:=Template.DatabaseSettings.Name;
         if not ActiveTemplateManager.tbTemplate.Locate('TempName',_Name,[]) then
            NewTemplate := True
         else
         begin
            if ActiveTemplateManager.tbTemplate.FieldByName('sysflag').asinteger =0 then
            begin
               NewTemplate:=true;
               _Name := ActiveTemplateManager.checkName(_Name);
            end
         end;
         if NewTemplate then
         begin
            if vGetTemplateFile.Execute(vOwner, _Name, False) then
            begin
               Update;
               Cursor := crHourGlass;
               if SaveRptTemplate(fmGetTemplateFile.RzEdit1.Text, fmGetTemplateFile.RzMemo1.Text) then
               begin
                  FTemplateChanged := True;
                  xShowMessage('報表範本存檔成功');
               end;
            end
            else
            begin
               Template.FileName := '';
            end;
         end
         else
         begin
            SaveRptTemplate(_Name, '');
            FTemplateChanged := True;
         end;
      finally
         Cursor := crDefault;
      end;
   end;
end;

procedure TfmvRBBase.miSaveAsTemplateClick(Sender: TObject);
begin
   SaveTemplate(ActiveReport, True);
end;

procedure TfmvRBBase.DisplayTemplateName(const Name: string);
begin

end;

procedure TfmvRBBase.SetExtraFilterParams(const Value: Variant);
begin
   FExtraFilterParams := Value;
end;

procedure TfmvRBBase.SetReportID(const Value: string);
begin
   FReportID := Value;
end;

procedure TfmvRBBase.TranslateFieldName(DBPipeLine: TppDBPipeLine);
var
   I: Integer;
   AppPath:string;
begin
   AppPath:= IncludeTrailingBackslash(ExtractFileDir(Application.ExeName));
   if not FileExists(AppPath+'CACHE\FIELD_MAP.DAT') then Exit;
   with tbFieldMap do
   begin
      if not Active then
      begin
         DataBaseName := AppPath + 'CACHE\';
         TableName := 'FIELD_MAP.DAT';
         Open;
      end
   end;
   with DBPipeLine do
   begin
      for i := 0 to FieldCount - 1 do
      begin
         if tbFieldMap.Locate('FIELD_NAME', Fields[i].FieldName, [loCaseInsensitive]) then
            Fields[i].FieldAlias := tbFieldMap.FieldByName('CAPTION').AsString;
      end;
   end;
end;

procedure TfmvRBBase.TranslateFieldNames;
var
   i: Integer;
begin
   for i := 0 to ComponentCount - 1 do
   begin
      if (Components[i] is TppDBPipeLine) or (Components[i] is TppJITPipeLine) then
         TranslateFieldName(TppDBPipeline(Components[i]));
   end;
end;

function TfmvRBBase.SaveRptTemplate(_Name, _Remark: string): Boolean;
begin
   if not Assigned(STemplateStream) then STemplateStream:=TMemoryStream.Create;
   STemplateStream.Clear;
   STemplateStream.Position := 0;
   ActiveReport.Template.SaveToStream(STemplateStream);
   with GetActiveTemplateManager.tbTemplate do
   begin
      if GetActiveTemplateManager.GetTemplateData(_Name)  then
      begin
         if fieldbyname('sysflag').asinteger =0 then
            Result := GetActiveTemplateManager.AddRptTemplate(_Name, _Remark, STemplateStream, 1)
         else
            Result := GetActiveTemplateManager.UpdateRptTemplate(_Name, STemplateStream);
      end
      else
         Result := GetActiveTemplateManager.AddRptTemplate(_Name, _Remark, STemplateStream, 1);
   end;
end;

procedure TfmvRBBase.SetGroupID(const Value: string);
begin
   FGroupID := Value;
end;

function TfmvRBBase.GetActiveTemplateManager: TfmTemplate;
begin
   Result := nil;
   if not Assigned(vOwner) then exit;
   if FReportID = '' then exit;
   if FGroupID = '' then exit;
   Result := vTemplate.GetTemplateManager(vOWner, FReportID, FGroupID);
end;

procedure TfmvRBBase.SetvOwner(const Value: TForm);
begin
   fvOwner := Value;
end;

procedure TfmvRBBase.SetUseTemplate(const Value: string);
var
   OldTemplate: string;
begin
   OldTemplate := fUseTemplate;
   fUseTemplate := Value;
   if Assigned(ActiveReport) then
   begin
      with ActiveReport do
      begin
         if Value = '' then
         begin
            Template.FileName := '';
            FDefaultTemplateStream.Position := 0;
            Template.LoadFromStream(FDefaultTemplateStream);
         end
         else
         begin
            try
               LoadTemplate(Value);
            except
               if OldTemplate <> fUseTemplate then
                  UseTemplate := OldTemplate;
            end;
         end;
      end;
      DisplayTemplateName(Value);
   end;
end;

function TfmvRBBase.GetDefaultTemplate: string;
begin
   Result := vTemplate.GetDefault(vOwner, fReportID, fGroupID);
end;

procedure TfmvRBBase.PrepareReportData(var Accept: Boolean);
begin
end;

procedure TfmvRBBase.PrintToFile(FileType, FileName: string);
var
   sOrgDeviceType, sOrgFileName: string;
   bOrgShowPrintDialog: Boolean;
   bOrgAllowPrintToFile: Boolean;
begin
   with ppViewer1.Report do
   begin
      sOrgDeviceType := DeviceType;
      sOrgFileName := TextFileName;
      bOrgShowPrintDialog := ShowPrintDialog;
      bOrgAllowPrintToFile := AllowPrintToFile;
      DeviceType := FileType;
      TextFileName := FileName;
      ShowPrintDialog := False;
      Print;
      DeviceType := sOrgDeviceType;
      TextFileName := sOrgFileName;
      ShowPrintDialog := bOrgShowPrintDialog;
      AllowPrintToFile := bOrgAllowPrintToFile;
   end;
end;

procedure TfmvRBBase.PrintToExcel(FileName: string);
begin
   PrintToFile('ExcelFile', FileName);
end;

procedure TfmvRBBase.PrintToHTML(FileName: string);
begin
   PrintToFile('HTMLLayerFile', FileName);
end;

procedure TfmvRBBase.PrintToText(FileName: string);
begin
   PrintToFile('ReportTextFile', FileName);
end;

procedure TfmvRBBase.PrintToWord(FileName: string);
begin
   PrintToFile('RTFFile', FileName);
end;

procedure TfmvRBBase.FindExportHtmlFiles(const MainFileName: string; HtmlFileList, ImgFileList: TStringList);
var
   sDir, sFileName, sExt, sTempFileName: string;
   i, iCreateTime: Integer;
begin
   sDir := ExtractFileDir(MainFileName);
   sExt := ExtractFileExt(MainFileName);
   sFileName := Copy(MainFileName, 1, Length(MainFileName) - Length(sExt));
   sTempFileName := sFileName + '0001' + sExt;
   iCreateTime := FileAge(sTempFileName);
   if Assigned(HtmlFileList) then
   begin
      HtmlFileList.Clear;
      for i := 1 to 9999 do
      begin
         sTempFileName := IntToStr(i);
         sTempFileName := sFileName +
         StringOfChar('0', 4 - Length(sTempFileName)) + sTempFileName + sExt;
         if (FileAge(sTempFileName) >= iCreateTime) then
            HtmlFileList.Add(sTempFileName)
         else
            break;
      end;
   end;
   if Assigned(ImgFileList) then
   begin
      ImgFileList.Clear;
      for i := 0 to 9999 do
      begin
         sTempFileName := IntToStr(i);
         sTempFileName := sDir + '\Img' + StringOfChar('0', 4 - Length(sTempFileName)) + sTempFileName + '.jpg';
         if (iCreateTime <= FileAge(sTempFileName)) then
            ImgFileList.Add(sTempFileName)
         else
            break;
      end;
   end;
end;

procedure TfmvRBBase.OpenExportFile(iFileType: Integer; sFileName: string);
var
   sExt: string;
begin
   if iFileType = EFT_HTML then
   begin
      sExt := ExtractFileExt(sFileName);
      sFileName := Copy(sFileName, 1, Length(sFileName) - Length(sExt));
      sFileName := sFileName + '0001' + sExt;
   end;
   ShellExecute(Handle, 'open', PChar(sFileName), '', '', SW_SHOWMAXIMIZED);
end;

function TfmvRBBase.CopyCDSStruct(aDataSet: TDataSet; aCDS: TdxmemData = nil): Boolean;
var
  K: Integer;
  xField: TField;
begin
  if not Assigned(aCDS) then
    aCDS := cdsMaster;

  with aCDS do
  begin
    if Active then Active := False;
    FieldDefs.Clear;

    for K := 0 to aDataSet.FieldCount - 1 do
    begin
      xField := aDataSet.Fields[K];
      FieldDefs.Add(xField.FieldName, xField.DataType, xField.Size, xField.Required);
    end;
    //CreateDataSet;
  end;
end;

function TfmvRBBase.CopyCDSData(aDataSet: TDataSet; aCDS: TdxmemData): Boolean;
var
  K: Integer;
  xField: TField;
begin
  if not Assigned(aCDS) then
    aCDS := cdsMaster;
  with aDataSet do
  begin
    if not aCDS.Active then aCDS.Active := True;
    First;
    While not Eof do
    begin
      aCDS.Append;
      for K := 0 to aCDS.FieldCount - 1 do
      begin
        xField := aCDS.Fields[K];
        case xField.DataType of
        ftString:
           aCDS[xField.FieldName] := FieldByName(xField.FieldName).AsString;
        ftInteger:
           aCDS[xField.FieldName] := FieldByName(xField.FieldName).AsInteger;
        ftDate:
           aCDS[xField.FieldName] := FieldByName(xField.FieldName).AsDateTime;
        end;
      end;
      aCDS.Post;
      Next;
      Application.ProcessMessages;
    end;
  end;
end;

end.

