unit Unit1;

interface

uses
  Winapi.Windows, System.SysUtils, System.StrUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCtrls,
  SynEditHighlighter, SynHighlighterCpp, SynEdit, SynEditCodeFolding, SynHighlighterPas;

type
  TForm1 = class(TForm)
    SearchBox1: TSearchBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    SynEdit1: TSynEdit;
    SynCppSyn1: TSynCppSyn;
    SynEdit2: TSynEdit;
    SynPasSyn1: TSynPasSyn;
    btnSaveToFile: TButton;
    btnTrans: TButton;
    procedure FormResize(Sender: TObject);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveToFileClick(Sender: TObject);
    procedure btnTransClick(Sender: TObject);
  private
    FstrTempFileName: String;
    { C头文件翻译到 PASCAL 语法 }
    procedure TransCHeader2Pascal(const strFileName: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses uDelCNote, uC2P;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.Title := 'C/C++ 头文件翻译到 Pascal (dll)';
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  SynEdit1.Left   := 8;
  SynEdit1.Top    := 68;
  SynEdit1.Height := Height - 114;
  SynEdit1.Width  := (Width - 8 - 12 - 22) div 2;

  SynEdit2.Left   := SynEdit1.Left + SynEdit1.Width + 8;
  SynEdit2.Top    := SynEdit1.Top;
  SynEdit2.Width  := SynEdit1.Width;
  SynEdit2.Height := SynEdit1.Height;
end;

procedure TForm1.SearchBox1InvokeSearch(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do
  begin
    Filter := '头文件(*.h;*.hpp)|*.h;*.hpp';
    if Execute() then
    begin
      SearchBox1.Text := FileName;
    end;
    Free;
  end;

  if not FileExists(SearchBox1.Text) then
  begin
    ShowMessage('文件不存在，请检查文件');
    Exit;
  end;

  if Trim(Edit1.Text) = '' then
  begin
    Edit1.Text := ChangeFileExt(ExtractFileName(SearchBox1.Text), '.dll');
  end;

  { C头文件翻译到 PASCAL 语法 }
  TransCHeader2Pascal(SearchBox1.Text);

  SynEdit1.SetFocus;
end;

{ C头文件翻译到 PASCAL 语法 }
procedure TForm1.TransCHeader2Pascal(const strFileName: string);
begin
  FstrTempFileName := ExtractFilePath(ParamStr(0)) + ExtractFileName(strFileName);
  if FileExists(FstrTempFileName) then
    DeleteFile(FstrTempFileName);

  { 复制到当前目录 }
  CopyFile(PChar(strFileName), PChar(FstrTempFileName), True);

  { 删除注释 }
  DeleteCHeadFileNote(FstrTempFileName);

  SynEdit1.Lines.LoadFromFile(FstrTempFileName);
  btnTrans.Enabled := True;
end;

procedure TForm1.btnTransClick(Sender: TObject);
var
  strList  : TStringList;
  intIndex1: Integer;
  intIndex2: Integer;
begin
  SynEdit2.Clear;

  strList := TStringList.Create;
  try
    strList.Add('unit ' + ChangeFileExt(ExtractFileName(FstrTempFileName), '') + ';');
    strList.Add('');
    strList.Add('uses Windows, Classes;');
    intIndex1 := strList.Add('');
    if Trim(Edit1.Text) <> '' then
    begin
      strList.Add('const');
      strList.Add('  c_strDllFileName = ' + QuotedStr(Edit1.Text) + ';');
      intIndex1 := strList.Add('');
    end;
    intIndex2 := strList.Add('implementation');
    strList.Add('');
    strList.Add('end.');
    CHeader2Pascal(FstrTempFileName, strList, intIndex1, intIndex2);
    SynEdit2.Lines.AddStrings(strList);
    btnSaveToFile.Enabled := True;
  finally
    strList.Free;
  end;
end;

procedure TForm1.btnSaveToFileClick(Sender: TObject);
var
  I, J       : Integer;
  strFileName: String;
begin
  with TSaveDialog.Create(nil) do
  begin
    Filter      := 'Pas(*.pas)|*.pas';
    I           := Pos(' ', SynEdit2.Lines.Strings[0]);
    J           := Pos(';', SynEdit2.Lines.Strings[0]);
    strFileName := Midstr(SynEdit2.Lines.Strings[0], I + 1, J - I - 1);
    FileName    := strFileName + '.pas';
    if Execute then
    begin
      SynEdit2.Lines.SaveToFile(FileName);
    end;
  end;
end;

end.
