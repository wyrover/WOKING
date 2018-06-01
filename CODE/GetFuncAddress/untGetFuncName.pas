unit untGetFuncName;

interface

uses System.Classes, System.SysUtils, System.Rtti;

{ ��ȡ��ǰ�����ĵ�ǰ EIP ��ǰ���е�ַ }
procedure GetEIP(); stdcall;

{ ��ȡ��ǰ�������� }
function GetCurrentFuncName(const frm: TObject): string;

implementation

var
  { ��ǰ���е�ַ }
  g_CurrentFuncEIP: Cardinal;

  { ��ȡ��ǰ�����ĵ�ǰ EIP ��ǰ���е�ַ }
procedure GetEIP(); stdcall;
asm
  POP EAX;
  MOV g_CurrentFuncEIP,EAX;
  PUSH EAX;
end;

{ TStringList ���������� }
function cmpint(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Index1 := StrToIntDef(List[Index1], 0);
  Index2 := StrToIntDef(List[Index2], 0);
  Result := Index1 - Index2;
end;

{ ö�� frm ���Ժ������ƺͺ�����ڵ�ַ���� intEIP �Աȣ��Ӷ��õ��������� }
function CheckEIP(const intEIP: Cardinal; const frm: TObject): string;
type
  PMethodInfo = ^TMethodInfo;

  TMethodInfo = record
    strAddress: ShortString;
    strFunName: ShortString;
  end;
var
  rc      : TRttiContext;
  rt      : TRttiType;
  rm      : TRttiMethod;
  sl      : TStringList;
  pmi     : PMethodInfo;
  intIndex: Integer;
  III     : Integer;
begin
  rc := TRttiContext.Create;
  sl := TStringList.Create;
  try
    sl.Sorted := False;
    rt        := rc.GetType(frm.ClassInfo);
    for rm in rt.GetMethods do
    begin
      pmi             := AllocMem(SizeOf(TMethodInfo));
      pmi^.strAddress := ShortString(Format('%d', [Cardinal(rm.CodeAddress)]));
      pmi^.strFunName := ShortString(Format('%s', [rm.ToString]));
      sl.AddObject(String(pmi.strAddress), TObject(pmi));
    end;

    { �ӵ��б��� }
    sl.Append(IntToStr(intEIP));

    { ���������� }
    sl.CustomSort(cmpint);

    { �����ռ������ʲôλ�� }
    intIndex := sl.IndexOf(IntToStr(intEIP));

    { ���غ������� }
    if intIndex = 0 then
      Result := string(PMethodInfo(sl.Objects[intIndex + 1])^.strFunName)
    else
      Result := string(PMethodInfo(sl.Objects[intIndex - 1])^.strFunName);

    { �ͷ��ڴ� }
    for III := 0 to sl.Count - 1 do
    begin
      FreeMem(PMethodInfo(sl.Objects[III]));
    end;
  finally
    sl.Free;
    rc.Free;
  end;
end;

{ ��ȡ��ǰ�������� }
function GetCurrentFuncName(const frm: TObject): string;
begin
  Result := CheckEIP(g_CurrentFuncEIP, frm);
end;

end.
