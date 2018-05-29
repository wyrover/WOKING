unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.StdCtrls,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, System.Types, System.IOUtils, uMFTSearchFile;

type
  TfrmFileSearch = class(TForm)
    lvFileList: TListView;
    pnl1: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FstrsFileList: TStringList;
    procedure GetAllLogicalDisk(pnl: TPanel);
    procedure OnFileSearchClick(Sender: TObject);
    { 获取逻辑磁盘下所有文件 }
    procedure GetLogicalAllFiles(const strLogicalDiskName: string; lvFiles: TListView);
    procedure FillUI(lv: TListView; strs: TStringList);
  public
    { Public declarations }
  end;

procedure ShowDllForm(var strTitle: PChar; var frm: TFormClass); stdcall;

implementation

{$R *.dfm}

procedure ShowDllForm(var strTitle: PChar; var frm: TFormClass); stdcall;
begin
  strTitle := '光速搜索';
  frm      := TfrmFileSearch;
end;

procedure TfrmFileSearch.FormCreate(Sender: TObject);
begin
  FstrsFileList := TStringList.Create;
  GetAllLogicalDisk(pnl1);
end;

procedure TfrmFileSearch.GetAllLogicalDisk(pnl: TPanel);
var
  strsLogicalDisk: TStringDynArray;
  III            : Integer;
begin
  strsLogicalDisk := TDirectory.GetLogicalDrives;
  for III         := Low(strsLogicalDisk) to High(strsLogicalDisk) do
  begin
    with TButton.Create(pnl) do
    begin
      Parent  := pnl;
      Caption := strsLogicalDisk[III];
      Width   := 80;
      Height  := 30;
      Top     := 4;
      Left    := 4 + III * (Width + 4);
      OnClick := OnFileSearchClick;
    end;
  end;
end;

procedure TfrmFileSearch.FillUI(lv: TListView; strs: TStringList);
var
  III         : Integer;
  intST, intET: Cardinal;
begin
  intST := GetTickCount;
  lv.Items.Clear;
  lv.Items.BeginUpdate;
  for III := 0 to strs.Count - 1 do
  begin
    with lv.Items.Add do
    begin
      Caption := IntToStr(III);
      SubItems.Add(strs[III]);
    end;
  end;
  lv.Items.EndUpdate;
  intET := GetTickCount;
  ShowMessage(Format('界面加载用时：%d 秒', [(intET - intST) div 1000]));
end;

{ 获取逻辑磁盘下所有文件 }
procedure TfrmFileSearch.GetLogicalAllFiles(const strLogicalDiskName: string; lvFiles: TListView);
var
  intST, intET  : Cardinal;
  chrLogicalDisk: Char;
begin
  chrLogicalDisk := Char(strLogicalDiskName[1]);
  FstrsFileList.Clear;
  intST := GetTickCount;
  GetLogicalDiskAllFiles(chrLogicalDisk, FstrsFileList, True);
  intET   := GetTickCount;
  Caption := Format('扫描 %s:\ , 共计：%d 个文件和文件夹。用时：%d 秒', [chrLogicalDisk, FstrsFileList.Count, (intET - intST) div 1000]);
  { 加载到界面列表 }
  FillUI(lvFiles, FstrsFileList);
end;

procedure TfrmFileSearch.OnFileSearchClick(Sender: TObject);
var
  strLogicalDisk: String;
begin
  strLogicalDisk := TButton(Sender).Caption;
  GetLogicalAllFiles(strLogicalDisk, lvFileList);
end;

end.
