program prm;
{$IF CompilerVersion >= 21.0}
{$WEAKLINKRTTI ON}
{$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
{$IFEND}
{$APPTYPE CONSOLE}
{$R *.res}

uses
  Winapi.Windows,
  Vcl.Dialogs,
  Winapi.ShellAPI,
  Winapi.Messages,
  System.SysUtils;

procedure HookPE;
var
  strCommand    : String;
  DataStruct    : TCopyDataStruct;
  data          : PChar;
  dataSize      : Integer;
  hMainForm     : THandle;
  strFileName   : String;
  strOldFileName: String;
begin
  { ��ȡ�����в��������͸������� }
  strCommand := GetCommandLine;
  ShowMessage(strCommand);
  hMainForm := FindWindow('TfrmHookPE', 'HOOK PE');
  data      := StrAlloc(Length(strCommand) + 1);
  dataSize  := StrBufSize(data);
  ZeroMemory(data, dataSize);
  CopyMemory(data, @strCommand[1], dataSize);
  DataStruct.dwData := WM_COPYDATA;
  DataStruct.cbData := dataSize;
  SendMessage(hMainForm, WM_COPYDATA, 0, LongInt(@DataStruct));
  StrDispose(data);

  { ����ԭ���ĳ��򣬲����ϲ��� }
  strFileName    := ParamStr(0);
  strOldFileName := Format('%s\%s.hpe.exe', [ExtractFilePath(strFileName), ChangeFileExt(ExtractFileName(strFileName), '')]);
  ShellExecute(0, 'open', PChar(strOldFileName), PChar(strCommand), PChar(ExtractFilePath(strFileName)), SW_SHOW);
end;

begin
  HookPE;

end.
