unit vRB_REPORT;

interface

uses
  Windows, Messages, SysUtils, Classes, Variants, Graphics, Controls, Forms, Dialogs, Db, DBClient, ppDBPipe, ppDBJIT,
  ppDB, ppRelatv, ppProd, ppReport, ExtCtrls, ppViewr, StdCtrls, RzStatus, RzEdit, RzCmboBx, RzPanel, Buttons, RzButton,
  DBISAMTb, RzCommon, RzSndMsg, Menus, ppEndUsr, RzPrgres, DbTables, dxmdaset, vRB_BASE, ppComm, Mask;
  
type
  TfmvRBReport = class(TfmvRBBase)
    RzStatusBar1: TRzStatusBar;
    RzStatusPanel: TRzStatusPane;
    RzStatusPane1: TRzStatusPane;
    RzSendMessage1: TRzSendMessage;
    RzFrameController1: TRzFrameController;
    RzStatusPanel3: TRzStatusPane;
    RzPanel1: TRzPanel;
    btnPrint: TRzToolbarButton;
    btnPrintNow: TRzToolbarButton;
    btnFirst: TRzToolbarButton;
    btnPrior: TRzToolbarButton;
    btnNext: TRzToolbarButton;
    BtnLast: TRzToolbarButton;
    btnExport: TRzToolbarButton;
    btnTemplateDesign: TRzToolbarButton;
    btnTemplateLoad: TRzToolbarButton;
    RzToolbarButton1: TRzToolbarButton;
    btnGoto: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    mskPreviewPage: TRzMaskEdit;
    RzPanel9: TPanel;
    ComboBox1: TRzComboBox;
    RzToolbarButton2: TRzToolbarButton;
    plShowMessage: TRzPanel;
    procedure mskPreviewPageKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ppViewer1PageChange(Sender: TObject);
    procedure ppViewer1PrintStateChange(Sender: TObject);
    procedure ppViewer1StatusChange(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrintNowClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
    procedure BtnLastClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnTemplateLoadClick(Sender: TObject);
    procedure btnTemplateDesignClick(Sender: TObject);
    procedure RzToolbarButton1Click(Sender: TObject);

  private
    FCanDesignReport: Boolean;
    procedure SetCanDesignReport(const Value: Boolean);

  protected
    procedure DisplayTemplateName(const Name: string); override;
    property CanDesignReport: Boolean read FCanDesignReport write SetCanDesignReport;

  public
    procedure InitReportPreview;
    procedure PreviewReport(ModalReport: Boolean = True; ResetReport: Boolean = True); virtual;
    procedure RefreshReport; virtual;
    procedure EmailExportFile(iFileType: Integer; sSubject, sFileName: string);
  end;

const
  TEMP_DISP_FMT = '使用範本: %s';

var
  fmvRBReport: TfmvRBReport;

implementation

uses DLL_COMMON, DLL_Public, cUtility, vPrintToFileDlg, vMakeUpPrintPage, vTemplate;

{$R *.DFM}

procedure TfmvRBReport.mskPreviewPageKeyPress(Sender: TObject; var Key: Char);
var
   liPage: Longint;
begin
   inherited;
   if (Key = #13) then
   begin
      if Assigned(ppViewer1) then
      begin
         liPage := StrToIntDef(Trim(mskPreviewPage.Text), 0);
         if (liPage > 0) then ppViewer1.GotoPage(liPage);
      end;
      mskPreviewPage.SetFocus;
   end;
end;

procedure TfmvRBReport.EmailExportFile(iFileType: Integer; sSubject, sFileName: string);
var
   HtmlFileList, ImgFileList: TStringList;
   i: Integer;
begin
   with RzSendMessage1 do
   begin
      Subject := sSubject;
      Attachments.Clear;
      if iFileType = EFT_HTML then
      begin
         try
            HtmlFileList := TStringList.Create;
            ImgFileList := TStringList.Create;
            FindExportHtmlFiles(sFileName, HtmlFileList, ImgFileList);
            for i := 0 to HtmlFileList.Count - 1 do Attachments.Add(HtmlFileList[i]);
            for i := 0 to ImgFileList.Count - 1 do Attachments.Add(ImgFileList[i]);
         finally
            HtmlFileList.Free;
            ImgFileList.Free;
         end;
      end
      else
         Attachments.Add(sFileName);
      Send;
   end;
end;

procedure TfmvRBReport.ComboBox1Change(Sender: TObject);
var
   strZoomPercentage: string;
   iPercentage: Integer;
begin
   inherited;
   strZoomPercentage := ComboBox1.Items[ComboBox1.ItemIndex];
   if (strZoomPercentage = '頁寬') then
      ZoomViewerSize(ppViewer1, -1)
   else if (strZoomPercentage = '整頁') then
      ZoomViewerSize(ppViewer1, -2)
   else   
   begin
      iPercentage := StrToIntDef(Copy(strZoomPercentage, 1, Length(strZoomPercentage)- 1), 100);
      ZoomViewerSize(ppViewer1, iPercentage)
   end;
end;

procedure TfmvRBReport.FormCreate(Sender: TObject);
begin
   CanDesignReport := True;
   inherited;
   if Assigned(ActiveReport) then
      Caption := ActiveReport.PrinterSetup.DocumentName;
   InitReportPreview;
end;

procedure TfmvRBReport.FormDestroy(Sender: TObject);
begin
   inherited;
   if Assigned(fmvRBReport) then fmvRBReport := nil;
end;

procedure TfmvRBReport.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
   if (Shift = []) then
   begin
      case Key of
      VK_ESCAPE: Close;
      VK_HOME:
         begin
            btnFirstClick(btnFirst);
            Key := 0;
         end;
      VK_END:
         begin
            btnLastClick(btnLast);
            Key := 0;
         end;
      VK_PRIOR:
         begin
            btnPriorClick(btnPrior);
            Key := 0;
         end;
      VK_NEXT:
         begin
            btnNextClick(btnNext);
            Key := 0;
         end;
      VK_F7:
        begin
          btnTemplateDesignClick(btnTemplateDesign);
          Key := 0;
        end;
      VK_F8:
        begin
          btnTemplateLoadClick(btnTemplateLoad);
          Key := 0;
        end;
      VK_F9:
        begin
          btnExportClick(btnExport);
          Key := 0;
        end;
      VK_F12:
        begin
          btnPrintClick(btnPrint);
          Key := 0;
        end;
     end;
   end
   else if (Shift = [ssShift]) then
   begin
      case Key of
      VK_F12:
         begin
           btnPrintNowClick(btnPrintNow);
           Key := 0;
         end;
      end;
   end;
end;

procedure TfmvRBReport.ppViewer1PageChange(Sender: TObject);
begin
   inherited;
   with TppViewer(Sender) do
   begin
      mskPreviewPage.Text := IntToStr(AbsolutePageNo);
   end;
end;

procedure TfmvRBReport.ppViewer1PrintStateChange(Sender: TObject);
var
   lPosition: TPoint;
begin
   inherited;
   with TppViewer(Sender) do
   begin
      if Busy then
      begin
         mskPreviewPage.Enabled := False;
         Cursor := crHourGlass;
      end
      else
      begin
         mskPreviewPage.Enabled := True;
         Cursor := crDefault;
      end;
      GetCursorPos(lPosition);
      SetCursorPos(lPosition.X, lPosition.Y);
   end;
end;

procedure TfmvRBReport.ppViewer1StatusChange(Sender: TObject);
begin
   inherited;
   with TppViewer(Sender) do
      RzStatusPanel.Caption := Status;
end;

procedure TfmvRBReport.InitReportPreview;
begin
   ComboBox1.ItemIndex := ComboBox1.Items.IndexOf('頁寬');
   ZoomViewerSize(ppViewer1, -1);
end;

procedure TfmvRBReport.PreviewReport(ModalReport, ResetReport: Boolean);
var
   CurPageNo: Integer;
   xAccept: Boolean;
begin
   try
      Cursor := crHourGlass;
      if not CheckReportCanRun then Exit;
      SetForegroundWindow(Self.Handle);
      Update;
      xAccept := True;
      PrepareReportData(xAccept);
      if not xAccept then
        exit;
      if (not Assigned(dsMaster.DataSet)) or (ReportDataIsEmpty) then
      begin
        xShowMessage('沒有資料可以列印');
        Exit;
      end;
      SetReport;
      CurPageNo := ppViewer1.AbsolutePageNo;
      ActiveReport.Reset;
      ActiveReport.DeviceType := 'Screen';
      ActiveReport.ResetDevices;
      ActiveReport.PrintToDevices;
      if not ResetReport then ppViewer1.GotoPage(CurPageNo);
      if (WindowState = wsMinimized) then WindowState := wsNormal;
      if (not Self.Visible) then
         if ModalReport then ShowModal else Show;
   finally
   end;
end;

procedure TfmvRBReport.RefreshReport;
begin
   PreviewReport(True, False);
end;

procedure TfmvRBReport.DisplayTemplateName(const Name: string);
begin
   inherited;
   if Name = '' then
   begin
      RzStatusPanel3.Font.Color := clRed;
      RzStatusPanel3.Caption := '沒有範本可使用,自動使用內定範本';
      exit;
   end
   else
   begin
      if Name = DefaultTemplate then
      begin
         RzStatusPanel3.Font.Color := clBlack;
         RzStatusPanel3.Caption := Format(TEMP_DISP_FMT, [Name + '(預設)'])
      end
      else
      begin
         RzStatusPanel3.Font.Color := $00A00000;
         RzStatusPanel3.Caption := Format(TEMP_DISP_FMT, [Name]);
      end;
   end;
end;

procedure TfmvRBReport.FormPaint(Sender: TObject);
begin
   inherited;
   BringWindowToTop(Self.Handle);
end;

procedure TfmvRBReport.btnPrintClick(Sender: TObject);
begin
   inherited;
   PrintReport(True, False);
end;

procedure TfmvRBReport.btnPrintNowClick(Sender: TObject);
begin
   inherited;
   PrintReport(False, False);
end;

procedure TfmvRBReport.btnPriorClick(Sender: TObject);
begin
   inherited;
   ppViewer1.PriorPage;
end;

procedure TfmvRBReport.btnNextClick(Sender: TObject);
begin
   inherited;
   ppViewer1.NextPage;
end;

procedure TfmvRBReport.btnFirstClick(Sender: TObject);
begin
   inherited;
   ppViewer1.FirstPage;
end;

procedure TfmvRBReport.BtnLastClick(Sender: TObject);
begin
   inherited;
   ppViewer1.LastPage;
end;

procedure TfmvRBReport.btnExportClick(Sender: TObject);
var
   iFileType: Integer;
   sExportFileName: string;
   bOpenFile, bEmailFile: Boolean;
begin
   inherited;
   with ppViewer1 do
   begin
      sExportFileName := Report.PrinterSetup.DocumentName;
      iFileType := ExecPrintToFileDlg(Self, sExportFileName, bOpenFile, bEmailFile);
      if (iFileType < 0) or (sExportFileName = '') then Exit;
      case iFileType of
      EFT_RTF: PrintToWord(sExportFileName);
      EFT_EXCEL: PrintToExcel(sExportFileName);
      EFT_HTML: PrintToHTML(sExportFileName);
      EFT_TEXT: PrintToText(sExportFileName);
      end;
      if bOpenFile then OpenExportFile(iFileType, sExportFileName);
      if bEmailFile then EmailExportFile(iFileType, Report.PrinterSetup.DocumentName, sExportFileName);
   end;
end;

procedure TfmvRBReport.btnTemplateLoadClick(Sender: TObject);
begin
   inherited;
   PickTemplate;
end;

procedure TfmvRBReport.btnTemplateDesignClick(Sender: TObject);
var
   OldTemplateStream : TMemoryStream;
begin
   inherited;
   OldTemplateStream := TMemoryStream.Create;
   ActiveReport.Template.SaveToStream(OldTemplateStream);
   ppDesigner1.Caption:='報表範本設計 [' + ActiveReport.Template.DatabaseSettings.Name + ']';
   try
      dShowPromptBox('起始報表設計環境');
      TranslateFieldNames;
   finally
      dHidePromptBox;
   end;
   try
      ppDesigner1.ShowModal;
      try
         if not FTemplateChanged then
         begin
            OldTemplateStream.Position := 0;
            ActiveReport.Template.LoadFromStream(OldTemplateStream);
            DisplayTemplateName(ActiveReport.Template.DatabaseSettings.Name);
         end
         else
            LoadTemplate(UseTemplate);
      except
         on E:Exception do
         begin
            if Pos('找不到記錄', E.Message) = 0 then
              Raise
            else
              ShellCallBackProc(99, VarArrayOF(['[找不到範本記錄:' + UseTemplate + '] ' +E.Message]));
         end;
      end;
      FTemplateChanged := False;
   finally
      FreeAndNil(OldTemplateStream);
   end;
end;

procedure TfmvRBReport.RzToolbarButton1Click(Sender: TObject);
var
  areport:TppReport;
begin
  aReport:= ActiveReport;
  TfmMakeUpPrintSetup.Excute(Self, ReportID, GroupID, aReport);
end;

procedure TfmvRBReport.SetCanDesignReport(const Value: Boolean);
begin
  FCanDesignReport := Value;
  btnTemplateDesign.Visible := Value;
end;

end.

