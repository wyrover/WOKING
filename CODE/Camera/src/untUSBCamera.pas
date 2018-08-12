unit untUSBCamera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DirectShow9, ActiveX, ComObj, Dialogs, StdCtrls, ExtCtrls;

{ 启动本地USB相机视频预览；默认为第一个 }
function PreviewNativeUSBCamera(pnl: TPanel; const intIndex: Integer = 0; const bPreview: Boolean = True; const bSnapBmp: Boolean = True; const bRecord: Boolean = False; const strSaveFileName: String = ''): Boolean;

procedure VideoResize(pnlVideo: TPanel);

implementation

const
  FourCC_YUY2 = $32595559;
  FourCC_YUYV = $56595559;
  FourCC_YUNV = $564E5559;
  FourCC_MJPG = $47504A4D;
  FourCC_I420 = $30323449;
  FourCC_YV12 = $32315659;
  FourCC_IYUV = $56555949;

  IID_IPropertyBag: TGUID = '{55272A00-42CB-11CE-8135-00AA004BB851}';

  c_arrVideoFormatGUID: array [0 .. 35] of PGUID = (                                                                                 //
    @MEDIASUBTYPE_CLPL, @MEDIASUBTYPE_YUYV, @MEDIASUBTYPE_IYUV, @MEDIASUBTYPE_YVU9, @MEDIASUBTYPE_Y411, @MEDIASUBTYPE_Y41P,          //
    @MEDIASUBTYPE_YUY2, @MEDIASUBTYPE_YVYU, @MEDIASUBTYPE_UYVY, @MEDIASUBTYPE_Y211, @MEDIASUBTYPE_YV12, @MEDIASUBTYPE_CLJR,          //
    @MEDIASUBTYPE_IF09, @MEDIASUBTYPE_CPLA, @MEDIASUBTYPE_MJPG, @MEDIASUBTYPE_TVMJ, @MEDIASUBTYPE_WAKE, @MEDIASUBTYPE_CFCC,          //
    @MEDIASUBTYPE_IJPG, @MEDIASUBTYPE_Plum, @MEDIASUBTYPE_DVCS, @MEDIASUBTYPE_DVSD, @MEDIASUBTYPE_MDVF, @MEDIASUBTYPE_RGB1,          //
    @MEDIASUBTYPE_RGB4, @MEDIASUBTYPE_RGB8, @MEDIASUBTYPE_RGB565, @MEDIASUBTYPE_RGB555, @MEDIASUBTYPE_RGB24, @MEDIASUBTYPE_RGB32,    //
    @MEDIASUBTYPE_ARGB1555, @MEDIASUBTYPE_ARGB4444, @MEDIASUBTYPE_ARGB32, @MEDIASUBTYPE_AYUV, @MEDIASUBTYPE_AI44, @MEDIASUBTYPE_IA44 //
    );

  c_arrVideoFormatName: array [0 .. 35] of AnsiString = (    //
    'CLPL', 'YUYV', 'IYUV', 'YVU9', 'Y411', 'Y41P',          //
    'YUY2', 'YVYU', 'UYVY', 'Y211', 'YV12', 'CLJR',          //
    'IF09', 'CPLA', 'MJPG', 'TVMJ', 'WAKE', 'CFCC',          //
    'IJPG', 'Plum', 'DVCS', 'DVSD', 'MDVF', 'RGB1',          //
    'RGB4', 'RGB8', 'RGB565', 'RGB555', 'RGB24', 'RGB32',    //
    'ARGB1555', 'ARGB4444', 'ARGB32', 'AYUV', 'AI44', 'IA44' //
    );

