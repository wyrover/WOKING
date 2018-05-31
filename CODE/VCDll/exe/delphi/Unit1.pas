unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Winapi.ImageHlp;

type
  TForm1 = class(TForm)
    btn1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  PDllFuncInfo = ^TDllFuncInfo;

  TDllFuncInfo = record
    strName: ShortString;
    intEntryAddress: Cardinal;
  end;

  { C++ Dll �������Ա������װ }
  Cvcdll01 = class(TObject)
  private
    FhDllHandle: THandle;
    FListFunc  : TList;
    procedure GetDllFuncList;
    function GetVCDllOffsetFuncAddress(const strFuncName: string): Cardinal;
  public
    constructor Create(const strDllFileName: String);
    destructor Destroy; override;
    function MyAdd(a, b: Integer): Integer; stdcall;
    function MySub(a, b: Integer): Integer; stdcall;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  vcdll: Cvcdll01;
begin
  vcdll := Cvcdll01.Create('vcdll01.dll');
  try
    Caption := Format('%d %d', [vcdll.MyAdd(2, 3), vcdll.MySub(3, 2)]);
  finally
    vcdll.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
end;

{ Cvcdll01 }

constructor Cvcdll01.Create(const strDllFileName: String);
begin
  FListFunc   := TList.Create;
  FhDllHandle := LoadLibrary(PChar(strDllFileName));
  GetDllFuncList;
end;

destructor Cvcdll01.Destroy;
var
  III: Integer;
begin
  FreeLibrary(FhDllHandle);

  if FListFunc <> nil then
  begin
    { �ͷ��ڴ� }
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

procedure Cvcdll01.GetDllFuncList;
var
  idh               : PImageDosHeader;
  inh               : PImageNtHeaders32;
  intExportTableRVA : Cardinal;
  sts               : array of TImageSectionHeader;
  eft               : PImageExportDirectory;
  strFunctionName   : array [0 .. 255] of AnsiChar;
  intFunctionAddress: Cardinal;
  tmpFuncInfo       : PDllFuncInfo;
  III               : Integer;
  // DllMain          : function(dwHandle, dwReason, dwReserved: DWord): DWord; stdcall;

  { ��ȡ��������ڵ�ַ }
  function GetFuncEntryAddress(const intIndex: Integer): Cardinal;
  var
    JJJ: Integer;
  begin
    Result  := 0;
    for JJJ := 0 to eft^.NumberOfFunctions - 1 do
    begin
      if JJJ = intIndex then
      begin
        Result := PCardinal(FhDllHandle + eft^.AddressOfFunctions + Cardinal(4 * JJJ))^;
        Result := FhDllHandle + Result;
        Break;
      end;
    end;
  end;

begin
  idh := PImageDosHeader(FhDllHandle);                                                                                                          // ��ȡ�ļ�ͷ
  inh := pImageNtHeaders(FhDllHandle + Cardinal(idh^._lfanew));                                                                                 // ��ȡ TImageNtHeaders32
  SetLength(sts, inh.FileHeader.NumberOfSections);                                                                                              // �ڵĸ���
  CopyMemory(sts, Pointer(FhDllHandle + Cardinal(idh^._lfanew) + SizeOf(inh)), inh^.FileHeader.NumberOfSections * SizeOf(TImageSectionHeader)); // ��ȡ�ڱ�
  intExportTableRVA := inh.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress;                                           // �����������ַ

  { ���� dll ��ʼ������ }
  // DllMain := Pointer(FhDllHandle + inh.OptionalHeader.AddressOfEntryPoint); // dll ����ں�����ַ
  // DllMain(FhDllHandle, DLL_PROCESS_ATTACH, 0);                              // dll ��ʼ������

  { ö�ٵ����������� }
  eft     := PImageExportDirectory(FhDllHandle + intExportTableRVA);                                 // ����������
  for III := 0 to eft^.NumberOfNames - 1 do                                                          //
  begin                                                                                              //
    CopyMemory(@intFunctionAddress, Pointer(FhDllHandle + eft^.AddressOfNames + DWord(4 * III)), 4); // ȡ�õ���������ַ
    CopyMemory(@strFunctionName[0], Pointer(FhDllHandle + intFunctionAddress), 256);                 // ȡ�ú�������
    tmpFuncInfo                  := AllocMem(SizeOf(TDllFuncInfo));                                  // ע���ͷ��ڴ�
    tmpFuncInfo^.strName         := ShortString(strFunctionName);                                    // ��Ӻ�������
    tmpFuncInfo^.intEntryAddress := GetFuncEntryAddress(III);                                        // ��Ӻ�����ڵ�ַ
    FListFunc.Add(tmpFuncInfo);                                                                      // ��ӵ��б�
  end;
end;

function Cvcdll01.GetVCDllOffsetFuncAddress(const strFuncName: string): Cardinal;
var
  strTempFuncName: String;
  III            : Integer;
begin
  Result          := 0;
  strTempFuncName := Format('?%s@', [strFuncName]);
  for III         := 0 to FListFunc.Count - 1 do
  begin
    if Pos(strTempFuncName, string(PDllFuncInfo(FListFunc[III])^.strName)) > 0 then
    begin
      Result := PDllFuncInfo(FListFunc[III])^.intEntryAddress;
      Break;
    end;
  end;
end;

function Cvcdll01.MyAdd(a, b: Integer): Integer;
type
  TMyAdd = function(a, b: Integer): Integer; stdcall;
var
  tmpMyAdd: TMyAdd;
begin
  tmpMyAdd := Pointer(GetVCDllOffsetFuncAddress('MyAdd'));
  Result   := tmpMyAdd(a, b);
end;

function Cvcdll01.MySub(a, b: Integer): Integer;
type
  TMySub = function(a, b: Integer): Integer; stdcall;
var
  tmpMySub: TMySub;
begin
  tmpMySub := Pointer(GetVCDllOffsetFuncAddress('MySub'));
  Result   := tmpMySub(a, b);
end;

end.
