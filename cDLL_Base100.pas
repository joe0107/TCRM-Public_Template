unit cDLL_Base100;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, cDLL_Base10,
  Buttons, RzButton, ExtCtrls, RzPanel, RzStatus, DB, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls, cxMemo, cxGridCustomView, TypInfo,
  cxCheckBox, cxTextEdit, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxDBEdit,
  cxGrid, cxButtonEdit, JcCxGridResStr, StdCtrls, RzTabs, RzBmpBtn, vRB_Base, vTemplate, ADODB,
  BetterADODataSet, cxPropertiesStore, cxDB;

type
  TfmcDLL_Base100 = class(TfmcDLL_Base10)
    btnQuery: TRzToolbarButton;
    btnFirst: TRzToolbarButton;
    btnPrior: TRzToolbarButton;
    btnNext: TRzToolbarButton;
    btnLast: TRzToolbarButton;
    btnAdd: TRzToolbarButton;
    btnDel: TRzToolbarButton;
    btnModify: TRzToolbarButton;
    btnSave: TRzToolbarButton;
    btnCancel: TRzToolbarButton;
    btnRefresh: TRzToolbarButton;
    btnPreview: TRzToolbarButton;
    btnImp: TRzToolbarButton;
    dsMaster: TDataSource;
    pFormPageControl: TRzPageControl;
    pPageSheet1: TRzTabSheet;
    plEdit: TRzPanel;
    btnChangeViewPage: TRzBmpButton;
    ADOMaster: TBetterADODataSet;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnModifyClick(Sender: TObject);
    procedure btnChangeViewPageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ADOMasterNewRecord(DataSet: TDataSet);
  private
    FCanEdit: boolean;
    FUseTemplate: string;
    FDefaultTemplate: string;
    procedure SetCanEdit(const Value: boolean);
    procedure SetViewFormPage(const Value: integer);
    procedure SetUseTemplate(const Value: string);
    procedure SetDefaultTemplate(const Value: string);
  protected
    FViewFormPage: integer;
    FAutoInsertMode, FSaveMode: boolean;
    FEditMode, FUpDateCache, FInTranMode: boolean;
    FStatePanel: TRzPanel;
    procedure InitializationValues; override;
    function sysApplyUpdates: Boolean; virtual;
    procedure ApplyUpdateAllDataSets; virtual;
    procedure CancelUpDates; virtual;
    procedure CheckAllDataSetInBrowseMode; virtual;
    procedure NotifyButtonEnabled(aEditMode: boolean); virtual;
    procedure NotifyGridEnabled(aEditMode: boolean); virtual;
    procedure NotifyEditPanelEnabled(aEditMode: boolean); virtual;
    procedure SetEditReadonly(aEditMode: Boolean); virtual;
    procedure AfterApplyUpDates; virtual;
    procedure AfterCancelUpDates; virtual;
    procedure DoBeforeChangeFormPage(NewPage, OldPage: Integer; Var aAccept: Boolean); virtual;
    procedure NotifyEditReadOnly(aEditMode: Boolean; aWinControl: TWinControl);
    function xGetObjectProp(aObject: Tobject; PropertyName: string): Tobject;
    property ViewFormPage: integer read FViewFormPage write SetViewFormPage;
    function ReadCanEdit: Boolean; override;
  public
    { Public declarations }
    FStartQuery, FCanCalc, FCanShowMsg, FCheckValue: Boolean;
    FCustomEditMode: Integer;
    {控制列印用的}
    FReportID, FGroupID: string;
    FPubReport: TfmvRBBase;
    FTemplate: TfmTemplate; //設定範本Form
    FPreViewMode: Boolean;
    property CanEdit: boolean read FCanEdit write SetCanEdit;
    {控制列印用的}
    property DefaultTemplate: string read FDefaultTemplate write SetDefaultTemplate; //內定使用的範本
    property UseTemplate: string read FUseTemplate write SetUseTemplate; //目前使用的範本

    procedure ClearTemplateSetup;
    procedure GetDefaultTemplate; virtual; //取得預設範本
    procedure PrepareReportData(var Accept: Boolean); virtual;
  end;

