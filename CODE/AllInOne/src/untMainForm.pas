unit untMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,
  System.IOUtils, System.Types;

type
  TForm1 = class(TForm)
    pgcAll: TPageControl;
    tsConfig: TTabSheet;
    chkTrayIco: TCheckBox;
    trycnTools: TTrayIcon;
    pmTools: TPopupMenu;
    mniConfig: TMenuItem;
    mniLine0ne: TMenuItem;
    mniExit: TMenuItem;
    mniShowForm: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mniExitClick(Sender: TObject);
    procedure mniShowFormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FbExit: Boolean;
    procedure AddAllModule;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  TShowDllForm = procedure(var strTitle: PChar; var frm: TFormClass); stdcall;

  PDllFormInfo = ^TDllFormInfo;

  TDllFormInfo = record
    hFormHandle: THandle;
    OldWndProc: Pointer;
  end;

var
  FOldWndProcList: TList;

  { 解决 dll 中，当控件获取焦点，主窗体变成非激活状态 }
function NewDllFormProc(hWnd: THandle; msg: UINT; wParam: Cardinal; lParam: Cardinal): Integer; stdcall;
var
  III: Integer;
begin
  Result := 1;

  { 如果子窗体获取焦点时，激活主窗体 }
  if msg = WM_ACTIVATE then
  begin
    if Application.MainForm <> nil then
    begin
      SendMessage(Application.MainForm.Handle, WM_NCACTIVATE, Integer(True), 0);
    end;
  end;

  { 调用原来的回调过程 }
  for III := 0 to FOldWndProcList.Count - 1 do
  begin
    if PDllFormInfo(FOldWndProcList[III])^.hFormHandle = hWnd then
    begin
      Result := CallWindowProc(PDllFormInfo(FOldWndProcList[III])^.OldWndProc, hWnd, msg, wParam, lParam);
    end;
  end;
end;

procedure TForm1.AddAllModule;
var
  strDllPath    : String;
  strDllFileName: String;
  dllModuleList : TStringDynArray;
  III, Count    : Integer;
  hDllFileHandle: Cardinal;
  tmpFunc       : TShowDllForm;
  strTitle      : PChar;
  tmpfrm        : TFormClass;
  tmpts         : TTabSheet;
  DllForm       : TForm;
  DllInfo       : PDllFormInfo;
  OldWndProc    : Pointer;
begin
  { 插件目录是否存在 }
  strDllPath := ExtractFilePath(ParamStr(0)) + 'plugin';
  if not DirectoryExists(strDllPath) then
    Exit;

  { 枚举所有 DLL 插件文件 }
  dllModuleList := TDirectory.GetFiles(strDllPath, '*.dll');
  Count         := Length(dllModuleList);
  if Count = 0 then
    Exit;

  { 加载 DLL 插件文件 }
  FOldWndProcList := TList.Create;
  for III         := 0 to Count - 1 do
  begin
    strDllFileName := dllModuleList[III];
    hDllFileHandle := LoadLibrary(PChar(strDllFileName));
    if hDllFileHandle = 0 then
      Continue;

    { 判断 DLL 中是否有指定的导出函数 }
    tmpFunc := GetProcAddress(hDllFileHandle, 'ShowDllForm');
    if not Assigned(tmpFunc) then
      Continue;

    { 创建 TAB 页放置 DLL 窗体 }
    tmpFunc(strTitle, tmpfrm);
    tmpts             := TTabSheet.Create(pgcAll);
    tmpts.PageControl := pgcAll;
    tmpts.Name        := strTitle;
    tmpts.Caption     := strTitle;
    tmpts.PageIndex   := 0;

    DllForm             := tmpfrm.Create(Application);
    DllForm.Position    := poDesigned;
    DllForm.BorderStyle := bsNone;
    DllForm.Color       := clWhite;
    DllForm.Anchors     := [akLeft, akTop, akRight, akBottom];
    SetWindowPos(DllForm.Handle, tmpts.Handle, 0, 0, tmpts.Width - 4, tmpts.Height - 4, SWP_NOZORDER + SWP_NOACTIVATE);
    DllForm.Show;

    { 解决 DLL 窗体获取焦点时，主窗体丢失焦点的问题 }
    Winapi.Windows.SetParent(DllForm.Handle, tmpts.Handle);               // 解决 DLL 窗体 TAB 键不能用的问题
    OldWndProc := Pointer(GetWindowLong(DllForm.Handle, GWL_WNDPROC));    // 拦截 DLL 窗体消息
    SetWindowLong(DllForm.Handle, GWL_WNDPROC, LongInt(@NewDllFormProc)); // 指向新的窗体过程

    { 记录下 DLL 窗体回调过程信息 }
    DllInfo              := AllocMem(SizeOf(TDllFormInfo)); // 注意释放内存
    DllInfo^.hFormHandle := DllForm.Handle;                 // 记录下窗体句柄
    DllInfo^.OldWndProc  := OldWndProc;                     // 记录下窗体回调过程地址
    FOldWndProcList.Add(DllInfo);                           // 添加到列表
  end;

  pgcAll.ActivePageIndex := 0;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not FbExit then
  begin
    if chkTrayIco.Checked then
    begin
      Hide;
      trycnTools.Visible := True;
      Action             := caNone;
    end
    else
    begin
      Action := caFree;
    end;
  end
  else
  begin
    Action := caFree;
  end;
