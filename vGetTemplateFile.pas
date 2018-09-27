unit vGetTemplateFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzEdit, RzButton, RzRadChk, Mask, RzBtnEdt, RzLabel,
  Buttons, ExtCtrls, RzPanel, RzShellDialogs;

type
  TfmGetTemplateFile = class(TForm)
    RzPanel2: TRzPanel;
    RzToolbarButton1: TRzToolbarButton;
    RzToolbarButton2: TRzToolbarButton;
    RzLabel1: TRzLabel;
    RzButtonEdit1: TRzButtonEdit;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzCheckBox1: TRzCheckBox;
    RzEdit1: TRzEdit;
    RzMemo1: TRzMemo;
    RzOpenDialog1: TRzOpenDialog;
    procedure RzToolbarButton1Click(Sender: TObject);
    procedure RzToolbarButton2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzButtonEdit1ButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function Execute(AOwner: TComponent; ADefaultName: string = ''; AShowFile: Boolean = True): boolean;

var
  fmGetTemplateFile: TfmGetTemplateFile;

implementation

uses cController;

{$R *.dfm}

function Execute(AOwner: TComponent; ADefaultName: string = ''; AShowFile: Boolean = True): boolean;
begin
   if not Assigned(fmGetTemplateFile) then
      fmGetTemplateFile := TfmGetTemplateFile.Create(AOwner);
   with fmGetTemplateFile do
   begin
      RzButtonEdit1.Visible := AShowFile;
      RzLabel2.Visible := AShowFile;
      RzButtonEdit1.Text := '';
      RzEdit1.Text := ADefaultName;
      RzCheckBox1.Checked := False;
      RzMemo1.Text := '';
      Result := (ShowModal = mrOK);
   end;
end;

procedure TfmGetTemplateFile.RzToolbarButton1Click(Sender: TObject);
begin
   ModalResult := mrOK;
end;

procedure TfmGetTemplateFile.RzToolbarButton2Click(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TfmGetTemplateFile.FormDestroy(Sender: TObject);
begin
   fmGetTemplateFile := nil;
end;

procedure TfmGetTemplateFile.RzButtonEdit1ButtonClick(Sender: TObject);
var
   L, P: Integer;
   S: string;
begin
   if RzOpenDialog1.Execute then
   begin
      RzButtonEdit1.text := RzOpenDialog1.FileName;
      L := Length(ExtractFileDir(RzButtonEdit1.text));
      S := copy(RzButtonEdit1.text, L+2, MaxInt);
      P := Pos('.', S);
      if P > 0 then RzEdit1.Text := Copy(S, 1, P - 1);
   end;
end;

end.
