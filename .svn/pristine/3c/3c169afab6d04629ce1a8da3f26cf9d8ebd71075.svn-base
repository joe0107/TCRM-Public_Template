unit cTranBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cBase, ExtCtrls, RzPanel, DB, ADODB, JcCxGridResStr, Buttons,
  RzButton, RzPrgres;

type
  TfmcTranBase = class(TfmcBase)
    ADOConnection1: TADOConnection;
    RzPanel1: TRzPanel;
    RzProgressBar1: TRzProgressBar;
    btnOK: TRzToolbarButton;
    btnCancel: TRzToolbarButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FPosition: Integer;
    procedure SetPosition(const Value: Integer);
    { Private declarations }
  protected
    FBreak, FInTranData: Boolean;
    property Position: Integer read FPosition write SetPosition;
    function TranData: boolean; virtual;  
  public
    { Public declarations }
  end;

var
  fmcTranBase: TfmcTranBase;

implementation

uses cUtility;

{$R *.dfm}

{ TfmcTranBase }
procedure TfmcTranBase.btnCancelClick(Sender: TObject);
begin
   inherited;
   if FCanCloseForm then
      ModalResult := mrCancel
   else
   begin
      FBreak := True;
      btnCancel.Caption := '取消(&C)';
      FCanCloseForm := True;
      RzProgressBar1.Percent := 0;
      UpDate;
   end;   
end;

procedure TfmcTranBase.btnOKClick(Sender: TObject);
begin
   inherited;
   if FInTranData then exit;
   FInTranData := True;
   FBreak := False;
   FCanCloseForm := False;
   btnCancel.Caption := '中斷(&C)';
   try
      if TranData then
      begin
         btnCancel.Caption := '取消(&C)';
         xShowMessage('轉檔完成');
         FCanCloseForm := True;
         FBreak := False;
         FInTranData := False;
         ModalResult := mrOK;
      end
      else
      begin
         btnCancel.Caption := '取消(&C)';
         xShowMessage('中斷轉檔');
         FCanCloseForm := True;
         FBreak := False;
         FInTranData := False;
      end;   
   except
      FCanCloseForm := True;
      xShowMessage('轉檔失敗');      
      btnCancel.Caption := '取消(&C)';
      FBreak := False;
      FInTranData := False;
   end;   
end;

procedure TfmcTranBase.SetPosition(const Value: Integer);
begin
   if Value <> FPosition then
   begin
      FPosition := Value;
      RzProgressBar1.Visible :=  (Value > 0);
      RzProgressBar1.Percent := Value;
      RzProgressBar1.UpDate;
   end;   
end;

function TfmcTranBase.TranData: Boolean;
var
   K: integer;
begin
   Result := False;
   for K := 0 to 10000000 do
   begin
      if FBreak then exit;
      Application.ProcessMessages;
   end;   
   Result := True;   
end;

procedure TfmcTranBase.FormCreate(Sender: TObject);
begin
   inherited;
   FBreak := False;
   FInTranData := False;
   Position := 0;
end;

end.
