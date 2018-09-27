unit cDLL_Base140;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cDLL_Base100, RzTabs, JcCxGridResStr, DB, AstaDrv2,
  AstaClientDataset, ExtCtrls, Buttons, RzButton, RzPanel, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxEdit, cxDBData,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, RzBmpBtn, ADODB, BetterADODataSet,
  cxDataStorage, cxPropertiesStore;

type
  TfmcDLL_Base140 = class(TfmcDLL_Base100)
    FormPageControl: TRzPageControl;
    FormPage1: TRzTabSheet;
    FormPage2: TRzTabSheet;
    cgdView: TcxGrid;
    cgdViewLevel1: TcxGridLevel;
    cgdViewDBBandedTableView1: TcxGridDBBandedTableView;
    RzBmpButton1: TRzBmpButton;
    procedure FormCreate(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnModifyClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure cgdViewDBBandedTableView1DblClick(Sender: TObject);
  private
    FFormPage: Integer;
    procedure SetFormPage(const Value: Integer);
    { Private declarations }
  protected
    procedure BeforeChangePage(aOldPage, aNewPage: Integer); virtual;  
    procedure NotifyGridEnabled(aEditMode: boolean); override;
  public
    { Public declarations }
    property FormPage: Integer read FFormPage write SetFormPage;
  end;

var
  fmcDLL_Base140: TfmcDLL_Base140;

implementation

uses cController, cDB_Manager, cDLLDm, cUtility;

{$R *.dfm}

{ TfmcDLL_Base1 }

procedure TfmcDLL_Base140.BeforeChangePage(aOldPage, aNewPage: Integer);
begin
   //
end;

procedure TfmcDLL_Base140.SetFormPage(const Value: Integer);
begin
  BeforeChangePage(FFormPage, Value);
  FFormPage := Value;
  FormPageControl.ActivePage := FormPageControl.Pages[Value];
end;

procedure TfmcDLL_Base140.FormCreate(Sender: TObject);
begin
   FormPageControl.Pages[0].TabVisible := False;
   FormPageControl.Pages[1].TabVisible := False;
   inherited;
   FormPage := 0;
end;

procedure TfmcDLL_Base140.RzBmpButton1Click(Sender: TObject);
begin
   inherited;
   FormPage := ((FormPage + 1) Mod FormPageControl.PageCount);
end;

procedure TfmcDLL_Base140.NotifyGridEnabled(aEditMode: boolean);
begin
   inherited;
   cgdView.Enabled := not aEditMode;
end;

procedure TfmcDLL_Base140.btnFirstClick(Sender: TObject);
begin
   inherited;
   cgdViewDBBandedTableView1.DataController.GotoFirst;
end;

procedure TfmcDLL_Base140.btnPriorClick(Sender: TObject);
begin
   inherited;
   cgdViewDBBandedTableView1.DataController.GotoPrev;
end;

procedure TfmcDLL_Base140.btnNextClick(Sender: TObject);
begin
   inherited;
   cgdViewDBBandedTableView1.DataController.GotoNext;
end;

procedure TfmcDLL_Base140.btnLastClick(Sender: TObject);
begin
   inherited;
   cgdViewDBBandedTableView1.DataController.GotoLast;
end;

procedure TfmcDLL_Base140.btnAddClick(Sender: TObject);
begin
   inherited;
   FormPage := 1;   
   cgdViewDBBandedTableView1.DataController.DataSource.DataSet.Append;
   CanEdit := True;
   SelectFirst;
end;

procedure TfmcDLL_Base140.btnDelClick(Sender: TObject);
begin
   if cgdViewDBBandedTableView1.DataController.DataSource.DataSet.IsEmpty then
   begin
      xMsgWarning('資料表中沒有任何資料,可以刪除!!');
      exit;
   end
   else
   begin
      inherited;
      cgdViewDBBandedTableView1.DataController.DeleteFocused;
      ApplyUpdateAllDataSets;
   end;
end;

procedure TfmcDLL_Base140.btnModifyClick(Sender: TObject);
begin
   if cgdViewDBBandedTableView1.DataController.DataSet.IsEmpty then
   begin
      xMsgWarning('資料表中沒有任何資料,可以修改!!');
      exit;
   end
   else
   begin
      inherited;
      FormPage := 1;      
      cgdViewDBBandedTableView1.DataController.Edit;
      CanEdit := True;
   end;
end;

procedure TfmcDLL_Base140.btnRefreshClick(Sender: TObject);
var
   xGUID: string;
begin
   inherited;
   xGUID := AdoMaster.FieldByName('GUID').AsString;
   ADOMaster.DisableControls;
   ADOMaster.ReQuery;
   ADOMaster.Locate('GUID', xGUID, []);
   ADOMaster.EnableControls;
end;

procedure TfmcDLL_Base140.cgdViewDBBandedTableView1DblClick(
  Sender: TObject);
begin
  inherited;
  RzBmpButton1.Click;
end;

end.