type
  PVideoFormatInfo = ^TVideoFormatInfo;
  PVideoInputInfo  = ^TVideoInputInfo;

  { 视频支持格式 }
  TVideoFormatInfo = record
    id: TGUID;
    iWidth, iHeight: Integer;
    iMod: TGUID;
    Frame: Int64;
    format: ShortString;
  end;

  { 视频输入设备 }
  TVideoInputInfo = record
    id: TGUID;
    strName: ShortString;
    index: Integer;
  end;

  IAMStreamConfig = interface(IUnknown)
    ['{C6E13340-30AC-11d0-A18C-00A0C9118956}']
    function SetFormat(const pmt: TAMMediaType): HResult; stdcall;
    function GetFormat(out ppmt: PAMMediaType): HResult; stdcall;
    function GetNumberOfCapabilities(out piCount, piSize: Integer): HResult; stdcall;
    { Delphi 声明有误，修改声明 }
    function GetStreamCaps(iIndex: Integer; var ppmt: PAMMediaType; pSCC: PVideoStreamConfigCaps): HResult; stdcall;
  end;

  ISampleGrabber = interface(IUnknown)
    ['{6B652FFF-11FE-4FCE-92AD-0266B5D7C78F}']
    function SetOneShot(OneShot: BOOL): HResult; stdcall;
    { Delphi 声明有误，修改声明 }
    function SetMediaType(pType: PAMMediaType): HResult; stdcall;
    function GetConnectedMediaType(out pType: TAMMediaType): HResult; stdcall;
    function SetBufferSamples(BufferThem: BOOL): HResult; stdcall;
    function GetCurrentBuffer(var pBufferSize: longint; pBuffer: Pointer): HResult; stdcall;
    function GetCurrentSample(out ppSample: IMediaSample): HResult; stdcall;
    function SetCallback(pCallback: ISampleGrabberCB; WhichMethodToCallback: longint): HResult; stdcall;
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

  if CocreateInstance(CLSID_SystemDeviceEnum, nil, CLSCTX_INPROC, IID_ICreateDevEnum, pSysDevEnum) = S_OK then
  begin
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
  end;
  pEnumCat    := nil;
  pSysDevEnum := nil;
end;

function VideoMediaSubTypeToStr(mst: TGUID): AnsiString;
var
  I: Integer;
begin
  Result := '';
  for I  := 0 to 35 do
    if CompareMem(c_arrVideoFormatGUID[I], @mst, sizeof(TGUID)) then
    begin
      Result := c_arrVideoFormatName[I];
      break;
    end;
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

procedure DeleteMediaType(pmt: PAMMediaType);
begin
  if pmt <> nil then
  begin
    FreeMediaType(pmt^);
    CoTaskMemFree(pmt);
  end;
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
      { 找到输出接口，返回 }
      Exit;
    end;
  end;
  Result := nil;
end;

function StrToVideoMediaSubType(ss: AnsiString): TGUID;
var
  I: Integer;
begin
  Result := c_arrVideoFormatGUID[0]^;
  for I  := 0 to 35 do
    if ss = c_arrVideoFormatName[I] then
    begin
      Result := c_arrVideoFormatGUID[I]^;
      break;
    end;
end;

function CompareGUID(const g1, g2: TGUID): Boolean;
begin
  Result := CompareMem(@g1, @g2, sizeof(TGUID));
end;

function SetMediaType(filter: IBaseFilter; Width, Height: Integer; format: AnsiString): Boolean;
var
  pmt            : PAMMediaType;
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
  Result := False;

  if (Width = 0) or (Height = 0) then
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
        ih := Pointer(pmt^.pbFormat);
        if (pSCC^.MinOutputSize.cx = Width) and (pSCC^.MinOutputSize.cy = Height) and (ih^.bmiHeader.biWidth = Width) and (ih^.bmiHeader.biheight = Height) and ((format = '') or (CompareGUID(formatID, pmt^.subtype))) and (ih^.dwBitRate > bitRate) // select format with maximum bitrate
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
      FreeMem(pSCC);
    end;
  end;
  Result := True;
end;

{ 枚举视频支持格式 }
function EnumVideoFormat(const strFriendlyName: String; const intIndex: Integer): TVideoFormatInfo;
var
  SysDevEnum          : IBaseFilter;
  CaptureGraphBuilder2: ICaptureGraphBuilder2;
  iunk                : IUnknown;
  fStreamConfig       : IAMStreamConfig;
  piCount, piSize     : Integer;
  III                 : Integer;
  pmt                 : PAMMediaType;
  pSCC                : PVideoStreamConfigCaps;
