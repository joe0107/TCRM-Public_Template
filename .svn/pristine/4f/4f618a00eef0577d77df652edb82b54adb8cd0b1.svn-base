unit cDLL_Base210;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cDLL_Base10, JcCxGridResStr, ExtCtrls, RzPanel, DB, DBClient,
  Buttons, RzButton, RzStatus, StdCtrls, RzLabel, vRB_BASE, vTemplate,
  cxPropertiesStore, cxClasses;

type
  TfmcDLL_Base210 = class(TfmcDLL_Base10)
    btnPrint: TRzToolbarButton;
    btnPreview: TRzToolbarButton;
    btnExport: TRzToolbarButton;
    RzPanel1: TRzPanel;
    RzStatusBar1: TRzStatusBar;
    RzStatusPane1: TRzStatusPane;
    RzStatusPane2: TRzStatusPane;
    btnQuery: TRzToolbarButton;
    lblState: TRzLabel;
    btnTemplate: TRzToolbarButton;
    dsMaster: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnTemplateClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FWorkState: integer;
    FUseTemplate: string;
    FDefaultTemplate: string;
    procedure SetWorkState(const Value: integer);
    procedure SetUseTemplate(const Value: string);
    procedure SetDefaultTemplate(const Value: string);
    { Private declarations }
  protected
    procedure vCreateDataSet(aDataSet: TClientDataSet);
    procedure NotifyRefresh(aWorkState: Integer); virtual;
  public
    { Public declarations }
    FReportID, FGroupID: string;
    FTemplate: TfmTemplate; //設定範本Form
    FPubReport: TfmvRBBase; //預覽列印Form
    FPreViewMode: Boolean;  //要進入預覽模式否
    procedure GetDefaultTemplate; virtual; //取得預設範本
    procedure PrepareReportData(var aAccept: Boolean); virtual;
    property WorkState: integer read FWorkState write SetWorkState;
    property UseTemplate: string read FUseTemplate write SetUseTemplate; //目前使用的範本
    property DefaultTemplate: string read FDefaultTemplate write SetDefaultTemplate; //內定使用的範本   
  end;

var
  fmcDLL_Base210: TfmcDLL_Base210;

implementation

uses cUtility, vPubReport{, cDLLDm};

{$R *.dfm}

procedure TfmcDLL_Base210.vCreateDataSet(aDataSet: TClientDataSet);
begin
   with aDataSet do
   begin
     CreateDataSet;
     Append;
     Post;
   end;
end;

procedure TfmcDLL_Base210.FormCreate(Sender: TObject);
begin
   inherited;
   FReportID := Name;
   FGroupID := '0';
   FPubReport := nil;
   FTemplate := nil;
   //vCreateDataSet(cdsMaster);
   GetDefaultTemplate;  //取得預設的範本
   //cdsMaster.InitOriginalSQL;
end;

procedure TfmcDLL_Base210.PrepareReportData(var aAccept: Boolean);
begin
  try
    (*
    cdsMaster.ExecSetSQL(True);
    aAccept :=  (acdsMaster.RecordCount > 0);
    FPubReport.dsMaster.DataSet := acdsMaster;
    *)
  except
    aAccept := False;
  end;
end;

procedure TfmcDLL_Base210.SetWorkState(const Value: integer);
begin
  FWorkState := Value;
  case Value of
  0: lblState.Caption := '條件設定';
  1: lblState.Caption := '查詢狀態';
  2: lblState.Caption := '列印狀態';
  3: lblState.Caption := '預覽狀態';
  4: lblState.Caption := '匯出狀態';
  5: lblState.Caption := '範本設定';
  end;
  NotifyRefresh(Value);
end;

procedure TfmcDLL_Base210.btnQueryClick(Sender: TObject);
var
  xAccept: Boolean;
begin
  WorkState := 1;  //查詢狀態
  try
     xAccept := True;
     PrepareReportData(xAccept);
     if not xAccept then 
     begin
       WorkState := 0;
       exit
     end; 
  except
     WorkState := 0;
  end;     
end;

procedure TfmcDLL_Base210.btnPrintClick(Sender: TObject);
begin
  WorkState := 2;  //列印狀態
  FPreViewMode := False;
  try
     TfmvPubReport.CreateService(Self);
  finally
     WorkState := 0;
  end;     
end;

procedure TfmcDLL_Base210.btnPreviewClick(Sender: TObject);
begin
  WorkState := 3;  //預覽狀態
  FPreViewMode := True;
  try
     TfmvPubReport.CreateService(Self);
  except
     WorkState := 0;
  end;     
end;

procedure TfmcDLL_Base210.btnExportClick(Sender: TObject);
var
  xAccept: Boolean;
begin
  WorkState := 4;  //匯出狀態
  try
     xAccept := True;
     PrepareReportData(xAccept);
     if not xAccept then 
     begin
       WorkState := 0;
       exit
     end; 
  except
     WorkState := 0;
  end;     
end;

procedure TfmcDLL_Base210.NotifyRefresh(aWorkState: Integer);
begin
  btnQuery.Enabled := (aWorkState = 0); 
  btnPrint.Enabled := (aWorkState = 0);
  btnPreView.Enabled := (aWorkState = 0); 
  btnExport.Enabled := (aWorkState = 0); 
  btnTemplate.Enabled := (aWorkState = 0); 
end;

procedure TfmcDLL_Base210.btnTemplateClick(Sender: TObject);
begin
  WorkState := 5;  //設定範本
  try
    UseTemplate := vTemplate.Execute(Self, FReportID, FGroupID, FUseTemplate);
  finally  
    WorkState := 0;
  end;
end;

procedure TfmcDLL_Base210.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := (WorkState = 0);
  if not CanClose then
    xMsgWarning('目前視窗狀態不得關閉');
end;

procedure TfmcDLL_Base210.SetUseTemplate(const Value: string);
const
  cFmt = '使用範本: %s';
begin
  FUseTemplate := Value;
  if (FUseTemplate = '') and (FDefaultTemplate > '') then
     FUseTemplate := FDefaultTemplate;
  RzStatusPane2.Caption := Format(cFmt, [FUseTemplate]);
end;

procedure TfmcDLL_Base210.SetDefaultTemplate(const Value: string);
begin
  FDefaultTemplate := Value;
  if (FUseTemplate = '') And (FDefaultTemplate > '') then  //如果目前沒有使用中的範本,就用Default值
    UseTemplate := FDefaultTemplate; 
end;

procedure TfmcDLL_Base210.GetDefaultTemplate;
begin
   DefaultTemplate := vTemplate.GetDefault(Self, FReportID, FGroupID);
end;

end.
