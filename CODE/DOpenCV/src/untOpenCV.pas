unit untOpenCV;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, System.SysUtils, System.StrUtils, Winapi.ImageHlp, untOpenCVType, untGetFuncName;

type
  TOpenCV       = class; { OpenCV 基类 }
  Tcv           = class; { OpenCV 子类: cv 类 }
  TVideoCapture = class; { cv     子类: VideoCapture 类 }

  { OpenCV 基类 }
  TOpenCV = Class
  private
    FhDllHandle: THandle;
    FListFunc  : TList;
    { 获取函数列表 }
    procedure InitCPlusPlusFunc;
    { 获取函数的入口地址 }
    function GetFunctionEntryAddress(const intIndex: Integer; eft: PImageExportDirectory): Pointer; overload;
    function GetFunctionEntryAddress(const strFunctionName: string): Pointer; overload;
    { Dll 导出的函数名称 }
    function GetFunctionName(const strClassName: string = ''): String;
  public
    { OpenCV 子类: cv 类 }
    cv: Tcv;
    constructor Create;
    destructor Destroy; override;
    { OpenCV 基类的 C 函数 }
    function cvLoadImage(const strFileName: PChar; const iscolor: TCvLoadImageIsColor = CV_LOAD_IMAGE_COLOR): PIplImage; cdecl;
    function cvNamedWindow(const strTitle: PChar; flags: Integer): Integer; cdecl;
    procedure cvShowImage(name: PChar; image: Pointer); cdecl;
    function cvWaitKey(const delay: Integer = 0): Integer; cdecl;
    procedure cvReleaseImage(var image: PIplImage); cdecl;
    procedure cvDestroyWindow(const name: PChar); cdecl;
  end;

  { OpenCV 子类: cv 类 }
  Tcv = class(TOpenCV)
  public
    VideoCapture: TVideoCapture;
    constructor Create(hDllHandle: THandle; ListFunc: TList);
    destructor Destroy; override;
    function getBuildInformation: PChar; cdecl;
  end;

  { OpenCV 子类: VideoCapture 类 }
  TVideoCapture = class(Tcv)
  public
    function set_(intWH: Integer; intValue: Double): Boolean; cdecl;
    function get_(intWH: Integer): Double; cdecl;
    function grab(): Boolean; cdecl;
    function isOpened(): Boolean; cdecl;
  end;

implementation

{ TOpenCV }

constructor TOpenCV.Create;
begin
  FListFunc   := TList.Create;
  FhDllHandle := LoadLibrary(PWideChar(c_strOpenCVDll));
  InitCPlusPlusFunc;

  cv := Tcv.Create(FhDllHandle, FListFunc);
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

{ 获取函数的入口地址 }
function TOpenCV.GetFunctionEntryAddress(const strFunctionName: string): Pointer;
var
  III: Integer;
begin
  Result := nil;

  if (Pos('?', strFunctionName) = 0) and (Pos('@', strFunctionName) = 0) then
  begin
    { 获取函数的入口地址 C }
    for III := 0 to FListFunc.Count - 1 do
    begin
      if CompareStr(strFunctionName, String(PDllFuncInfo(FListFunc.Items[III])^.strFunctionName)) = 0 then
      begin
        Result := PDllFuncInfo(FListFunc.Items[III])^.intEntryAddress;
        Break;
      end;
    end;
  end
  else
  begin
    { 获取函数的入口地址 C++ }
    for III := 0 to FListFunc.Count - 1 do
    begin
      if Pos(strFunctionName, String(PDllFuncInfo(FListFunc.Items[III])^.strFunctionName)) > 0 then
      begin
        Result := PDllFuncInfo(FListFunc.Items[III])^.intEntryAddress;
        Break;
      end;
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

{ 获取函数列表 }
procedure TOpenCV.InitCPlusPlusFunc;
var
  idh               : PImageDosHeader;
  inh               : PImageNtHeaders64;
  intExportTableRVA : Cardinal;
  eft               : PImageExportDirectory;
  strFunctionName   : array [0 .. 255] of Ansichar;
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
    tmpFuncInfo^.intEntryAddress := GetFunctionEntryAddress(III, eft);                               // 添加函数入口地址
    FListFunc.Add(tmpFuncInfo);                                                                      // 添加到列表
  end;
end;

