unit untMain;
{$WARN UNIT_PLATFORM OFF}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Winapi.TlHelp32, System.Math, System.StrUtils, System.Win.ComObj, Winapi.ActiveX,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, System.IniFiles, Winapi.PsAPI, Winapi.ShLwApi, Winapi.ShellAPI, Winapi.ShlObj, System.Types, System.IOUtils,
  Vcl.Clipbrd, Vcl.FileCtrl, System.Win.Registry, Vcl.Menus, Data.Win.ADODB, Data.DB, Data.Win.ADOConEd;

type
  TfrmSystem = class(TForm)
    pgcAll: TPageControl;
    tsSystem: TTabSheet;
    tsProcess: TTabSheet;
    tsSearchPath: TTabSheet;
    tsDataBase: TTabSheet;
    tsWebSoft: TTabSheet;
    lbl1: TLabel;
    lvProcess: TListView;
    lvModule: TListView;
    tsPE: TTabSheet;
    tsServer: TTabSheet;
    tsAutorun: TTabSheet;
    tsShell: TTabSheet;
    pmProcess: TPopupMenu;
    mniOpenProcessPath: TMenuItem;
    mniRenameProcessName: TMenuItem;
    mniLoadPE: TMenuItem;
    mniLine01: TMenuItem;
    pmModule: TPopupMenu;
    mniOpenModulePath: TMenuItem;
    mniEjectFromProcess: TMenuItem;
    mniCopySelectedModulePath: TMenuItem;
    mniCopySelectedModuleName: TMenuItem;
    mniCopySelectedModuleMemoryAddress: TMenuItem;
    mniLine02: TMenuItem;
    mniLine03: TMenuItem;
    mniSaveToFile: TMenuItem;
    mniDllInsertProcess: TMenuItem;
    mniDumpToDiskFile: TMenuItem;
    mniSelectedLineToSaveFile: TMenuItem;
    btnSysSearchAdd: TButton;
    btnSysSearchModify: TButton;
    btnSysSearchUp: TButton;
    btnSysSearchDown: TButton;
    btnSysSearchUpTop: TButton;
    btnSysSearchDownBottom: TButton;
    btnSysSearchBackup: TButton;
    btnSysSearchRestore: TButton;
    btnSysSearchDel: TButton;
    btnInputSysSearch: TButton;
    lstSystemSearchPath: TListBox;
    btnLinkDataBase: TButton;
    adoconn: TADOConnection;
    grpTableName: TGroupBox;
    grpFields: TGroupBox;
    lstTables: TListBox;
    lvData: TListView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure lvProcessColumnClick(Sender: TObject; Column: TListColumn);
    procedure mniOpenProcessPathClick(Sender: TObject);
    procedure mniRenameProcessNameClick(Sender: TObject);
    procedure mniLoadPEClick(Sender: TObject);
    procedure lvProcessClick(Sender: TObject);
    procedure mniOpenModulePathClick(Sender: TObject);
    procedure mniEjectFromProcessClick(Sender: TObject);
    procedure mniCopySelectedModulePathClick(Sender: TObject);
    procedure mniCopySelectedModuleNameClick(Sender: TObject);
    procedure mniCopySelectedModuleMemoryAddressClick(Sender: TObject);
    procedure mniSaveToFileClick(Sender: TObject);
    procedure mniDllInsertProcessClick(Sender: TObject);
    procedure mniSelectedLineToSaveFileClick(Sender: TObject);
    procedure btnSysSearchBackupClick(Sender: TObject);
    procedure btnSysSearchRestoreClick(Sender: TObject);
    procedure btnSysSearchAddClick(Sender: TObject);
    procedure btnInputSysSearchClick(Sender: TObject);
    procedure btnSysSearchDelClick(Sender: TObject);
    procedure btnSysSearchModifyClick(Sender: TObject);
    procedure btnSysSearchUpClick(Sender: TObject);
    procedure btnSysSearchDownClick(Sender: TObject);
    procedure btnSysSearchUpTopClick(Sender: TObject);
    procedure btnSysSearchDownBottomClick(Sender: TObject);
    procedure btnLinkDataBaseClick(Sender: TObject);
    procedure lstTablesClick(Sender: TObject);
  private
    { Private declarations }
    function ReadDefaultPage: Integer;
    procedure EnumProcess(lv: TListView);
    procedure EnumProcessModules(const intPID: Cardinal; lv: TListView);
    procedure EnumSystemSearchPath(lstBox: TListBox);
  public
    { Public declarations }
  end;