begin
  { 获取指定USB摄像头的 Filter }
  SysDevEnum := CreateFilter(CLSID_VideoInputDeviceCategory, AnsiString(strFriendlyName), intIndex);
  if SysDevEnum = nil then
    Exit;

  { 创建 ICaptureGraphBuilder2 接口 }
  if Failed(CocreateInstance(CLSID_CaptureGraphBuilder2, nil, CLSCTX_INPROC, IID_ICaptureGraphBuilder2, CaptureGraphBuilder2)) then
    Exit;

  { 获取 IID_IAMStreamConfig 接口 }
  if Failed(CaptureGraphBuilder2.FindInterface(nil, nil, SysDevEnum, IID_IAMStreamConfig, iunk)) then
    Exit;

  { 获取 IAMStreamConfig 媒体类型接口 }
  if Failed(iunk.QueryInterface(IID_IAMStreamConfig, fStreamConfig)) then
    Exit;

  if Failed(fStreamConfig.GetNumberOfCapabilities(piCount, piSize)) then
    Exit;

  if piCount <= 0 then
    Exit;

  { 枚举支持的视频格式 }
  pSCC := AllocMem(piSize);
  try
    for III := 0 to piCount - 1 do
    begin
      if fStreamConfig.GetStreamCaps(III, pmt, pSCC) = S_OK then
      begin
        try
          Result.id      := pmt^.formattype;
          Result.iWidth  := pSCC^.MaxOutputSize.cx;
          Result.iHeight := pSCC^.MaxOutputSize.cy;
          Result.format  := VideoMediaSubTypeToStr(pmt^.subtype);
          Result.iMod    := pmt^.subtype;
          Result.Frame   := PVIDEOINFOHEADER(pmt^.pbFormat)^.AvgTimePerFrame;
          break;
        finally
          DeleteMediaType(pmt);
        end;
      end;
    end;
  finally
    FreeMem(pSCC);
  end;

  SysDevEnum           := nil;
  CaptureGraphBuilder2 := nil;
  fStreamConfig        := nil;
end;

var
  FIGraphBuilder        : IGraphBuilder;
  FICaptureGraphBuilder2: ICaptureGraphBuilder2;
  FSysDevEnum           : IBaseFilter;
  FIVideoWindow         : IVideoWindow;
  FIMediaControl        : IMediaControl;
  FISampleGrabber       : ISampleGrabber;

function PreviewUSBVideo(vii: TVideoInputInfo; pnl: TPanel; const bPreview: Boolean = True; const bSnapBmp: Boolean = True; const bRecord: Boolean = False; const strSaveFileName: String = ''): Boolean;
var
  vfi                : TVideoFormatInfo;
  SampleGrabberFilter: IBaseFilter;
  mt                 : TAMMediaType;
  multiplexer        : IBaseFilter;
  Writer             : IFileSinkFilter;
begin
  Result := False;

  vfi := EnumVideoFormat(string(vii.strName), vii.index);

  { 创建 IGraphBuilder 接口 }
  if Failed(CocreateInstance(CLSID_FilterGraph, nil, CLSCTX_INPROC, IID_IGraphBuilder, FIGraphBuilder)) then
    Exit;

  { 创建 ICaptureGraphBuilder2 接口 }
  if Failed(CocreateInstance(CLSID_CaptureGraphBuilder2, nil, CLSCTX_INPROC, IID_ICaptureGraphBuilder2, FICaptureGraphBuilder2)) then
    Exit;

  { 调用 ICaptureGraphBuilder2 的 SetFilterGraph 方法将 FilterGraph 加入到Builder中 }
  if Failed(FICaptureGraphBuilder2.SetFiltergraph(FIGraphBuilder)) then
    Exit;

  { 获取指定USB摄像头的 Filter }
  FSysDevEnum := CreateFilter(CLSID_VideoInputDeviceCategory, AnsiString(vii.strName), vii.index);
  if FSysDevEnum = nil then
    Exit;

  { 设置指定 Filter 的媒体格式类型 }
  if not SetMediaType(FSysDevEnum, vfi.iWidth, vfi.iHeight, vfi.format) then
    Exit;

  { 将视频捕捉 Filter 添加到 Filter 图中 }
  if Failed(FIGraphBuilder.AddFilter(FSysDevEnum, 'VideoCapture')) then
    Exit;

  { 如果需要截图功能 }
  if bSnapBmp then
  begin
    CocreateInstance(CLSID_SampleGrabber, nil, CLSCTX_INPROC, IID_IBaseFilter, SampleGrabberFilter);
    FIGraphBuilder.AddFilter(SampleGrabberFilter, 'SampleGrabber');
    SampleGrabberFilter.QueryInterface(IID_ISampleGrabber, FISampleGrabber);
    zeromemory(@mt, sizeof(AM_MEDIA_TYPE));
    mt.majortype := MEDIATYPE_Video;
    mt.subtype   := MEDIASUBTYPE_RGB24;     // 24位，位图格式输出
    FISampleGrabber.SetMediaType(@mt);      //
    FISampleGrabber.SetBufferSamples(True); // 允许从 Buffer 中获取数据
    { 渲染预览视频PIN }
    if Failed(FICaptureGraphBuilder2.RenderStream(@PIN_CATEGORY_PREVIEW, @MEDIATYPE_Video, FSysDevEnum, SampleGrabberFilter, nil)) then
      Exit;
  end
  else
  begin
    { 渲染预览视频PIN }
    if Failed(FICaptureGraphBuilder2.RenderStream(@PIN_CATEGORY_PREVIEW, @MEDIATYPE_Video, FSysDevEnum, nil, nil)) then
      Exit;
  end;

  { 如果是视频录制 }
  if bRecord then
  begin
    { 视频录制文件保持路径 }
    if Failed(FICaptureGraphBuilder2.SetOutputFileName(MEDIASUBTYPE_Avi, PWideChar(strSaveFileName), multiplexer, Writer)) then
      Exit;

    if Failed(FICaptureGraphBuilder2.RenderStream(@PIN_CATEGORY_CAPTURE, @MEDIATYPE_Video, FSysDevEnum, nil, multiplexer)) then
      Exit;
  end;

  { 设置视频预览窗口 }
  if Failed(FIGraphBuilder.QueryInterface(IID_IVideoWindow, FIVideoWindow)) then
    Exit;

  { 设置视频播放的WINDOWS窗口 }
  if Failed(FIVideoWindow.put_Owner(pnl.Handle)) then
    Exit;

  if Failed(FIVideoWindow.put_windowstyle(WS_CHILD or WS_Clipsiblings)) then
    Exit;

  { 设置视频尺寸 }
  if Failed(FIVideoWindow.SetWindowposition(0, 0, pnl.Width, pnl.Height)) then
    Exit;

  { 得到IMediaControl接口，用于控制流播放 }
  if Failed(FIGraphBuilder.QueryInterface(IID_IMediaControl, FIMediaControl)) then
    Exit;

  FIMediaControl.Run;

  Result := True;
