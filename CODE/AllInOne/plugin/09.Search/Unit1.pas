unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.StdCtrls,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, System.Types, System.IOUtils, uMFTSearchFile,
  VirtualTrees;

type
  TfrmFileSearch = class(TForm)
    pnl1: TPanel;
    chk1: TCheckBox;
    lvFileList: TVirtualStringTree;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure lvFileListInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure lvFileListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
  private
    { Private declarations }
    FstrsFileList: TStringList;
    procedure GetAllLogicalDisk(pnl: TPanel);
    procedure OnFileSearchClick(Sender: TObject);
    { 获取逻辑磁盘下所有文件 }
    procedure GetLogicalAllFiles(const strLogicalDiskName: string; lvFiles: TVirtualStringTree);
  public
    { Public declarations }
  end;

procedure ShowDllForm(var strTitle: PChar; var frm: TFormClass); stdcall;

implementation

{$R *.dfm}

uses Unit5;

type
  PMyRec = ^TMyRec;

  TMyRec = record
    intIndex: Integer;
    Caption: WideString;
  end;

procedure ShowDllForm(var strTitle: PChar; var frm: TFormClass); stdcall;
begin
  strTitle := '光速搜索';
  frm      := TfrmFileSearch;
end;

procedure TfrmFileSearch.FormCreate(Sender: TObject);
begin
  lvFileList.NodeDataSize := SizeOf(TMyRec);
  FstrsFileList           := TStringList.Create;
  GetAllLogicalDisk(pnl1);
end;

procedure TfrmFileSearch.FormResize(Sender: TObject);
begin
  lvFileList.Header.Columns[1].Width := Width - 176;
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

{ 获取逻辑磁盘下所有文件 }
procedure TfrmFileSearch.GetLogicalAllFiles(const strLogicalDiskName: string; lvFiles: TVirtualStringTree);
var
  intST, intET  : Cardinal;
  chrLogicalDisk: Char;
  strTip        : String;
begin
  chrLogicalDisk := Char(strLogicalDiskName[1]);
  FstrsFileList.Clear;
  intST := GetTickCount;
  GetLogicalDiskAllFiles(chrLogicalDisk, FstrsFileList, chk1.Checked);
  intET  := GetTickCount;
  strTip := Format('扫描 %s:\ , 共计：%d 个文件和文件夹。用时：%d 秒', [chrLogicalDisk, FstrsFileList.Count, (intET - intST) div 1000]);
  EnableWaittingForm(strTip);
  lvFiles.RootNodeCount := FstrsFileList.Count;
end;

procedure DelayTime(const intTime: Cardinal);
var
  intET, intST: Cardinal;
begin
  intST := GetTickCount;
  while True do
  begin
    Application.ProcessMessages;
    intET := GetTickCount;
    if intET - intST >= intTime then
      Break;
  end;
end;

procedure TfrmFileSearch.OnFileSearchClick(Sender: TObject);
var
  strLogicalDisk: String;
begin
  ShowWaittingForm;
  DelayTime(200);
  lvFileList.Clear;
  strLogicalDisk := TButton(Sender).Caption;
  GetLogicalAllFiles(strLogicalDisk, lvFileList);
end;

procedure TfrmFileSearch.lvFileListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Data: PMyRec;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
  begin
    if Column = 0 then
      CellText := IntToStr(Data^.intIndex);

    if Column = 1 then
      CellText := Data^.Caption;
  end;
end;

procedure TfrmFileSearch.lvFileListInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PMyRec;
begin
  with Sender do
  begin
    Data           := GetNodeData(Node);
    Data^.intIndex := Node.Index;
    Data^.Caption  := FstrsFileList[Node.Index];
  end;
end;

end.
