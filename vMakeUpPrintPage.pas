unit vMakeUpPrintPage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin, ComCtrls, Tabnotbk,ppClass,ppPrintr,printers,
  ppTypes, ppComm, ppRelatv, ppProd, ppReport, ppBands, ppCache,db,
  Buttons, RzButton, RzPanel, RzTabs;

type
  TfmMakeUpPrintSetup = class(TForm)
    ppReport1: TppReport;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    TabSheet4: TRzTabSheet;
    lblPrinter: TLabel;
    cbxPrinterName: TComboBox;
    Label3: TLabel;
    edtDocumentName: TEdit;
    Label1: TLabel;
    edtCopies: TEdit;
    Label2: TLabel;
    rdbCollationYes: TRadioButton;
    rdbCollationNo: TRadioButton;
    lblDuplex: TLabel;
    cbxDuplex: TComboBox;
    SpinCopies: TSpinButton;
    lblPaperSize: TLabel;
    cbxPaperName: TComboBox;
    lblWidth: TLabel;
    edtPaperWidth: TEdit;
    lblHeight: TLabel;
    edtPaperHeight: TEdit;
    gbxOrientation: TGroupBox;
    imgLandScape: TImage;
    imgPortrait: TImage;
    rdbPortrait: TRadioButton;
    rdbLandscape: TRadioButton;
    spinPaperWidth: TSpinButton;
    spinPaperHeight: TSpinButton;
    lblPaperTray: TLabel;
    lbxBinName: TListBox;
    lblOtherPages: TLabel;
    lbxBinOtherPages: TListBox;
    lblPaperSource: TLabel;
    lblMarginTop: TLabel;
    edtMarginTop: TEdit;
    lblMarginBottom: TLabel;
    edtMarginBottom: TEdit;
    lblMarginLeft: TLabel;
    edtMarginLeft: TEdit;
    lblMarginRight: TLabel;
    edtMarginRight: TEdit;
    Label4: TLabel;
    ComboBox1: TComboBox;
    lblMargins: TLabel;
    spinMarginTop: TSpinButton;
    spinMarginBottom: TSpinButton;
    spinMarginLeft: TSpinButton;
    spinMarginRight: TSpinButton;
    RzPanel1: TRzPanel;
    btnPreview: TRzToolbarButton;
    btnSave: TRzToolbarButton;
    procedure cbxPrinterNameChange(Sender: TObject);
    procedure edtDocumentNameExit(Sender: TObject);
    procedure edtDocumentNameKeyPress(Sender: TObject; var Key: Char);
    procedure edtCopiesExit(Sender: TObject);
    procedure edtCopiesKeyPress(Sender: TObject; var Key: Char);
    procedure rdbCollationYesClick(Sender: TObject);
    procedure rdbCollationNoClick(Sender: TObject);
    procedure cbxDuplexChange(Sender: TObject);
    procedure cbxPaperNameChange(Sender: TObject);
    procedure edtPaperWidthKeyPress(Sender: TObject; var Key: Char);
    procedure edtPaperHeightChange(Sender: TObject);
    procedure edtPaperWidthChange(Sender: TObject);
    procedure SpinCopiesDownClick(Sender: TObject);
    procedure SpinCopiesUpClick(Sender: TObject);
    procedure spinPaperWidthDownClick(Sender: TObject);
    procedure spinPaperWidthUpClick(Sender: TObject);
    procedure rdbPortraitClick(Sender: TObject);
    procedure rdbLandscapeClick(Sender: TObject);
    procedure edtPaperHeightKeyPress(Sender: TObject; var Key: Char);
    procedure lbxBinNameClick(Sender: TObject);
    procedure edtMarginTopChange(Sender: TObject);
    procedure edtMarginTopKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarginBottomChange(Sender: TObject);
    procedure edtMarginBottomKeyPress(Sender: TObject; var Key: Char);
    procedure btnPreviewClick(Sender: TObject);
    procedure spinPaperHeightDownClick(Sender: TObject);
    procedure spinPaperHeightUpClick(Sender: TObject);
    procedure spinMarginTopDownClick(Sender: TObject);
    procedure spinMarginTopUpClick(Sender: TObject);
    procedure spinMarginBottomDownClick(Sender: TObject);
    procedure spinMarginBottomUpClick(Sender: TObject);
    procedure spinMarginLeftDownClick(Sender: TObject);
    procedure spinMarginLeftUpClick(Sender: TObject);
    procedure spinMarginRightDownClick(Sender: TObject);
    procedure spinMarginRightUpClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure edtMarginLeftChange(Sender: TObject);
    procedure edtMarginLeftKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarginRightChange(Sender: TObject);
    procedure edtMarginRightKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fShowType: Integer;
    procedure SetShowType(const Value: Integer);
  private
    { Private declarations }
    FReport: TppCustomReport;
    FReportID, FGroupID : string;
    FSavePrinterSetup: TppPrinterSetup;
    FLanguageIndex: Longint;
    FSpinIncrement, FMarginSpinIncrement: Single;
    STemplateStream: TMemoryStream;
    procedure PrinterChange;
    procedure PaperChange;
    procedure SetLanguage(aLanguageIndex: Longint);
    procedure SetReport(aReport: TppCustomReport);
    Property ShowType: Integer Read fShowType Write SetShowType Default 0;
  public
    { Public declarations }
    Class function Excute(AOwner: TComponent; ReportID,GroupID: string; var aReport:TppReport):Boolean;
    Class function RunSetup(AOWner: TComponent; aReport:TppReport):Boolean;
  end;