var
  fmcDLL_Base100: TfmcDLL_Base100;

implementation

uses {cDLLDm, }cUtility, cDB_Manager, DLL_COMMON;

{$R *.dfm}

{ TfmcDLL_Base100 }

procedure TfmcDLL_Base100.NotifyButtonEnabled(aEditMode: boolean);
begin
   btnQuery.Enabled := not aEditMode;
   btnRefresh.Enabled := not aEditMode;
   btnFirst.Enabled := not aEditMode;
   btnPrior.Enabled := not aEditMode;
   btnNext.Enabled := not aEditMode;
   btnLast.Enabled := not aEditMode;
   btnAdd.Enabled := not aEditMode;
   btnDel.Enabled := not aEditMode;
   btnModify.Enabled := not aEditMode;
   btnSave.Enabled := aEditMode;
   btnCancel.Enabled := aEditMode;
   btnPreview.Enabled := not aEditMode;
   btnImp.Enabled := not aEditMode;
end;

procedure TfmcDLL_Base100.SetCanEdit(const Value: boolean);
begin
   FCanEdit := Value;
   FEditMode := Value;
   if Assigned(FStatePanel) then
   begin
      if Value then
      begin
         if ADOMaster.State In [dsEdit] then
            FStatePanel.Caption := '修改'
         else
            FStatePanel.Caption := '新增';
      end
      else
         FStatePanel.Caption := '瀏覽';
   end;      
   NotifyButtonEnabled(Value);
   NotifyGridEnabled(Value);
   NotifyEditPanelEnabled(Value);
   SetEditReadonly(Value);
   UpDate;
   FCanCloseForm := not Value;
   SelectFirst;
end;

procedure TfmcDLL_Base100.btnSaveClick(Sender: TObject);
begin
   inherited;
   if FSaveMode then exit;
   dShowPromptBox('資料存檔中,請稍候...');
   FSaveMode := True;
   if sysApplyUpdates then
   begin
      AfterApplyUpDates;//空的??
      if CanEdit then CanEdit := False;
      FSaveMode := False;
      dHidePromptBox;
      if FAutoInsertMode then
         btnAdd.Click;
   end
   else
   begin
      FSaveMode := False;
      dHidePromptBox;
   end;
end;

function TfmcDLL_Base100.sysApplyUpdates: Boolean;
var
   vMsg: string;
begin
   FInTranMode := True;
   FCanCalc := False;
   Result := False;
   try
      CheckAllDataSetInBrowseMode;
      ApplyUpdateAllDataSets;
      Result := True;
      FInTranMode := False;
      FCanCalc := True;
   except
      on E:Exception do
      begin
         FInTranMode := False;
         FCanCalc := True;
         Result := False;
         ShellCallBackProc(99, VarArrayOF(['[存檔錯誤:' + Name + '] ' +E.Message]));
         if Pos('重複索引鍵', E.Message) > 0 then
         begin
            vMsg := '這筆資料的索引鍵值重複,無法存檔!';
            xMsgError(vMsg);
         end
         else if Pos('無法插入 NULL 值到資料行', E.Message) > 0 then
         begin
            vMsg := '資料欄位不得空白,無法存檔!';
            xMsgError(vMsg);
         end
         else
         begin
            vMsg := '存檔過程發生失敗,無法存檔!';
            xMsgError(vMsg);
         end;
         exit;
      end;
   end;
end;

procedure TfmcDLL_Base100.ApplyUpdateAllDataSets;
begin
  ShellCallBackProc(97, VarArrayOF(['[' + Name + ']=> 開始ApplyUpDates']));
  ADOMaster.Connection.BeginTrans;
  try
    if ADOMaster.Active then ADOMaster.UpdateBatch();
    ShellCallBackProc(97, VarArrayOF(['[' + Name + ']=> 完成 ADOMaster UpdateBatch']));
    ADOMaster.Connection.CommitTrans;
    ShellCallBackProc(97, VarArrayOF(['[' + Name + ']=> 完成 Commit']));
  except
    ADOMaster.Connection.RollbackTrans;
    ShellCallBackProc(97, VarArrayOF(['[' + Name + ']=> 失敗 RollBack']));
  end;