var
  frmSystem: TfrmSystem;

implementation

{$R *.dfm}

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

function SHOpenFolderAndSelectItems(pidlFolder: pItemIDList; cidl: Cardinal; apidl: Pointer; dwFlags: DWORD): HRESULT; stdcall; external shell32;

function OpenFolderAndSelectFile(const strFileName: string; const bEditMode: Boolean = False): Boolean;
var
  IIDL      : pItemIDList;
  pShellLink: IShellLink;
  hr        : Integer;
begin
  Result := False;

  hr := CoCreateInstance(CLSID_ShellLink, nil, CLSCTX_INPROC_SERVER, IID_IShellLink, &pShellLink);
  if hr = S_OK then
  begin
    pShellLink.SetPath(PChar(strFileName));
    pShellLink.GetIDList(&IIDL);
    Result := SHOpenFolderAndSelectItems(IIDL, 0, nil, Cardinal(bEditMode)) = S_OK;
  end;
end;

procedure ModifySysSearchPath(const strsList: TStrings);
var
  strSearchPath: String;
  III          : Integer;
  rv           : DWORD_PTR;
begin
  strSearchPath := '';
  for III       := 0 to strsList.Count - 1 do
  begin
    strSearchPath := strSearchPath + ';' + strsList.Strings[III];
  end;
  strSearchPath := RightStr(strSearchPath, Length(strSearchPath) - 1);

  with TRegistry.Create do
  begin
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('SYSTEM\CurrentControlSet\Control\Session Manager\Environment', False);
    if (Win32MajorVersion >= 6) and (Win32MinorVersion >= 1) then
      WriteExpandString('Path', strSearchPath)
    else
      WriteString('Path', strSearchPath);

    SystemParametersInfo(SPI_SETCURSORS, 0, nil, SPIF_SENDCHANGE);
    SendMessageTimeout(HWND_BROADCAST, WM_WININICHANGE, $2A, LParam(PChar('Environment')), SMTO_NORMAL or SMTO_ABORTIFHUNG or SMTO_BLOCK, 5000, @rv);

    CloseKey;
    Free;
  end;
end;

procedure TfrmSystem.FormCreate(Sender: TObject);
begin
  EnableDebugPrivilege('SeDebugPrivilege', True);
  EnableDebugPrivilege('SeSecurityPrivilege', True);

  pgcAll.ActivePageIndex := ReadDefaultPage;
  EnumProcess(lvProcess);

  EnumSystemSearchPath(lstSystemSearchPath);
end;

procedure TfrmSystem.FormDestroy(Sender: TObject);
begin
  with TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini') do
  begin
    WriteInteger('ActivePageIndex', 'Value', pgcAll.ActivePageIndex);
    Free;
  end;

  EnableDebugPrivilege('SeDebugPrivilege', False);
  EnableDebugPrivilege('SeSecurityPrivilege', False);
end;

procedure TfrmSystem.FormResize(Sender: TObject);
begin
  lvProcess.Column[4].Width := Width - 774;
  lvModule.Column[2].Width  := Width - 684;
end;

var
  m_bSort: Boolean = False;

function CustomSortProc(Item1, Item2: TListItem; ParamSort: Integer): Integer; stdcall;
var
  txt1, txt2: string;
  intTemp1  : Integer;
  intTemp2  : Integer;
