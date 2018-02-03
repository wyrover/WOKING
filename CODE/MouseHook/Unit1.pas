unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    mmo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

var
  FMouseHook: HHOOK;

function MouseHookProc(code: Integer; wparam: wparam; lparam: lparam): LRESULT stdcall;
begin
  Result := 1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FMouseHook := SetWindowsHookEx(WH_MOUSE_LL, MouseHookProc, HInstance, 0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  UnhookWindowsHookEx(FMouseHook);
  FMouseHook := 0;
end;

end.
