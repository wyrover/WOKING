unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmCarX64 = class(TForm)
  private
    { Private declarations }
  protected
    procedure RecvMessage(var aMsg: TWMCOPYDATA); message WM_COPYDATA;
  public
    { Public declarations }
  end;

var
  frmCarX64: TfrmCarX64;

implementation

{$R *.dfm}

procedure TfrmCarX64.RecvMessage(var aMsg: TWMCOPYDATA);
var
  cdds: PCopyDataStruct;
begin
  cdds := aMsg.CopyDataStruct;
  ShowMessage(PChar(cdds.lpData));
end;

end.
