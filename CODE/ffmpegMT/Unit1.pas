unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst, System.IOUtils, System.Types;

type
  TForm1 = class(TForm)
    chklst1: TCheckListBox;
    btn1: TButton;
    btn2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
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
  c_constFFMPEGVCPath = 'E:\Source\ffmpeg\backup\ffvc';
  c_strReleaseX64     = '<ItemDefinitionGroup Condition="' + #$27 + '$(Configuration)|$(Platform)' + #$27 + '==' + #$27 + 'Release|x64' + #$27 + '">';
  c_strReleaseX64MT   = '      <RuntimeLibrary>MultiThreaded</RuntimeLibrary>';

function ModifyFileReleaseX64MTProc(const strFileName: String; const lstFile: TStringList; const intPos: Integer): Boolean;
var
  III: Integer;
  JJJ: Integer;
  KKK: Integer;
begin
  JJJ := -1;

  { 寻找  </ClCompile> 节 }
  for III := intPos + 1 to lstFile.Count - 1 do
  begin
    if lstFile.Strings[III].Contains('</ClCompile>') then
    begin
      JJJ := III;
      break;
    end;
  end;

  Result := JJJ <> -1;

  if Result then
  begin
    { 寻找  <RuntimeLibrary> 属性 }
    KKK     := -1;
    for III := intPos + 1 to JJJ - 1 do
    begin
      if lstFile.Strings[III].Contains('<RuntimeLibrary>') then
      begin
        KKK := III;
        break;
      end;
    end;

    if KKK = -1 then
    begin
      { <RuntimeLibrary> 不存在，直接插入到 </ClCompile> 前一行 }
      lstFile.Insert(JJJ, c_strReleaseX64MT);
      lstFile.SaveToFile(strFileName);
    end
    else
    begin
      { <RuntimeLibrary>   存在，修改此行 }
      lstFile.Strings[KKK] := c_strReleaseX64MT;
      lstFile.SaveToFile(strFileName);
    end;
  end;

end;

function ModifyFileReleaseX64MT(const strFileName: string): Boolean;
var
  III, JJJ: Integer;
  KKK, MMM: Integer;
  lstFile : TStringList;
begin
  Result := False;

  lstFile := TStringList.Create;
  try
    lstFile.LoadFromFile(strFileName);

    { 找到了 }
    for III := 0 to lstFile.Count - 1 do
    begin
      if (lstFile.Strings[III].Contains(c_strReleaseX64)) and (lstFile.Strings[III + 1].Contains('<ClCompile>')) then
      begin
        Result := True;
        if not ModifyFileReleaseX64MTProc(strFileName, lstFile, III) then
        begin
          ShowMessage('找到文件了，但没有修改成功');
        end;
        break;
      end;
    end;

    { 没有找到 }
    if not Result then
    begin

      KKK     := -1;
      MMM     := -1;
      for III := 0 to lstFile.Count - 1 do
      begin
        if lstFile.Strings[III].Contains(c_strReleaseX64) then
        begin
          for JJJ := III + 1 to lstFile.Count - 1 do
          begin
            if lstFile.Strings[JJJ].Contains('</ItemDefinitionGroup>') then
            begin
              MMM := III;
              KKK := JJJ;
              break;
            end;
          end;
        end;
      end;

      if KKK <> -1 then
      begin
        for JJJ := MMM + 1 to KKK - 1 do
        begin
          if lstFile.Strings[JJJ].Contains('<ClCompile>') then
          begin
            Result := True;
            if not ModifyFileReleaseX64MTProc(strFileName, lstFile, JJJ) then
            begin
              ShowMessage('找到文件了，但没有修改成功');
            end;
            break;
          end;
        end;
      end
      else
      begin
        Result := False;
        ShowMessage(strFileName);
      end;

    end;
  finally
    lstFile.Free;
  end;
end;

procedure TForm1.btn1Click(Sender: TObject);
var
  III: Integer;
begin
  for III := 0 to chklst1.Count - 1 do
  begin
    if chklst1.Checked[III] then
    begin
      ModifyFileReleaseX64MT(chklst1.Items.Strings[III]);
    end;
  end;
  ShowMessage('修改完毕');
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  //
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  strFiles: TStringDynArray;
  III     : Integer;
begin
  strFiles := TDirectory.GetFiles(c_constFFMPEGVCPath, '*.vcxproj', TSearchOption.soAllDirectories);
  for III  := Low(strFiles) to High(strFiles) do
  begin
    if strFiles[III].Contains('\SMP\') then
    begin
      chklst1.Checked[chklst1.Items.Add(strFiles[III])] := True;
    end;
  end;
end;

end.
