unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IOUtils, Types;

type
  TForm1 = class(TForm)
    lst1: TListBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  c_strMSYS2 = 'F:\Green\Language\MSYS2\mingw64\lib';

procedure TForm1.FormCreate(Sender: TObject);
var
  arrFiles    : TStringDynArray;
  strFileName : String;
  III         : Integer;
  strStaticLib: String;
begin
  arrFiles := TDirectory.GetFiles(c_strMSYS2, '*.dll.a');    // , TSearchOption.soAllDirectories

  lst1.Items.BeginUpdate;
  for III := Low(arrFiles) to High(arrFiles) do
  begin
    strFileName  := arrFiles[III];
    strStaticLib := ExtractFilePath(strFileName) + ChangeFileExt(ChangeFileExt(ExtractFileName(strFileName), ''), '.a');
    if not FileExists(strStaticLib) then
    begin
      DeleteFile(strFileName);
      //lst1.Items.Add(strFileName);
    end;
  end;
  lst1.Items.EndUpdate;
end;

end.