end;

procedure TfmcDLL_Base100.btnCancelClick(Sender: TObject);
begin
   inherited;
   if FSaveMode then exit;
   FSaveMode := True;
   FCheckValue := False;
   CancelUpDates;
   AfterCancelUpDates;//空的？
   FAutoInsertMode := False;
   CanEdit := False;
   FCheckValue := True;
   FSaveMode := False;
end;

procedure TfmcDLL_Base100.CancelUpDates;
begin
  if ADOMaster.Active then
     ADOMaster.CancelUpdates;
end;

procedure TfmcDLL_Base100.btnAddClick(Sender: TObject);
begin
   if (Trim(ADOMaster.CommandText) > '') then
   begin
     if not ADOMaster.Active then
        ADOMaster.Open;
   end;
   FAutoInsertMode := True;
end;

procedure TfmcDLL_Base100.btnModifyClick(Sender: TObject);
begin
   inherited;
   FAutoInsertMode := False;
end;

procedure TfmcDLL_Base100.SetEditReadonly(aEditMode: Boolean);
begin
   dsMaster.AutoEdit := aEditMode;
end;

procedure TfmcDLL_Base100.CheckAllDataSetInBrowseMode;
begin
   if DataSetInEditing(ADOMaster) then
      ADOMaster.Post;
end;

procedure TfmcDLL_Base100.NotifyEditReadOnly(aEditMode: Boolean; aWinControl: TWinControl);
var
    K: integer;
    vDataSource: TDataSource;
    vDataField: string;
    vReadOnly: integer;

    function GetDataSource(aObject: TObject; var aFieldName: string): TDataSource;
    var
       vObject: TObject;
       vDataBinding : TcxDBDataBinding;
    begin
       Result := nil;
       aFieldName := '';
       vObject := nil;
       vObject := xGetObjectProp(aObject, 'DataSource');
       if Assigned(vObject) then
       begin
          Result := TDataSource(vObject);
          aFieldName := GetPropValue(aObject, 'DataField', True);
          exit;
       end
       else
       begin
          vObject := nil;
          vObject := xGetObjectProp(aObject, 'DataBinding');
          if Assigned(vObject) then
          begin
             vDataBinding := TcxDBDataBinding(vObject);
             Result := vDataBinding.DataSource;
             aFieldName := vDataBinding.DataField;
             exit;
          end;
       end;
    end;

    function GetReadOnlyProperty(aDataSource: TDataSource; aDataField: string): integer;
    var
       xField: TField;
       xDataSet: TDataSet;
    begin
       Result := 2;
       xDataSet := aDataSource.DataSet;
       if not Assigned(xDataSet) then
          exit;
       if not xDataSet.Active then
       begin
          Result := 1;
          exit;
       end;
       xField := xDataSet.FieldByName(aDataField);
       if not Assigned(xField) then
          exit;
       case xDataSet.State of
       dsInsert:
         if (xField.Tag And 1) > 0 then
            Result := 0;
       dsEdit:
         if (xField.Tag And 2) > 0 then
            Result := 0;
       end;
    end;

    procedure SetReadOnlyProperty(aObject: TObject; aReadOnly: integer);
    var
       vEdit: TcxTextEdit;
       vCheckBox: TcxCheckBox;
    begin
       if aObject is TWinControl then
       begin
          TWinControl(aObject).Enabled := (aReadOnly <> 0);
          if aReadOnly = 0 then
             exit;
          if aObject is TcxCustomEdit then
          begin
             vEdit := TcxTextEdit(aObject);
             vEdit.Properties.ReadOnly := (aReadOnly = 1);
          end
          else if aObject is TcxCustomCheckBox then
          begin
             vCheckBox := TcxCheckBox(aObject);
             vCheckBox.Properties.ReadOnly := (aReadOnly = 1);
          end;
       end;
    end;

begin
   for K := 0 to ComponentCount - 1 do
   begin
      if InWinControl(aWinControl, Components[K]) then
      begin
         vReadOnly := 1; //唯讀狀態
         if aEditMode then
         begin
            vDataSource := GetDataSource(Components[K], vDataField);
            if (not Assigned(vDataSource)) or (vDataField = '') then
               vReadOnly := 2  //可以寫入
            else
               vReadOnly := GetReadOnlyProperty(vDataSource, vDataField);
         end;
         SetReadOnlyProperty(Components[K], vReadOnly);
      end;
   end;