var
  fmMakeUpPrintSetup: TfmMakeUpPrintSetup;

implementation

uses vRB_BASE;

{$R *.DFM}
Class function TfmMakeUpPrintSetup.Excute(AOwner: TComponent; ReportID, GroupID: string; var aReport: TppReport): Boolean;
begin
   if not Assigned(fmMakeUpPrintSetup) then
      fmMakeUpPrintSetup := TfmMakeUpPrintSetup.Create(AOwner);
   with fmMakeUpPrintSetup do
   begin
     FSavePrinterSetup := TppPrinterSetup.Create(Nil);
     FReport := TppCustomReport(aReport);
     SetReport(FReport);
     SetLanguage(FReport.LanguageIndex);
     FReportID  := ReportID;
     FGroupID := GroupID;
     RzPageControl1.ActivePage := TabSheet1;
     Result := (ShowModal = mrOk);
     aReport:=TppReport(FReport);
     Free;
   end;
end;

Class function TfmMakeUpPrintSetup.RunSetup(AOWner: TComponent; aReport: TppReport): Boolean;
begin
   if not Assigned(fmMakeUpPrintSetup) then
      fmMakeUpPrintSetup := TfmMakeUpPrintSetup.Create(AOwner);
   with fmMakeUpPrintSetup do
   begin
      ShowType := 1;
      FReport:=TppCustomReport(aReport);
      FSavePrinterSetup := TppPrinterSetup.Create(Nil);
      SetReport(FReport);
      SetLanguage(FReport.LanguageIndex);
      RzPageControl1.ActivePage := TabSheet1;
      Result := (ShowModal = mrOk);
      aReport:=TppReport(FReport);
      Free;
      fmMakeUpPrintSetup := Nil;
   end;
end;


procedure TfmMakeUpPrintSetup.cbxPrinterNameChange(Sender: TObject);
begin
   FReport.PrinterSetup.PrinterName := cbxPrinterName.Text;
   PrinterChange;
end;

procedure TfmMakeUpPrintSetup.PaperChange;
var
   lPrinterSetup: TppPrinterSetup;
begin
   lPrinterSetup := FReport.PrinterSetup;
   cbxPaperName.Text := lPrinterSetup.PaperName;
   edtPaperWidth.Text      := FloatToStrF(lPrinterSetup.PaperWidth,   ffGeneral,  7, 0);
   edtPaperHeight.Text     := FloatToStrF(lPrinterSetup.PaperHeight,  ffGeneral,  7, 0);
   edtMarginTop.Text       := FloatToStrF(lPrinterSetup.MarginTop,    ffGeneral,  7, 0);
   edtMarginBottom.Text    := FloatToStrF(lPrinterSetup.MarginBottom, ffGeneral,  7, 0);
   edtMarginLeft.Text      := FloatToStrF(lPrinterSetup.MarginLeft,   ffGeneral,  7, 0);
   edtMarginRight.Text     := FloatToStrF(lPrinterSetup.MarginRight,  ffGeneral,  7, 0);
   rdbPortrait.Checked     := (lPrinterSetup.Orientation = poPortrait);
   rdbLandscape.Checked    := (lPrinterSetup.Orientation = poLandscape);
   imgPortrait.Visible     := (lPrinterSetup.Orientation = poPortrait);
   imgLandscape.Visible    := (lPrinterSetup.Orientation = poLandscape);
   lbxBinName.ItemIndex   := lbxBinName.Items.IndexOf(lPrinterSetup.BinName);
