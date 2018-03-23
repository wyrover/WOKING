unit untCommon;

interface

uses Windows, Forms, SysUtils, StrUtils, Dialogs, ADODB, DB, IniFiles;

const
  c_strDefaultMainProc  = 'main.exe';
  c_strDBConfigFileName = 'DBInit.dat';
  c_strYYEncDecKey      = '上海亦源智能科技有限公司加解密密钥';
  c_strDefaultConn      = 'aBcDeFgHiJkZHANGBAOQUAN';

  { 修改当前电脑时间为数据库服务器时间 }
procedure ModifyNativeTimeToServer(const strDateTime: string);

{ 通用数据库连接对话框 }
function LinkDataBase(AdoConn: TADOConnection; const bCheck: Boolean = True): Boolean;

{ 获取主程序文件名 }
function GetMainProcFileName: String;

{ 运行程序 }
function RunMainProc(const strMainProc, strParam: string): Boolean;

implementation

{ 上海亦源智能科技字符串加解密函数 }
function YYEncDecStr(const S: String; const bEncrypt: Boolean = True): String; stdcall; export;

{ 字符串转为16进制表达字符 }
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
      Result := Result + IntToHex(Ord(S), 2); // 将字符串转化为16进制字符串，
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

  { 变换处理秘钥字符串 }
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
    { 加密 }
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
    { 还原 }
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

{ 错误提示框 }
procedure ShowDBErr(const strDisplayTip: String = '数据库连接异常，请检查数据库连接');
begin
  ShowMessage(strDisplayTip);
end;

{ 修改当前电脑时间为数据库服务器时间 }
procedure ModifyNativeTimeToServer(const strDateTime: string);
var
  systemtime: Tsystemtime;
  DateTime  : TDateTime;
begin
  DateTime := StrToDateTime(strDateTime);     // 获得时间（TDateTime格式）
  DateTimeToSystemTime(DateTime, systemtime); // 把Delphi的TDateTime格式转化为API的TSystemTime格式
  SetLocalTime(systemtime);                   // 设置系统时间
end;

{ 显示连接数据库对话框 }
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

{ 通用数据库连接对话框 }
function LinkDataBase(AdoConn: TADOConnection; const bCheck: Boolean = True): Boolean;
var
  strConn: String;
  strSql : String;
label _linkconn;
begin
  Result := False;

  { 不检查配置文件是否存在 }
  if not bCheck then
  begin
    ShowDBLinkDialog;
  end
  else
  begin
    { 检查配置文件是否存在：配置文件不存在，弹出连接数据库对话框 }
    if not FileExists(ExtractFilePath(ParamStr(0)) + c_strDBConfigFileName) then
      ShowDBLinkDialog;
  end;

  { 配置文件存在 }
_linkconn:
  with TIniFile.Create(ExtractFilePath(ParamStr(0)) + c_strDBConfigFileName) do
  begin
    strConn := ReadString('database', 'name', '');
    if Trim(strConn) = '' then
    begin
      { 配置文件存在，但数据库连接字段没有 }
      strConn := PromptDataSource(Application.Handle, c_strDefaultConn);
      if CompareText(strConn, c_strDefaultConn) = 0 then
        Exit;

      { 保存数据库连接字符串 }
      with TIniFile.Create(ExtractFilePath(ParamStr(0)) + c_strDBConfigFileName) do
      begin
        WriteString('database', 'name', YYEncDecStr(strConn, True));
        Free;
      end;

      { 再次检查数据库配置文件 }
      goto _linkconn;
    end
    else
    begin
      { 连接数据库 }
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

{ 获取主程序文件名 }
function GetMainProcFileName: String;
begin
  with TIniFile.Create(ExtractFilePath(ParamStr(0)) + c_strDBConfigFileName) do
  begin
    Result := ReadString('MainProc', 'FileName', c_strDefaultMainProc);
  end;
end;

{ 运行程序 }
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

{ 设置机器时间为数据库时间 }
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

  { 日期格式设置 }
  FormatSettings.ShortDateFormat := 'yyyy-MM-dd';
  FormatSettings.DateSeparator   := '-';
  FormatSettings.TimeSeparator   := ':';

  strSqlServerTime := qryTemp.Fields[0].AsString;
  ModifyNativeTimeToServer(strSqlServerTime);
  qryTemp.Close;

end;

end.