end;

function TfmcDLL_Base100.xGetObjectProp(aObject: Tobject;
  PropertyName: string): Tobject;
var
  xPropInfo: PPropInfo;
begin
   Result := nil;
   try
      xPropInfo := nil;
      xPropInfo := GetPropInfo(aObject, PropertyName);
      if Assigned(xPropInfo) then
         Result := GetObjectProp(aObject, PropertyName);
   except
      Result := nil;
   end;
end;

procedure TfmcDLL_Base100.InitializationValues;
begin
   inherited;
   FReportID := Name;
   FGroupID := '0';
   FPubReport := nil;
   FTemplate := nil;
   FStatePanel := nil;
   CanEdit := False;
   FCanCalc := True;
   FCanShowMsg := True;
   FCheckValue := True;
   FUpDateCache := True;
   FCustomEditMode := 0;
   FSaveMode := False;
   FInTranMode := False;
   FStartQuery := False;
   GetDefaultTemplate;
end;

procedure TfmcDLL_Base100.AfterApplyUpDates;
begin

end;

procedure TfmcDLL_Base100.AfterCancelUpDates;
begin

end;

procedure TfmcDLL_Base100.NotifyEditPanelEnabled(aEditMode: boolean);
begin

end;

procedure TfmcDLL_Base100.NotifyGridEnabled(aEditMode: boolean);
begin

end;

procedure TfmcDLL_Base100.btnChangeViewPageClick(Sender: TObject);
begin
  inherited;
  ViewFormPage := ((ViewFormPage + 1) Mod pFormPageControl.PageCount);
end;

procedure TfmcDLL_Base100.DoBeforeChangeFormPage(NewPage, OldPage: Integer;
  var aAccept: Boolean);
begin
// 
end;

procedure TfmcDLL_Base100.SetViewFormPage(const Value: integer);
var
   xAccept: Boolean;  
   OldPage: Integer;
begin
   xAccept := True;
   OldPage := FViewFormPage;
   FViewFormPage := Value;
   DoBeforeChangeFormPage(Value, OldPage, xAccept);
   if not xAccept then
   begin
     FViewFormPage := OldPage;
     exit;
   end;
   pFormPageControl.ActivePage := pFormPageControl.Pages[Value];
   pFormPageControl.UpDate;
end;

procedure TfmcDLL_Base100.FormCreate(Sender: TObject);
begin
   inherited;
   ViewFormPage := 0;
end;

function TfmcDLL_Base100.ReadCanEdit: Boolean;
begin
   Result := FEditMode;
end;

procedure TfmcDLL_Base100.PrepareReportData(var Accept: Boolean);
begin
   //
end;

procedure TfmcDLL_Base100.SetUseTemplate(const Value: string);
begin
  FUseTemplate := Value;
  if (FUseTemplate = '') and (FDefaultTemplate > '') then
     FUseTemplate := FDefaultTemplate;
end;

procedure TfmcDLL_Base100.GetDefaultTemplate;
begin
  DefaultTemplate := vTemplate.GetDefault(Self, FReportID, FGroupID);
end;

procedure TfmcDLL_Base100.SetDefaultTemplate(const Value: string);
begin
  FDefaultTemplate := Value;
  if (FUseTemplate = '') And (FDefaultTemplate > '') then  //如果目前沒有使用中的範本,就用Default值
    UseTemplate := FDefaultTemplate;
end;

procedure TfmcDLL_Base100.ADOMasterNewRecord(DataSet: TDataSet);
var
   vGUIDField: TField;
begin
   inherited;
   vGUIDField := DataSet.FindField('GUID');
   if Assigned(vGUIDField) then
      vGUIDField.AsString := GetGUIDNo(-1);
end;

procedure TfmcDLL_Base100.ClearTemplateSetup;
begin
  FUseTemplate := '';
  FDefaultTemplate := '';
end;

end.
