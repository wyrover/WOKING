unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Data.DB, Data.Win.ADODB, Data.Win.ADOConEd, System.IniFiles;

type
  TForm1 = class(TForm)
    btn1: TButton;
    grpTable: TGroupBox;
    grpField: TGroupBox;
    lstTable: TListBox;
    lvFields: TListView;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    procedure btn1Click(Sender: TObject);
    procedure lstTableClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure GetTables;
    procedure GetFields;
    procedure GetData;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  strLink: String;
begin
  with TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini') do
  begin
    strLink := ReadString('DB', 'LINK', '');
    Free;
  end;

  ADOConnection1.KeepConnection   := True;
  ADOConnection1.LoginPrompt      := False;
  ADOConnection1.Connected        := False;
  ADOConnection1.ConnectionString := strLink;
  if not EditConnectionString(ADOConnection1) then
    Exit;

  with TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini') do
  begin
    WriteString('DB', 'LINK', ADOConnection1.ConnectionString);
    Free;
  end;

  GetTables;
end;

procedure TForm1.GetTables;
begin
  ADOConnection1.GetTableNames(lstTable.Items);
end;

procedure TForm1.lstTableClick(Sender: TObject);
begin
  GetFields;
  GetData;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  strLink   : String;
  bConnected: Boolean;
begin
  with TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini') do
  begin
    strLink := ReadString('DB', 'LINK', '');
    Free;
  end;

  if strLink = '' then
    Exit;

  ADOConnection1.KeepConnection   := True;
  ADOConnection1.LoginPrompt      := False;
  ADOConnection1.Connected        := False;
  ADOConnection1.ConnectionString := strLink;
  try
    ADOConnection1.Connected := True;
    bConnected               := True;
  except
    bConnected := False;
  end;

  if bConnected then
  begin
    GetTables;
  end;
end;

procedure TForm1.GetData;
begin

end;

function GetDataType(const intType: Integer): String;
begin
  Result := 'unkonwn';
  case intType of
    111, 61, 0:
      Result := 'DateTime';
    106, 63:
      Result := 'Cardinal';
    56, 37:
      Result := 'GUID';
    50:
      Result := 'BIT';
    39:
      Result := 'pChar';
    38:
      Result := 'Integer';
    34:
      Result := 'Image';
    108:
      Result := 'Int64';
  end;
end;

procedure TForm1.GetFields;
begin
  with TADOQuery.Create(nil) do
  begin
    Connection := ADOConnection1;
    SQL.Add(Format('Select name,type from syscolumns Where ID=OBJECT_ID(%s)', [QuotedStr(lstTable.Items.Strings[lstTable.ItemIndex])]));
    Open;
    if RecordCount > 0 then
    begin
      lvFields.Items.Clear;
      while not Eof do
      begin
        with lvFields.Items.Add do
        begin
          Caption := FieldByName('name').AsString;
          SubItems.Add(GetDataType(FieldByName('type').AsInteger));
        end;
        Next;
      end;
    end;
    Free;
  end;
end;

end.