end;

procedure TfmMakeUpPrintSetup.PrinterChange;
var
   lPrinterSetup: TppPrinterSetup;
begin
   lPrinterSetup := FReport.PrinterSetup;
   cbxPrinterName.ItemIndex := cbxPrinterName.Items.IndexOf(lPrinterSetup.PrinterName);
   cbxPaperName.Items   := lPrinterSetup.PaperNames;
   lbxBinName.Items     := lPrinterSetup.BinNames;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.edtDocumentNameExit(Sender: TObject);
begin
   FReport.PrinterSetup.DocumentName := edtDocumentName.Text;
end;

procedure TfmMakeUpPrintSetup.edtDocumentNameKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then edtDocumentNameExit(Self);
end;

procedure TfmMakeUpPrintSetup.edtCopiesExit(Sender: TObject);
var
  liCopies: Integer;
begin
   try
      liCopies := StrToInt(edtCopies.Text);
      if liCopies >= 1 then FReport.PrinterSetup.Copies := StrToInt(edtCopies.Text);
   except on EConvertError do
      MessageDlg(LoadStr(FLanguageIndex + 377), mtWarning, [mbOK], 0);
   end;
end;

procedure TfmMakeUpPrintSetup.edtCopiesKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = #13) then edtCopiesExit(Self);
end;

procedure TfmMakeUpPrintSetup.rdbCollationYesClick(Sender: TObject);
begin
   FReport.PrinterSetup.Collation := True;
end;

procedure TfmMakeUpPrintSetup.rdbCollationNoClick(Sender: TObject);
begin
   FReport.PrinterSetup.Collation := False;
end;

procedure TfmMakeUpPrintSetup.cbxDuplexChange(Sender: TObject);
begin
   FReport.PrinterSetup.Duplex := TppDuplexType(cbxDuplex.ItemIndex + 1);
end;

procedure TfmMakeUpPrintSetup.cbxPaperNameChange(Sender: TObject);
begin
   FReport.PrinterSetup.PaperName := cbxPaperName.Text;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.edtPaperWidthKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then edtPaperWidthChange(Self);
end;

procedure TfmMakeUpPrintSetup.edtPaperHeightChange(Sender: TObject);
begin
   try
      FReport.PrinterSetup.PaperHeight := StrToFloat(edtPaperHeight.Text);
   except on EConvertError do
      MessageDlg(LoadStr(FLanguageIndex + 377), mtWarning, [mbOK], 0);
   end;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.edtPaperWidthChange(Sender: TObject);
begin
   try
      FReport.PrinterSetup.PaperWidth := StrToFloat(edtPaperWidth.Text);
   except on EConvertError do
      MessageDlg(LoadStr(FLanguageIndex + 377), mtWarning, [mbOK], 0);
   end;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.SpinCopiesDownClick(Sender: TObject);
begin
   if (FReport.PrinterSetup.Copies = 1) then Exit;
   FReport.PrinterSetup.Copies :=  FReport.PrinterSetup.Copies - 1;
   edtCopies.Text := IntToStr(FReport.PrinterSetup.Copies);
end;

procedure TfmMakeUpPrintSetup.SpinCopiesUpClick(Sender: TObject);
begin
   FReport.PrinterSetup.Copies :=  FReport.PrinterSetup.Copies + 1;
   edtCopies.Text := IntToStr(FReport.PrinterSetup.Copies);
end;

procedure TfmMakeUpPrintSetup.spinPaperWidthDownClick(Sender: TObject);
begin
   with FReport.PrinterSetup do
      PaperWidth := PaperWidth - FSpinIncrement;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.spinPaperWidthUpClick(Sender: TObject);
begin
   with FReport.PrinterSetup do
      PaperWidth := PaperWidth + FSpinIncrement;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.rdbPortraitClick(Sender: TObject);
