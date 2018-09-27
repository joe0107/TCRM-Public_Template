unit dvDataView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cDLL_Base10, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Buttons, RzButton, DBClient, ExtCtrls,
  RzPanel, RzPrgres, RzStatus;

type
  TfmdvDataView = class(TfmcDLL_Base10)
    cdsMaster: TClientDataSet;
    dsMaster: TDataSource;
    RzToolbarButton1: TRzToolbarButton;
    RzToolbarButton2: TRzToolbarButton;
    RzToolbarButton3: TRzToolbarButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmdvDataView: TfmdvDataView;

implementation

uses cController;

{$R *.dfm}

end.
