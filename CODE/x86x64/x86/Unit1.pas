unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Winapi.TlHelp32;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FintPID: Integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  c_strCarTest = 'ª¶A88888';

function KillAppExe(const strFullFileName: string): Boolean;
const
  PROCESS_TERMINATE = $0001;
var
  hSnap              : THandle;
  _vProEntry         : TProcessEntry32;
  bFind              : Boolean;
  strTempFullFileName: string;
begin
  Result := False;
  hSnap  := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    _vProEntry.dwSize := SizeOf(_vProEntry);
    bFind             := Process32First(hSnap, _vProEntry);
    while bFind do
    begin
      strTempFullFileName := _vProEntry.szExeFile;
      if (UpperCase(strTempFullFileName) = UpperCase(ExtractFileName(strFullFileName))) or (UpperCase(strTempFullFileName) = UpperCase(strFullFileName)) then
      begin
        Result := TerminateProcess(OpenProcess(PROCESS_TERMINATE, Boolean(0), _vProEntry.th32ProcessID), 0);
      end;
      bFind := Process32Next(hSnap, _vProEntry);
    end;
  finally
    CloseHandle(hSnap);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  hx64Form: THandle;
  cdds    : TCopyDataStruct;
begin
  cdds.dwData := 0;
  cdds.cbData := 2 * (length(c_strCarTest) + 1);
  cdds.lpData := PChar(c_strCarTest);
  hx64Form    := FindWindow('TfrmCarX64', 'Ω” ’≥Ã–Ú');
  SendMessage(hx64Form, WM_COPYDATA, Handle, LongWord(@cdds));
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  si         : STARTUPINFO;
  pi         : PROCESS_INFORMATION;
  strFileName: String;
begin
  FintPID     := -1;
  strFileName := ExtractFilePath(ParamStr(0)) + 'X64.exe';
  FillChar(si, SizeOf(si), 0);
  FillChar(pi, SizeOf(pi), 0);
  si.cb          := SizeOf(si);
  si.dwFlags     := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_HIDE;
  if CreateProcess(PChar(strFileName), nil, nil, nil, False, 0, nil, PChar(ExtractFileDir(strFileName)), si, pi) then
  begin
    FintPID := pi.dwProcessId;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  // KillAppExe(ExtractFilePath(ParamStr(0)) + 'X64.EXE');
  TerminateProcess(OpenProcess(PROCESS_TERMINATE, Boolean(0), FintPID), 0);
end;

end.
