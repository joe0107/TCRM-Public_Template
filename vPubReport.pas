unit vPubReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, vRB_BASE, vRB_REPORT, DBClient, ppDBJIT, DB, DBISAMTb, RzCommon, RzSndMsg,
  Menus, ppEndUsr, ppComm, ppRelatv, ppDB, ppDBPipe, StdCtrls,
  RzCmboBx, Mask, RzEdit, ExtCtrls, Buttons, RzButton, RzPanel, RzStatus,
  ppViewr, ppProd, ppClass, ppReport, ppBands, ppCache, RzBmpBtn,
  ppParameter, ppDesignLayer, dxmdaset;

type
  TfmvPubReport = class(TfmvRBReport)
    ppReport1: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnTemplateLoadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PrepareReportData(var Accept: Boolean); override;
    class procedure CreateService(AOwner: TComponent); override;
  end;

implementation

uses vTemplate, cDLL_Base210, cDLL_Base100;
{$R *.dfm}

class procedure TfmvPubReport.CreateService(AOwner: TComponent);
begin
   if AOwner is TfmcDLL_Base210 then  //從設定的Form呼叫的
   begin
     if not Assigned(TfmcDLL_Base210(AOwner).FPubReport) then
       TfmcDLL_Base210(AOwner).FPubReport := TfmvPubReport.Create(AOwner);
     with TfmvPubReport(TfmcDLL_Base210(AOwner).FPubReport) do
     begin
        FCallerType := 0;
        vOwner := TForm(AOwner);
        ReportID := TfmcDLL_Base210(AOwner).FReportID;
        GroupID := TfmcDLL_Base210(AOwner).FGroupID;
        UseTemplate := TfmcDLL_Base210(AOwner).UseTemplate;
        if TfmcDLL_Base210(AOwner).FPreViewMode then
        begin
           PreviewReport(False, False);
           if not Showing then
             TfmcDLL_Base210(AOwner).WorkState := 0;
        end
        else
           PrintReport(False, True);
     end;
   end
   else
   begin   //從維護的Form呼叫
     if AOwner is TfmcDLL_Base100 then  //從設定的Form呼叫的
     begin
       if not Assigned(TfmcDLL_Base100(AOwner).FPubReport) then
         TfmcDLL_Base100(AOwner).FPubReport := TfmvPubReport.Create(AOwner);
       with TfmvPubReport(TfmcDLL_Base100(AOwner).FPubReport) do
       begin
         dsMaster.DataSet := nil;
         FCallerType := 1;
         vOwner := TfmcDLL_Base100(AOwner);
         ReportID := TfmcDLL_Base100(AOwner).FReportID;
         GroupID := TfmcDLL_Base100(AOwner).FGroupID;
         UseTemplate := TfmcDLL_Base100(AOwner).UseTemplate;
         PreviewReport(False, False);
       end;
     end;
   end;
end;

procedure TfmvPubReport.FormCreate(Sender: TObject);
begin
  FCallerType := -1;
  inherited;
  ActiveReport := ppReport1;
end;

procedure TfmvPubReport.PrepareReportData(var Accept: Boolean);
begin
   case FCallerType of
   0: begin
        TfmcDLL_Base210(vOwner).PrepareReportData(Accept);
        exit;
      end;
   1: begin
        TfmcDLL_Base100(vOwner).PrepareReportData(Accept);
        exit;
      end;
   else
     Inherited;
   end;
end;

procedure TfmvPubReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if vOwner is TfmcDLL_Base210 then
    TfmcDLL_Base210(vOwner).WorkState := 0;
end;

procedure TfmvPubReport.FormDestroy(Sender: TObject);
begin
  inherited;
  case FCallerType of
  0: if vOwner is TfmcDLL_Base210 then
       TfmcDLL_Base210(vOwner).FPubReport := nil;
  1: if vOwner is TfmcDLL_Base100 then
       TfmcDLL_Base100(vOwner).FPubReport := nil;
  end;
  Inherited;
end;

procedure TfmvPubReport.btnTemplateLoadClick(Sender: TObject);
begin
  inherited;
  if vOwner is TfmcDLL_Base210 then
    TfmcDLL_Base210(vOwner).UseTemplate := UseTemplate;
end;

end.
