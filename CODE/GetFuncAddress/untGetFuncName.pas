unit untGetFuncName;

interface

uses System.Classes, System.SysUtils, System.Rtti;

{ 获取当前函数的当前 EIP 当前运行地址 }
procedure GetEIP(); stdcall;

{ 获取当前函数名称 }
function GetCurrentFuncName(const frm: TObject): string;

implementation

var
  { 当前运行地址 }
  g_CurrentFuncEIP: Cardinal;

  { 获取当前函数的当前 EIP 当前运行地址 }
procedure GetEIP(); stdcall;
asm
  POP EAX;
  MOV g_CurrentFuncEIP,EAX;
  PUSH EAX;
end;

{ TStringList 按整数排序 }
function cmpint(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Index1 := StrToIntDef(List[Index1], 0);
  Index2 := StrToIntDef(List[Index2], 0);
  Result := Index1 - Index2;
end;

{ 枚举 frm 所以函数名称和函数入口地址，与 intEIP 对比，从而得到函数名称 }
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

    { 加到列表中 }
    sl.Append(IntToStr(intEIP));

    { 按整数排序 }
    sl.CustomSort(cmpint);

    { 检索刚加入的在什么位置 }
    intIndex := sl.IndexOf(IntToStr(intEIP));

    { 返回函数名称 }
    if intIndex = 0 then
      Result := string(PMethodInfo(sl.Objects[intIndex + 1])^.strFunName)
    else
      Result := string(PMethodInfo(sl.Objects[intIndex - 1])^.strFunName);

    { 释放内存 }
    for III := 0 to sl.Count - 1 do
    begin
      FreeMem(PMethodInfo(sl.Objects[III]));
    end;
  finally
    sl.Free;
    rc.Free;
  end;
end;

{ 获取当前函数名称 }
function GetCurrentFuncName(const frm: TObject): string;
begin
  Result := CheckEIP(g_CurrentFuncEIP, frm);
end;

end.
