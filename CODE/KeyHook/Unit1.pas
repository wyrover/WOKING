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
  FKeyHook: HHOOK;

function KeyHookProc(code: Integer; wparam: wparam; lparam: lparam): LRESULT stdcall;
var
  pEvt: TEventMsg;
  vKey: Cardinal;
begin
  if code = HC_ACTION then
  begin
    case wparam of
      WM_SYSKEYDOWN, WM_KEYDOWN:
        begin
          pEvt := PEventMsg(lparam)^;
          vKey := LOBYTE(pEvt.message);
          Form1.mmo1.Lines.Add(Chr(vKey) + ' ' + Inttostr(vKey) + ' $' + IntToHex(vKey, 2));
        end;
    end;

  end;
  Result := CallNextHookEx(FKeyHook, code, wparam, lparam);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FKeyHook := SetWindowsHookEx(WH_KEYBOARD_LL, KeyHookProc, HInstance, 0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  UnhookWindowsHookEx(FKeyHook);
  FKeyHook := 0;
end;

end.
