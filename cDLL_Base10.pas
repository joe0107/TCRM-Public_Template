unit cDLL_Base10;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cDLL_Base, ExtCtrls, RzPanel, RzStatus, JcCxGridResStr,
  cxPropertiesStore, cxClasses;

type
  TfmcDLL_Base10 = class(TfmcDLL_Base)
    plControl: TRzPanel;
    plLogo: TRzPanel;
    imgLogo: TImage;
    plShowMessage: TRzPanel;
  private
    { Private declarations }
  public
    { Public declarations }
    class Procedure StartService; virtual; 
  end;

var
  fmcDLL_Base10: TfmcDLL_Base10;

implementation

{$R *.dfm}

{ TfmcDLL_Base10 }

{ TfmcDLL_Base10 }

class procedure TfmcDLL_Base10.StartService;
begin

end;

end.
