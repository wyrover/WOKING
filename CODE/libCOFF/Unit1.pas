unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, Math, System.Types, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Menus;

type
  TForm1 = class(TForm)
    mmo1: TMemo;
    mm1: TMainMenu;
    mniFile: TMenuItem;
    mniFileOpen: TMenuItem;
    procedure mniFileOpenClick(Sender: TObject);
  private
    { Private declarations }
    procedure OpenStaticLib(const strLibFileName: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  TFirstSectionData = record
    SymbolNum: DWORD;
    SymbolOffset: array of DWORD;
    strTable: array of AnsiChar;
  end;

  TSecondSectionData = record
    ObjNum: DWORD;
    ObjOffset: array of DWORD;
    SymbolNum: DWORD;
    SymbolIdx: array of WORD;
    strTable: array of AnsiChar;
  end;

  TFirstSectionHeader = record
    Name: array [0 .. 16 - 1] of AnsiChar;       // 名称
    Time: array [0 .. 12 - 1] of AnsiChar;       // 时间
    UserID: array [0 .. 6 - 1] of AnsiChar;      // 用户ID
    GroupID: array [0 .. 6 - 1] of AnsiChar;     // 组ID
    Mode: array [0 .. 8 - 1] of AnsiChar;        // 模式
    Size: array [0 .. 10 - 1] of AnsiChar;       // 长度
    EndOfHeader: array [0 .. 2 - 1] of AnsiChar; // 结束符
  end;

  TSecondSectionHeader = TFirstSectionHeader;
  TThirdSectionHeader  = TFirstSectionHeader;
  TFourthSectionHeader = TFirstSectionHeader;

function BE2LE(const intValue: DWORD): DWORD;
begin
  Result := ((intValue and $000000FF) shl 24) or ((intValue and $0000FF00) shl 8) or ((intValue and $00FF0000) shr 8) or ((intValue and $FF000000) shr 24);
end;

procedure TForm1.OpenStaticLib(const strLibFileName: string);
var
  strHeader    : array [0 .. 7] of AnsiChar;
  fsh          : TFirstSectionHeader;
  ssh          : TSecondSectionHeader;
  tsh          : TThirdSectionHeader;
  f4sh         : TFourthSectionHeader;
  fsd          : TFirstSectionData;
  ssd          : TSecondSectionData;
  hFile        : THandle;
  Count        : Integer;
  intSize      : Integer;
  intLen       : Integer;
  Buffer       : array of AnsiChar;
  III, JJJ, KKK: Integer;
  strValue     : string;
  sCount       : Integer;
  oCount       : Integer;
  intIndex     : Integer;
  intPos       : Integer;
  strssec      : TStringList;
label _thirdsec;
begin
  hFile := FileOpen(strLibFileName, fmOpenRead);
  if (hFile <= 0) or (hFile = INVALID_HANDLE_VALUE) then
  begin
    ShowMessage('打开文件失败，请检查文件是否被占用');
    Exit;
  end;

  strssec            := TStringList.Create;
  strssec.Sorted     := True;
  strssec.Duplicates := dupIgnore;

  mmo1.Lines.BeginUpdate;
  mmo1.Lines.Clear;
  FileRead(hFile, strHeader[0], 8);
  mmo1.Lines.Add('0. 文件头(Signature)：' + string(strHeader));
  mmo1.Lines.Add('');

  { 第一个节 }
  FileRead(hFile, fsh, SizeOf(TFirstSectionHeader));
  mmo1.Lines.Add('1. 第一个节(First Sec)');
  mmo1.Lines.Add(Chr(9) + '10. 头部信息：');
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Name       : ' + string(fsh.Name));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Time       : ' + string(fsh.Time));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'UserID     : ' + string(fsh.UserID));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'GroupID    : ' + string(fsh.GroupID));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Mode       : ' + string(fsh.Mode));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Size       : ' + string(fsh.Size));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'EndOfHeader: ' + string(fsh.EndOfHeader));

  intSize := StrToInt(Trim(String(fsh.Size)));
  SetLength(Buffer, intSize);
  FileRead(hFile, Buffer[0], intSize);

  Count  := BE2LE(PCardinal(Buffer)^);
  intLen := intSize - (Count + 1) * 4;
  SetLength(fsd.SymbolOffset, Count);
  SetLength(fsd.strTable, intLen);
  fsd.SymbolNum := Count;
  CopyMemory(fsd.SymbolOffset, @Buffer[4], Count * 4);
  CopyMemory(fsd.strTable, @Buffer[4 * (Count + 1)], intLen);
  mmo1.Lines.Add(Chr(9) + '11. 数据信息：');
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Symbols: ' + IntToStr(Count));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Ord' + Chr(9) + 'Offset' + Chr(9) + Chr(9) + 'name');

  for III := 0 to Count - 1 do
  begin
    strssec.Add(IntToStr(BE2LE(fsd.SymbolOffset[III])));
  end;

  KKK     := 0;
  for III := 0 to Count - 1 do
  begin
    strValue := '';
    for JJJ  := KKK to intLen - 1 do
    begin
      if fsd.strTable[JJJ] <> #0 then
      begin
        strValue := strValue + string(fsd.strTable[JJJ]);
      end
      else
      begin
        mmo1.Lines.Add(Format('%s%0.3d%s$%0.8x%s%s', [Chr(9) + Chr(9), III + 1, Chr(9), BE2LE(fsd.SymbolOffset[III]), Chr(9), strValue]));
        KKK := JJJ + 1;
        Break;
      end;
    end;
  end;
  mmo1.Lines.Add('');

  { 第二个节 }
  mmo1.Lines.Add('2. 第二个节(Second Sec)');
  intPos := FileSeek(hFile, 0, 1);
  FileRead(hFile, ssh, SizeOf(TSecondSectionHeader));
  if Trim(string(ssh.Name)) = '//' then
  begin
    { 没有第二节，跳到第三节，MINGW 里面的库文件 }
    FileSeek(hFile, intPos, 0);
    mmo1.Lines.Add(Chr(9) + '没有此节');
    mmo1.Lines.Add('');
    goto _thirdsec;
  end;

  mmo1.Lines.Add(Chr(9) + '20. 头部信息：');
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Name       : ' + string(ssh.Name));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Time       : ' + string(ssh.Time));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'UserID     : ' + string(ssh.UserID));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'GroupID    : ' + string(ssh.GroupID));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Mode       : ' + string(ssh.Mode));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Size       : ' + string(ssh.Size));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'EndOfHeader: ' + string(ssh.EndOfHeader));

  intSize := StrToInt(Trim(String(ssh.Size)));
  SetLength(Buffer, intSize);
  FileRead(hFile, Buffer[0], intSize);

  oCount     := PCardinal(Buffer)^;
  ssd.ObjNum := oCount;
  SetLength(ssd.ObjOffset, ssd.ObjNum);
  CopyMemory(ssd.ObjOffset, @Buffer[4], oCount * 4);

  mmo1.Lines.Add(Chr(9) + '21. 数据信息：');
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Obj Files: ' + IntToStr(oCount));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Ord' + Chr(9) + 'Offset');
  for III := 0 to oCount - 1 do
  begin
    mmo1.Lines.Add(Chr(9) + Chr(9) + Format('%0.3d%s$%0.8x', [III + 1, Chr(9), ssd.ObjOffset[III]]));
  end;

  sCount        := PCardinal(@Buffer[(oCount * 4 + 4)])^;
  intLen        := intSize - 4 - oCount * 4 - 4 - sCount * 2;
  ssd.SymbolNum := sCount;
  SetLength(ssd.SymbolIdx, sCount);
  SetLength(ssd.strTable, intLen);
  CopyMemory(ssd.SymbolIdx, @Buffer[4 + oCount * 4 + 4], sCount);
  CopyMemory(ssd.strTable, @Buffer[4 + oCount * 4 + 4 + sCount * 2], intLen);

  mmo1.Lines.Add('');
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'SymbolIdx Count: ' + IntToStr(sCount));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Ord' + Chr(9) + 'Index' + Chr(9) + Chr(9) + 'Name');
  KKK     := 0;
  for III := 0 to Count - 1 do
  begin
    strValue := '';
    for JJJ  := KKK to intLen - 1 do
    begin
      if ssd.strTable[JJJ] <> #0 then
      begin
        strValue := strValue + string(ssd.strTable[JJJ]);
      end
      else
      begin
        mmo1.Lines.Add(Format('%s%0.3d%s$%0.8x%s%s', [Chr(9) + Chr(9), III + 1, Chr(9), (ssd.SymbolIdx[III]), Chr(9), strValue]));
        KKK := JJJ + 1;
        Break;
      end;
    end;
  end;
  mmo1.Lines.Add('');