begin
   FReport.PrinterSetup.Orientation := poPortrait;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.rdbLandscapeClick(Sender: TObject);
begin
   FReport.PrinterSetup.Orientation := poLandscape;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.edtPaperHeightKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then edtPaperHeightChange(Self);
end;

procedure TfmMakeUpPrintSetup.lbxBinNameClick(Sender: TObject);
begin
   FReport.PrinterSetup.BinName := lbxBinName.Items[lbxBinName.ItemIndex];
end;

procedure TfmMakeUpPrintSetup.edtMarginTopChange(Sender: TObject);
begin
   try
      FReport.PrinterSetup.MarginTop := StrToFloat(edtMarginTop.Text);
      PaperChange;
   except on EConvertError do
      MessageDlg(LoadStr(FLanguageIndex + 377), mtWarning, [mbOK], 0);
   end;
end;

procedure TfmMakeUpPrintSetup.edtMarginTopKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = chEnterKey) then edtMarginTopChange(Self);
end;

procedure TfmMakeUpPrintSetup.edtMarginBottomChange(Sender: TObject);
begin
   try
      FReport.PrinterSetup.MarginBottom := StrToFloat(edtMarginBottom.Text);
      PaperChange;
   except on EConvertError do
      MessageDlg(LoadStr(FLanguageIndex + 377), mtWarning, [mbOK], 0);
   end;
end;

procedure TfmMakeUpPrintSetup.edtMarginBottomKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then edtMarginBottomChange(Self);
end;

procedure TfmMakeUpPrintSetup.SetLanguage(aLanguageIndex: Integer);
begin
   Caption := '版面設定';
   lblPrinter.Caption         := '印表機';
   Label3.Caption             := '文件名稱';
   Label1.Caption             := '份數';
   lblHeight.Caption          := '高';
   lblMargins.Caption         := '邊界';
   gbxOrientation.Caption     := '方向';
   lblPaperSize.Caption       := '紙張大小';
   lblPaperSource.Caption     := '紙張來源';
   lblPaperTray.Caption       := '紙盤';
   lblOtherPages.Caption      := '';
   lblWidth.Caption           := '寬';
   lblMarginTop.Caption       := '上';
   lblMarginBottom.Caption    := '下';
   lblMarginLeft.Caption      := '左';
   lblMarginRight.Caption     := '右';
   rdbPortrait.Caption        := '直印(P)';
   rdbLandscape.Caption       := '橫印(L)';
   Label2.Caption             := '分頁';
end;

procedure TfmMakeUpPrintSetup.SetReport(aReport: TppCustomReport);
var
   lPrinterSetup: TppPrinterSetup;
begin
   FReport := aReport;
   FSavePrinterSetup.Assign(ppReport1.PrinterSetup);
   case FReport.Units of
    utInches:        ComboBox1.ItemIndex:=0;
    utMillimeters:   ComboBox1.ItemIndex:=1;
    utScreenPixels:  ComboBox1.ItemIndex:=2;
    utPrinterPixels: ComboBox1.ItemIndex:=3;
    utMMThousandths: ComboBox1.ItemIndex:=4;
   end;

   case FReport.Units of
    utInches:        FSpinIncrement  := 0.5;
    utMillimeters:   FSpinIncrement  := 5.0;
    utScreenPixels:  FSpinIncrement  := 50.0;
    utPrinterPixels: FSpinIncrement  := 300.0;
    utMMThousandths: FSpinIncrement  := 5000.0;
   end;

   case FReport.Units of
    utInches:        FMarginSpinIncrement  := 0.10;
    utMillimeters:   FMarginSpinIncrement  := 1;
    utScreenPixels:  FMarginSpinIncrement  := 1.0;
    utPrinterPixels: FMarginSpinIncrement  := 50.0;
    utMMThousandths: FMarginSpinIncrement  := 1000.0;
   end;

   lPrinterSetup := FReport.PrinterSetup;
   cbxPrinterName.Items := lPrinterSetup.PrinterNames;
   edtDocumentName.Text := lPrinterSetup.DocumentName;
   edtCopies.Text := IntToStr(lPrinterSetup.Copies);
   rdbCollationYes.Checked := lPrinterSetup.Collation;
   rdbCollationNo.Checked  := not lPrinterSetup.Collation;
   cbxDuplex.ItemIndex := 0;
   PrinterChange;
