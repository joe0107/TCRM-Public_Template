unit cQueryBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cDLL_Base, Buttons, RzButton, ExtCtrls, RzPanel, DB, DBTables,
  AstaDrv2, AstaClientDataset, DBClient, JcCxGridResStr, ADODB, BetterADODataSet,
  cxPropertiesStore;

type
  TfmcQueryBase = class(TfmcDLL_Base)
    RzPanel1: TRzPanel;
    btnOK: TRzToolbarButton;
    btnCancel: TRzToolbarButton;
    cdsMaster: TClientDataSet;
    dsMaster: TDataSource;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FOriginalSQL: Variant;
    FRunningSQL: Variant;
    FRunning: boolean;
    procedure SetOriginalSQL(const Value: Variant);
    procedure SetRunningSQL(const Value: Variant);
    procedure SetRunning(const Value: boolean);
  protected
    function CheckQueryData: Boolean; virtual;
    procedure BeforeComposeSQL(var aRunningSQL: Variant); Virtual;
  public                        
    { Public declarations }
    FShowMsg: Boolean;
    FacsMaster: TDataSet;
    FUseADO: Boolean;
    property OriginalSQL: Variant read FOriginalSQL write SetOriginalSQL;
    property RunningSQL: Variant read FRunningSQL write SetRunningSQL;
    property Running: boolean read FRunning write SetRunning;
    procedure InitOriginalSQL; virtual;
    procedure PrepareSearchSQL; virtual;
    class procedure Execute(AOWner: TComponent; var aDataSet: TDataSet); virtual;
  end;

implementation

uses cDLL_Base100, cUtility;

{$R *.dfm}

procedure TfmcQueryBase.btnOKClick(Sender: TObject);
begin
   inherited;
   if DataSetInEditing(cdsMaster) then cdsMaster.Post;
   if CheckQueryData then
   begin
      TDataSet(FacsMaster).Active := False;
      PrepareSearchSQL;
      TDataSet(FacsMaster).Open;
      if FacsMaster.IsEmpty then
      begin
         if Owner is TfmcDLL_Base100 then
         begin
            if (FShowMsg) And (not TfmcDLL_Base100(Owner).FStartQuery) then
               xShowMessage('資料庫中查無符合條件的資料');
         end;
      end;
      ModalResult := mrOK;
      Application.ProcessMessages;
   end;
end;

procedure TfmcQueryBase.btnCancelClick(Sender: TObject);
begin
   inherited;
   ModalResult := mrCancel;
   Application.ProcessMessages;
end;

class procedure TfmcQueryBase.Execute(AOWner: TComponent; var aDataSet: TDataSet);
begin
end;

procedure TfmcQueryBase.SetOriginalSQL(const Value: Variant);
begin
  FOriginalSQL := Value;
end;

procedure TfmcQueryBase.SetRunningSQL(const Value: Variant);
begin
  FRunningSQL := Value;
end;

procedure TfmcQueryBase.InitOriginalSQL;
begin
  if FUseADO then
     OriginalSQL := SplitSQL(TBetterADODataSet(FacsMaster).CommandText)
  else
     OriginalSQL := SplitSQL(TAstaClientDataSet(FacsMaster).SQL);
end;

procedure TfmcQueryBase.FormCreate(Sender: TObject);
begin
   inherited;
   FUseADO := False;
   FShowMsg := True;
   FRunning := False;
   cdsMaster.CreateDataSet;
   cdsMaster.Edit;
   cdsMaster.Post;
end;

procedure TfmcQueryBase.PrepareSearchSQL;
var
   K: integer;
   NewFilter, PS1, PS2: string;
   vValueList: TStringList;

   Procedure GetSQLText(FieldName: String);
   var
      S, S1, S2, mText: string;
   begin
      if not xVarIsEmpty(cdsMaster.FieldByName(FieldName).Value) then
      begin
         mText := cdsMaster.FieldByName(FieldName).AsString;
         Cut2String(FieldName, S1, S2);
         if S1 <> 'TEMP' then
         begin
            if S1 = 'START' then  //條件的開始
            begin
               S := '%s >= :%s';
               NewFilter := Format(S, [S2, FieldName]);
               RunningSQL := AppendWhereFilter(RunningSQL, NewFilter);
            end
            else if S1 = 'END' then
            begin
               S := '%s <= :%s';
               NewFilter := Format(S, [S2, FieldName]);
               RunningSQL := AppendWhereFilter(RunningSQL, NewFilter);
            end
            else if cdsMaster.FieldByName(FieldName).DataType = ftString then
            begin
               NewFilter := ParseStringFilter(FieldName, mText);
               RunningSQL := AppendWhereFilter(RunningSQL, NewFilter);
               vValueList.Values[FieldName] := mText;
            end
            else if cdsMaster.FieldByName(FieldName).DataType = ftMemo then
            begin
               S := '%s Like :%s';
               NewFilter := Format(S, [S2, FieldName]);
               RunningSQL := AppendWhereFilter(RunningSQL, NewFilter);
            end
            else
            begin
               S := '%s = :%s';
               NewFilter := Format(S, [S2, FieldName]);
               RunningSQL := AppendWhereFilter(RunningSQL, NewFilter);
            end;
         end;
     end;
  end;

