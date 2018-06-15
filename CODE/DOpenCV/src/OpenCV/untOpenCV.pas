unit untOpenCV;
{
  OpenCV for Delphi
  Delphi 10.2.3 测试通过
  dbyoung@sina.com
  2018-06-01
}

interface

uses
  Winapi.Windows, System.Classes, System.SysUtils, Winapi.ImageHlp, System.Rtti, System.TypInfo, untOpenCVType;

type
  Tcv     = class;
  TString = class;

  { OpenCV 基类 <包含 Dll 导出的 C 类型函数> }
  TOpenCV = class
  private
    FhDllHandle: THandle;
    FListFunc  : TList;
    { 获取 Dll 所有导出函数列表 }
    procedure InitDllAllExportFunc;
    { 获取所有 Public 成员变量的函数入口地址 }
    procedure InitPublicFieldVarAddress;
    { 获取函数的入口地址 }
    function GetFunctionEntryAddress(const intIndex: Integer; eft: PImageExportDirectory): Pointer;
    { 设置 Public 成员变量的函数入口地址 }
    procedure SetPublicFieldVarAddress(const pFuncEntryAddress: Pointer; const intOffset: Integer);
    { 根据函数名称获取函数入口地址 }
    function GetFuncEntryAddressFromName(const strFunctionName: string): Pointer;
    { 获取导出函数全名 C++ 类型函数 }
    function GetFullFuncNameCpp(const strFuncName: string): String;
  protected
    cv: Tcv;
  public
    { Dll 导出的 C 类型函数 }
    cvLoadImage    : TcvLoadImage;
    cvNamedWindow  : TcvNamedWindow;
    cvShowImage    : TcvShowImage;
    cvWaitKey      : TcvWaitKey;
    cvReleaseImage : TcvReleaseImage;
    cvDestroyWindow: TcvDestroyWindow;
    constructor Create;
    destructor Destroy; override;
  end;

  Tcv = class(TOpenCV)
  public
    function getBuildInformation: TString;
  end;

  TString = class(Tcv)

  end;

implementation

{ TOpenCV }
constructor TOpenCV.Create;
begin
  FListFunc   := TList.Create;
  FhDllHandle := LoadLibrary(PWideChar(c_strOpenCVDll));
  InitDllAllExportFunc;
  InitPublicFieldVarAddress;
end;

destructor TOpenCV.Destroy;
var
  III: Integer;
begin
  FreeLibrary(FhDllHandle);

  { 释放内存 }
  if (FListFunc <> nil) then
  begin
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

{ 设置 Public 成员变量的函数入口地址 }
procedure TOpenCV.SetPublicFieldVarAddress(const pFuncEntryAddress: Pointer; const intOffset: Integer); assembler;
asm
  MOV [RCX + RAX], RDX
end;

{ 获取所有 Public 成员变量的函数入口地址 }
procedure TOpenCV.InitPublicFieldVarAddress;
var
  rc               : TRttiContext;
  rt               : TRttiType;
  rf               : TRttiField;
  pFuncEntryAddress: Pointer;
begin
  rc := TRttiContext.Create;
  try
    rt := rc.GetType(ClassInfo);
    for rf in rt.GetFields do
    begin
      if rf.Visibility = mvPublic then
      begin
        pFuncEntryAddress := GetFuncEntryAddressFromName(rf.Name); // 根据成员变量名称，获取函数的入口地址
        SetPublicFieldVarAddress(pFuncEntryAddress, rf.Offset);    // 将函数入口地址赋给成员变量
      end;
    end;
  finally
    rc.Free;
  end;
end;

{ 根据函数名称获取函数入口地址 }
function TOpenCV.GetFuncEntryAddressFromName(const strFunctionName: string): Pointer;
var
  III: Integer;
begin
  Result  := nil;
  for III := 0 to FListFunc.Count - 1 do
  begin
    if CompareStr(strFunctionName, String(PDllFuncInfo(FListFunc.Items[III])^.strFunctionNameC)) = 0 then
    begin
      Result := PDllFuncInfo(FListFunc.Items[III])^.intEntryAddress;
      Break;
    end;
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

{ 获取导出函数全名 C++ 类型函数 }
function TOpenCV.GetFullFuncNameCpp(const strFuncName: string): String;
var
  strFuncFullName: array [0 .. 255] of AnsiChar;
begin
  UnDecorateSymbolName(PAnsiChar(AnsiString(strFuncName)), strFuncFullName, 256, 0);
  Result := string(strFuncFullName);
end;

{ 获取 Dll 所有导出函数列表 }
procedure TOpenCV.InitDllAllExportFunc;
var
  pidh              : PImageDosHeader;
  pinh              : PImageNtHeaders64;
  intExportTableRVA : Cardinal;
  peft              : PImageExportDirectory;
  strFunctionName   : array [0 .. 255] of AnsiChar;
  intFunctionAddress: Cardinal;
  tmpFuncInfo       : PDllFuncInfo;
  III               : Integer;
begin
  pidh              := PImageDosHeader(FhDllHandle);                                                    // 读取文件头
  pinh              := PImageNtHeaders(FhDllHandle + Cardinal(pidh^._lfanew));                          // 读取 TImageNtHeaders64
  intExportTableRVA := pinh^.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress; // 导出表虚拟地址

  { 枚举导出函数名称 }
  peft    := PImageExportDirectory(FhDllHandle + intExportTableRVA);                                  // 函数导出表
  for III := 0 to peft^.NumberOfNames - 1 do                                                          // 循环
  begin                                                                                               //
    CopyMemory(@intFunctionAddress, Pointer(FhDllHandle + peft^.AddressOfNames + DWORD(4 * III)), 4); // 取得导出函数名称地址
    CopyMemory(@strFunctionName[0], Pointer(FhDllHandle + intFunctionAddress), 256);                  // 取得函数名称
    tmpFuncInfo                     := AllocMem(SizeOf(TDllFuncInfo));                                // 注意释放内存
    tmpFuncInfo^.strFunctionNameC   := String(strFunctionName);                                       // 添加函数名称 C   类型函数
    tmpFuncInfo^.strFunctionNameCpp := GetFullFuncNameCpp(tmpFuncInfo^.strFunctionNameC);             // 添加函数全名 C++ 类型函数
    tmpFuncInfo^.intEntryAddress    := GetFunctionEntryAddress(III, peft);                            // 添加函数入口地址
    FListFunc.Add(tmpFuncInfo);                                                                       // 添加到列表
  end;
end;

{ Tcv }

function Tcv.getBuildInformation: TString;
begin
  Result := nil;
end;

end.
