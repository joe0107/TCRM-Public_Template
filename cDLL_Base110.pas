unit cDLL_Base110;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cDLL_Base100, ExtCtrls, Buttons, RzButton, RzPanel, RzStatus,
  DB, AstaDrv2, AstaClientDataset, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, vMegaDbLookup, JcCxGridResStr, RzTabs,
  RzBmpBtn, ADODB, BetterADODataSet, cxDataStorage, cxPropertiesStore;

type
  TfmcDLL_Base110 = class(TfmcDLL_Base100)
    cgdView: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    procedure btnFirstClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnModifyClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure NotifyGridEnabled(aEditMode: boolean); override;
  public
    { Public declarations }
  end;

var
  fmcDLL_Base110: TfmcDLL_Base110;

implementation

uses cDLLDm, cController, cUtility;

{$R *.dfm}

{ TfmcDLL_Base110}

procedure TfmcDLL_Base110.NotifyGridEnabled(aEditMode: boolean);
begin
   inherited;
   cgdView.Enabled := not aEditMode;
end;

procedure TfmcDLL_Base110.btnFirstClick(Sender: TObject);
begin
   inherited;
   cxGrid1DBTableView1.DataController.GotoFirst;
end;

procedure TfmcDLL_Base110.btnPriorClick(Sender: TObject);
begin
   inherited;
   cxGrid1DBTableView1.DataController.GotoPrev;
end;

procedure TfmcDLL_Base110.btnNextClick(Sender: TObject);
begin
   inherited;
   cxGrid1DBTableView1.DataController.GotoNext;
end;

procedure TfmcDLL_Base110.btnLastClick(Sender: TObject);
begin
   inherited;
   cxGrid1DBTableView1.DataController.GotoLast;
end;

procedure TfmcDLL_Base110.btnAddClick(Sender: TObject);
begin
   inherited;
   cxGrid1DBTableView1.DataController.DataSource.DataSet.Append;
   CanEdit := True;
   SelectFirst;
end;

procedure TfmcDLL_Base110.btnDelClick(Sender: TObject);
begin
   if cxGrid1DBTableView1.DataController.DataSource.DataSet.IsEmpty then
   begin
      xMsgWarning('資料表中沒有任何資料,可以刪除!!');
      exit;
   end
   else
   begin
      inherited;
      cxGrid1DBTableView1.DataController.DeleteFocused;
      ApplyUpdateAllDataSets;
   end;
end;

procedure TfmcDLL_Base110.btnModifyClick(Sender: TObject);
begin
   if cxGrid1DBTableView1.DataController.DataSet.IsEmpty then
   begin
      xMsgWarning('資料表中沒有任何資料,可以修改!!');
      exit;
   end
   else
   begin
      inherited;
      cxGrid1DBTableView1.DataController.Edit;
      CanEdit := True;
   end;
end;

procedure TfmcDLL_Base110.btnRefreshClick(Sender: TObject);
var
   xGUID: string;
begin
   inherited;
   xGUID := ADOMaster.FieldByName('GUID').AsString;
   ADOMaster.DisableControls;
   ADOMaster.ReQuery;
   ADOMaster.Locate('GUID', xGUID, []);
   ADOMaster.EnableControls;
end;

end.
