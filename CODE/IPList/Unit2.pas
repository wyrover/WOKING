unit Unit2;
{

  多线程 PING 机器。扫描多个 IP

}

interface

uses
  Windows, Winapi.Messages, System.SysUtils, Winapi.Winsock2, System.Classes, Vcl.Forms, System.SyncObjs;

const
  WM_IPOK      = WM_USER + 1000;
  WM_THREADEND = WM_USER + 1001;

type
  PIPOptionInformation = ^TIPOptionInformation;

  TIPOptionInformation = packed record
    TTL: Byte;
    TOS: Byte;
    Flags: Byte;
    OptionsSize: Byte;
    OptionsData: PChar;
  end;

  PIcmpEchoReply = ^TIcmpEchoReply;

  TIcmpEchoReply = packed record
    Address: DWORD;
    Status: DWORD;
    RTT: DWORD;
    DataSize: Word;
    Reserved: Word;
    Data: Pointer;
    Options: TIPOptionInformation;
  end;

  TIcmpCreateFile = function: THandle; stdcall;

  TIcmpCloseHandle = function(IcmpHandle: THandle): Boolean; stdcall;

  TIcmpSendEcho = function(IcmpHandle: THandle; DestinationAddress: DWORD; RequestData: Pointer; RequestSize: Word; RequestOptions: PIPOptionInformation; ReplyBuffer: Pointer; ReplySize: DWORD; Timeout: DWORD): DWORD; stdcall;

type
  TPingIP = class(TThread)
  private
    FintStart, FintStop: Integer;
    FstrThreeIP        : string;
    hICMP              : THandle;
    FhICMPdll          : THandle;
    FIcmpCreateFile    : TIcmpCreateFile;
    FIcmpCloseHandle   : TIcmpCloseHandle;
    FIcmpSendEcho      : TIcmpSendEcho;
    function PingHost(HostIP: string): Boolean;
  protected
    procedure Execute; override;
  public
    constructor Create(const intStart, intStop: Integer; const strThreeIP: string = '192.168.0'); overload;
    destructor Destroy; override;
  end;

procedure ScanLanIP(const strThreeIP: String = '192.168.0');

implementation

Function sendarp(ipaddr: ulong; temp: DWORD; ulmacaddr: Pointer; ulmacaddrleng: Pointer): DWORD; StdCall; External 'Iphlpapi.dll' Name 'SendARP';

{ TPingIP }

var
  g_intCount      : Integer = 0;
  g_intThreadCount: Integer = 0;

procedure ScanLanIP(const strThreeIP: String = '192.168.0');
var
  III  : Integer;
  Count: Integer;
begin
  Count   := StrToIntDef(GetEnvironmentVariable('NUMBER_OF_PROCESSORS'), 4);
  for III := 0 to Count - 1 do
  begin
    Inc(g_intThreadCount);
    if III = Count - 1 then
    begin
      TPingIP.Create(III * Count + 1, (III + 1) * Count, strThreeIP);
    end
    else
    begin
      TPingIP.Create(III * Count + 1, (III + 1) * Count - 1, strThreeIP);
    end;
  end;
end;

constructor TPingIP.Create(const intStart, intStop: Integer; const strThreeIP: string = '192.168.0');
begin
  inherited Create(False);
  FreeOnTerminate := True;

  FhICMPdll := LoadLibrary('icmp.dll');
  if FhICMPdll = 0 then
    Exit;

  @FIcmpCreateFile  := GetProcAddress(FhICMPdll, 'IcmpCreateFile');
  @FIcmpCloseHandle := GetProcAddress(FhICMPdll, 'IcmpCloseHandle');
  @FIcmpSendEcho    := GetProcAddress(FhICMPdll, 'IcmpSendEcho');

  hICMP := FIcmpCreateFile;

  if (hICMP = INVALID_HANDLE_VALUE) then
    Exit;

  FintStart   := intStart;
  FintStop    := intStop;
  FstrThreeIP := strThreeIP;
end;

destructor TPingIP.Destroy;
begin
  FIcmpCloseHandle(hICMP);
  FreeLibrary(FhICMPdll);

  Dec(g_intThreadCount);
  if g_intThreadCount = 0 then
  begin
    PostMessage(Application.MainForm.Handle, WM_THREADEND, 0, 0);
  end;

  inherited;
end;

function TPingIP.PingHost(HostIP: string): Boolean;
var
  pIPE              : PIcmpEchoReply;
  FIPAddress        : DWORD;
  FSize             : DWORD;
  FTimeOut          : DWORD;
  BufferSize        : DWORD;
  pReqData, pRevData: PChar;
  MyString          : string;
begin
  FIPAddress := inet_addr(PAnsiChar(AnsiString(HostIP)));
  MyString   := 'Hello';
  pReqData   := PChar(MyString);
  FSize      := 40;
  BufferSize := Sizeof(TIcmpEchoReply) + FSize;
  GetMem(pIPE, BufferSize);
  FillChar(pIPE^, Sizeof(pIPE^), 0);
  GetMem(pRevData, FSize);
  pIPE^.Data := pRevData;
  FTimeOut   := 50;
  try
    Result := FIcmpSendEcho(hICMP, FIPAddress, pReqData, Length(MyString), nil, pIPE, BufferSize, FTimeOut) > 0;
  finally
    FreeMem(pRevData);
    FreeMem(pIPE);
  end;
end;

function IP2Mac(const strIP: string): String;
var
  myip       : ulong;
  mymac      : array [0 .. 5] of Byte;
  mymaclength: ulong;
  r          : Integer;
begin
  myip        := inet_addr(PAnsiChar(AnsiString(strIP)));
  mymaclength := Length(mymac);
  r           := sendarp(myip, 0, @mymac, @mymaclength);
  if r = 0 then
  begin
    Result := format('%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x', [mymac[0], mymac[1], mymac[2], mymac[3], mymac[4], mymac[5]]);
  end
  else
  begin
    Result := '';
  end;
end;

function GetNameByIPAddr(const strIP: String; var strMacName: String): Boolean;
var
  SockAddrIn: TSockAddrIn;
  HostEnt   : PHostEnt;
  WSAData   : TWSAData;
begin
  Result := False;

  strMacName := '';
  if strIP = '' then
    Exit;

  try
    WSAStartup(2, WSAData);
    SockAddrIn.sin_addr.s_addr := inet_addr(PAnsiChar(AnsiString(strIP)));
    HostEnt                    := gethostbyaddr(@SockAddrIn.sin_addr.s_addr, 4, AF_INET);
    if HostEnt <> nil then
    begin
      strMacName := string(AnsiString(HostEnt^.h_name));
      Result     := True;
    end;
  finally
    WSACleanup;
  end;
end;

procedure TPingIP.Execute;
var
  III      : Integer;
  strIP    : String;
  strmsg   : string;
  strPCName: string;
begin
  for III := FintStart to FintStop do
  begin
    strIP := format('%s.%d', [FstrThreeIP, III]);
    if PingHost(strIP) then
    begin
      Inc(g_intCount);
      GetNameByIPAddr(strIP, strPCName);
      strmsg := format('%d%s%s%s%s%s%s%s%s', [0, Chr(9), strIP, Chr(9), FormatDateTime('YYYY-MM-DD hh:mm:ss:zzz', Now), Chr(9), IP2Mac(strIP), Chr(9), strPCName]);
      SendMessage(Application.MainForm.Handle, WM_IPOK, Integer(@strmsg[1]), 0);
    end;
  end;
end;

end.
