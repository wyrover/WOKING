unit uDelCNote;

interface

uses Windows, Classes, SysUtils, StrUtils;

{ 删除注释 }
procedure DeleteCHeadFileNote(const strFileName: string);

implementation

function GetLine(const strFileName: String; const intIndex: Integer; var intPos: Integer): Integer;
var
  I, J   : Integer;
  strTemp: String;
begin
  Result := -1;
  with TStringList.Create do
  begin
    LoadFromFile(strFileName);
    for I := intIndex - 1 downto 0 do
    begin
      strTemp := Trim(Strings[I]);
      J       := Pos('/*', strTemp);
      if J > 0 then
      begin
        if J = 1 then // 一行的开始
        begin
          Result := I;
          intPos := 0;
          Break;
        end
        else
        begin
          Result := I; // 一行的结尾
          intPos := Pos('/*', Strings[I]);
          Break;
        end;
      end;
    end;
    Free;
  end;
end;

{
  删除注释
  C/C++注释类型：
  1：// 单行
  2：/* */ 单行、多行
}
procedure DeleteCHeadFileNote(const strFileName: string);
var
  I, J, K, L: Integer;
  strTemp   : String;
  intCount  : Integer;
  intPos    : Integer;
label reCount;
begin
  with TStringList.Create do
  begin
    LoadFromFile(strFileName);

    { 1：// 单行 行尾 }
    for I := 0 to Count - 1 do
    begin
      strTemp := Strings[I];
      J       := Pos('//', strTemp);
      K       := Pos('"', strTemp);
      if ((J > 0) and (K = 0)) or ((J > 0) and (K > 0) and (J > K)) then
      begin
        strTemp    := LeftStr(strTemp, J - 1);
        Strings[I] := strTemp;
      end;
    end;

    { 2.1：/* */  单行 一行中有可能有多对 }
    for I := 0 to Count - 1 do
    begin
      for L := 0 to 9 do
      begin
        strTemp := Strings[I];
        J       := Pos('/*', strTemp);
        K       := Pos('*/', strTemp);
        if ((J > 0) and (K > 0)) and (K > J) then
        begin
          strTemp    := LeftStr(strTemp, J - 1) + RightStr(strTemp, Length(strTemp) - (K + 1));
          Strings[I] := strTemp;
        end;
      end;
    end;

    { 2.2：/* */ 多行，/* 有可能在一行的开始，也有可能在一行的结尾 }
    intCount := Count;
  reCount:
    for I := intCount - 1 downto 0 do
    begin
      strTemp := Strings[I];
      K       := Pos('*/', strTemp);
      if K = 0 then
        Continue;

      J := GetLine(strFileName, I, intPos);
      if J = -1 then
        Continue;

      if intPos = 0 then
      begin
        { 一行的开始 }
        for L := I downto J do
        begin
          Delete(L);
        end;
        intCount := intCount - (I - J + 1);
      end
      else
      begin
        { 一行的结尾 }
        for L := I downto J + 1 do
        begin
          Delete(L);
        end;
        Strings[J] := LeftStr(Strings[J], intPos - 1);
        intCount   := intCount - (I - J);
      end;

      goto reCount;
    end;

    SaveToFile(strFileName);
    Free;
  end;
end;

end.
