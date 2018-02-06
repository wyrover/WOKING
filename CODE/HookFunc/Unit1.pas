unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.StrUtils, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Winapi.TlHelp32;

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
    procedure cbbMouduleChange(Sender: TObject);
  private
    { Private declarations }
    procedure EnumAllProcess;
    procedure EnumProcessAllMoudule(const strProcessName: string); overload;
    procedure EnumProcessAllMoudule(const intProcessID: Integer); overload;
    procedure EnumModuleAllFunc(const strModuleName: string); overload;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.cbbMouduleChange(Sender: TObject);
begin
  cbbFunc.Clear;
  EnumModuleAllFunc(cbbMoudule.Text);
end;

procedure TForm1.cbbProcessChange(Sender: TObject);
begin
  cbbMoudule.Clear;
  cbbFunc.Clear;
  EnumProcessAllMoudule(cbbProcess.Text);
end;

procedure TForm1.EnumAllProcess;
var
  hProcessSnap: THandle;
  pe32        : TProcessEntry32;
  bProcess    : Boolean;
  III         : Integer;
begin
  hProcessSnap := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hProcessSnap = INVALID_HANDLE_VALUE then
  begin
    ShowMessage('不能枚举进程列表。');
    Exit;
  end;

  pe32.dwSize := SizeOf(TProcessEntry32);
  try
    bProcess := Process32First(hProcessSnap, pe32);
    while bProcess do
    begin
      cbbProcess.Items.Add(Format('%6d  %s', [pe32.th32ProcessID, pe32.szExeFile]));
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
      cbbProcess.OnChange(nil);
      Break;
    end;
  end;
end;

procedure TForm1.EnumModuleAllFunc(const strModuleName: string);
begin
  //
end;

procedure TForm1.EnumProcessAllMoudule(const intProcessID: Integer);
var
  hModuleSnap: THandle;
  pe32       : TModuleEntry32;
  bModule    : Boolean;
begin
  hModuleSnap := CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, intProcessID);
  if hModuleSnap = INVALID_HANDLE_VALUE then
  begin
    ShowMessage('不能枚举进程模块列表。');
    Exit;
  end;

  pe32.dwSize := SizeOf(TModuleEntry32);
  try
    bModule := Module32First(hModuleSnap, pe32);
    while bModule do
    begin
      cbbMoudule.Items.Add(Format('$%0.12x %s', [UInt64(pe32.modBaseAddr), pe32.szModule]));
      bModule := Module32Next(hModuleSnap, pe32);
    end;
  finally
    CloseHandle(hModuleSnap);
  end;

  if cbbMoudule.Items.Count >= 2 then
  begin
    cbbMoudule.Items.Delete(0);
    cbbMoudule.ItemIndex := 0;
    EnumModuleAllFunc(cbbMoudule.Text);
  end;
end;

procedure TForm1.EnumProcessAllMoudule(const strProcessName: string);
var
  intProcessID: Cardinal;
begin
  intProcessID := StrToInt(Trim(LeftStr(strProcessName, 6)));
  EnumProcessAllMoudule(intProcessID);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  EnumAllProcess;
end;

end.