{ Dll 导出的函数名称 }
function TOpenCV.GetFunctionName(const strClassName: string = ''): String;
begin
  Result := GetCurrentFuncName(Self);
  if strClassName <> '' then
  begin
    Result := Format('?%s@%s@@', [Result, RightStr(strClassName, Length(strClassName) - 1)]);
  end;
end;

procedure TOpenCV.cvDestroyWindow(const name: PChar);
type
  TcvDestroyWindow = procedure(const name: PChar); cdecl;
var
  strTempFuncName: String;
  tmpFunc        : TcvDestroyWindow;
begin
  GetEIP;
  strTempFuncName := GetFunctionName;
  tmpFunc         := GetFunctionEntryAddress(strTempFuncName);
  if Assigned(tmpFunc) then
    tmpFunc(name);
end;

function TOpenCV.cvLoadImage(const strFileName: PChar; const iscolor: TCvLoadImageIsColor = CV_LOAD_IMAGE_COLOR): PIplImage;
type
  TcvLoadImage = function(const strFileName: PChar; const iscolor: TCvLoadImageIsColor = CV_LOAD_IMAGE_COLOR): PIplImage; cdecl;
var
  strTempFuncName: String;
  tmpFunc        : TcvLoadImage;
begin
  GetEIP;
  strTempFuncName := GetFunctionName;
  tmpFunc         := GetFunctionEntryAddress(strTempFuncName);
  Result          := nil;
  if Assigned(tmpFunc) then
    Result := tmpFunc(strFileName, iscolor);
end;

function TOpenCV.cvNamedWindow(const strTitle: PChar; flags: Integer): Integer;
type
  TcvNamedWindow = function(const strTitle: PChar; flags: Integer): Integer; cdecl;
var
  strTempFuncName: String;
  tmpFunc        : TcvNamedWindow;
begin
  GetEIP;
  strTempFuncName := GetFunctionName;
  tmpFunc         := GetFunctionEntryAddress(strTempFuncName);
  Result          := -1;
  if Assigned(tmpFunc) then
    Result := tmpFunc(strTitle, flags);
end;

procedure TOpenCV.cvReleaseImage(var image: PIplImage);
type
  TcvReleaseImage = procedure(var image: PIplImage); cdecl;
var
  strTempFuncName: String;
  tmpFunc        : TcvReleaseImage;
begin
  GetEIP;
  strTempFuncName := GetFunctionName;
  tmpFunc         := GetFunctionEntryAddress(strTempFuncName);
  if Assigned(tmpFunc) then
    tmpFunc(image);
end;

procedure TOpenCV.cvShowImage(name: PChar; image: Pointer);
type
  TcvShowImage = procedure(name: PChar; image: Pointer); cdecl;
var
  strTempFuncName: String;
  tmpFunc        : TcvShowImage;
begin
  GetEIP;
  strTempFuncName := GetFunctionName;
  tmpFunc         := GetFunctionEntryAddress(strTempFuncName);
  if Assigned(tmpFunc) then
    tmpFunc(name, image);
end;

function TOpenCV.cvWaitKey(const delay: Integer): Integer;
type
  TcvWaitKey = function(const delay: Integer): Integer; cdecl;
var
  strTempFuncName: String;
  tmpFunc        : TcvWaitKey;
begin
  GetEIP;
  strTempFuncName := GetFunctionName;
  tmpFunc         := GetFunctionEntryAddress(strTempFuncName);
  Result          := -1;
  if Assigned(tmpFunc) then
    Result := tmpFunc(delay);
end;

{ TCV }

constructor Tcv.Create(hDllHandle: THandle; ListFunc: TList);
begin
  FhDllHandle := hDllHandle;
  FListFunc   := ListFunc;
end;

destructor Tcv.Destroy;
begin

  inherited;
end;

function Tcv.getBuildInformation: PChar;
type
  TgetBuildInformation = function(): PChar; cdecl;
var
  strTempFuncName: String;
  tmpFunc        : TgetBuildInformation;
begin
  GetEIP;
  strTempFuncName := GetFunctionName(ClassName);

  Result  := '';
  tmpFunc := GetFunctionEntryAddress(strTempFuncName);
  if Assigned(tmpFunc) then
    Result := PChar(Pointer(tmpFunc)^);
end;

{ TVideoCapture }

function TVideoCapture.get_(intWH: Integer): Double;
begin

end;

function TVideoCapture.grab: Boolean;
begin

end;

function TVideoCapture.isOpened: Boolean;
begin

end;

function TVideoCapture.set_(intWH: Integer; intValue: Double): Boolean;
begin

end;

end.
