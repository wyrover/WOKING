unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.IniFiles, Winapi.ShellAPI, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.Win.ADODB, Data.DB;

type
  TfrmDB = class(TForm)
    lbl1: TLabel;
    lbl3: TLabel;
    lbl2: TLabel;
    img1: TImage;
    conLink: TADOConnection;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbl1MouseEnter(Sender: TObject);
    procedure lbl1MouseLeave(Sender: TObject);
    procedure lbl1Click(Sender: TObject);
    procedure lbl3Click(Sender: TObject);
    procedure lbl2Click(Sender: TObject);
    procedure img1Click(Sender: TObject);
  private
    { 数据库连接成功之后，执行主程序 }
    procedure DBLinkSuccess(const connLink: TADOConnection);
  public
    { Public declarations }
  end;

var
  frmDB: TfrmDB;

implementation

{$R *.dfm}

const
  c_strYYEncDecKey      = '上海亦源智能科技有限公司加解密密钥';
  c_strDefaultMainProc  = 'main.exe';
  c_strDBConfigFileName = 'DBInit.dat';

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

procedure ShowDBErr(const strDisplayTip: String = '数据库连接异常，请检查数据库连接');
begin
  ShowMessage(strDisplayTip);
end;

{ 修改当前时间为 sqlserver 时间 }
procedure ModifyNativeTimeToServer(const strDateTime: string);
var
  systemtime: Tsystemtime;
  DateTime  : TDateTime;
begin
  DateTime := StrToDateTime(strDateTime);     // 获得时间（TDateTime格式）
  DateTimeToSystemTime(DateTime, systemtime); // 把Delphi的TDateTime格式转化为API的TSystemTime格式
  SetLocalTime(systemtime);                   // 设置系统时间
end;

function LinkDataBase(AdoConn: TADOConnection): Boolean;
const
  c_strDefaultConn = 'aBcDeFgHiJkZHANGBAOQUAN';
var
  strConn: String;
  strSql : String;
label _linkconn;
begin
  Result := False;

  { 配置文件不存在，弹出连接数据库对话框 }
  if not FileExists(ExtractFilePath(ParamStr(0)) + c_strDBConfigFileName) then
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

      with TIniFile.Create(ExtractFilePath(ParamStr(0)) + c_strDBConfigFileName) do
      begin
        WriteString('database', 'name', YYEncDecStr(strConn, True));
        Free;
      end;

      goto _linkconn;
    end
    else
    begin
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

procedure TfrmDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

function GetMainProcFileName: String;
begin
  with TIniFile.Create(ExtractFilePath(ParamStr(0)) + c_strDBConfigFileName) do
  begin
    Result := ReadString('MainProc', 'FileName', c_strDefaultMainProc);
  end;
end;

procedure TfrmDB.img1Click(Sender: TObject);
var
  stra, strb: string;
begin
  with TOpenDialog.Create(nil) do
  begin
    Title  := '选择一个可执行文件作为主程序';
    Filter := '可执行文件(*.EXE)|*.EXE';
    if Execute then
    begin
      stra := FileName;
      with TIniFile.Create(ExtractFilePath(ParamStr(0)) + c_strDBConfigFileName) do
      begin
        strb := ParamStr(0);
        if CompareText(ExtractFileName(stra), ExtractFileName(strb)) <> 0 then
        begin
          WriteString('MainProc', 'FileName', stra);
        end
        else
        begin
          MessageBox(Handle, '不能执行自身，请重新选择一个程序', '系统提示：', MB_OK OR MB_ICONWARNING);
        end;
        Free;
      end;
    end;
    Free;
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

{ 数据库连接成功之后，执行主程序 }
procedure TfrmDB.DBLinkSuccess(const connLink: TADOConnection);
var
  strMainProgramFileName: string;
  strconnDB             : String;
begin
  strconnDB              := conLink.ConnectionString;
  strMainProgramFileName := GetMainProcFileName;
  if FileExists(strMainProgramFileName) then
  begin
    RunMainProc(ExtractFilePath(ParamStr(0)) + strMainProgramFileName, strconnDB);
  end
  else
  begin
    strMainProgramFileName := ExtractFilePath(ParamStr(0)) + c_strDefaultMainProc;
    if FileExists(strMainProgramFileName) then
    begin
      RunMainProc(ExtractFilePath(ParamStr(0)) + strMainProgramFileName, strconnDB);
    end;
  end;
end;

procedure TfrmDB.lbl1Click(Sender: TObject);
begin
  if not LinkDataBase(conLink) then
  begin
    if MessageBox(Handle, '必须先配置好数据库，程序才能运行，否则程序将无法运行，你确定要退出吗？', '系统提示：', MB_YESNO OR MB_ICONINFORMATION) = ID_YES then
    begin
      Close;
    end;
  end
  else
  begin
    Close;

    { 数据库连接成功之后，执行主程序 }
    DBLinkSuccess(conLink);
  end;
end;

procedure TfrmDB.lbl1MouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clRed;
end;

procedure TfrmDB.lbl1MouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlue;
end;

procedure TfrmDB.lbl3Click(Sender: TObject);
begin
  //
end;

procedure TfrmDB.lbl2Click(Sender: TObject);
begin
  //
end;

end.
