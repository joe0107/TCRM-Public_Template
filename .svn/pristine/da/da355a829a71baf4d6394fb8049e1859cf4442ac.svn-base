unit DLL_COMMON;

interface

uses
  Windows, Messages, SysUtils, Forms, Classes, DB, DbTables, SqlExpr, DLL_PUBLIC;

type
  TCallBackProc = function(aServiceNo: Integer; ParamValues: OleVariant): OleVariant; stdcall;

var
  CallerApp: TApplication;  // Added by Joe 2018/07/17 10:46:24
  DbConnections: array[0..1] of TDatabase;
  ShellCallBackProc: TCallBackProc;

{ export function }
procedure SetParam(ParamName, Value: PChar); stdcall;
procedure ClearParam; stdcall;
procedure SetCallBackProc(CallBackProc: TCallBackProc); stdcall;

implementation

procedure SetParam(ParamName, Value: PChar); stdcall;
begin
  DllParams.Add(ParamName, Value);
end;

procedure ClearParam; stdcall;
begin
   DllParams.Clear;
end;

procedure SetCallBackProc(CallBackProc: TCallBackProc); stdcall;
begin
  ShellCallBackProc := CallBackProc;
end;

end.


