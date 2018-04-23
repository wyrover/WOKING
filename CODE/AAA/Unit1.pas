unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.IniFiles, Generics.Collections,
  Vcl.StdCtrls, System.StrUtils, System.Math, System.DateUtils,
  Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses uMFTSearchFile;

procedure TForm1.btn1Click(Sender: TObject);
var
  FileList    : TStringList;
  intST, intET: Cardinal;
begin
  FileList     := TStringList.Create;
  btn1.Enabled := False;
  try
    intST := GetTickCount;
    GetLogicalDiskAllFiles('C', FileList, True);
    intET := GetTickCount;
    ShowMessage(Format('文件和文件夹合计： %d 个； 搜索用时： %0.2f 秒', [FileList.Count, (intET - intST) / 1000]));
    FileList.SaveToFile('d:\temp.txt', TEncoding.UTF8);
  finally
    btn1.Enabled := True;
    FileList.Free;
  end;
end;

end.