_thirdsec:
  { 第三个节 }
  mmo1.Lines.Add('3. 第三个节(Longname Sec)');
  FileRead(hFile, tsh, SizeOf(TThirdSectionHeader));
  mmo1.Lines.Add(Chr(9) + '30. 头部信息：');
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Name       : ' + string(tsh.Name));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Time       : ' + string(tsh.Time));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'UserID     : ' + string(tsh.UserID));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'GroupID    : ' + string(tsh.GroupID));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Mode       : ' + string(tsh.Mode));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Size       : ' + string(tsh.Size));
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'EndOfHeader: ' + string(tsh.EndOfHeader));
  intSize := StrToInt(Trim(String(tsh.Size)));
  SetLength(Buffer, intSize);
  FileRead(hFile, Buffer[0], intSize);

  mmo1.Lines.Add(Chr(9) + '31. 数据信息：');
  mmo1.Lines.Add(Chr(9) + Chr(9) + 'Ord' + Chr(9) + 'Name');
  intIndex := 0;
  KKK      := 0;
  for III  := 0 to intSize - 1 do
  begin
    strValue := '';
    for JJJ  := KKK to intSize - 1 do
    begin
      if Buffer[JJJ] <> #0 then
      begin
        strValue := strValue + string(Buffer[JJJ]);
      end
      else
      begin
        Inc(intIndex);
        mmo1.Lines.Add(Chr(9) + Chr(9) + Format('%0.2d', [intIndex]) + Chr(9) + strValue);
        KKK := JJJ + 1;
        Break;
      end;
    end;
  end;

  if intIndex = 0 then
  begin
    KKK     := 0;
    for III := 0 to intSize - 1 do
    begin
      strValue := '';
      for JJJ  := KKK to intSize - 1 do
      begin
        if Buffer[JJJ] <> #10 then
        begin
          strValue := strValue + string(Buffer[JJJ]);
        end
        else
        begin
          Inc(intIndex);
          mmo1.Lines.Add(Chr(9) + Chr(9) + Format('%0.2d', [intIndex]) + Chr(9) + strValue);
          KKK := JJJ + 1;
          Break;
        end;
      end;
    end;
  end;

  mmo1.Lines.Add('');

  { 第四个节 }
  mmo1.Lines.Add('4. 第四个节(Obj Sec)');
  mmo1.Lines.Add(Chr(9) + '40. 头部信息：');
  if ssd.ObjNum > 0 then
  begin
    Caption := Format('%s%s', [strLibFileName, ' MSVC 静态库文件']);
    for III := 0 to ssd.ObjNum - 1 do
    begin
      FileSeek(hFile, ssd.ObjOffset[III], 0);
      FileRead(hFile, f4sh, SizeOf(TFourthSectionHeader));
      mmo1.Lines.Add(Chr(9) + Chr(9) + Format('File %d:  (位置：%d  大小：%d)', [III + 1, ssd.ObjOffset[III], StrToInt(Trim(String(f4sh.Size)))]));
      mmo1.Lines.Add(Chr(9) + Chr(9) + 'Name       : ' + string(f4sh.Name));
      mmo1.Lines.Add(Chr(9) + Chr(9) + 'Time       : ' + string(f4sh.Time));
      mmo1.Lines.Add(Chr(9) + Chr(9) + 'UserID     : ' + string(f4sh.UserID));
      mmo1.Lines.Add(Chr(9) + Chr(9) + 'GroupID    : ' + string(f4sh.GroupID));
      mmo1.Lines.Add(Chr(9) + Chr(9) + 'Mode       : ' + string(f4sh.Mode));
      mmo1.Lines.Add(Chr(9) + Chr(9) + 'Size       : ' + string(f4sh.Size));
      mmo1.Lines.Add(Chr(9) + Chr(9) + 'EndOfHeader: ' + string(f4sh.EndOfHeader));
      mmo1.Lines.Add('');
    end;
  end
  else
  begin
    { MINGW 里面的库文件 }
    if strssec.Count > 0 then
    begin
      Caption := Format('%s%s', [strLibFileName, ' MINGW 静态库文件']);
      for III := 0 to strssec.Count - 1 do
      begin
        FileSeek(hFile, StrToInt(strssec.Strings[III]), 0);
        FileRead(hFile, f4sh, SizeOf(TFourthSectionHeader));
        mmo1.Lines.Add(Chr(9) + Chr(9) + Format('File %d:  (位置：%d  大小：%d)', [III + 1, StrToInt(strssec.Strings[III]), StrToInt(Trim(String(f4sh.Size)))]));
        mmo1.Lines.Add(Chr(9) + Chr(9) + 'Name       : ' + string(f4sh.Name));
        mmo1.Lines.Add(Chr(9) + Chr(9) + 'Time       : ' + string(f4sh.Time));
        mmo1.Lines.Add(Chr(9) + Chr(9) + 'UserID     : ' + string(f4sh.UserID));
        mmo1.Lines.Add(Chr(9) + Chr(9) + 'GroupID    : ' + string(f4sh.GroupID));
        mmo1.Lines.Add(Chr(9) + Chr(9) + 'Mode       : ' + string(f4sh.Mode));
        mmo1.Lines.Add(Chr(9) + Chr(9) + 'Size       : ' + string(f4sh.Size));
        mmo1.Lines.Add(Chr(9) + Chr(9) + 'EndOfHeader: ' + string(f4sh.EndOfHeader));
        mmo1.Lines.Add('');
      end;
    end;
  end;

  strssec.Free;
  mmo1.Lines.EndUpdate;
  FileClose(hFile);
end;

procedure TForm1.mniFileOpenClick(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do
  begin
    Filter := '静态库文件(*.lib;*.a)|*.lib;*.a';
    if Execute() then
    begin
      OpenStaticLib(FileName);
    end;
    Free;
  end;
end;

end.
