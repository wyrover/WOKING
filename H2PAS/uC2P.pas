unit uC2P;

interface

uses Windows, Classes, SysUtils, StrUtils, Types;

procedure CHeader2Pascal(const strFileName, strDllFileName: String; var strList: TStringList);

implementation

{ 常量 }
procedure CHeader2Pascal_Const(const strTemp: String; const intIndex: Integer; var strList: TStringList);
var
  strArr     : String;
  I          : Integer;
  strLineList: TStringList;
begin
  if Trim(strTemp)[1] <> '\' then
  begin
    { 不跨行，单行 }
    strArr      := StringReplace(strTemp, ' ', #$D#$A, [rfReplaceAll]);
    strLineList := TStringList.Create;
    try
      strLineList.Text := strArr;
      if strLineList.Count > 2 then
      begin
        for I := strLineList.Count - 1 downto 0 do
        begin
          if Trim(strLineList.Strings[I]) = '' then
          begin
            strLineList.Delete(I);
          end;
        end;

        if strLineList.Count = 3 then
        begin
          if StrToIntDef(strLineList.Strings[2], -135792468) = -135792468 then
          begin
            if Trim(strLineList.Strings[2])[1] <> '"' then
            begin

            end
            else
            begin
              strList.Add(Format('  %s = %s', [strLineList.Strings[1], strLineList.Strings[2]]));
            end;
          end
          else
          begin
            strList.Add(Format('  %s = %s', [strLineList.Strings[1], strLineList.Strings[2]]));
          end;
        end;
      end;
    finally
      strLineList.Free;
    end;
  end
  else
  begin
    { 跨行，多行 }

  end;
end;

{ 枚举 }
procedure CHeader2Pascal_Enum(const strTemp: String; const intIndex: Integer; var strList: TStringList);
begin

end;

{ 结构 }
procedure CHeader2Pascal_struct(const strTemp: String; const intIndex: Integer; var strList: TStringList);
begin

end;

procedure AddCHead2Pascal(const strFileName: String; var strList: TStringList);
var
  I, J        : Integer;
  strcHeadList: TStringList;
  strTemp     : String;
begin
  strcHeadList := TStringList.Create;
  try
    strcHeadList.LoadFromFile(strFileName);
    for I := 0 to strcHeadList.Count - 1 do
    begin
      strTemp := strcHeadList.Strings[I];
      if Trim(strTemp) = '' then
        Continue;

      { 宏定义 }

      { 头文件 }

      { 常量 }
      J := Pos('#define ', strTemp);
      if J > 0 then
      begin
        CHeader2Pascal_Const(strTemp, I, strList);
      end;

      { 枚举 }
      J := Pos('enum ', strTemp);
      if J > 0 then
      begin
        CHeader2Pascal_Enum(strTemp, I, strList);
      end;

      { 结构 }
      J := Pos('typedef struct ', strTemp);
      if J > 0 then
      begin
        CHeader2Pascal_struct(strTemp, I, strList);
      end;

      { 输出函数 }

      { 自定义函数 }

    end;
  finally
    strcHeadList.Free;
  end;
end;

procedure CHeader2Pascal(const strFileName, strDllFileName: String; var strList: TStringList);
begin
  strList.Add('unit ' + ChangeFileExt(ExtractFileName(strFileName), '') + ';');
  strList.Add('');
  strList.Add('uses Windows, Classes;');
  strList.Add('');
  if Trim(strDllFileName) <> '' then
  begin
    strList.Add('const');
    strList.Add('  c_strDllFileName = ' + QuotedStr(strDllFileName) + ';');
    strList.Add('');
    AddCHead2Pascal(strFileName, strList);
  end;
  strList.Add('');
  strList.Add('implementation');
  strList.Add('');
  strList.Add('end.');
end;

end.