begin
  Result := 0;

  if ParamSort <> 0 then
  begin
    try
      txt1 := Item1.SubItems.Strings[ParamSort - 1];
      txt2 := Item2.SubItems.Strings[ParamSort - 1];
      if TryStrToInt(txt1, intTemp1) and TryStrToInt(txt2, intTemp2) then
      begin
        Result := IfThen(intTemp1 > intTemp2, 1 - Integer(m_bSort), Integer(m_bSort));
      end
      else
      begin
        Result := IfThen(m_bSort, 1, -1) * CompareText(txt1, txt2);
      end;
    except
    end;
  end
  else
  begin
    Result := IfThen(m_bSort, 1, -1) * CompareText(Item1.Caption, Item2.Caption);
  end;
end;

procedure TfrmSystem.lvProcessColumnClick(Sender: TObject; Column: TListColumn);
begin
  TListView(Sender).CustomSort(@CustomSortProc, Column.Index);
  m_bSort := not m_bSort;
end;

procedure TfrmSystem.mniOpenProcessPathClick(Sender: TObject);
begin
  if lvProcess.Selected = nil then
    Exit;

  if Trim(lvProcess.Selected.SubItems[3]) = '' then
    Exit;

  OpenFolderAndSelectFile(lvProcess.Selected.SubItems[3]);
end;

procedure TfrmSystem.mniRenameProcessNameClick(Sender: TObject);
begin
  if lvProcess.Selected = nil then
    Exit;

  if Trim(lvProcess.Selected.SubItems[3]) = '' then
    Exit;

  OpenFolderAndSelectFile(lvProcess.Selected.SubItems[3], True);
end;

function TfrmSystem.ReadDefaultPage: Integer;
begin
  with TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini') do
  begin
    Result := ReadInteger('ActivePageIndex', 'Value', 0);
    Free;
  end;
end;

function GetProcessName(dwProcessID: LongInt; bFullPath: Bool): PChar;
var
  hProcess: Cardinal;
begin
  GetMem(Result, 300);
  hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, dwProcessID);
  if bFullPath = False then
    GetModuleBaseName(hProcess, 0, Result, 300)
  else if GetModuleFileNameEx(hProcess, 0, Result, 300) = 0 then
    Result := '';
  CloseHandle(hProcess);
end;

function GetbX64Process(const intPID: Integer): Boolean;
var
  hProcess: UInt64;
  bWow64  : Bool;
begin
  hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, intPID);
  if IsWow64Process(hProcess, bWow64) then
  begin
    Result := not bWow64;
  end
  else
  begin
    Result := True;
  end;
  CloseHandle(hProcess);
end;

function GetFileDesc(const strExeName: string): String;
var
  n, Len     : DWORD;
  Buf        : PChar;
  Value      : Pointer;
  szName     : array [0 .. 255] of Char;
  Transstring: string;
  Translation: Cardinal;
