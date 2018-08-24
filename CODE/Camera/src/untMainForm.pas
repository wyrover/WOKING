unit untMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, System.IniFiles, Winapi.DirectShow9, untUSBCamera;

type
  TfrmCamera = class(TForm, ISampleGrabberCB)
    grdpnlVideo: TGridPanel;
    pnlVideo01: TPanel;
    pnlVideo02: TPanel;
    pnlVideo03: TPanel;
    pnlVideo04: TPanel;
    mmCamera: TMainMenu;
    mniCamera: TMenuItem;
    mniCameraAddUSBCamera: TMenuItem;
    mniCameraAddIPCamera: TMenuItem;
    mniRecognize: TMenuItem;
    mniRecognizeCar: TMenuItem;
    mniRecognizeFace: TMenuItem;
    mniEffect: TMenuItem;
    mniEffectRotate90: TMenuItem;
    mniEffectRotate180: TMenuItem;
    mniEffectRotate0: TMenuItem;
    mniEffectHorMirror: TMenuItem;
    mniEffectVerMirror: TMenuItem;
    mniEffectTrans: TMenuItem;
    mniEffectLine01: TMenuItem;
    mniEffectAdjustBrightness: TMenuItem;
    mniEffectAdjustChroma: TMenuItem;
    mniEffectAdustContrast: TMenuItem;
    mniConfig: TMenuItem;
    mniHelp: TMenuItem;
    mniHelpAbout: TMenuItem;
    mniEffectAdjustSaturation: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure mniHelpAboutClick(Sender: TObject);
    procedure mniRecognizeFaceClick(Sender: TObject);
    procedure mniRecognizeCarClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    function SampleCB(SampleTime: Double; pSample: IMediaSample): HResult; stdcall;
    function BufferCB(SampleTime: Double; pBuffer: PByte; BufferLen: longint): HResult; stdcall;
  private
    { 读取相机配置 }
    function ReadCameraConfig: Boolean;
  public
    { Public declarations }
  end;

var
  frmCamera: TfrmCamera;

  { 只允许同时运行一个实例 }
procedure OnlyRunOneInstance;

implementation

{$R *.dfm}

{ 错误日志 }
procedure LogInfo(const strLog: string; const bInsert: Boolean = False);
var
  strLogTemp: String;
{$IFDEF DEBUG}
  strLogFileName: String;
  strLogDirPath : String;
  strList       : TStringList;
{$ENDIF}
begin
  strLogTemp := Format('%s%s%s', [FormatDateTime('YYYY-MM-DD hh:mm:ss', Now), Char(9), strLog]);
{$IFDEF DEBUG}
  { 创建日志目录 }
  strLogDirPath := ExtractFilePath(ParamStr(0)) + 'log\';
  if not DirectoryExists(strLogDirPath) then
    CreateDir(strLogDirPath);

  { 日志文件是否存在，不存在，则创建 }
  strLogFileName := strLogDirPath + FormatDateTime('YYYY-MM-DD', Now) + '.log';
  if not FileExists(strLogFileName) then
    FileClose(FileCreate(strLogFileName));

  { 日志保存到文件 }
  strList := TStringList.Create;
  try
    strList.LoadFromFile(strLogFileName, TEncoding.UTF8);
    if not bInsert then
      strList.Add(strLogTemp)        // 追加模式
    else                             //
      strList.Insert(0, strLogTemp); // 插入模式
    strList.SaveToFile(strLogFileName, TEncoding.UTF8);
  finally
    strList.Free;
  end;
{$ELSE}
  Winapi.Windows.OutputDebugString(PChar(strLogTemp));
{$ENDIF}
end;

{ 只允许同时运行一个实例 }
procedure OnlyRunOneInstance;
const
  c_strMute = 'A907C449-0946-4FA2-9369-52962753545F';
var
  hMutex: THandle;
begin
  hMutex := CreateMutex(NIL, True, c_strMute);
  try
    if GetLastError = ERROR_ALREADY_EXISTS THEN
    begin
      LogInfo('程序已经运行，不能重复运行');
      Halt(0);
    end;
  finally
    ReleaseMutex(hMutex);
  end;
end;

function TfrmCamera.BufferCB(SampleTime: Double; pBuffer: PByte; BufferLen: longint): HResult;
begin
  //
end;

function TfrmCamera.SampleCB(SampleTime: Double; pSample: IMediaSample): HResult;
begin
  //
end;

procedure TfrmCamera.FormCreate(Sender: TObject);
begin
  grdpnlVideo.ColumnCollection.Items[1].Value := 0;
  grdpnlVideo.RowCollection.Items[1].Value    := 0;

  { 读取相机配置 }
  if not ReadCameraConfig then
    PreviewNativeUSBCamera();
end;

procedure TfrmCamera.FormResize(Sender: TObject);
begin
 // VideoResize(pnlVideo01);
end;

procedure TfrmCamera.mniHelpAboutClick(Sender: TObject);
begin
  MessageBox(Handle, 'dbyoung@sina.com' + #13#10 + '2015-10-01 15:00:00', '系统提示：', MB_OK OR MB_ICONINFORMATION)
end;

procedure TfrmCamera.mniRecognizeCarClick(Sender: TObject);
begin
  mniRecognizeCar.Checked  := True;
  mniRecognizeFace.Checked := False;
end;

procedure TfrmCamera.mniRecognizeFaceClick(Sender: TObject);
begin
  mniRecognizeCar.Checked  := False;
  mniRecognizeFace.Checked := True;
end;

{ 读取相机配置 }
function TfrmCamera.ReadCameraConfig: Boolean;
var
  strConfigFileName: String;
begin
  Result := False;

  strConfigFileName := ExtractFilePath(ParamStr(0)) + ChangeFileExt(ExtractFileName(ParamStr(0)), '') + '.ini';
  with TIniFile.Create(strConfigFileName) do
  begin

    Free;
  end;
end;

end.
