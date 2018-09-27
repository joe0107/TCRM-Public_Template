unit cDLL_Base130;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cDLL_Base100, ComCtrls, dxtree, dxdbtree, DB, AstaDrv2,
  AstaClientDataset, ExtCtrls, Buttons, RzButton, RzPanel, RzStatus,
  vMegaDbLookup, JcCxGridResStr, RzTabs, RzBmpBtn, ADODB, BetterADODataSet,
  cxPropertiesStore;

type
  TfmcDLL_Base130 = class(TfmcDLL_Base100)
    cTreeView: TdxDBTreeView;
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnModifyClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure NotifyGridEnabled(aEditMode: boolean); override;
  public
    { Public declarations }
  end;

var
  fmcDLL_Base130: TfmcDLL_Base130;

implementation

uses cUtility;

{$R *.dfm}

{ TfmcDLL_Base130 }

procedure TfmcDLL_Base130.NotifyGridEnabled(aEditMode: boolean);
begin
   inherited;
   cTreeView.Enabled := not aEditMode;
end;

procedure TfmcDLL_Base130.btnAddClick(Sender: TObject);
begin
   inherited;
   dsMaster.DataSet.Append;
   CanEdit := True;
end;

procedure TfmcDLL_Base130.btnDelClick(Sender: TObject);
begin
   if dsMaster.DataSet.IsEmpty then
   begin
      xMsgWarning('資料表中沒有任何資料,可以刪除!!');
      exit;
   end
   else
   begin
      inherited;
      if dsMaster.DataSet.FieldByName(cTreeView.KeyField).AsString =  cTreeView.RootValue then
      begin
         xMsgWarning('這筆資料是所有資料的根資料,不得刪除!!');
         exit;
      end;
      dsMaster.DataSet.Delete;
      ApplyUpdateAllDataSets;
   end;
end;

procedure TfmcDLL_Base130.btnModifyClick(Sender: TObject);
begin
   if dsMaster.DataSet.IsEmpty then
   begin
      xMsgWarning('資料表中沒有任何資料,可以修改!!');
      exit;
   end
   else
   begin
      inherited;
      dsMaster.DataSet.Edit;
      CanEdit := True;
   end;
end;

end.
