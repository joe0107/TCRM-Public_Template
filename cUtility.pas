unit cUtility;

interface
uses Windows, Messages, Classes, Controls, SysUtils, Math, Dialogs, {TypInfo, ShellApi,}
     Forms, DB, DBTables, {ActiveX, ComObj,} Variants;

const
   ORDER_LRTD = 1;
   ORDER_TDLR = 2;

   V_SQL_SELECT  = 0;
   V_SQL_FROM    = 1;
   V_SQL_WHERE   = 2;
   V_SQL_GROUP   = 3;
   V_SQL_ORDER   = 4;

function SplitSQL(SrcSQL: string): Variant; overload;
function SplitSQL(SrcSQL: TStrings): Variant; overload;
procedure ResortTabOrder(var FirstControl, LastControl: TWinControl; Container: TWinControl; OrderDir: Integer = ORDER_LRTD); overload;
procedure ResortTabOrder(Container: TWinControl; OrderDir: Integer = ORDER_LRTD); overload;
procedure CopyRecord(cdsDest, cdsSrc: TDataSet; ExclusiveFields: TStringList; AutoPost: Boolean = True); overload;
procedure CopyRecord(cdsDest, cdsSrc: TDataSet; ExclusiveField: string; AutoPost: Boolean = True); overload;
procedure CopyDataSet(cdsDest, cdsSrc: TDataSet; ExclusiveFields: TStringList; AutoPost: Boolean = True); overload;
procedure CopyDataSet(cdsDest, cdsSrc: TDataSet; ExclusiveField: string; AutoPost: Boolean = True); overload;
procedure WriteMsgToLogFile(aUser, aMsg: String);

