unit untCommon;

interface

uses Windows, Forms, SysUtils, StrUtils, Dialogs, ADODB, DB, IniFiles;

const
  c_strDefaultMainProc  = 'main.exe';
  c_strDBConfigFileName = 'DBInit.dat';
  c_strYYEncDecKey      = '�Ϻ���Դ���ܿƼ����޹�˾�ӽ�����Կ';
  c_strDefaultConn      = 'aBcDeFgHiJkZHANGBAOQUAN';

  { �޸ĵ�ǰ����ʱ��Ϊ���ݿ������ʱ�� }
procedure ModifyNativeTimeToServer(const strDateTime: string);

{ ͨ�����ݿ����ӶԻ��� }
function LinkDataBase(AdoConn: TADOConnection; const bCheck: Boolean = True): Boolean;

{ ��ȡ�������ļ��� }
function GetMainProcFileName: String;

{ ���г��� }
function RunMainProc(const strMainProc, strParam: string): Boolean;

implementation

{ �Ϻ���Դ���ܿƼ��ַ����ӽ��ܺ��� }
function YYEncDecStr(const S: String; const bEncrypt: Boolean = True): String; stdcall; export;

{ �ַ���תΪ16���Ʊ���ַ� }
  function MyStrToHex(AStr: string): string;
  var
    I, Len: Integer;
    S     : Char;
  begin
    Len    := Length(AStr);
    Result := '';
    for I  := 1 to Len do
    begin
      S      := AStr[I];
      Result := Result + IntToHex(Ord(S), 2); // ���ַ���ת��Ϊ16�����ַ�����
    end;
  end;

var
  I, L     : DWord;
  B, K     : WORD;
  mm       : Integer;
  key      : array of WORD;
  newkeystr: String;
begin
  Result := '';
  L      := Length(S);
  if L < 1 then
    Exit;

  { �任������Կ�ַ��� }
  newkeystr := MyStrToHex(c_strYYEncDecKey);
  mm        := (Length(newkeystr) div 2) - 1;
  if mm < 0 then
  begin
    Exit;
  end;
  setlength(key, mm + 1);
  for I := 0 to mm do
  begin
    key[I] := StrToInt('$' + Copy(newkeystr, I * 2 + 1, 2));
  end;

  K := 0;
  if bEncrypt then
  begin
    { ���� }
    for I := 1 to L do
    begin
      B      := WORD(S[I]) xor Ord(key[K]);
      Result := Result + IntToHex(B, 4);
      inc(K);
      if K > mm then
        K := 0;
    end;
  end
  else
  begin
    { ��ԭ }
    K := 0;
    I := 0;
    while I < L div 4 do
    begin
      Result := Result + chr(StrToInt('$' + Copy(S, I * 4 + 1, 4)) xor key[K]);
      inc(I);
      inc(K);
      if K > mm then
        K := 0;
    end;
  end;
end;

{ ������ʾ�� }
procedure ShowDBErr(const strDisplayTip: String = '���ݿ������쳣���������ݿ�����');
begin
  ShowMessage(strDisplayTip);
end;

{ �޸ĵ�ǰ����ʱ��Ϊ���ݿ������ʱ�� }
procedure ModifyNativeTimeToServer(const strDateTime: string);
var
  systemtime: Tsystemtime;
  DateTime  : TDateTime;
begin
  DateTime := StrToDateTime(strDateTime);     // ���ʱ�䣨TDateTime��ʽ��
  DateTimeToSystemTime(DateTime, systemtime); // ��Delphi��TDateTime��ʽת��ΪAPI��TSystemTime��ʽ
  SetLocalTime(systemtime);                   // ����ϵͳʱ��
end;

{ ��ʾ�������ݿ�Ի��� }
procedure ShowDBLinkDialog;
var
  strConn: String;
begin
  strConn := PromptDataSource(Application.Handle, c_strDefaultConn);
  if CompareText(strConn, c_strDefaultConn) = 0 then
    Exit;

  with TIniFile.Create(ExtractFilePath(ParamStr(0)) + c_strDBConfigFileName) do
  begin
    WriteString('database', 'name', YYEncDecStr(strConn, True));
    Free;
  end;
end;

{ ͨ�����ݿ����ӶԻ��� }
function LinkDataBase(AdoConn: TADOConnection; const bCheck: Boolean = True): Boolean;
var
  strConn: String;
  strSql : String;
label _linkconn;
begin
  Result := False;

  { ����������ļ��Ƿ���� }
  if not bCheck then
  begin
    ShowDBLinkDialog;
  end
  else
  begin
    { ��������ļ��Ƿ���ڣ������ļ������ڣ������������ݿ�Ի��� }
    if not FileExists(ExtractFilePath(ParamStr(0)) + c_strDBConfigFileName) then
      ShowDBLinkDialog;
  end;

  { �����ļ����� }
_linkconn:
  with TIniFile.Create(ExtractFilePath(ParamStr(0)) + c_strDBConfigFileName) do
  begin
    strConn := ReadString('database', 'name', '');
    if Trim(strConn) = '' then
    begin
      { �����ļ����ڣ������ݿ������ֶ�û�� }
      strConn := PromptDataSource(Application.Handle, c_strDefaultConn);
      if CompareText(strConn, c_strDefaultConn) = 0 then
        Exit;

      { �������ݿ������ַ��� }
      with TIniFile.Create(ExtractFilePath(ParamStr(0)) + c_strDBConfigFileName) do
      begin
        WriteString('database', 'name', YYEncDecStr(strConn, True));
        Free;
      end;

      { �ٴμ�����ݿ������ļ� }
      goto _linkconn;
    end
    else
    begin
      { �������ݿ� }
      strSql                   := YYEncDecStr(strConn, False);
      AdoConn.ConnectionString := strSql;
      try
        AdoConn.Connected := True;
        Result            := True;
      except
        Result := False;
      end;
    end;

    Free;
  end;
end;

{ ��ȡ�������ļ��� }
function GetMainProcFileName: String;
begin
  with TIniFile.Create(ExtractFilePath(ParamStr(0)) + c_strDBConfigFileName) do
  begin
    Result := ReadString('MainProc', 'FileName', c_strDefaultMainProc);
  end;
end;

{ ���г��� }
function RunMainProc(const strMainProc, strParam: string): Boolean;
var
  si: STARTUPINFO;
  pi: PROCESS_INFORMATION;
begin
  try
    FillChar(si, SizeOf(si), 0);
    FillChar(pi, SizeOf(pi), 0);
    si.cb  := SizeOf(si);
    Result := CreateProcess(PChar(strMainProc), PChar(strParam), nil, nil, False, 0, nil, PChar(ExtractFileDir(strMainProc)), si, pi);
  except
    Result := False;
  end;
end;

{ ���û���ʱ��Ϊ���ݿ�ʱ�� }
function SyncTime(): Boolean;
var
  qryTemp         : TADOQuery;
  strSqlServerTime: String;
begin
  Result := False;

  qryTemp := TADOQuery.Create(nil);
  try
    qryTemp.Close;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT CONVERT(varchar(100), GETDATE(), 20)');
    try
      qryTemp.Open;
    except
      ShowDBErr;
      Exit;
    end;
  finally
    qryTemp.Free;
  end;

  { ���ڸ�ʽ���� }
  FormatSettings.ShortDateFormat := 'yyyy-MM-dd';
  FormatSettings.DateSeparator   := '-';
  FormatSettings.TimeSeparator   := ':';

  strSqlServerTime := qryTemp.Fields[0].AsString;
  ModifyNativeTimeToServer(strSqlServerTime);
  qryTemp.Close;

end;

end.
