unit Unit1;

interface

uses
  Windows, Messages, IniFiles, ShellAPI, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ADODB, DB, Buttons;

type
  TfrmDB = class(TForm)
    lblLinkExistDB: TLabel;
    lblRestoreDB: TLabel;
    lblAddDB: TLabel;
    img1: TImage;
    conLink: TADOConnection;
    lblChangeDB: TLabel;
    lblBackupDB: TLabel;
    btnClose: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblLinkExistDBMouseEnter(Sender: TObject);
    procedure lblLinkExistDBMouseLeave(Sender: TObject);
    procedure lblLinkExistDBClick(Sender: TObject);
    procedure lblRestoreDBClick(Sender: TObject);
    procedure lblAddDBClick(Sender: TObject);
    procedure img1Click(Sender: TObject);
    procedure lblChangeDBClick(Sender: TObject);
    procedure lblBackupDBClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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

uses untCommon;

procedure TfrmDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmDB.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Handle, WM_SYSCOMMAND, SC_MOVE or HTCAPTION, 0);
end;

procedure TfrmDB.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDB.lblLinkExistDBMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clRed;
end;

procedure TfrmDB.lblLinkExistDBMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlue;
end;

{ 设置主程序 }
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

{ 1、连接到已有数据库 }
procedure TfrmDB.lblLinkExistDBClick(Sender: TObject);
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

{ 2、更换数据库 }
procedure TfrmDB.lblChangeDBClick(Sender: TObject);
begin
  if not LinkDataBase(conLink, False) then
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

{ 3、附加数据库 }
procedure TfrmDB.lblAddDBClick(Sender: TObject);
begin
  //
end;

{ 4、恢复数据库 }
procedure TfrmDB.lblRestoreDBClick(Sender: TObject);
begin
  //
end;

{ 5、备份数据库 }
procedure TfrmDB.lblBackupDBClick(Sender: TObject);
begin
  //
end;

end.