{�ǶiApplication.Handle���NDLL��Application.Handle}
procedure ReplaceApplicationHandle(aApplication: TApplication); external 'Utility.DLL';
{�ˬd���������X�O�_���T}
function CheckCreatID(S: string): Boolean; external 'Utility.DLL';
{�ˬd��~�H�����@�Ӹ��X�O�_���T}
function CheckForeignCreatID(S, Name: string; BirthDay: TDatetime): Boolean; external 'Utility.DLL';
{�ˬd�Τ@�s���O�_���T}
function CheckCreatNO(const CreatNO: string): Boolean; external 'Utility.DLL';
{�ˬd�k��N�Ӧr���O�_���O�Ʀr}
function RightNumber(const Number: string; FInt: byte): boolean; external 'Utility.DLL';
{�ˬd����N�Ӧr���O�_���O�Ʀr}
function LeftNumber(const Number: string; FInt: byte): boolean; external 'Utility.DLL';
{���k��N�Ӧr��}
function RCopy(S: string; FInt: byte): string; external 'Utility.DLL';
{��r���নDouble�ƭȫ��A}
function StrToDouble(S: string): Double; external 'Utility.DLL';
{���|�ˤ��J}
function ExtRound(Number: Double; Digit: Extended): Double; external 'Utility.DLL';
{��GUID�r��}
function GetGUIDNo(Max_Len: Integer = 32): string; external 'Utility.DLL';
{�ɺ�N��}
function FillZero(S: string; I: integer; CChar: Char = '0'; Front: boolean = True): string; external 'Utility.DLL';
{�N����ন�r���øɺ�N��}
function IntToStrFillZero(const I, Number: Integer): string; external 'Utility.DLL';
{�⥬�L���নY/N�r��}
function BoolToStr(B: boolean): string; external 'Utility.DLL';
{��Y/N�r���ন���L��}
function StrToBool(S: string): boolean; external 'Utility.DLL';
{����|�r��ɤW'\'�r��}
function IncludeTrailingBackslash(PathName: string): string; external 'Utility.DLL';
{�N�r��̤��j�r����Ѧ�string List}
procedure CutString(var aList: TStringList; S: string; Separate: string = ';'); external 'Utility.DLL';
{��900101�榡���r���ন������A}
function GetDate(S: string): TDateTime; external 'Utility.DLL';
{���X������~�׭�}
function GetYear(vDat: TDateTime): word; external 'Utility.DLL';
{�������A�ন���w�榡������r��}
function GetRocFormatDate(vDat: TDateTime; vFmt: Byte = 0): string; external 'Utility.DLL';
{���o����Ҧb���|�p�~��}
procedure GetAcctYear(vAcctStart, vDat: TDateTime; var vYear: word); external 'Utility.DLL';
{���o����O�Ҧb�|�p�~�ת��ĴX�Ӥ��}
procedure GetAcctMonth(vAcctStart, vDat: TDateTime; var vYear, vMonth:word); external 'Utility.DLL';
{���o�Y�|�p�~�ת��}�l���}
function GetAcctYearStart(vAcctStart: TDateTime; vYear: word): TDateTime; external 'Utility.DLL';
{���o�Y�|�p�~�ת��������}
function GetAcctYearEnd(vAcctStart: TDateTime; vYear: word): TDateTime; external 'Utility.DLL';
{���o�|�p�~�몺�}�l���}
function GetAcctMonthStart(vAcctStart: TDateTime; vYear, vMonth: word): TDateTime; external 'Utility.DLL';
{���o�|�p�~�몺�������}
function GetAcctMonthEnd(vAcctStart: TDateTime; vYear, vMonth: word): TDateTime; external 'Utility.DLL';
{�ˬd�Y����O�_���Y���ݩ�}
function HasProp(sender: TObject; const S: string): Boolean; external 'Utility.DLL';
{�N�r��[�K}
function EngEnCrypt(S: ShortString): ShortString; external 'Utility.DLL';
{�N�r��ѱK}
function EngDeCrypt(S: ShortString): ShortString; external 'Utility.DLL';
{�N�r���Ѧ�SELECT FROM WHERE GROUP ORDER �� LIST}
function SplitSQL1(SrcSQL: string): Variant; external 'Utility.DLL';
{�NTSTRINGS��Ѧ�SELECT FROM WHERE GROUP ORDER �� LIST}
function SplitSQL2(SrcSQL: TStrings): Variant; external 'Utility.DLL';
{SELECT FROM WHERE GROUP ORDER �� LIST}
function ComposeSQL(vSQL: Variant): string; external 'Utility.DLL';
{�����r��[��WHERE���}�C��}
function AppendWhereFilter(vSQL: Variant; NewFilter: string): Variant; external 'Utility.DLL';
{}
function ParseStringFilter(FieldName: string; var FilterValue: string): string; external 'Utility.DLL';
{���s�]�wORDER������}
procedure ResortTabOrder1(var FirstControl, LastControl: TWinControl; Container: TWinControl; OrderDir: Integer = ORDER_LRTD); external 'Utility.DLL';
{���s�]�wORDER������}
procedure ResortTabOrder2(Container: TWinControl; OrderDir: Integer = ORDER_LRTD); external 'Utility.DLL';
{�N��������,�ñN�ܼƲM��NIL}
procedure FreeAndNil(Obj: TObject); external 'Utility.DLL';
{}
function ConvertDBByteToOneByte(S: string): string; external 'Utility.DLL';
{}
function Num2BCNum(dblArabic: Double): string; external 'Utility.DLL';
{}
function AnsiCopy(S: string; Index, Count: Integer): string; external 'Utility.DLL';
{}
procedure AnsiDelete(var S: string; Index, Count: Integer); external 'Utility.DLL';
{}
procedure AnsiInsert(Source: string; var S: string; Index: Integer); external 'Utility.DLL';
{}
function AnsiLength(S: string): Integer; external 'Utility.DLL';
{}
function CheckISDBCSLeadByte(S: string): Boolean; external 'Utility.DLL';
{��ܰT������}
function xMessageBox(const Text, Caption: string; Flags: Longint): Integer; external 'Utility.DLL';
{��ܰT������}
function xMessageDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: Integer): Word; external 'Utility.DLL';
{��ܰT��}
function xShowMessage(const Msg: string; Buttons: LongInt = MB_OK): Word; external 'Utility.DLL';
{���ĵ�i�T��}
function xMsgWarning(const Msg: string; Buttons: Longint = MB_OK): Word; external 'Utility.DLL';
{��ܿ��~�T��}
function xMsgError(const Msg: string; Buttons: LongInt = MB_OK): Word; external 'Utility.DLL';
{��ܸ�T�T��}
function xMsgInformation(const Msg: string; Buttons: Longint = MB_OK): Word; external 'Utility.DLL';
{��ܽT�{�T��}
function xMsgConfirmation(const Msg: string; Buttons: LongInt = MB_YESNO): Word; external 'Utility.DLL';
{���oINI���ɦW}
function GetIniFileName: string; external 'Utility.DLL';
{���oLog���ɦW}
function GetLogFileName: string; external 'Utility.DLL';
{���oSQL���ɦW}
function GetScpFileName: string; external 'Utility.DLL';
{���o���ε{�����Ҧb���|}
function GetAppPath: string; external 'Utility.DLL';
{�R�����w���|�������ɮ�}
procedure DeleteAllFile(sDir: string); external 'Utility.DLL';
{�ק��ɮת��ק���}
procedure ModifyFileDate(FileName: string; ModifyDate: TDateTime); external 'Utility.DLL';
{����..�ɶ�}
procedure Delay(DelayTime: DWORD); external 'Utility.DLL';
{}
function GetStrokes(ADBCSWord: string): integer; external 'Utility.DLL';
{}
function CutChineseString(SS: String; nPos: Integer; var S1, S2: String):Boolean; external 'Utility.DLL';
{}
function BStrSplit(S :string; Line_Len: Integer; var aList: TStringList): Boolean; external 'Utility.DLL';
{}
procedure ExecuteOpen(OpenFile: string); external 'Utility.DLL';
{}
procedure ExecutePrint(PrintFile: string); external 'Utility.DLL';
{}
procedure ExecuteExplore(ExploreFile: string); external 'Utility.DLL';
{������ƶ������c}
function CopyStruct(vSDataSet, vDDataSet: TDataSet): Boolean; external 'Utility.DLL';
{�P�_�o�Ӹ�ƶ��O�_�b�s�誺�Ҧ��U}
function DataSetInEditing(vDataSet: TDataSet): Boolean; external 'Utility.DLL';
{}
procedure dShowPromptBox(const Prompt: string); external 'Utility.DLL';
{}
procedure dHidePromptBox; external 'Utility.DLL';
{}
procedure dShowWaitPrompt(Title, Msg1, Msg2: string); external 'Utility.DLL';
{}
procedure dCloseWaitPrompt; external 'Utility.DLL';
{}
procedure dShowProgramVersion(PgmFileName, PgmFileVersion, PgmFileDate: String); external 'Utility.DLL';
{}
function dCheckTableExist(vTableName: string): Boolean; external 'Utility.DLL';
{}
function dGetTableDisplay(vTableName: string): string; external 'Utility.DLL';
{}
function dGetFieldDisplay(vFieldName: string): string; external 'Utility.DLL';
{}
function dGetMessageStr(vMsgNo: Integer): string; external 'Utility.DLL';
{���Y�ɮ�}
procedure dZipFile(const SourceFile, destination: string); external 'Utility.DLL';
{�����Y�ɮ�}
procedure dUnZipFile(SourceFile, DestFile: string); external 'Utility.DLL';
{}
procedure dSendMsgTo(aIP: string; aMsg: string); external 'Utility.DLL';
{}
procedure dCastMsgTo(aMsg: string); external 'Utility.DLL';
{}
function IIF(Condition: Boolean; YesResult, NoResult: Variant): Variant; external 'Utility.DLL';
{}
function MbcsSafeCopy(SrcStr: string; StartPos, CopyLen: Integer): string; external 'Utility.DLL';
{�N�r���ন�ƭ�}
function StrToFloatDef(const S: string; const DefaultValue: Extended): Extended; external 'Utility.DLL';
{�N��ƶ�����ƲM��}
procedure EmptyDataSet(DataSet: TDataSet); external 'Utility.DLL';
{�����Y�Ӹ�Ƭ���}
procedure CopyRecord1(cdsDest, cdsSrc: TDataSet; ExclusiveFields: TStringList; AutoPost: Boolean = True); external 'Utility.DLL';
{�����Y�Ӹ�Ƭ���}
procedure CopyRecord2(cdsDest, cdsSrc: TDataSet; ExclusiveField: string; AutoPost: Boolean = True); external 'Utility.DLL';
{�����Y�Ӹ�ƶ�}
procedure CopyDataSet1(cdsDest, cdsSrc: TDataSet; ExclusiveFields: TStringList; AutoPost: Boolean = True); external 'Utility.DLL';
{�����Y�Ӹ�ƶ�}
procedure CopyDataSet2(cdsDest, cdsSrc: TDataSet; ExclusiveField: string; AutoPost: Boolean = True); external 'Utility.DLL';
{���o�������Ȧs�ɸ��|}
function GetSysTempPath: string; external 'Utility.DLL';
{�⤽���ন�ù��I}
function MmToPixel(Mm: Integer): Integer; external 'Utility.DLL';
{�Ǧ^N�Ӫťզr��}
function SpaceN(N: Integer): string; external 'Utility.DLL';
{}
procedure ParseToken(SrcStr, Delimiter: string; var slResult: TStringList); external 'Utility.DLL';
{}
procedure GetMemoContent(SrcStr: string; const CharPerLine: Integer; aLines: TStrings); external 'Utility.DLL';
{���o�������Ȧs�ɸ��|}
function GetLocalTempPath: string; external 'Utility.DLL';
{��ܨҥ~������}
function ShowExcept(E: Exception): boolean; external 'Utility.DLL';
{��J����}
function GetPrompt(AOwner: TComponent; ALabel: string; ACheck: string = '';
                   ACaption: string = '��ƿ�J'; AValue: string=''): string; external 'Utility.DLL';
{�P�_�Y����Τ�����O�_���Y���O}
function HasClass(xControl: TWinControl; xClass: TClass): Boolean; external 'Utility.DLL';
{�P�_�Y����O�_�b�Y�����}
function InWinControl(xControl: TWinControl; xObject: TComponent): Boolean; external 'Utility.DLL';
{��S�r����Ӧr����j�r��'_'}
procedure Cut2String(const S: string; var S1, S2: string); external 'Utility.DLL';
{�P�_�YVariant�ܼƬO�_���ťթ�Null}
function xVarIsEmpty(xV: Variant): boolean; external 'Utility.DLL';
{�NDATASET������নDBISAM��}
procedure DataSetTODBISAM(aDataSet: TDataSet; aTableName: string); external 'Utility.DLL';
{�NDATASET������নEXCEL��}
procedure DataSetToExcel(aDataSet: TDataSet; aExcelName: string); external 'Utility.DLL';
{��MSN���˦���ܰT��}
procedure ShowMsnMsg(const Info: string); external 'Utility.DLL';
{��J�K�X����}
function GetPassword(aLabel: string): string; external 'Utility.DLL';
{��J���ɦW�����O}
function	ExecPrintToFileDlg(AOWner: TComponent; var ExportFileName : string;	var OpenFile, EmailFile : Boolean) : Integer; external 'Utility.DLL';
{���ݸ�ƶ��}�ҧ���}
procedure WaitforOpen(aDataSet: TDataSet); external 'Utility.DLL';
{���o�t�θ�Ʀs����|}
function GetSysDataPath: string; external 'Utility.DLL';
{�ˬd�O�_�i�H���T�s�u��IP}
function CheckCanConnectTo(aIP: string): Integer; external 'Utility.DLL';
{���o�q���W��}
function xGetComputerName: string; external 'Utility.DLL';
{���o�q���W�٪�IP��}}
function xGetComputerIP(aComputerName: string): string; external 'Utility.DLL';
{���o��n����쪺�W��}
function GetFieldName(aFixStr: string; aFieldNo: integer): string; external 'Utility.DLL';
function xVarToStr(xV: Variant): string; external 'Utility.DLL';
function xVarToDateTime(xV: Variant): TDateTime; external 'Utility.DLL';
procedure WriteToLogFile(aMsg: string; aLogFile: string=''); external 'Utility.DLL';
function GetCheckNumber(aStr: string): integer; external 'Utility.DLL';
function GetNextFieldName(aFieldName: string): string; external 'Utility.DLL';
procedure ChangeDDMMSS(aDateTime:TDateTime; var aDay, aHours, aMin, aSec: Integer); external 'Utility.DLL';
function SaveToExcel(aDataSet: TDataSet; aFileName: string; aView: Boolean = False): string; external 'Utility.DLL';  
function ReadFromExcel(aDataSet: TDataSet): Boolean; external 'Utility.DLL';  
function GetFileDisplayLabel(aFileName: string): string;  external 'Utility.DLL';  
function GetFieldDisplayLabel(aFieldName: string): string;  external 'Utility.DLL';  