end;

procedure TfmMakeUpPrintSetup.btnPreviewClick(Sender: TObject);
begin
   FReport.ResetDevices;
   FReport.PrintToDevices;
end;

procedure TfmMakeUpPrintSetup.spinPaperHeightDownClick(Sender: TObject);
begin
   with FReport.PrinterSetup do
      PaperHeight := PaperHeight - FSpinIncrement;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.spinPaperHeightUpClick(Sender: TObject);
begin
   with FReport.PrinterSetup do
      PaperHeight := PaperHeight + FSpinIncrement;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.spinMarginTopDownClick(Sender: TObject);
begin
   with FReport.PrinterSetup do
      MarginTop := MarginTop - FMarginSpinIncrement;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.spinMarginTopUpClick(Sender: TObject);
begin
   with FReport.PrinterSetup do
      MarginTop := MarginTop + FMarginSpinIncrement;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.spinMarginBottomDownClick(Sender: TObject);
begin
   with FReport.PrinterSetup do
      MarginBottom := MarginBottom - FMarginSpinIncrement;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.spinMarginBottomUpClick(Sender: TObject);
begin
   with FReport.PrinterSetup do
      MarginBottom := MarginBottom + FMarginSpinIncrement;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.spinMarginLeftDownClick(Sender: TObject);
begin
   with FReport.PrinterSetup do
      MarginLeft := MarginLeft - FMarginSpinIncrement;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.spinMarginLeftUpClick(Sender: TObject);
begin
   with FReport.PrinterSetup do
      MarginLeft := MarginLeft + FMarginSpinIncrement;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.spinMarginRightDownClick(Sender: TObject);
begin
   with FReport.PrinterSetup do
      MarginRight := MarginRight - FMarginSpinIncrement;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.spinMarginRightUpClick(Sender: TObject);
begin
   with FReport.PrinterSetup do
      MarginRight := MarginRight + FMarginSpinIncrement;
   PaperChange;
end;

procedure TfmMakeUpPrintSetup.btnSaveClick(Sender: TObject);
begin
   btnPreview.Click;
   TfmvRBBase(OWner).SaveTemplate(FReport, True);
   ModalResult:=mrOK;
end;

procedure TfmMakeUpPrintSetup.edtMarginLeftChange(Sender: TObject);
begin
   try
      FReport.PrinterSetup.MarginLeft := StrToFloat(edtMarginLeft.Text);
      PaperChange;
   except on EConvertError do
      MessageDlg(LoadStr(FLanguageIndex + 377), mtWarning, [mbOK], 0);
   end;
end;

procedure TfmMakeUpPrintSetup.edtMarginLeftKeyPress(Sender: TObject;
  var Key: Char);
begin
   if (Key = chEnterKey) then edtMarginLeftChange(Self);
end;

procedure TfmMakeUpPrintSetup.edtMarginRightChange(Sender: TObject);
begin
   try
      FReport.PrinterSetup.MarginRight := StrToFloat(edtMarginRight.Text);
      PaperChange;
   except on EConvertError do
      MessageDlg(LoadStr(FLanguageIndex + 377), mtWarning, [mbOK], 0);
   end;
end;

procedure TfmMakeUpPrintSetup.edtMarginRightKeyPress(Sender: TObject; var Key: Char);
begin
   if (Key = chEnterKey) then edtMarginRightChange(Self);
end;

procedure TfmMakeUpPrintSetup.SetShowType(const Value: Integer);
begin
   fShowType := Value;
   btnPreView.Visible := (Value = 0);
   btnSave.Visible := (Value = 0);
   UpDate;
end;

procedure TfmMakeUpPrintSetup.FormCreate(Sender: TObject);
begin
   Inherited;
   ShowType := 0;
end;

procedure TfmMakeUpPrintSetup.btnOKClick(Sender: TObject);
begin
   FReport.ResetDevices;
   FReport.PrintToDevices;
   Close;
end;

procedure TfmMakeUpPrintSetup.FormDestroy(Sender: TObject);
begin
   if Assigned(fmMakeUpPrintSetup) then
      fmMakeUpPrintSetup := nil;
end;

end.
