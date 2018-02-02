unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, System.IniFiles;

type
  TfrmHookPE = class(TForm)
    lv1: TListView;
    btn1: TButton;
    btn2: TButton;
    mmo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    FbHook: Boolean;
    procedure AllPeSaveToFile;
    procedure StartHOOK;
    procedure StopHOOK;
    procedure CopyNewFile(const strFileName, strNewFileName: string);
  protected
    procedure WMCopyData(var M: TWMCopyData); message WM_COPYDATA;
  public
    { Public declarations }
  end;

var
  frmHookPE: TfrmHookPE;

implementation

{$R *.dfm}

procedure TfrmHookPE.AllPeSaveToFile;
var
  III: Integer;
begin
  with TStringList.Create do
  begin
    for III := 0 to lv1.Items.Count - 1 do
    begin
      Add(lv1.Items[III].SubItems[0]);
    end;
    SaveToFile(ExtractFilePath(ParamStr(0)) + 'hpe.txt');
    Free;
  end;
end;

procedure TfrmHookPE.btn1Click(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do
  begin
    Filter := 'PE(*.EXE)|*.EXE';
    if Execute() then
    begin
      with lv1.Items.Add do
      begin
        Caption := IntToStr(lv1.Items.Count);
        SubItems.Add(FileName);
      end;
      AllPeSaveToFile;
    end;
    Free;
  end;
end;

procedure TfrmHookPE.btn2Click(Sender: TObject);
begin
  if not FbHook then
  begin
    FbHook       := True;
    btn1.Enabled := False;
    lv1.Enabled  := False;
    btn2.Caption := 'UNHOOK';
    StartHOOK;
  end
  else
  begin
    FbHook       := False;
    btn1.Enabled := True;
    lv1.Enabled  := True;
    btn2.Caption := 'HOOK';
    StopHOOK;
  end;
end;

procedure TfrmHookPE.FormCreate(Sender: TObject);
var
  III: Integer;
begin
  FbHook := False;

  with TStringList.Create do
  begin
    if FileExists(ExtractFilePath(ParamStr(0)) + 'hpe.txt') then
    begin
      LoadFromFile(ExtractFilePath(ParamStr(0)) + 'hpe.txt');
      with lv1.Items.Add do
      begin
        lv1.Items.BeginUpdate;
        for III := 0 to Count - 1 do
        begin
          Caption := IntToStr(lv1.Items.Count);
          SubItems.Add(Strings[III]);
        end;
        lv1.Items.EndUpdate;
      end;
    end;
    Free;
  end;
end;

procedure TfrmHookPE.CopyNewFile(const strFileName, strNewFileName: string);
var
  hFileHandle: THandle;
  dosh       : TImageDosHeader;
  intOffset  : Integer;
  nt         : TImageNtHeaders;
  memrc      : TResourceStream;
begin
  hFileHandle := FileOpen(strNewFileName, fmOpenRead);
  try
    FileRead(hFileHandle, dosh, SizeOf(TImageDosHeader));
    intOffset := dosh._lfanew;
    FileSeek(hFileHandle, intOffset, 0);
    FileRead(hFileHandle, nt, SizeOf(TImageNtHeaders));
    if nt.FileHeader.Machine = IMAGE_FILE_MACHINE_I386 then
    begin
      { x86 }
      memrc := TResourceStream.Create(HInstance, 'X86', RT_RCDATA);
      try
        memrc.SaveToFile(strFileName);
      finally
        memrc.Free;
      end;
    end
    else
    begin
      { x64 }
      memrc := TResourceStream.Create(HInstance, 'X64', RT_RCDATA);
      try
        memrc.SaveToFile(strFileName);
      finally
        memrc.Free;
      end;
    end;
  finally
    FileClose(hFileHandle);
  end;
end;

procedure TfrmHookPE.StartHOOK;
var
  III           : Integer;
  strFileName   : String;
  strNewFileName: String;
begin
  for III := 0 to lv1.Items.Count - 1 do
  begin
    strFileName    := lv1.Items[III].SubItems[0];
    strNewFileName := Format('%s%s.hpe.exe', [ExtractFilePath(strFileName), ChangeFileExt(ExtractFileName(strFileName), '')]);
    RenameFile(strFileName, strNewFileName);
    CopyNewFile(strFileName, strNewFileName);
  end;
end;

procedure TfrmHookPE.StopHOOK;
var
  III           : Integer;
  strFileName   : String;
  strNewFileName: String;
begin
  for III := 0 to lv1.Items.Count - 1 do
  begin
    strFileName    := lv1.Items[III].SubItems[0];
    strNewFileName := Format('%s%s.hpe.exe', [ExtractFilePath(strFileName), ChangeFileExt(ExtractFileName(strFileName), '')]);
    if FileExists(strNewFileName) then
    begin
      while True do
      begin
        DeleteFile(strFileName);
        if not FileExists(strFileName) then
          Break;
      end;
      RenameFile(strNewFileName, strFileName);
    end;
  end;
end;

procedure TfrmHookPE.WMCopyData(var M: TWMCopyData);
begin
  mmo1.Lines.Add(string(PChar(M.CopyDataStruct.lpData)));
end;

end.
