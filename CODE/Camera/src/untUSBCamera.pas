unit untUSBCamera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DirectShow9, ActiveX, ComObj, Dialogs, StdCtrls, ExtCtrls;

const
  FourCC_YUY2 = $32595559;
  FourCC_YUYV = $56595559;
  FourCC_YUNV = $564E5559;
  FourCC_MJPG = $47504A4D;
  FourCC_I420 = $30323449;
  FourCC_YV12 = $32315659;
  FourCC_IYUV = $56555949;

type
  PVideoFormatInfo = ^TVideoFormatInfo;
  PUSBCameraInfo   = ^TUSBCameraInfo;

  { 视频支持格式 }
  TVideoFormatInfo = record
    id: TGUID;
    iWidth, iHeight: Integer;
    iMod: TGUID;
    Frame: Int64;
    format: ShortString;
  end;

  { 视频输入设备 }
  TUSBCameraInfo = record
    id: TGUID;
    strName: ShortString;
    index: Integer;
  end;

  { 枚举所有视频输入设备 }
procedure EnumAllVideoInput(strsList: TStrings);

{ 枚举视频支持格式 }
function EnumVideoFormat(const strFriendlyName: String; strsList: TStrings): Boolean;

{ 视频预览 }
function USBCameraPreview(                           //
//  VideoInfo: PUSBCameraInfo;                         //
//  FormatInfo: PVideoFormatInfo;                      //
  const sgCallbak: ISampleGrabberCB                 //
//  var FIMediaControl: IMediaControl;                 //
//  var FIVideoWindow: IVideoWindow;                   //
//  var FISysDevEnum: IBaseFilter;                     //
//  var FINullRenderer: IBaseFilter;                   //
//  var FISampleGrabber: IBaseFilter;                  //
//  var FIGraphBuilder: IGraphBuilder;                 //
//  var FICaptureGraphBuilder2: ICaptureGraphBuilder2; //
//  var FSampleGrabber: ISampleGrabber                 //
  ): Boolean;

function CreateFilter(gid: TGUID; FriendlyName: AnsiString; instanceIndex: Integer): IBaseFilter;

procedure SetMediaType(filter: IBaseFilter; width, height: Integer; format: AnsiString);

procedure PrepareTables;

procedure YUY2_to_RGB(var fBitmap: TBitmap; pData: pointer);

const
  IID_IPropertyBag: TGUID = '{55272A00-42CB-11CE-8135-00AA004BB851}';

  cv: array [0 .. 35] of PGUID = (                                                                                                   //
    @MEDIASUBTYPE_CLPL, @MEDIASUBTYPE_YUYV, @MEDIASUBTYPE_IYUV, @MEDIASUBTYPE_YVU9, @MEDIASUBTYPE_Y411, @MEDIASUBTYPE_Y41P,          //
    @MEDIASUBTYPE_YUY2, @MEDIASUBTYPE_YVYU, @MEDIASUBTYPE_UYVY, @MEDIASUBTYPE_Y211, @MEDIASUBTYPE_YV12, @MEDIASUBTYPE_CLJR,          //
    @MEDIASUBTYPE_IF09, @MEDIASUBTYPE_CPLA, @MEDIASUBTYPE_MJPG, @MEDIASUBTYPE_TVMJ, @MEDIASUBTYPE_WAKE, @MEDIASUBTYPE_CFCC,          //
    @MEDIASUBTYPE_IJPG, @MEDIASUBTYPE_Plum, @MEDIASUBTYPE_DVCS, @MEDIASUBTYPE_DVSD, @MEDIASUBTYPE_MDVF, @MEDIASUBTYPE_RGB1,          //
    @MEDIASUBTYPE_RGB4, @MEDIASUBTYPE_RGB8, @MEDIASUBTYPE_RGB565, @MEDIASUBTYPE_RGB555, @MEDIASUBTYPE_RGB24, @MEDIASUBTYPE_RGB32,    //
    @MEDIASUBTYPE_ARGB1555, @MEDIASUBTYPE_ARGB4444, @MEDIASUBTYPE_ARGB32, @MEDIASUBTYPE_AYUV, @MEDIASUBTYPE_AI44, @MEDIASUBTYPE_IA44 //
    );

  cs: array [0 .. 35] of AnsiString = (                   //
    'CLPL', 'YUYV', 'IYUV', 'YVU9', 'Y411', 'Y41P',       //
    'YUY2', 'YVYU', 'UYVY', 'Y211', 'YV12', 'CLJR',       //
    'IF09', 'CPLA', 'MJPG', 'TVMJ', 'WAKE', 'CFCC',       //
    'IJPG', 'Plum', 'DVCS', 'DVSD', 'MDVF', 'RGB1',       //
    'RGB4', 'RGB8', 'RGB565', 'RGB555', 'RGB24', 'RGB32', //
    'ARGB1555', 'ARGB4444', 'ARGB32', 'AYUV', 'AI44', 'IA44');

  vs1: array [0 .. 19] of Integer    = ($00000000, $00000001, $00000002, $00000004, $00000010, $00000020, $00000080, $00000100, $00000200, $00000400, $00000800, $00001000, $00002000, $00004000, $00008000, $00010000, $00020000, $00040000, $00080000, $00100000);
  vs2: array [0 .. 19] of AnsiString = ('None', 'NTSC_M', 'NTSC_M_J', 'NTSC_433', 'PAL_B', 'PAL_D', 'PAL_H', 'PAL_I', 'PAL_M', 'PAL_N', 'PAL_60', 'SECAM_B', 'SECAM_D', 'SECAM_G', 'SECAM_H', 'SECAM_K', 'SECAM_K1', 'SECAM_L', 'SECAM_L1', 'PAL_N_COMBO');

