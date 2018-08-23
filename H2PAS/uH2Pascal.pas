unit uH2Pascal;

interface

uses Windows, Classes, SysUtils, StrUtils;

procedure CHeader2Pascal(const strFileName: String; var strList: TStringList);

{ ɾ��ע�� }
procedure DeleteCHeadFileNote(const strFileName: string);

implementation

{
  ɾ��ע��
  C/C++ע�����ͣ�
  1��// ����
  2��/* */ ���С�����
}
procedure DeleteCHeadFileNote(const strFileName: string);
var
  I, J, K, L: Integer;
  strTemp   : String;
begin
  with TStringList.Create do
  begin
    LoadFromFile(strFileName);

    { 1.1��// ���� }
    for I := Count - 1 downto 0 do
    begin
      strTemp := Strings[I];
      J       := Pos('//', strTemp);
      K       := Pos('"', strTemp);
      if ((J > 0) and (K = 0)) or ((J > 0) and (J > K)) then
      begin
        strTemp    := LeftStr(strTemp, Length(strTemp) - J - 1);
        Strings[I] := strTemp;
      end;
    end;
    SaveToFile(strFileName);
    LoadFromFile(strFileName);

    { 1.2��/* */  ���� }
    for I := Count - 1 downto 0 do
    begin
      for L := 0 to 9 do
      begin
        strTemp := Strings[I];
        J       := Pos('/*', strTemp);
        K       := Pos('*/', strTemp);
        if ((J > 0) and (K > 0)) and (J > K) then
        begin
          strTemp    := LeftStr(strTemp, J - 1) + RightStr(strTemp, Length(strTemp) - (K + 1));
          Strings[I] := strTemp;
        end;
      end;
    end;
    SaveToFile(strFileName);
    LoadFromFile(strFileName);

    { 2.1��/* */ ���� }
    for I := Count - 1 downto 0 do
    begin
      strTemp := Trim(Strings[I]);
      J       := Pos('*/', strTemp);
      K       := Pos('/*', strTemp);
      if (K = 1) and (J = Length(strTemp) - 1) then
      begin
        Delete(I);
      end;
    end;
    SaveToFile(strFileName);
    LoadFromFile(strFileName);

    { 2.2��/* */ ���� }
    for I := Count - 1 downto 0 do
    begin

    end;

    SaveToFile(strFileName);
    Free;
  end;
end;

procedure CHeader2Pascal(const strFileName: String; var strList: TStringList);
begin

end;

end.
