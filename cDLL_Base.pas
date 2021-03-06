unit cDLL_Base;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TypInfo, cBase, JcCxGridResStr, DB, ADODB, cxTextEdit, cxMemo, cxDBEdit,
  cxPropertiesStore, cxClasses;

type
  TfmcDLL_Base = class(TfmcBase)
  private
    //procedure ReplaceConnection;
  protected
    procedure InitializationValues; override;
    //procedure ReplaceAllImeName(aControl: TWinControl);
  public
    { Public declarations }
  end;

var
  fmcDLL_Base: TfmcDLL_Base;

implementation

uses cUtility;

{$R *.dfm}

procedure TfmcDLL_Base.InitializationValues;
begin
   inherited;
   (*
   if not (csDesigning In ComponentState) then
   begin
     ReplaceConnection;
     ReplaceAllImeName(Self);
   end;
   *)
end;
(*
procedure TfmcDLL_Base.ReplaceAllImeName(aControl: TWinControl);
var
   K: Integer;
begin
  with aControl do
  begin
    for K := 0 to ComponentCount - 1 do
    begin
      if (Components[K] is TcxDBTextEdit) or (Components[K] is TcxDBMemo) or
         (Components[K] is TcxTextEdit) or (Components[K] is TcxMemo) then
      begin
        with TcxDBTextEdit(Components[K]) do
        begin
          if ImeMode = imOpen then
             ImeName := cDLLDm.dmcDLL.cdsLogin.FieldByName('Master006').AsString;
        end;
      end;
    end;
  end;
end;

procedure TfmcDLL_Base.ReplaceConnection;
var
   K: integer;
begin
   if Assigned(cDLLDm.FMainConnection) then
   begin
      for K := 0 to ComponentCount - 1 do
      begin
         if Components[K] is TAstaClientDataset then
         begin
            TAstaClientDataset(Components[K]).AstaClientSocket := cDLLDm.FMainConnection;
         end
         else if Components[K] is TCustomADODataSet then
         begin
            TCustomADODataSet(Components[K]).Connection := cDLLDm.FMainADOConnection;
            if Components[K] is TADODataSet then
              TADODataSet(Components[K]).CommandTimeout := cDLLDm.FMainADOConnection.CommandTimeout;
         end;
      end;
   end;
end;
*)
end.
