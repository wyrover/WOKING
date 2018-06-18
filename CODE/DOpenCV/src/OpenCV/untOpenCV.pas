unit untOpenCV;

interface

uses
  Winapi.Windows, System.Classes, System.SysUtils, System.StrUtils, System.Rtti, System.TypInfo, Winapi.ImageHlp, untOpenCVType;

type
  { OpenCV 基类，包含 Dll 中所有 C 类型的导出函数 }
  TOpenCV = class
  private
    FhDllHandle: THandle;
    FListFunc  : TList;
    { 获取函数列表 }
    procedure InitCPlusPlusFunc;
    { 获取函数的入口地址 }
    function GetFunctionEntryAddress(const intIndex: Integer; eft: PImageExportDirectory): Pointer; overload;
    { 获取 Dll 中 C++ 类型的导出函数全称 }
    function GetCppFuncFullName(const strFuncName: ShortString): String;
  protected
    { 根据函数名称，获取函数的入口地址 <C类型函数> }
    function GetFunctionEntryAddressC(const strFunctionName: string): Pointer;
    { 根据函数名称，获取函数的入口地址 <C++函数> }
    function GetFunctionEntryAddressCpp(const strFunctionName: string): Pointer;
    { 将入口地址 赋给 Public 成员变量 }
    procedure SetFieldFuncAddress(pFuncEntry: Pointer; intOffset: Integer);
    { 设置 public 中所有函数地址 }
    procedure SetPublicFieldvarAddress;
  public
    { Dll 中所有 C 类型的导出函数 }
    cvLoadImage    : TcvLoadImage;
    cvNamedWindow  : TcvNamedWindow;
    cvShowImage    : TcvShowImage;
    cvWaitKey      : TcvWaitKey;
    cvReleaseImage : TcvReleaseImage;
    cvDestroyWindow: TcvDestroyWindow;
    { .............................. }
    { .........Add All C 函数....... }
    { .............................. }
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses untOpenCV.cv;

{ TOpenCV }

constructor TOpenCV.Create;
begin
  FListFunc   := TList.Create;
  FhDllHandle := LoadLibrary(PWideChar(c_strOpenCVDll));
  InitCPlusPlusFunc;
  SetPublicFieldvarAddress;
end;

destructor TOpenCV.Destroy;
var
  III: Integer;
begin
  FreeLibrary(FhDllHandle);

  if FListFunc <> nil then
  begin
    { 释放内存 }
    if FListFunc.Count > 0 then
    begin
      for III := FListFunc.Count - 1 downto 0 do
      begin
        FreeMem(FListFunc[III]);
      end;
    end;

    FListFunc.Free;
  end;
  inherited;
end;

{ 根据函数名称，获取函数的入口地址 }
function TOpenCV.GetFunctionEntryAddressC(const strFunctionName: string): Pointer;
var
  III: Integer;
begin
  Result := nil;

  { 获取函数的入口地址 <C函数> }
  for III := 0 to FListFunc.Count - 1 do
  begin
    if CompareStr(strFunctionName, String(PDllFuncInfo(FListFunc.Items[III])^.strFunctionName)) = 0 then
    begin
      Result := PDllFuncInfo(FListFunc.Items[III])^.intEntryAddress;
      Break;
    end;
  end;
end;

{ 根据函数名称，获取函数的入口地址 <C++函数> }
function TOpenCV.GetFunctionEntryAddressCpp(const strFunctionName: string): Pointer;
begin
  Result := nil;
end;

{ 将入口地址 赋给 Public 成员变量 }
procedure TOpenCV.SetFieldFuncAddress(pFuncEntry: Pointer; intOffset: Integer); assembler;
asm
  MOV [RCX + RAX], RDX
end;

{ 设置 public 中所有函数地址 }
procedure TOpenCV.SetPublicFieldvarAddress;
type
  PUInt32 = ^UInt32;
var
  rc         : TRttiContext;
  rt         : TRttiType;
  rm         : TRttiField;
  strFuncName: String;
  pFuncEntry : Pointer;
begin
  rc := TRttiContext.Create;
  try
    rt := rc.GetType(ClassInfo);
    for rm in rt.GetFields do
    begin
      if rm.Visibility = mvPublic then
      begin
        strFuncName := rm.Name;                               // 成员变量，即：函数名称
        pFuncEntry  := GetFunctionEntryAddressC(strFuncName); // 根据函数名称，获取入口地址
        SetFieldFuncAddress(pFuncEntry, rm.Offset);           // 将入口地址 赋给 成员变量
      end;
    end;
  finally
    rc.Free;
  end;
end;

{ 获取函数的入口地址 }
function TOpenCV.GetFunctionEntryAddress(const intIndex: Integer; eft: PImageExportDirectory): Pointer;
var
  JJJ: Integer;
begin
  Result  := nil;
  for JJJ := 0 to eft^.NumberOfFunctions - 1 do
  begin
    if JJJ = intIndex then
    begin
      Result := Pointer(FhDllHandle + PCardinal(FhDllHandle + eft^.AddressOfFunctions + Cardinal(4 * JJJ))^);
      Break;
    end;
  end;
end;

{ 获取 Dll 中 C++ 类型的导出函数全称 }
function TOpenCV.GetCppFuncFullName(const strFuncName: ShortString): String;
var
  chrBuffer: array [0 .. 255] of AnsiChar;
begin
  UnDecorateSymbolName(PAnsiChar(AnsiString(strFuncName)), chrBuffer, 256, 0);
  Result := string(chrBuffer);
end;

{ 获取函数列表 }
procedure TOpenCV.InitCPlusPlusFunc;
var
  idh               : PImageDosHeader;
  inh               : PImageNtHeaders64;
  intExportTableRVA : Cardinal;
  eft               : PImageExportDirectory;
  strFunctionName   : array [0 .. 255] of AnsiChar;
  intFunctionAddress: Cardinal;
  tmpFuncInfo       : PDllFuncInfo;
  III               : Integer;
begin
  idh               := PImageDosHeader(FhDllHandle);                                                   // 读取文件头
  inh               := PImageNtHeaders(FhDllHandle + Cardinal(idh^._lfanew));                          // 读取 TImageNtHeaders64
  intExportTableRVA := inh^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress; // 导出表虚拟地址

  { 枚举导出函数名称 }
  eft     := PImageExportDirectory(FhDllHandle + intExportTableRVA);                                 // 函数导出表
  for III := 0 to eft^.NumberOfNames - 1 do                                                          //
  begin                                                                                              //
    CopyMemory(@intFunctionAddress, Pointer(FhDllHandle + eft^.AddressOfNames + DWORD(4 * III)), 4); // 取得导出函数地址
    CopyMemory(@strFunctionName[0], Pointer(FhDllHandle + intFunctionAddress), 256);                 // 取得函数名称
    tmpFuncInfo                  := AllocMem(SizeOf(TDllFuncInfo));                                  // 注意释放内存
    tmpFuncInfo^.strFunctionName := ShortString(strFunctionName);                                    // 添加函数名称
    tmpFuncInfo^.strFullFuncName := ShortString(GetCppFuncFullName(tmpFuncInfo^.strFunctionName));   // 添加函数全称
    tmpFuncInfo^.intEntryAddress := GetFunctionEntryAddress(III, eft);                               // 添加函数入口地址
    FListFunc.Add(tmpFuncInfo);                                                                      // 添加到列表
  end;
end;

end.
