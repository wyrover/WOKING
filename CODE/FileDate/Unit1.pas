unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, System.Types, System.IOUtils,
  Vcl.Menus;

type
  TfrmFileDateTime = class(TForm)
    lv1: TListView;
    MainMenu1: TMainMenu;
    mniDirectory: TMenuItem;
    mniColumn: TMenuItem;
    mniColumnCopy: TMenuItem;
    mniDirectoryFind: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure lv1ColumnClick(Sender: TObject; Column: TListColumn);
    procedure lv1Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure mniDirectoryFindClick(Sender: TObject);
    procedure mniColumnCopyClick(Sender: TObject);
  private
    { Private declarations }
    procedure ListFileInfo(const strPath: string);
  public
    { Public declarations }
  end;

var
  frmFileDateTime: TfrmFileDateTime;

implementation

{$R *.dfm}

procedure TfrmFileDateTime.FormCreate(Sender: TObject);
begin
  ListFileInfo('F:\openssl-1.0.1c\tmp32');
end;

procedure TfrmFileDateTime.ListFileInfo(const strPath: string);
var
  arrFiles   : TStringDynArray;
  strFileName: string;
begin
  arrFiles := TDirectory.GetFiles(strPath, '*.obj');
  lv1.Clear;
  lv1.Items.BeginUpdate;
  for strFileName in arrFiles do
  begin
    with lv1.Items.Add do
    begin
      Caption := (strFileName);
      SubItems.Add(DateTimeToStr(TFile.GetCreationTime(strFileName)));
      SubItems.Add(DateTimeToStr(TFile.GetLastAccessTime(strFileName)));
      SubItems.Add(DateTimeToStr(TFile.GetLastWriteTime(strFileName)));
    end;
  end;
  lv1.Items.EndUpdate;
end;

procedure TfrmFileDateTime.lv1ColumnClick(Sender: TObject; Column: TListColumn);
begin
  (Sender as TListView).CustomSort(nil, Column.Index);
end;

procedure TfrmFileDateTime.lv1Compare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if Data = 0 then
    Compare := CompareStr(Item1.Caption, Item2.Caption)
  else
    Compare := CompareStr(Item1.SubItems.Strings[Data - 1], Item2.SubItems.Strings[Data - 1]);
end;

procedure TfrmFileDateTime.mniColumnCopyClick(Sender: TObject);
var
  I: Integer;
begin
  with TStringList.Create do
  begin
    for I := 0 to lv1.Items.Count - 1 do
    begin
      Add(Format('{$LINK %s }', [ExtractFileName(lv1.Items[I].Caption)]));
    end;
    SaveToFile('D:\temp.txt');
    Free;
  end;
end;

procedure TfrmFileDateTime.mniDirectoryFindClick(Sender: TObject);
begin
  //
end;

end.