begin
   vValueList := TStringList.Create;
   vValueList.Clear;
   try
      RunningSQL := FOriginalSQL;
      for K := 0 to cdsMaster.FieldCount - 1 do
         GetSQLText(cdsMaster.Fields[K].FieldName);
      BeforeComposeSQL(FRunningSQL);
      if FUseADO then
         TBetterADODataSet(FacsMaster).CommandText := ComposeSQL(RunningSQL)
      else
         TAstaClientDataSet(FacsMaster).SQL.Text := ComposeSQL(RunningSQL);
      for K := 0 to cdsMaster.FieldCount - 1 do
      begin
         Cut2String(cdsMaster.Fields[K].FieldName, PS1, PS2);
         if PS1 <> 'TEMP' then
         begin
            if not xVarIsEmpty(cdsMaster.Fields[K].Value) then
            begin
               if vValueList.Values[cdsMaster.Fields[K].FieldName] > '' then
               begin
                  if FUseADO then
                     TBetterADODataSet(FacsMaster).Parameters.ParamByName(cdsMaster.Fields[K].FieldName).Value :=
                          vValueList.Values[cdsMaster.Fields[K].FieldName]
                  else
                     TAstaClientDataSet(FacsMaster).Params.ParamByName(cdsMaster.Fields[K].FieldName).AsString :=
                          vValueList.Values[cdsMaster.Fields[K].FieldName];
               end
               else
               begin
                  case cdsMaster.Fields[K].DataType of
                  ftString:
                     if FUseADO then
                        TBetterADODataSet(FacsMaster).Parameters.ParamByName(cdsMaster.Fields[K].FieldName).Value :=
                            cdsMaster.Fields[K].AsString
                     else
                        TAstaClientDataSet(FacsMaster).Params.ParamByName(cdsMaster.Fields[K].FieldName).AsString :=
                            cdsMaster.Fields[K].AsString;
                  ftMemo:
                     if FUseADO then
                        TBetterADODataSet(FacsMaster).Parameters.ParamByName(cdsMaster.Fields[K].FieldName).Value :=
                            '%' + cdsMaster.Fields[K].AsString + '%'
                     else
                        TAstaClientDataSet(FacsMaster).Params.ParamByName(cdsMaster.Fields[K].FieldName).AsString :=
                            '%' + cdsMaster.Fields[K].AsString + '%';
                  ftSmallint, ftInteger, ftWord:
                     if FUseADO then
                        TBetterADODataSet(FacsMaster).Parameters.ParamByName(cdsMaster.Fields[K].FieldName).Value :=
                            cdsMaster.Fields[K].AsInteger
                     else
                        TAstaClientDataSet(FacsMaster).Params.ParamByName(cdsMaster.Fields[K].FieldName).AsInteger :=
                            cdsMaster.Fields[K].AsInteger;
                  ftDate, ftTime, ftDateTime:
                     if FUseADO then
                        TBetterADODataSet(FacsMaster).Parameters.ParamByName(cdsMaster.Fields[K].FieldName).Value :=
                            cdsMaster.Fields[K].AsDateTime
                     else
                        TAstaClientDataSet(FacsMaster).Params.ParamByName(cdsMaster.Fields[K].FieldName).AsDateTime :=
                            cdsMaster.Fields[K].AsDateTime;
                  ftFloat:
                     if FUseADO then
                        TBetterADODataSet(FacsMaster).Parameters.ParamByName(cdsMaster.Fields[K].FieldName).Value :=
                            cdsMaster.Fields[K].AsFloat
                     else
                        TAstaClientDataSet(FacsMaster).Params.ParamByName(cdsMaster.Fields[K].FieldName).AsFloat :=
                            cdsMaster.Fields[K].AsFloat;
                  end;
               end;
            end;
         end;
      end;
   finally
      vValueList.Free;
   end;
end;

function TfmcQueryBase.CheckQueryData: Boolean;
const
   cMsg = '您沒有輸入任何過濾的條件'#13'這樣會從主機中下載大量的資料'#13'您確定嗎???';
var
   K: integer;
   R: boolean;
begin
   Result := True;
   R := False;
   for K := 0 to cdsMaster.FieldCount - 1 do
      if not VarIsNull(cdsMaster.Fields[K].Value) then
         R := True;
   if not R then
      Result := xMsgWarning(cMsg, MB_YESNO) = mrYes;
end;

procedure TfmcQueryBase.SetRunning(const Value: boolean);
begin
   FRunning := Value;
   Enabled := not Value;
   UpDate;
end;

procedure TfmcQueryBase.BeforeComposeSQL(Var aRunningSQL: Variant);
begin

end;

end.