end;

function EnableDebugPrivilege(PrivName: string; CanDebug: Boolean): Boolean;
var
  TP    : Winapi.Windows.TOKEN_PRIVILEGES;
  Dummy : Cardinal;
  hToken: THandle;
begin
  OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES, hToken);
  TP.PrivilegeCount := 1;
  LookupPrivilegeValue(nil, PChar(PrivName), TP.Privileges[0].Luid);
  if CanDebug then
    TP.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED
  else
    TP.Privileges[0].Attributes := 0;
  Result                        := AdjustTokenPrivileges(hToken, False, TP, SizeOf(TP), nil, Dummy);
  hToken                        := 0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FbExit := False;

  EnableDebugPrivilege('SeDebugPrivilege', True);
  EnableDebugPrivilege('SeSecurityPrivilege', True);

  AddAllModule;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  III: Integer;
begin
  if FOldWndProcList <> nil then
  begin
    if FOldWndProcList.Count > 0 then
    begin
      for III := 0 to FOldWndProcList.Count - 1 do
      begin
        FreeMem(FOldWndProcList[III]);
      end;
    end;
    FOldWndProcList.Free;
  end;
end;

function EnumChildFunc(hDllForm: THandle; hTabSheetHandle: THandle): Boolean; stdcall;
var
  rct: TRect;
begin
  { 判断是否是 DLL 的窗体句柄，不是子窗体的句柄 }
  if GetParent(hDllForm) = 0 then
  begin
    GetWindowRect(hTabSheetHandle, rct);
    SetWindowPos(hDllForm, hTabSheetHandle, 0, 0, rct.Width - 4, rct.Height - 4, SWP_NOZORDER + SWP_NOACTIVATE);
  end;
  Result := True;
end;

procedure TForm1.FormResize(Sender: TObject);
var
  III: Integer;
begin
  { 枚举每个 TABSHEET 的子窗体 }
  for III := 0 to pgcAll.PageCount - 2 do
  begin
    EnumChildWindows(pgcAll.Pages[III].Handle, @EnumChildFunc, pgcAll.Pages[III].Handle);
  end;
end;

procedure TForm1.mniExitClick(Sender: TObject);
begin
  FbExit := True;
  Close;
end;

procedure TForm1.mniShowFormClick(Sender: TObject);
begin
  if Visible then
    Hide
  else
    Show;
end;

end.
