unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCtrls, System.IOUtils;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    SearchBox1: TSearchBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormResize(Sender: TObject);
    procedure SearchBox1InvokeSearch(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Cͷ�ļ����뵽 PASCAL �﷨ }
    procedure TransCHeader2Pascal(const strFileName: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses uH2Pascal;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.Title := 'C/C++ ͷ�ļ����뵽 Pascal (dll)';
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  Memo1.Left   := 8;
  Memo1.Top    := 68;
  Memo1.Height := Height - 114;
  Memo1.Width  := (Width - 8 - 12 - 22) div 2;

  Memo2.Left   := Memo1.Left + Memo1.Width + 8;
  Memo2.Top    := Memo1.Top;
  Memo2.Width  := Memo1.Width;
  Memo2.Height := Memo1.Height;
end;

procedure TForm1.SearchBox1InvokeSearch(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do
  begin
    Filter := 'ͷ�ļ�(*.h;*.hpp)|*.h;*.hpp';
    if Execute() then
    begin
      SearchBox1.Text := FileName;
    end;
    Free;
  end;

  if not FileExists(SearchBox1.Text) then
  begin
    ShowMessage('�ļ������ڣ������ļ�');
    Exit;
  end;

  Memo1.Lines.LoadFromFile(SearchBox1.Text);

  { Cͷ�ļ����뵽 PASCAL �﷨ }
  TransCHeader2Pascal(SearchBox1.Text);
end;

{ Cͷ�ļ����뵽 PASCAL �﷨ }
procedure TForm1.TransCHeader2Pascal(const strFileName: string);
var
  strTempFileName: String;
  strList        : TStringList;
begin
  strTempFileName := ExtractFilePath(ParamStr(0)) + ExtractFileName(strFileName);
  if FileExists(strTempFileName) then
    DeleteFile(strTempFileName);

  { ���Ƶ���ǰĿ¼ }
  CopyFile(PChar(strFileName), PChar(strTempFileName), True);

  { ɾ��ע�� }
  DeleteCHeadFileNote(strTempFileName);

  strList := TStringList.Create;
  try
    CHeader2Pascal(strTempFileName, strList);
    Memo2.Lines.AddStrings(strList);
  finally
    strList.Free;
  end;
end;

end.
