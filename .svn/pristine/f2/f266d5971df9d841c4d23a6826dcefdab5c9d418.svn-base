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

{傳進Application.Handle取代DLL的Application.Handle}
procedure ReplaceApplicationHandle(aApplication: TApplication); external 'Utility.DLL';
{檢查身分正號碼是否正確}
function CheckCreatID(S: string): Boolean; external 'Utility.DLL';
{檢查國外人員的護照號碼是否正確}
function CheckForeignCreatID(S, Name: string; BirthDay: TDatetime): Boolean; external 'Utility.DLL';
{檢查統一編號是否正確}
function CheckCreatNO(const CreatNO: string): Boolean; external 'Utility.DLL';
{檢查右邊N個字元是否都是數字}
function RightNumber(const Number: string; FInt: byte): boolean; external 'Utility.DLL';
{檢查左邊N個字元是否都是數字}
function LeftNumber(const Number: string; FInt: byte): boolean; external 'Utility.DLL';
{取右邊N個字元}
function RCopy(S: string; FInt: byte): string; external 'Utility.DLL';
{把字元轉成Double數值型態}
function StrToDouble(S: string): Double; external 'Utility.DLL';
{取四捨五入}
function ExtRound(Number: Double; Digit: Extended): Double; external 'Utility.DLL';
{取GUID字串}
function GetGUIDNo(Max_Len: Integer = 32): string; external 'Utility.DLL';
{補滿N位}
function FillZero(S: string; I: integer; CChar: Char = '0'; Front: boolean = True): string; external 'Utility.DLL';
{將整數轉成字元並補滿N位}
function IntToStrFillZero(const I, Number: Integer): string; external 'Utility.DLL';
{把布林值轉成Y/N字元}
function BoolToStr(B: boolean): string; external 'Utility.DLL';
{把Y/N字元轉成布林值}
function StrToBool(S: string): boolean; external 'Utility.DLL';
{把路徑字串補上'\'字元}
function IncludeTrailingBackslash(PathName: string): string; external 'Utility.DLL';
{將字串依分隔字元拆解成string List}
procedure CutString(var aList: TStringList; S: string; Separate: string = ';'); external 'Utility.DLL';
{把900101格式的字串轉成日期型態}
function GetDate(S: string): TDateTime; external 'Utility.DLL';
{取出日期的年度值}
function GetYear(vDat: TDateTime): word; external 'Utility.DLL';
{把日期型態轉成指定格式的日期字串}
function GetRocFormatDate(vDat: TDateTime; vFmt: Byte = 0): string; external 'Utility.DLL';
{取得日期所在的會計年度}
procedure GetAcctYear(vAcctStart, vDat: TDateTime; var vYear: word); external 'Utility.DLL';
{取得日期是所在會計年度的第幾個月份}
procedure GetAcctMonth(vAcctStart, vDat: TDateTime; var vYear, vMonth:word); external 'Utility.DLL';
{取得某會計年度的開始日期}
function GetAcctYearStart(vAcctStart: TDateTime; vYear: word): TDateTime; external 'Utility.DLL';
{取得某會計年度的結束日期}
function GetAcctYearEnd(vAcctStart: TDateTime; vYear: word): TDateTime; external 'Utility.DLL';
{取得會計年月的開始日期}
function GetAcctMonthStart(vAcctStart: TDateTime; vYear, vMonth: word): TDateTime; external 'Utility.DLL';
{取得會計年月的結束日期}
function GetAcctMonthEnd(vAcctStart: TDateTime; vYear, vMonth: word): TDateTime; external 'Utility.DLL';
{檢查某物件是否有某項屬性}
function HasProp(sender: TObject; const S: string): Boolean; external 'Utility.DLL';
{將字串加密}
function EngEnCrypt(S: ShortString): ShortString; external 'Utility.DLL';
{將字串解密}
function EngDeCrypt(S: ShortString): ShortString; external 'Utility.DLL';
{將字串拆解成SELECT FROM WHERE GROUP ORDER 的 LIST}
function SplitSQL1(SrcSQL: string): Variant; external 'Utility.DLL';
{將TSTRINGS拆解成SELECT FROM WHERE GROUP ORDER 的 LIST}
function SplitSQL2(SrcSQL: TStrings): Variant; external 'Utility.DLL';
{SELECT FROM WHERE GROUP ORDER 的 LIST}
function ComposeSQL(vSQL: Variant): string; external 'Utility.DLL';
{把條件字串加到WHERE的陣列中}
function AppendWhereFilter(vSQL: Variant; NewFilter: string): Variant; external 'Utility.DLL';
{}
function ParseStringFilter(FieldName: string; var FilterValue: string): string; external 'Utility.DLL';
{重新設定ORDER的順序}
procedure ResortTabOrder1(var FirstControl, LastControl: TWinControl; Container: TWinControl; OrderDir: Integer = ORDER_LRTD); external 'Utility.DLL';
{重新設定ORDER的順序}
procedure ResortTabOrder2(Container: TWinControl; OrderDir: Integer = ORDER_LRTD); external 'Utility.DLL';
{將物件釋放,並將變數清成NIL}
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
{顯示訊息視窗}
function xMessageBox(const Text, Caption: string; Flags: Longint): Integer; external 'Utility.DLL';
{顯示訊息視窗}
function xMessageDlg(const Msg: string; DlgType: TMsgDlgType; Buttons: Integer): Word; external 'Utility.DLL';
{顯示訊息}
function xShowMessage(const Msg: string; Buttons: LongInt = MB_OK): Word; external 'Utility.DLL';
{顯示警告訊息}
function xMsgWarning(const Msg: string; Buttons: Longint = MB_OK): Word; external 'Utility.DLL';
{顯示錯誤訊息}
function xMsgError(const Msg: string; Buttons: LongInt = MB_OK): Word; external 'Utility.DLL';
{顯示資訊訊息}
function xMsgInformation(const Msg: string; Buttons: Longint = MB_OK): Word; external 'Utility.DLL';
{顯示確認訊息}
function xMsgConfirmation(const Msg: string; Buttons: LongInt = MB_YESNO): Word; external 'Utility.DLL';
{取得INI的檔名}
function GetIniFileName: string; external 'Utility.DLL';
{取得Log的檔名}
function GetLogFileName: string; external 'Utility.DLL';
{取得SQL的檔名}
function GetScpFileName: string; external 'Utility.DLL';
{取得應用程式的所在路徑}
function GetAppPath: string; external 'Utility.DLL';
{刪除指定路徑的全部檔案}
procedure DeleteAllFile(sDir: string); external 'Utility.DLL';
{修改檔案的修改日期}
procedure ModifyFileDate(FileName: string; ModifyDate: TDateTime); external 'Utility.DLL';
{延遲..時間}
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
{拷貝資料集的結構}
function CopyStruct(vSDataSet, vDDataSet: TDataSet): Boolean; external 'Utility.DLL';
{判斷這個資料集是否在編輯的模式下}
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
{壓縮檔案}
procedure dZipFile(const SourceFile, destination: string); external 'Utility.DLL';
{解壓縮檔案}
procedure dUnZipFile(SourceFile, DestFile: string); external 'Utility.DLL';
{}
procedure dSendMsgTo(aIP: string; aMsg: string); external 'Utility.DLL';
{}
procedure dCastMsgTo(aMsg: string); external 'Utility.DLL';
{}
function IIF(Condition: Boolean; YesResult, NoResult: Variant): Variant; external 'Utility.DLL';
{}
function MbcsSafeCopy(SrcStr: string; StartPos, CopyLen: Integer): string; external 'Utility.DLL';
{將字串轉成數值}
function StrToFloatDef(const S: string; const DefaultValue: Extended): Extended; external 'Utility.DLL';
{將資料集的資料清空}
procedure EmptyDataSet(DataSet: TDataSet); external 'Utility.DLL';
{拷貝某個資料紀錄}
procedure CopyRecord1(cdsDest, cdsSrc: TDataSet; ExclusiveFields: TStringList; AutoPost: Boolean = True); external 'Utility.DLL';
{拷貝某個資料紀錄}
procedure CopyRecord2(cdsDest, cdsSrc: TDataSet; ExclusiveField: string; AutoPost: Boolean = True); external 'Utility.DLL';
{拷貝某個資料集}
procedure CopyDataSet1(cdsDest, cdsSrc: TDataSet; ExclusiveFields: TStringList; AutoPost: Boolean = True); external 'Utility.DLL';
{拷貝某個資料集}
procedure CopyDataSet2(cdsDest, cdsSrc: TDataSet; ExclusiveField: string; AutoPost: Boolean = True); external 'Utility.DLL';
{取得本機的暫存檔路徑}
function GetSysTempPath: string; external 'Utility.DLL';
{把公厘轉成螢幕點}
function MmToPixel(Mm: Integer): Integer; external 'Utility.DLL';
{傳回N個空白字元}
function SpaceN(N: Integer): string; external 'Utility.DLL';
{}
procedure ParseToken(SrcStr, Delimiter: string; var slResult: TStringList); external 'Utility.DLL';
{}
procedure GetMemoContent(SrcStr: string; const CharPerLine: Integer; aLines: TStrings); external 'Utility.DLL';
{取得本機的暫存檔路徑}
function GetLocalTempPath: string; external 'Utility.DLL';
{顯示例外的視窗}
function ShowExcept(E: Exception): boolean; external 'Utility.DLL';
{輸入視窗}
function GetPrompt(AOwner: TComponent; ALabel: string; ACheck: string = '';
                   ACaption: string = '資料輸入'; AValue: string=''): string; external 'Utility.DLL';
{判斷某物件或父物件是否為某類別}
function HasClass(xControl: TWinControl; xClass: TClass): Boolean; external 'Utility.DLL';
{判斷某物件是否在某物件裡}
function InWinControl(xControl: TWinControl; xObject: TComponent): Boolean; external 'Utility.DLL';
{把S字串拆成兩個字串分隔字元'_'}
procedure Cut2String(const S: string; var S1, S2: string); external 'Utility.DLL';
{判斷某Variant變數是否為空白或Null}
function xVarIsEmpty(xV: Variant): boolean; external 'Utility.DLL';
{將DATASET的資料轉成DBISAM檔}
procedure DataSetTODBISAM(aDataSet: TDataSet; aTableName: string); external 'Utility.DLL';
{將DATASET的資料轉成EXCEL檔}
procedure DataSetToExcel(aDataSet: TDataSet; aExcelName: string); external 'Utility.DLL';
{依MSN的樣式顯示訊息}
procedure ShowMsnMsg(const Info: string); external 'Utility.DLL';
{輸入密碼視窗}
function GetPassword(aLabel: string): string; external 'Utility.DLL';
{輸入轉檔名稱類別}
function	ExecPrintToFileDlg(AOWner: TComponent; var ExportFileName : string;	var OpenFile, EmailFile : Boolean) : Integer; external 'Utility.DLL';
{等待資料集開啟完成}
procedure WaitforOpen(aDataSet: TDataSet); external 'Utility.DLL';
{取得系統資料存放路徑}
function GetSysDataPath: string; external 'Utility.DLL';
{檢查是否可以正確連線到IP}
function CheckCanConnectTo(aIP: string): Integer; external 'Utility.DLL';
{取得電腦名稱}
function xGetComputerName: string; external 'Utility.DLL';
{取得電腦名稱的IP位址}
function xGetComputerIP(aComputerName: string): string; external 'Utility.DLL';
{取得第n個欄位的名稱}
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



