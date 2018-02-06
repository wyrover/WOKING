unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Winapi.TlHelp32;

type
  TForm1 = class(TForm)
    cbbProcess: TComboBox;
    lblProcess: TLabel;
    cbbMoudule: TComboBox;
    lblModule: TLabel;
    cbbFunc: TComboBox;
    lblFunc: TLabel;
    procedure cbbProcessChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure EnumAllProcess;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.cbbProcessChange(Sender: TObject);
begin
  cbbMoudule.Clear;
  cbbFunc.Clear;
end;

procedure TForm1.EnumAllProcess;
var
  hProcessSnap: THandle;
  pe32        : PROCESSENTRY32;
  bProcess    : Boolean;
  III         : Integer;
begin
  hProcessSnap := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hProcessSnap = INVALID_HANDLE_VALUE then
  begin
    ShowMessage('不能枚举进程列表。');
    Exit;
  end;

  pe32.dwSize := SizeOf(PROCESSENTRY32);
  try
    bProcess := Process32First(hProcessSnap, pe32);
    while bProcess do
    begin
      cbbProcess.Items.Add(Format('%5d %s', [pe32.th32ProcessID, pe32.szExeFile]));
      bProcess := Process32Next(hProcessSnap, pe32);
    end;
  finally
    CloseHandle(hProcessSnap);
  end;

  for III := 0 to cbbProcess.Items.Count - 1 do
  begin
    if cbbProcess.Items.Strings[III].Contains('explorer.exe') then
    begin
      cbbProcess.ItemIndex := III;
      Break;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  EnumAllProcess;
end;

end.