type
  IAMStreamConfig = interface(IUnknown)
    ['{C6E13340-30AC-11d0-A18C-00A0C9118956}']
    function SetFormat(const pmt: TAMMediaType): HRESULT; stdcall;
    function GetFormat(out ppmt: PAMMEDIATYPE): HRESULT; stdcall;
    function GetNumberOfCapabilities(out piCount, piSize: Integer): HRESULT; stdcall;
    { 声明有误，修改声明 }
    function GetStreamCaps(iIndex: Integer; var ppmt: PAMMEDIATYPE; pSCC: PVideoStreamConfigCaps): HRESULT; stdcall;
  end;

implementation

var
  ValueY_298, ValueU_100, ValueU_516, ValueV_409, ValueV_208: array [0 .. 255] of Integer;
  ValueClip                                                 : array [-1023 .. 1023] of byte;

  FIMediaControl        : IMediaControl;
  FIVideoWindow         : IVideoWindow;
  FISysDevEnum          : IBaseFilter;
  FINullRenderer        : IBaseFilter;
  FISampleGrabber       : IBaseFilter;
  FIGraphBuilder        : IGraphBuilder;
  FICaptureGraphBuilder2: ICaptureGraphBuilder2;
  FSampleGrabber        : ISampleGrabber;

procedure PrepareTables;
var
  I: Integer;
