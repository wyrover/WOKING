unit untErrLog;

interface

procedure LogText(const strTemp: string; const bInsert: Boolean = False);

implementation

uses Windows, SysUtils, Classes;

procedure LogText(const strTemp: string; const bInsert: Boolean = False);
{$IFNDEF DEBUG}
var
  strLogFileName: String;
  strLogDirPath : String;
  strList       : TStringList;
begin
  { ������־Ŀ¼ }
  strLogDirPath := ExtractFilePath(ParamStr(0)) + 'log\';
  if not DirectoryExists(strLogDirPath) then
    CreateDir(strLogDirPath);

  { ��־�ļ��Ƿ���ڣ������ڣ��򴴽� }
  strLogFileName := strLogDirPath + FormatDateTime('YYYY-MM-DD', Now) + '.log';
  if not FileExists(strLogFileName) then
    FileClose(FileCreate(strLogFileName));

  { ��־���浽�ļ� }
  strList := TStringList.Create;
  try
    strList.LoadFromFile(strLogFileName, TEncoding.UTF8);
    if not bInsert then
      strList.Add(Format('%s%s%s', [FormatDateTime('YYYY-MM-DD hh:mm:ss', Now), Char(9), strTemp]))        // ׷��ģʽ
    else                                                                                                   //
      strList.Insert(0, Format('%s%s%s', [FormatDateTime('YYYY-MM-DD hh:mm:ss', Now), Char(9), strTemp])); // ����ģʽ
    strList.SaveToFile(strLogFileName, TEncoding.UTF8);
  finally
    strList.Free;
  end;
{$ELSE}
  Windows.OutputDebugString(PChar(Format('%s%s%s', [FormatDateTime('YYYY-MM-DD hh:mm:ss', Now), Char(9), strTemp])));
{$ENDIF}
end;

end.