end;

procedure FreeGraph;
begin
  FIGraphBuilder         := nil;
  FIMediaControl         := nil;
  FIVideoWindow          := nil;
  FSysDevEnum            := nil;
  FICaptureGraphBuilder2 := nil;
  FISampleGrabber        := nil;
end;

{ 启动本地USB相机视频预览；默认为第一个 }
function PreviewNativeUSBCamera(pnl: TPanel; const intIndex: Integer = 0; const bPreview: Boolean = True; const bSnapBmp: Boolean = True; const bRecord: Boolean = False; const strSaveFileName: String = ''): Boolean;
var
  SysDevEnum     : ICreateDevEnum;
  EnumCat        : IEnumMoniker;
  hr             : Integer;
  Moniker        : IMoniker;
  Fetched        : ULONG;
  PropBag        : IPropertyBag;
  strFriendlyName: OleVariant;
  strGuid        : OleVariant;
  I              : Integer;
  vii            : TVideoInputInfo;
begin
  Result := True;
  I      := -1;

  { 创建系统枚举器对象 }
  hr := CocreateInstance(CLSID_SystemDeviceEnum, nil, CLSCTX_INPROC, IID_ICreateDevEnum, SysDevEnum);
  if hr <> S_OK then
    Exit;

  { 用指定的 Filter 目录类型创建一个枚举器，并获得 IEnumMoniker 接口； }
  hr := SysDevEnum.CreateClassEnumerator(CLSID_VideoInputDeviceCategory, EnumCat, 0);
  if hr <> S_OK then
    Exit;

  try
    { 获取指定类型目录下所有设备标识 }
    while (EnumCat.Next(1, Moniker, @Fetched) = S_OK) do
    begin
      Inc(I);
      Moniker.BindToStorage(nil, nil, IID_IPropertyBag, PropBag);
      PropBag.Read('CLSID', strGuid, nil);
      PropBag.Read('FriendlyName', strFriendlyName, nil);
      try
        if intIndex = I then
        begin
          vii.id      := StringToGUID(strGuid);
          vii.strName := ShortString(strFriendlyName);
          vii.index   := I;
          Result      := PreviewUSBVideo(vii, pnl, bPreview, bSnapBmp, bRecord, strSaveFileName);
          break;
        end;
      finally
        PropBag := nil;
        Moniker := nil;
      end;
    end;
  finally
    EnumCat    := nil;
    SysDevEnum := nil;
  end;
end;

procedure VideoResize(pnlVideo: TPanel);
begin
    if FIVideoWindow <> nil then
  begin
    FIVideoWindow.SetWindowposition(0, 0, pnlVideo.width, pnlVideo.height);
  end;
end;

initialization

finalization
  FreeGraph;

end.
