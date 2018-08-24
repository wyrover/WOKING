unit uC2P;

interface

uses Windows, Classes, SysUtils, StrUtils, Types;

procedure CHeader2Pascal(const strFileName: String; var strList: TStringList; const intIndexConst, intIndex2: Integer);

implementation

procedure CHeader2Pascal_Const(const strTemp: String; const intStart: Integer; var strList: TStringList; const intNewIndex: Integer);
var
  strArr     : String;
  I          : Integer;
  strLineList: TStringList;
begin
  if Trim(strTemp)[1] <> '\' then
  begin
    { �����У����� }
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
              strList.Insert(intNewIndex, Format('  %s = %s', [strLineList.Strings[1], strLineList.Strings[2]]));
            end;
          end
          else
          begin
            strList.Insert(intNewIndex, Format('  %s = %s', [strLineList.Strings[1], strLineList.Strings[2]]));
          end;
        end;
      end;
    finally
      strLineList.Free;
    end;
  end
  else
  begin
    { ���У����� }

  end;
end;

procedure CHeader2Pascal(const strFileName: String; var strList: TStringList; const intIndexConst, intIndex2: Integer);
var
  I, J        : Integer;
  strcHeadList: TStringList;
  strTemp     : String;
begin
  strcHeadList := TStringList.Create;
  try
    strcHeadList.LoadFromFile(strFileName);
    for I := strcHeadList.Count - 1 downto 0 do
    begin
      strTemp := strcHeadList.Strings[I];
      if Trim(strTemp) = '' then
        Continue;

      { �궨�� }

      { ͷ�ļ� }

      { ���� }
      J := Pos('#define ', strTemp);
      if J > 0 then
      begin
        CHeader2Pascal_Const(strTemp, I, strList, intIndexConst);
      end;

      { ö�� }

      { �ṹ }

      { ������� }

      { �Զ��庯�� }

    end;
  finally
    strcHeadList.Free;
  end;
end;

end.