Const
   LogMsgFmt = '[%s(%s)]: %s';

implementation

function SplitSQL(SrcSQL: string): Variant;
begin
   Result := SplitSQL1(SrcSQL);
end;

function SplitSQL(SrcSQL: TStrings): Variant;
begin
   Result := SplitSQL2(SrcSQL);
end;

procedure ResortTabOrder(var FirstControl, LastControl: TWinControl; Container: TWinControl; OrderDir: Integer = ORDER_LRTD);
begin
   ResortTabOrder1(FirstControl, LastControl, Container, OrderDir)
end;

procedure ResortTabOrder(Container: TWinControl; OrderDir: Integer = ORDER_LRTD);
begin
   ResortTabOrder2(Container, OrderDir)
end;

procedure CopyRecord(cdsDest, cdsSrc: TDataSet; ExclusiveFields: TStringList; AutoPost: Boolean = True);
begin
   CopyRecord1(cdsDest, cdsSrc, ExclusiveFields, AutoPost);
end;

procedure CopyRecord(cdsDest, cdsSrc: TDataSet; ExclusiveField: string; AutoPost: Boolean = True);
begin
   CopyRecord2(cdsDest, cdsSrc, ExclusiveField, AutoPost);
end;

procedure CopyDataSet(cdsDest, cdsSrc: TDataSet; ExclusiveFields: TStringList; AutoPost: Boolean = True);
begin
   CopyDataSet(cdsDest, cdsSrc, ExclusiveFields, AutoPost);
end;

procedure CopyDataSet(cdsDest, cdsSrc: TDataSet; ExclusiveField: string; AutoPost: Boolean = True);
begin
   CopyDataSet(cdsDest, cdsSrc, ExclusiveField, AutoPost);
end;

procedure WriteMsgToLogFile(aUser, aMsg: String);
var
   xFileName: string;
begin
   xFileName := ChangeFileExt(Application.ExeName, aUser+'.Log');
   WriteToLogFile(Format(LogMsgFmt, [aUser, DateTimeToStr(Now), aMsg]), xFileName);
end;

end.