begin
  Result := '';

  Len := GetFileVersionInfoSize(PChar(strExeName), n);
  if Len > 0 then
  begin
    Buf := AllocMem(Len);
    if GetFileVersionInfo(PChar(strExeName), n, Len, Buf) then
    begin
      VerQueryValue(Buf, '\\VarFileInfo\\Translation', Value, Len);
      if (Len > 0) then
      begin
        Translation := Cardinal(Value^);
        Transstring := Format('%4.4x%4.4x', [(Translation and $0000FFFF), ((Translation shr 16) and $0000FFFF)]);
      end;
      StrPCopy(szName, 'StringFileInfo\' + Transstring + '\FileDescription');
      if VerQueryValue(Buf, szName, Value, Len) then
        Result := StrPas(PChar(Value));
    end;
    FreeMem(Buf, n);
  end;
end;

function GetFileCompany(const strExeName: string): String;
var
  n, Len     : DWORD;
  Buf        : PChar;
  Value      : Pointer;
  szName     : array [0 .. 255] of Char;
  Transstring: string;
  Translation: Cardinal;
begin
  Result := '';

  Len := GetFileVersionInfoSize(PChar(strExeName), n);
  if Len > 0 then
  begin
    Buf := AllocMem(Len);
    if GetFileVersionInfo(PChar(strExeName), n, Len, Buf) then
    begin
      VerQueryValue(Buf, '\\VarFileInfo\\Translation', Value, Len);
      if (Len > 0) then
      begin
        Translation := Cardinal(Value^);
        Transstring := Format('%4.4x%4.4x', [(Translation and $0000FFFF), ((Translation shr 16) and $0000FFFF)]);
      end;
      StrPCopy(szName, 'StringFileInfo\' + Transstring + '\CompanyName');
      if VerQueryValue(Buf, szName, Value, Len) then
        Result := StrPas(PChar(Value));
    end;
    FreeMem(Buf, n);
  end;
end;

procedure TfrmSystem.EnumProcess(lv: TListView);
var
  hSnap         : THandle;
  pe32          : TProcessEntry32;
  bFind         : Boolean;
  intCount      : Integer;
  strProcessName: String;
begin
  hSnap := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnap = INVALID_HANDLE_VALUE then
    Exit;

  try
    pe32.dwSize := SizeOf(TProcessEntry32);
    bFind       := Process32First(hSnap, pe32);
    if not bFind then
      Exit;

    intCount := 0;

    lv.Items.BeginUpdate;
    while bFind do
    begin
      Inc(intCount);
      with lv.Items.Add do
      begin
        Caption        := Format('%0.3d', [intCount]);
        strProcessName := GetProcessName(pe32.th32ProcessID, True);
        SubItems.Add(pe32.szExeFile);
        SubItems.Add(Format('%4d', [pe32.th32ProcessID]));
        SubItems.Add(IfThen(GetbX64Process(pe32.th32ProcessID), 'x64', 'x86'));
        SubItems.Add(strProcessName);
        SubItems.Add(GetFileCompany(strProcessName));
        SubItems.Add(GetFileDesc(strProcessName));
      end;
      bFind := Process32Next(hSnap, pe32);
    end;
    lv.Items.EndUpdate;
  finally
    CloseHandle(hSnap);
  end;
end;

procedure TfrmSystem.EnumProcessModules(const intPID: Cardinal; lv: TListView);
var
  hSnap   : THandle;
  me32    : TModuleEntry32;
  intCount: Integer;
  bFind   : Boolean;
begin
  lv.Clear;

  hSnap := CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, intPID);
  if hSnap = INVALID_HANDLE_VALUE then
    Exit;

  try
    me32.dwSize := SizeOf(TModuleEntry32);
    bFind       := Module32First(hSnap, me32);
    if not bFind then
      Exit;

    intCount := 0;
    lv.Items.BeginUpdate;
    while bFind do
    begin
      Inc(intCount);
      with lv.Items.Add do
      begin
        Caption := Format('%0.3d', [intCount]);
        SubItems.Add(me32.szModule);
        SubItems.Add(me32.szExePath);
        SubItems.Add(Format('$%0.8x', [Cardinal(me32.modBaseAddr)]));
        SubItems.Add(Format('$%0.8x', [Cardinal(me32.modBaseSize)]));
        SubItems.Add(GetFileCompany(me32.szExePath));
      end;
      bFind := Module32Next(hSnap, me32);
    end;
    lv.Items.EndUpdate;
  finally
    CloseHandle(hSnap);
  end;
end;

function GetSysSearchPath: TStringDynArray;
begin
  with TRegistry.Create do
  begin
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey('SYSTEM\CurrentControlSet\Control\Session Manager\Environment', False);
    Result := SplitString(ReadString('Path'), ';');
    Free;
  end;
end;

procedure TfrmSystem.EnumSystemSearchPath(lstBox: TListBox);
var
  strArr: TStringDynArray;
  III   : Integer;
begin
  strArr  := GetSysSearchPath;
  for III := Low(strArr) to High(strArr) do
  begin
    lstBox.Items.Add(strArr[III]);
  end;
end;

{ ����ע�� }
procedure TfrmSystem.mniDllInsertProcessClick(Sender: TObject);
begin
  //
end;

{ ���̼��ص� PE }
procedure TfrmSystem.mniLoadPEClick(Sender: TObject);
begin
  //
end;

procedure TfrmSystem.lvProcessClick(Sender: TObject);
var
  intPID: Cardinal;
begin
  if lvProcess.Selected = nil then
    Exit;

  intPID := System.SysUtils.StrToInt(lvProcess.Selected.SubItems[1]);
  EnumProcessModules(intPID, lvModule);
end;

procedure TfrmSystem.mniOpenModulePathClick(Sender: TObject);
begin
  //
end;

procedure TfrmSystem.mniCopySelectedModuleMemoryAddressClick(Sender: TObject);
begin
  //
end;

procedure TfrmSystem.mniCopySelectedModuleNameClick(Sender: TObject);
begin
  //
end;

procedure TfrmSystem.mniCopySelectedModulePathClick(Sender: TObject);
begin
  //
end;

procedure TfrmSystem.mniEjectFromProcessClick(Sender: TObject);
begin
  //
end;

procedure TfrmSystem.mniSaveToFileClick(Sender: TObject);
begin
  //
end;

procedure TfrmSystem.mniSelectedLineToSaveFileClick(Sender: TObject);
begin
  //
end;

// ---------------------------------------------------------------------------------------------------------------------------------------//
// ----------------------------------------------------------- ϵͳ����·�� --------------------------------------------------------------//
// ---------------------------------------------------------------------------------------------------------------------------------------//

procedure TfrmSystem.btnInputSysSearchClick(Sender: TObject);
var
  strNewPath: String;
begin
  strNewPath := Clipboard.AsText;
  if not InputQuery('����·����', '���ƣ�', strNewPath) then
    Exit;

  lstSystemSearchPath.Selected[lstSystemSearchPath.Items.Add(strNewPath)] := True;
  ModifySysSearchPath(lstSystemSearchPath.Items);
end;

procedure TfrmSystem.btnSysSearchAddClick(Sender: TObject);
var
  strSelectDir: String;
begin
  if not SelectDirectory('��ѡ��һ���ļ��У�', '', strSelectDir) then
    Exit;

  lstSystemSearchPath.Items.Add(strSelectDir);
  ModifySysSearchPath(lstSystemSearchPath.Items);
end;

procedure TfrmSystem.btnSysSearchBackupClick(Sender: TObject);
begin
  with TSaveDialog.Create(nil) do
  begin
    Filter := 'ϵͳ����·�������ļ�(*.SSP)|*.SSP';
    if Execute() then
    begin
      lstSystemSearchPath.Items.SaveToFile(FileName + '.ssp');
    end;
    Free;
  end;
end;

procedure TfrmSystem.btnSysSearchDelClick(Sender: TObject);
begin
  if lstSystemSearchPath.ItemIndex < 0 then
    Exit;

  lstSystemSearchPath.DeleteSelected;
  ModifySysSearchPath(lstSystemSearchPath.Items);
end;

procedure TfrmSystem.btnSysSearchDownBottomClick(Sender: TObject);
begin
  if lstSystemSearchPath.ItemIndex < 0 then
    Exit;

  if lstSystemSearchPath.ItemIndex >= lstSystemSearchPath.Items.Count - 1 then
    Exit;

  lstSystemSearchPath.Items.Move(lstSystemSearchPath.ItemIndex, lstSystemSearchPath.Items.Count - 1);
  ModifySysSearchPath(lstSystemSearchPath.Items);
  lstSystemSearchPath.Selected[lstSystemSearchPath.Items.Count - 1] := True;
end;

procedure TfrmSystem.btnSysSearchDownClick(Sender: TObject);
begin
  if lstSystemSearchPath.ItemIndex < 0 then
    Exit;

  if lstSystemSearchPath.ItemIndex >= lstSystemSearchPath.Items.Count - 1 then
    Exit;

  lstSystemSearchPath.Items.Exchange(lstSystemSearchPath.ItemIndex, lstSystemSearchPath.ItemIndex + 1);
  ModifySysSearchPath(lstSystemSearchPath.Items);
end;

procedure TfrmSystem.btnSysSearchModifyClick(Sender: TObject);
var
  strNewPath: String;
begin
  if lstSystemSearchPath.ItemIndex < 0 then
    Exit;

  strNewPath := lstSystemSearchPath.Items.Strings[lstSystemSearchPath.ItemIndex];
  if not InputQuery('�޸�·��', '·����', strNewPath) then
    Exit;

  lstSystemSearchPath.Items.Strings[lstSystemSearchPath.ItemIndex] := strNewPath;
  ModifySysSearchPath(lstSystemSearchPath.Items);
end;

procedure TfrmSystem.btnSysSearchRestoreClick(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do
  begin
    Filter := 'ϵͳ����·�������ļ�(*.SSP)|*.SSP';
    if Execute() then
    begin
      lstSystemSearchPath.Items.LoadFromFile(FileName);
      ModifySysSearchPath(lstSystemSearchPath.Items);
    end;
    Free;
  end;
end;

procedure TfrmSystem.btnSysSearchUpClick(Sender: TObject);
begin
  if lstSystemSearchPath.ItemIndex <= 0 then
    Exit;

  lstSystemSearchPath.Items.Exchange(lstSystemSearchPath.ItemIndex, lstSystemSearchPath.ItemIndex - 1);
  ModifySysSearchPath(lstSystemSearchPath.Items);
end;

procedure TfrmSystem.btnSysSearchUpTopClick(Sender: TObject);
begin
  if lstSystemSearchPath.ItemIndex <= 0 then
    Exit;

  lstSystemSearchPath.Items.Move(lstSystemSearchPath.ItemIndex, 0);
  ModifySysSearchPath(lstSystemSearchPath.Items);
  lstSystemSearchPath.Selected[0] := True;
end;

// --------------------------------------------------------------------------------------------------------------------------------------//
// -------------------------------------------------------- Database ---------------------------------------------------------------------//
// ---------------------------------------------------------------------------------------------------------------------------------------//

procedure TfrmSystem.btnLinkDataBaseClick(Sender: TObject);
begin
  if not EditConnectionString(adoconn) then
    Exit;

  adoconn.GetTableNames(lstTables.Items);
end;

procedure TfrmSystem.lstTablesClick(Sender: TObject);
var
  strTableName: string;
  qry         : TADOQuery;
  bOpen       : Boolean;
  strsFields  : TStringList;
  III         : Integer;
begin
  if lstTables.SelCount = 0 then
    Exit;

  bOpen        := True;
  strTableName := lstTables.Items.Strings[lstTables.ItemIndex];
  qry          := TADOQuery.Create(nil);
  strsFields   := TStringList.Create;
  try
    qry.Connection := adoconn;
    qry.SQL.Add('select * from ' + strTableName);
    try
      qry.Open;
    except
      bOpen := False;
    end;

    if not bOpen then
      Exit;

    adoconn.GetFieldNames(strTableName, strsFields);
    lvData.Items.BeginUpdate;
    lvData.Clear;
    lvData.Columns.Clear;
    for III := 0 to strsFields.Count - 1 do
    begin
      with lvData.Columns.Add do
      begin
        Caption := strsFields[III];
        Width   := 100;
      end;
    end;

    if qry.RecordCount > 0 then
    begin
      qry.First;
      while not qry.Eof do
      begin
        with lvData.Items.Add do
        begin
          Caption := qry.Fields[0].AsString;
          for III := 1 to qry.FieldCount - 1 do
          begin
            SubItems.Add(qry.Fields[III].AsString);
          end;
        end;
        qry.Next;
      end;
    end;
    lvData.Items.EndUpdate;
  finally
    strsFields.Free;
    qry.Free;
  end;
end;

end.