begin
  for I := 0 to 255 do
  begin
    ValueY_298[I] := round(I * 298.082);
    ValueU_100[I] := round(I * -100.291);
    ValueU_516[I] := round(I * 516.412 - 276.836 * 256);
    ValueV_409[I] := round(I * 408.583 - 222.921 * 256);
    ValueV_208[I] := round(I * -208.120 + 135.576 * 256);
  end;

  FillChar(ValueClip, sizeof(ValueClip), #0);
  for I          := 0 to 255 do
    ValueClip[I] := I;
  for I          := 256 to 1023 do
    ValueClip[I] := 255;
end;

procedure YUY2_to_RGB(var fBitmap: TBitmap; pData: pointer);
type
  TFour = array [0 .. 3] of byte;
var
  L, X, Y: Integer;
  ps     : PByte;
  pf     : ^TFour;
begin
  pf    := pData;
  for Y := 0 to fBitmap.height - 1 do
  begin
    ps    := fBitmap.ScanLine[Y];
    for X := 0 to (fBitmap.width div 2) - 1 do
    begin
      L   := ValueY_298[pf^[0]];
      ps^ := ValueClip[(L + ValueU_516[pf^[1]]) div 256];
      Inc(ps);
      ps^ := ValueClip[(L + ValueU_100[pf^[1]] + ValueV_208[pf^[3]]) div 256];
      Inc(ps);
      ps^ := ValueClip[(L + ValueV_409[pf^[3]]) div 256];
      Inc(ps);

      L   := ValueY_298[pf^[2]];
      ps^ := ValueClip[(L + ValueU_516[pf^[1]]) div 256];
      Inc(ps);
      ps^ := ValueClip[(L + ValueU_100[pf^[1]] + ValueV_208[pf^[3]]) div 256];
      Inc(ps);
      ps^ := ValueClip[(L + ValueV_409[pf^[3]]) div 256];
      Inc(ps);

      Inc(pf);
    end;
  end;
end;

function CreateFilter(gid: TGUID; FriendlyName: AnsiString; instanceIndex: Integer): IBaseFilter;
var
  pSysDevEnum: ICreateDevEnum;
  pEnumCat   : IEnumMoniker;
  pMoniker   : IMoniker;
  cFetched   : ULONG;
  pPropBag   : IPropertyBag;
  bc         : IBindCtx;
  mo         : IMoniker;
  er         : IErrorLog;
  ov         : OleVariant;
  iIndex     : Integer;
begin
  Result := nil;

  pSysDevEnum := nil;
  pEnumCat    := nil;
  pMoniker    := nil;

  CocreateInstance(CLSID_SystemDeviceEnum, nil, CLSCTX_INPROC, IID_ICreateDevEnum, pSysDevEnum);
  if pSysDevEnum.CreateClassEnumerator(gid, pEnumCat, 0) = S_OK then
  begin
    iIndex := 0;
    while (pEnumCat.Next(1, pMoniker, @cFetched) = S_OK) and (cFetched > 0) and (pMoniker <> nil) do
    begin
      bc := nil;
      mo := nil;
      pMoniker.BindToStorage(bc, mo, IID_IPropertyBag, pPropBag);
      er := nil;
      pPropBag.Read('FriendlyName', ov, er);
      if AnsiString(ov) = FriendlyName then
      begin
        if iIndex = instanceIndex then
        begin
          bc := nil;
          mo := nil;
          pMoniker.BindToObject(bc, mo, IID_IBaseFilter, Result);
        end;
        Inc(iIndex);
      end;
      pPropBag := nil;
      pMoniker := nil;
    end;
  end;
  pEnumCat    := nil;
  pSysDevEnum := nil;
end;

function GetOutputPin(filter: IBaseFilter): IPin;
var
  penum: IEnumPins;
  f    : Integer;
  d    : PIN_DIRECTION;
begin
  Result := nil;
  filter.EnumPins(penum);
  while (penum.Next(1, Result, @f) = S_OK) and (f > 0) do
  begin
    if (Result.QueryDirection(d) = S_OK) and (d = PINDIR_OUTPUT) then
    begin
      // found first output pin
      Exit;
    end;
  end;
  Result := nil;
end;

function VideoMediaSubTypeToStr(mst: TGUID): AnsiString;
var
  I: Integer;
begin
  Result := '';
  for I  := 0 to 35 do
    if comparemem(cv[I], @mst, sizeof(TGUID)) then
    begin
      Result := cs[I];
      break;
    end;
end;

function AnTrim(const v: AnsiString): AnsiString;
begin
{$IFDEF UNICODE}
  Result := AnsiString(Trim(string(v)));
{$ELSE}
  Result := Trim(v);
{$ENDIF}
end;

function VideoStandard2Str(vs: Integer): AnsiString;
var
  I: Integer;
begin
  Result := '';
  for I  := 0 to 19 do
    if (vs and vs1[I]) <> 0 then
      Result := Result + vs2[I] + ' ';
  Result     := AnTrim(Result);
end;

procedure FreeMediaType(mt: TAMMediaType);
begin
  if (mt.cbFormat <> 0) then
  begin
    CoTaskMemFree(mt.pbFormat);
    mt.cbFormat := 0;
    mt.pbFormat := nil;
  end;
  if (mt.pUnk <> nil) then
  begin
    mt.pUnk := nil;
  end;
end;

procedure DeleteMediaType(pmt: PAMMEDIATYPE);
begin
  if pmt <> nil then
  begin
    FreeMediaType(pmt^);
    CoTaskMemFree(pmt);
  end;
end;

function GetMaxIndex(const strsList: TStrings; const strUSBCameraName: string): Integer;
var
  III, Count: Integer;
begin
  Result  := 0;
  Count   := strsList.Count;
  for III := 0 to Count - 1 do
  begin
    if CompareText(String(PUSBCameraInfo(strsList.Objects[III])^.strName), strUSBCameraName) = 0 then
    begin
      Result := Result + 1;
    end;
  end;
end;

function StrToVideoMediaSubType(ss: AnsiString): TGUID;
var
  I: Integer;
begin
  Result := cv[0]^;
  for I  := 0 to 35 do
    if ss = cs[I] then
    begin
      Result := cv[I]^;
      break;
    end;
end;

function CompareGUID(const g1, g2: TGUID): Boolean;
begin
  Result := comparemem(@g1, @g2, sizeof(TGUID));
end;

procedure SetMediaType(filter: IBaseFilter; width, height: Integer; format: AnsiString);
var
  pmt            : PAMMEDIATYPE;
  piCount, piSize: Integer;
  I              : Integer;
  pSCC           : PVideoStreamConfigCaps;
  streamConfig   : IAMStreamConfig;
  outPin         : IPin;
  formatID       : TGUID;
  selectedIndex  : Integer;
  ih             : PVIDEOINFOHEADER;
  bitRate        : dword;
begin
  if (width = 0) or (height = 0) then
    Exit;

  outPin := GetOutputPin(filter);
  outPin.QueryInterface(IID_IAMStreamConfig, streamConfig);
  if assigned(streamConfig) then
  begin
    selectedIndex := -1;
    bitRate       := 0;
    formatID      := StrToVideoMediaSubType(format);
    streamConfig.GetNumberOfCapabilities(piCount, piSize);
    getmem(pSCC, piSize);
    try
      for I := 0 to piCount - 1 do
      begin
        streamConfig.GetStreamCaps(I, pmt, pSCC);
        ih := pointer(pmt^.pbFormat);
        if (pSCC^.MinOutputSize.cx = width) and (pSCC^.MinOutputSize.cy = height) and (ih^.bmiHeader.biWidth = width) and (ih^.bmiHeader.biheight = height) and ((format = '') or (CompareGUID(formatID, pmt^.subtype))) and (ih^.dwBitRate > bitRate) // select format with maximum bitrate
        then
        begin
          selectedIndex := I;
          bitRate       := ih^.dwBitRate;
        end;
        DeleteMediaType(pmt);
      end;
      if selectedIndex > -1 then
      begin
        streamConfig.GetStreamCaps(selectedIndex, pmt, pSCC);
        try
          streamConfig.SetFormat(pmt^);
        finally
          DeleteMediaType(pmt);
        end;
      end;
    finally
      freemem(pSCC);
    end;
  end;
end;

{ 枚举所有视频输入设备 }
procedure EnumAllVideoInput(strsList: TStrings);
var
  SysDevEnum: ICreateDevEnum;
  EnumCat   : IEnumMoniker;
  hr        : Integer;
  Moniker   : IMoniker;
  Fetched   : ULONG;
  PropBag   : IPropertyBag;
  strName   : OleVariant;
  strGuid   : OleVariant;
  III       : Integer;
  // puInfo    : PUSBCameraInfo;
  // intIndex  : Integer;
begin
  CocreateInstance(CLSID_SystemDeviceEnum, nil, CLSCTX_INPROC, IID_ICreateDevEnum, SysDevEnum);
  hr := SysDevEnum.CreateClassEnumerator(CLSID_VideoInputDeviceCategory, EnumCat, 0);
  if hr <> S_OK then
    Exit;

  { 释放内存 }
  if strsList.Count > 0 then
  begin
    for III := 0 to strsList.Count - 1 do
    begin
      freemem(PVideoFormatInfo(strsList.Objects[III]));
    end;
  end;
  strsList.Clear;

  while (EnumCat.Next(1, Moniker, @Fetched) = S_OK) do
  begin
    Moniker.BindToStorage(nil, nil, IID_IPropertyBag, PropBag);
    PropBag.Read('CLSID', strGuid, nil);
    PropBag.Read('FriendlyName', strName, nil);
    // New(puInfo);
    // puInfo^.id      := TGUID(strGuid);
    // puInfo^.strName := ShortString(strName);
    // puInfo^.index   := 0;
    // if strsList.IndexOf(strName) = -1 then
    // begin
    // strsList.AddObject(strName, TObject(puInfo));
    // end
    // else
    // begin
    // { 相同名称的 USBCamera 相机，<有可能有多个名称重复的相机> }
    // intIndex      := GetMaxIndex(strsList, strName);
    // puInfo^.index := intIndex + 1;
    // strsList.AddObject(strName + format('(%d)', [puInfo^.index]), TObject(puInfo));
    // end;
    PropBag := nil;
    Moniker := nil;
  end;

  EnumCat    := nil;
  SysDevEnum := nil;
end;

{ 枚举视频支持格式 }
function EnumVideoFormat(const strFriendlyName: String; strsList: TStrings): Boolean;
var
  bfVideoInput   : IBaseFilter;
  cgbBuilder     : ICaptureGraphBuilder2;
  iunk           : IUnknown;
  fStreamConfig  : IAMStreamConfig;
  piCount, piSize: Integer;
  III            : Integer;
  pmt            : PAMMEDIATYPE;
  pSCC           : PVideoStreamConfigCaps;
  pvInfo         : PVideoFormatInfo;
begin
  Result := False;

  bfVideoInput := CreateFilter(CLSID_VideoInputDeviceCategory, AnsiString(strFriendlyName), 0);
  if bfVideoInput = nil then
    Exit;

  { 释放内存 }
  if strsList.Count > 0 then
  begin
    for III := 0 to strsList.Count - 1 do
    begin
      freemem(PVideoFormatInfo(strsList.Objects[III]));
    end;
  end;
  strsList.Clear;

  CocreateInstance(CLSID_CaptureGraphBuilder2, nil, CLSCTX_INPROC, IID_ICaptureGraphBuilder2, cgbBuilder);
  cgbBuilder.RenderStream(@PIN_CATEGORY_CAPTURE, @MEDIATYPE_Video, bfVideoInput, nil, nil);
  cgbBuilder.FindInterface(nil, nil, bfVideoInput, IID_IAMStreamConfig, iunk);
  iunk.QueryInterface(IID_IAMStreamConfig, fStreamConfig);
  fStreamConfig.GetNumberOfCapabilities(piCount, piSize);
  pSCC := AllocMem(piSize);
  try
    for III := 0 to piCount - 1 do
    begin
      if fStreamConfig.GetStreamCaps(III, pmt, pSCC) = S_OK then
      begin
        // try
        // New(pvInfo); { 注意释放内存 }
        // pvInfo^.Frame   := PVIDEOINFOHEADER(pmt^.pbFormat)^.AvgTimePerFrame;
        // pvInfo^.id      := pmt^.formattype;
        // pvInfo^.iWidth  := pSCC^.MaxOutputSize.cx;
        // pvInfo^.iHeight := pSCC^.MaxOutputSize.cy;
        // pvInfo^.iMod    := pmt^.subtype;
        // pvInfo^.format  := VideoMediaSubTypeToStr(pmt^.subtype);
        // strsList.AddObject(format('类型：%s  分辨率：%4d×%4d (%2d f/s)', [pvInfo^.format, pvInfo^.iWidth, pvInfo^.iHeight, 10000000 div pvInfo^.Frame]), TObject(pvInfo));
        // finally
        // DeleteMediaType(pmt);
        // end;
      end;
    end;
  finally
    freemem(pSCC);
  end;

  bfVideoInput  := nil;
  cgbBuilder    := nil;
  fStreamConfig := nil;

  Result := true;
end;

{ 视频预览 }
function USBCameraPreview(                           //
//  VideoInfo: PUSBCameraInfo;                         //
//  FormatInfo: PVideoFormatInfo;                      //
  const sgCallbak: ISampleGrabberCB                 //
//  var FIMediaControl: IMediaControl;                 //
//  var FIVideoWindow: IVideoWindow;                   //
//  var FISysDevEnum: IBaseFilter;                     //
//  var FINullRenderer: IBaseFilter;                   //
//  var FISampleGrabber: IBaseFilter;                  //
//  var FIGraphBuilder: IGraphBuilder;                 //
//  var FICaptureGraphBuilder2: ICaptureGraphBuilder2; //
//  var FSampleGrabber: ISampleGrabber                 //
  ): Boolean;
var
  hr: HRESULT;
begin
  Result := False;

  { 创建 Sample Grabber }
  hr := CocreateInstance(CLSID_SampleGrabber, nil, CLSCTX_INPROC_SERVER, IBaseFilter, FISampleGrabber);
  if (FAILED(hr)) then
    Exit;

  { 获取 ISampleGrabber 接口 }
  hr := FISampleGrabber.QueryInterface(IID_ISampleGrabber, FSampleGrabber);
  if (FAILED(hr)) then
    Exit;

  FSampleGrabber.SetBufferSamples(False);   // 不允许从 Buffer 中获取数据
  FSampleGrabber.SetCallBack(sgCallbak, 0); // 使用回调方式

  { 创建 Null Renderer }
  hr := CocreateInstance(CLSID_NullRenderer, nil, CLSCTX_INPROC_SERVER, IID_IBaseFilter, FINullRenderer);
  if (FAILED(hr)) then
    Exit;

  { 创建 ICaptureGraphBuilder2 接口 }
  hr := CocreateInstance(CLSID_CaptureGraphBuilder2, nil, CLSCTX_INPROC, IID_ICaptureGraphBuilder2, FICaptureGraphBuilder2);
  if (FAILED(hr)) then
    Exit;

  { 创建 IGraphBuilder 接口 }
  hr := CocreateInstance(CLSID_FilterGraph, nil, CLSCTX_INPROC, IID_IGraphBuilder, FIGraphBuilder);
  if (FAILED(hr)) then
    Exit;

  { 调用 ICaptureGraphBuilder2 的 SetFilterGraph 方法将 FilterGraph 加入到 Builder 中 }
  FICaptureGraphBuilder2.SetFiltergraph(FIGraphBuilder);

  { 获取指定USB摄像头的 Filter }
  FISysDevEnum := CreateFilter(CLSID_VideoInputDeviceCategory, AnsiString(VideoInfo^.strName), VideoInfo^.index);

  { 设置指定 Filter 的媒体格式类型 }
  SetMediaType(FISysDevEnum, FormatInfo^.iWidth, FormatInfo^.iHeight, FormatInfo^.format);

  { 将 Video Capture Filter 添加到 Filter 图中 }
  hr := FIGraphBuilder.AddFilter(FISysDevEnum, Widestring('Video Capture'));
  if (FAILED(hr)) then
    Exit;

  { 将 Sample Grabber Filter 添加到 Filter 图中 }
  hr := FIGraphBuilder.AddFilter(FISampleGrabber, Widestring('Sample Grabber'));
  if (FAILED(hr)) then
    Exit;

  { 将 Null Renderer Filter 添加到 Filter 图中 }
  hr := FIGraphBuilder.AddFilter(FINullRenderer, Widestring('Null Renderer'));
  if (FAILED(hr)) then
    Exit;

  { 渲染视频PIN }
  hr := FICaptureGraphBuilder2.RenderStream(@PIN_CATEGORY_CAPTURE, @MEDIATYPE_Video, FISysDevEnum, FISampleGrabber, FINullRenderer);
  if (FAILED(hr)) then
    Exit;

  { 得到IMediaControl接口，用于控制流播放 }
  hr := FIGraphBuilder.QueryInterface(IID_IMediaControl, FIMediaControl);
  if (FAILED(hr)) then
    Exit;

  { 设置视频预览窗口 }
  hr := FIGraphBuilder.QueryInterface(IID_IVideoWindow, FIVideoWindow);
  if (FAILED(hr)) then
    Exit;

  Result := true;
end;

end.
