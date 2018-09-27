unit cBackGround;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzBckgnd;

type
  TfmBrForm = class(TForm)
    RzBackground1: TRzBackground;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetFormPosition;
  public
    { Public declarations }
  end;

procedure SetBackground(aVisible: Boolean);

var
  fmBrForm: TfmBrForm;

implementation


{$R *.dfm}

function GetWorkRect: TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @Result, 0)
end;

procedure SetBackground(aVisible: Boolean);
begin
  if not Assigned(fmBrForm) then
    fmBrForm := TfmBrForm.Create(Application);
  if aVisible then
  begin
    fmBrForm.SendToBack;
    fmBrForm.Show;
  end
  else
    fmBrForm.Hide;
end;

{ TfmBrForm }

procedure TfmBrForm.SetFormPosition;
var
  xRect: TRect;
begin
  xRect := GetWorkRect;
  Top := 0;
  Left := 0;
  Width := xRect.Right;
  Height := xRect.Bottom;
end;

procedure TfmBrForm.FormCreate(Sender: TObject);
begin
  SetFormPosition;
end;

end.
