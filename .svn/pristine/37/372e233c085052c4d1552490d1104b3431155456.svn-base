unit vPrintToFileDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, RzSndMsg, IniFiles, RzButton, RzRadGrp,
  RzRadChk, Mask, RzEdit, RzBtnEdt, RzPanel;

type
  TfrmPrintToFileDlg = class(TForm)
    OpenDialog1: TOpenDialog;
    RzPanel3: TRzPanel;
    RzToolbarButton1: TRzToolbarButton;
    RzToolbarButton2: TRzToolbarButton;
    RadioGroup1: TRzRadioGroup;
    RzGroupBox1: TRzGroupBox;
    edtExportFile: TRzButtonEdit;
    CheckBox1: TRzCheckBox;
    CheckBox2: TRzCheckBox;
    procedure RadioGroup1Click(Sender: TObject);
    procedure spbOpenFileClick(Sender: TObject);
    procedure RzToolbarButton1Click(Sender: TObject);
    procedure RzToolbarButton2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FExpFileName: string;
    procedure SetExpFileName(const Value: string);
    { Private declarations }
  public
		{ Public declarations }
    property  ExpFileName: string read FExpFileName write SetExpFileName;
		function	GetLocalTempFile(prefix: string) : string;
		function	GetUniqueTempFile(TempPath, Prefix : string) : string;
		function	ReplaceFileExt(FileName, NewFileExt : string) : string;
		function	GetProperExportFileName(FileName : string) : string;
  end;

var
  frmPrintToFileDlg: TfrmPrintToFileDlg;

const
	PTF_CANCEL	=	-1;
	PTF_WORD		=	0;
	PTF_EXCEL		=	1;
	PTF_HTML		=	2;
	PTF_TEXT		=	3;

function	ExecPrintToFileDlg(AOWner: TComponent; var ExportFileName : string;	var OpenFile, EmailFile : Boolean) : Integer;

implementation

uses vRB_BASE, cController, cUtility;

{$R *.DFM}

function	ExecPrintToFileDlg(AOWner: TComponent; var ExportFileName : string;	var OpenFile, EmailFile : Boolean) : Integer;
begin
   if not Assigned(frmPrintToFileDlg) then
      frmPrintToFileDlg := TfrmPrintToFileDlg.Create(AOWner);
   with frmPrintToFileDlg do
   begin
      ExpFileName := ExportFileName;
     	edtExportFile.Text := GetProperExportFileName(GetLocalTempFile(ExportFileName+'~'));
 	  	if (ShowModal <> mrOk)	 then
		    	Result := -1
	  	else
		    	Result := RadioGroup1.ItemIndex;
	  	ExportFileName := edtExportFile.Text;
	  	OpenFile := CheckBox1.Checked;
      EmailFile:= CheckBox2.Checked;
	  	Free;
   end;
end;

{ TfrmPrintToFileDlg }
function TfrmPrintToFileDlg.GetLocalTempFile(prefix: string): string;
begin
   Result := GetUniqueTempFile(GetSysTempPath, prefix);
end;

function TfrmPrintToFileDlg.GetUniqueTempFile(TempPath, Prefix : string): string;
var
   K : Integer;
begin
	 K := 1;
	 while True  do
	 begin
		  Result := Format('%s\%s%d.tmp', [TempPath, Prefix, K]);
      Result := GetProperExportFileName(Result);
		  if not FileExists(Result) then break;
		  Inc(K);
	 end;
end;

function TfrmPrintToFileDlg.ReplaceFileExt(FileName, NewFileExt : string) : string;
var
	 sOrgExt : string;
begin
	 sOrgExt := ExtractFileExt(FileName);
	 FileName := Copy(FileName, 1, Length(FileName)-Length(sOrgExt));
	 Result := Format('%s.%s', [FileName, NewFileExt]);
end;

function TfrmPrintToFileDlg.GetProperExportFileName(
	 FileName: string): string;
begin
	 case RadioGroup1.ItemIndex of
		0: Result := ReplaceFileExt(FileName, 'doc');
		1: Result := ReplaceFileExt(FileName, 'xls');
		2: Result := ReplaceFileExt(FileName, 'htm');
		3: Result := ReplaceFileExt(FileName, 'txt');
	 end;
end;

procedure TfrmPrintToFileDlg.RadioGroup1Click(Sender: TObject);
begin
	 edtExportFile.Text := GetProperExportFileName(GetLocalTempFile(FExpFileName+'~'));
end;

procedure TfrmPrintToFileDlg.spbOpenFileClick(Sender: TObject);
begin
	if OpenDialog1.Execute then	edtExportFile.Text := OpenDialog1.FileName;
end;

procedure TfrmPrintToFileDlg.SetExpFileName(const Value: string);
begin
  FExpFileName := Value;
end;

procedure TfrmPrintToFileDlg.RzToolbarButton1Click(Sender: TObject);
begin
   ModalResult := MrOK;
end;

procedure TfrmPrintToFileDlg.RzToolbarButton2Click(Sender: TObject);
begin
   ModalResult := MrCancel;
end;

procedure TfrmPrintToFileDlg.FormDestroy(Sender: TObject);
begin
  frmPrintToFileDlg := nil;
  Inherited;
end;

end.
