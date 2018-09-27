unit cDB_Manager;

interface
Uses Forms, DB, DBTables, ADODB, StdCtrls, Controls;

procedure CreateLookDM; stdcall; external 'DB_Manager.DLL';
procedure DestroyLookDM; stdcall; external 'DB_Manager.DLL';
procedure ReplaceApplicationHandle(aApplication: TApplication); stdcall; external 'DB_Manager.DLL';
procedure SetADOConnection(DbConn: TADOConnection; ConnNdx: Integer); stdcall; external 'DB_Manager.DLL';
procedure SetDataSet(DataSet: TDataSet; ConnNdx: Integer); stdcall; external 'DB_Manager.DLL';
function cDBLookup(DBLookupName, aFilter: string; aDataSet: TDataSet; aDataField,
                   aResultField: string; aCaption: string = ''): boolean; external 'DB_Manager.DLL';
function cLookUpValue(aDataSetName, aKeyFieldS: string; aKeyValues: Variant; aResultField: string): Variant; external 'DB_Manager.DLL';
procedure QueryPH(aEdit: TWinControl; aEditKind: Integer = 0); external 'DB_Manager.DLL';
function ValueExists(aDataSetName, aKeyFieldS: string; aKeyValues: Variant): Boolean; external 'DB_Manager.DLL';
function FoundRecord(aDataSetName, aKeyFieldS: string; aKeyValues: Variant; var aFound: Boolean): TDataSet; external 'DB_Manager.DLL';
procedure UpDateCacheTable(aCacheTableName: string); external 'DB_Manager.DLL';
function GetCacheDBName: string; external 'DB_Manager.DLL';
function GetTranDBName: string; external 'DB_Manager.DLL';

implementation

end.
