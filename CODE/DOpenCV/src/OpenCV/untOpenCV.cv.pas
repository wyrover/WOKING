unit untOpenCV.cv;

interface

uses System.Classes, untOpenCVType, untOpenCV;

type
  Tcv                           = class; { cv                                                 基类 }
  T_InputArray                  = class; { cv::_InputArray                                    子类 }
  T_OutputArray                 = class; { cv::_OutputArray                                   子类 }
  TAlgorithm                    = class; { cv::Algorithm                                      子类 }
  TAVIReadContainer             = class; { cv::AVIReadContainer                               子类 }
  TAVIWriteContainer            = class; { cv::AVIWriteContainer                              子类 }
  TBFMatcher                    = class; { cv::BFMatcher                                      子类 }
  TBriskScaleSpace              = class; { cv::BriskScaleSpace                                子类 }
  TCascadeClassifier            = class; { cv::CascadeClassifier                              子类 }
  TCommandLineParser            = class; { cv::CommandLineParser                              子类 }
  Tcuda                         = class; { cv::cuda                                           子类 }
  TDeviceInfo                   = class; { cv::cuda::DeviceInfo                               子类 }
  TGpuMat                       = class; { cv::cuda::GpuMat                                   子类 }
  TBufferPool                   = class; { cv::cuda::BufferPool                               子类 }
  THostMem                      = class; { cv::cuda::HostMem                                  子类 }
  TStream                       = class; { cv::cuda::Stream                                   子类 }
  TTargetArchs                  = class; { cv::cuda::TargetArchs                              子类 }
  TDescriptorMatcher            = class; { cv::DescriptorMatcher                              子类 }
  Tdetail                       = class; { cv::detail                                         子类 }
  TDMatch                       = class; { cv::DMatch                                         子类 }
  Tdnn                          = class; { cv::dnn                                            子类 }
  Texperimental_dnn_v4          = class; { cv::dnn::experimental_dnn_v4                       子类 }
  TFeature2D                    = class; { cv::Feature2D                                      子类 }
  TFileNode                     = class; { cv::FileNode                                       子类 }
  TFileStorage                  = class; { cv::FileStorage                                    子类 }
  Tflann                        = class; { cv::flann                                          子类 }
  Tindex                        = class; { cv::flann::index                                   子类 }
  TFlannBasedMatcher            = class; { cv::FlannBasedMatcher                              子类 }
  Thal                          = class; { cv::hal                                            子类 }
  THOGDescriptor                = class; { cv::HOGDescriptor                                  子类 }
  Tinstr                        = class; { cv::instr                                          子类 }
  Tipp                          = class; { cv::ipp                                            子类 }
  TMat                          = class; { cv::Mat                                            子类 }
  TMatOp                        = class; { cv::MatOp                                          子类 }
  TMatSize                      = class; { cv::MatSize                                        子类 }
  Tml                           = class; { cv::ml                                             子类 }
  TEMImpl                       = class; { cv::ml:EMImpl                                      子类 }
  TStatModel                    = class; { cv::ml:StatModel                                   子类 }
  TSVM                          = class; { cv::ml:SVM                                         子类 }
  TMutex                        = class; { cv::Mutex                                          子类 }
  Tocl                          = class; { cv::ocl                                            子类 }
  TContext                      = class; { cv::ocl::Context                                   子类 }
  TDevice                       = class; { cv::ocl::Device                                    子类 }
  TImage2D                      = class; { cv::ocl::Image2D                                   子类 }
  Tinternal                     = class; { cv::ocl::internal                                  子类 }
  TKernel                       = class; { cv::ocl::Kernel                                    子类 }
  TProgram                      = class; { cv::ocl::Program                                   子类 }
  TQueue                        = class; { cv::ocl::Queue                                     子类 }
  Togl                          = class; { cv::ogl                                            子类 }
  TArrays                       = class; { cv::ogl::Arrays                                    子类 }
  TBuffer                       = class; { cv::ogl::Buffer                                    子类 }
  TTexture2D                    = class; { cv::ogl::Texture2D                                 子类 }
  TPointSetRegistrator          = class; { cv::PointSetRegistrator                            子类 }
  TCallback                     = class; { cv::PointSetRegistrator::Callback                  子类 }
  TRange                        = class; { cv::Range                                          子类 }
  TRNG                          = class; { cv::RNG                                            子类 }
  TSimilarRects                 = class; { cv::SimilarRects                                   子类 }
  Tsoftdouble                   = class; { cv::softdouble                                     子类 }
  Tsoftfloat                    = class; { cv::softfloat                                      子类 }
  TString                       = class; { cv::String                                         子类 }
  TSubdiv2D                     = class; { cv::Subdiv2D                                       子类 }
  TUMat                         = class; { cv::UMat                                           子类 }
  TUMatData                     = class; { cv::UMatData                                       子类 }
  Tutils                        = class; { cv::utils                                          子类 }
  Tfs                           = class; { cv::utils::fs                                      子类 }
  Ttrace                        = class; { cv::utils::trace                                   子类 }
  Tdetails                      = class; { cv::utils::details                                 子类 }
  TRegion                       = class; { cv::utils::details::Region                         子类 }
  TTraceManager                 = class; { cv::utils::details::TraceManager                   子类 }
  TVideoCapture                 = class; { cv::VideoCapture                                   子类 }
  Tvideostab                    = class; { cv::videostab                                      子类 }
  TInpaintingPipeline           = class; { cv::videostab::InpaintingPipeline                  子类 }
  TMotionStabilizationPipeline  = class; { cv::videostab::MotionStabilizationPipeline         子类 }
  TFastMarchingMethod           = class; { cv::videostab::FastMarchingMethod                  子类 }
  TFromFileMotionReader         = class; { cv::videostab::FromFileMotionReader                子类 }
  TMotionEstimatorL1            = class; { cv::videostab::MotionEstimatorL1                   子类 }
  TNullFrameSource              = class; { cv::videostab::NullFrameSource                     子类 }
  TOnePassStabilizer            = class; { cv::videostab::OnePassStabilizer                   子类 }
  TStabilizerBase               = class; { cv::videostab::StabilizerBase                      子类 }
  TMotionEstimatorRansacL2      = class; { cv::videostab::MotionEstimatorRansacL2             子类 }
  TKeypointBasedMotionEstimator = class; { cv::videostab::KeypointBasedMotionEstimator        子类 }
  TGaussianMotionFilters        = class; { cv::videostab::GaussianMotionFilter                子类 }
  TTwoPassStabilizer            = class; { cv::videostab::TwoPassStabilizer                   子类 }
  TToFileMotionWriter           = class; { cv::videostab::ToFileMotionWriter                  子类 }
  TVideoWriter                  = class; { cv::VideoWriter                                    子类 }
  TEMDHistogramCostExtractor    = class; { cv::EMDHistogramCostExtractor                      子类 }
  TEMDL1HistogramCostExtractor  = class; { cv::EMDL1HistogramCostExtractor                    子类 }
  TException                    = class; { cv::Exception                                      子类 }
  TFarnebackOpticalFlow         = class; { cv::FarnebackOpticalFlow                           子类 }
  TFastFeatureDetector          = class; { cv::FastFeatureDetector                            子类 }
  TFileNodeIterator             = class; { cv::FileNodeIterator                               子类 }
  TFormatted                    = class; { cv::Formatted                                      子类 }
  TGeneralizedHough             = class; { cv::GeneralizedHough                               子类 }
  TGeneralizedHoughBallard      = class; { cv::GeneralizedHoughBallard                        子类 }
  TGeneralizedHoughGuil         = class; { cv::GeneralizedHoughGuil                           子类 }
  TGFTTDetector                 = class; { cv::GFTTDetector                                   子类 }
  THausdorffDistanceExtractor   = class; { cv::HausdorffDistanceExtractor                     子类 }
  THistogramCostExtractor       = class; { cv::HistogramCostExtractor                         子类 }
  TKalmanFilter                 = class; { cv::KalmanFilter                                   子类 }
  TKAZE                         = class; { cv::KAZE                                           子类 }
  TKeyPoint                     = class; { cv::KeyPoint                                       子类 }
  KeyPointsFilter               = class; { cv::KeyPointsFilter                                子类 }
  TLDA                          = class; { cv::LDA                                            子类 }
  TLineIterator                 = class; { cv::LineIterator                                   子类 }
  TLineSegmentDetector          = class; { cv::LineSegmentDetector                            子类 }
  TLMSolver                     = class; { cv::LMSolver                                       子类 }
  TMatAllocator                 = class; { cv::MatAllocator                                   子类 }
  TMatConstIterator             = class; { cv::MatConstIterator                               子类 }
  TMatExpr                      = class; { cv::MatExpr                                        子类 }
  TMergeDebevec                 = class; { cv::MergeDebevec                                   子类 }
  TMergeExposures               = class; { cv::MergeExposures                                 子类 }
  TMergeMertens                 = class; { cv::MergeMertens                                   子类 }
  TMergeRobertson               = class; { cv::MergeRobertson                                 子类 }
  TMinProblemSolver             = class; { cv::MinProblemSolver                               子类 }

  { cv 类的成员函数 }
  Tcv = Class(TOpenCV)
  public
    VideoCapture: TVideoCapture;
    constructor Create(hDllHandle: THandle; ListFunc: TList);
    destructor Destroy; override;
    function getBuildInformation: TString; cdecl;
  end;

  { cv::VideoCapture 子类 }
  TVideoCapture = class(Tcv)
  public
    function set_(intWH: Integer; intValue: Double): Boolean; cdecl;
    function get_(intWH: Integer): Double; cdecl;
    function grab(): Boolean; cdecl;
    function isOpened(): Boolean; cdecl;
  end;

  T_InputArray = class(Tcv)

  end;

  T_OutputArray = class(Tcv)

  end;

  TAlgorithm = class(Tcv)

  end;

  TAVIReadContainer = class(Tcv)

  end;

  TAVIWriteContainer = class(Tcv)

  end;

  TBFMatcher = class(Tcv)

  end;

  TBriskScaleSpace = class(Tcv)

  end;

  TCascadeClassifier = class(Tcv)

  end;

  TCommandLineParser = class(Tcv)

  end;

  Tcuda = class(Tcv)

  end;

  TDeviceInfo = class(Tcuda)

  end;

  TGpuMat = class(Tcuda)

  end;

  TBufferPool = class(Tcuda)

  end;

  THostMem = class(Tcuda)

  end;

  TStream = class(Tcuda)

  end;

  TTargetArchs = class(Tcuda)

  end;

  TDescriptorMatcher = class(Tcv)

  end;

  Tdetail = class(Tcv)

  end;

  TDMatch = class(Tcv)

  end;

  Tdnn = class(Tcv)

  end;

  Texperimental_dnn_v4 = class(Tdnn)

  end;

  TFeature2D = class(Tcv)

  end;

  TFileNode = class(Tcv)

  end;

  TFileStorage = class(Tcv)

  end;

  Tflann = class(Tcv)

  end;

  Tindex = class(Tflann)

  end;

  TFlannBasedMatcher = class(Tcv)

  end;

  Thal = class(Tcv)

  end;

  THOGDescriptor = class(Tcv)

  end;

  Tinstr = class(Tcv)

  end;

  Tipp = class(Tcv)

  end;

  TMat = class(Tcv)

  end;

  TMatOp = class(Tcv)

  end;

  TMatSize = class(Tcv)

  end;

  Tml = class(Tcv)

  end;

  TEMImpl = class(Tml)

  end;

  TStatModel = class(Tml)

  end;

  TSVM = class(Tml)

  end;

  TMutex = class(Tcv)

  end;

  Tocl = class(Tcv)

  end;

  TContext = class(Tocl)

  end;

  TDevice = class(Tocl)

  end;

  TImage2D = class(Tocl)

  end;

  Tinternal = class(Tocl)

  end;

  TKernel = class(Tocl)

  end;

  TProgram = class(Tocl)

  end;

  TQueue = class(Tocl)

  end;

  Togl = class(Tcv)

  end;

  TArrays = class(Togl)

  end;

  TBuffer = class(Togl)

  end;

  TTexture2D = class(Togl)

  end;

  TPointSetRegistrator = class(Tcv)

  end;

  TCallback = class(TPointSetRegistrator)

  end;

  TRange = class(Tcv)

  end;

  TRNG = class(Tcv)

  end;

  TSimilarRects = class(Tcv)

  end;

  Tsoftdouble = class(Tcv)

  end;

  Tsoftfloat = class(Tcv)

  end;

  TString = class(Tcv)

  end;

  TSubdiv2D = class(Tcv)

  end;

  TUMat = class(Tcv)

  end;

  TUMatData = class(Tcv)

  end;

  Tutils = class(Tcv)

  end;

  Tfs = class(Tutils)

  end;

  Ttrace = class(Tutils)

  end;

  Tdetails = class(Ttrace)

  end;

  TRegion = class(Tdetails)

  end;

  TTraceManager = class(Tdetails)

  end;

  Tvideostab = class(Tcv)

  end;

  TInpaintingPipeline = class(Tvideostab)

  end;

  TMotionStabilizationPipeline = class(Tvideostab)

  end;

  TFastMarchingMethod = class(Tvideostab)

  end;

  TStabilizerBase = class(Tvideostab)

  end;

  TMotionEstimatorRansacL2 = class(Tvideostab)

  end;

  TFromFileMotionReader = class(Tvideostab)

  end;

  TMotionEstimatorL1 = class(Tvideostab)

  end;

  TNullFrameSource = class(Tvideostab)

  end;

  TOnePassStabilizer = class(Tvideostab)

  end;

  TToFileMotionWriter = class(Tvideostab)

  end;

  TTwoPassStabilizer = class(Tvideostab)

  end;

  TGaussianMotionFilters = class(Tvideostab)

  end;

  TKeypointBasedMotionEstimator = class(Tvideostab)

  end;

  TVideoWriter = class(Tcv)

  end;

  TEMDHistogramCostExtractor = class(Tcv)

  end;

  TEMDL1HistogramCostExtractor = class(Tcv)

  end;

  TException = class(Tcv)

  end;

  TFarnebackOpticalFlow = class(Tcv)

  end;

  TFastFeatureDetector = class(Tcv)

  end;

  TFileNodeIterator = class(Tcv)

  end;

  TFormatted = class(Tcv)

  end;

  TGeneralizedHough = class(Tcv)

  end;

  TGeneralizedHoughBallard = class(Tcv)

  end;

  TGeneralizedHoughGuil = class(Tcv)

  end;

  TGFTTDetector = class(Tcv)

  end;

  THausdorffDistanceExtractor = class(Tcv)

  end;

  THistogramCostExtractor = class(Tcv)

  end;

  TKalmanFilter = class(Tcv)

  end;

  TKAZE = class(Tcv)

  end;

  TKeyPoint = class(Tcv)

  end;

  KeyPointsFilter = class(Tcv)

  end;

  TLDA = class(Tcv)

  end;

  TLineIterator = class(Tcv)

  end;

  TLineSegmentDetector = class(Tcv)

  end;

  TLMSolver = class(Tcv)

  end;

  TMatAllocator = class(Tcv)

  end;

  TMatConstIterator = class(Tcv)

  end;

  TMatExpr = class(Tcv)

  end;

  TMergeDebevec = class(Tcv)

  end;

  TMergeExposures = class(Tcv)

  end;

  TMergeMertens = class(Tcv)

  end;

  TMergeRobertson = class(Tcv)

  end;

  TMinProblemSolver = class(Tcv)

  end;

implementation

{ TCV }
constructor Tcv.Create(hDllHandle: THandle; ListFunc: TList);
begin
  // FhDllHandle := hDllHandle;
  // FListFunc   := ListFunc;
end;

destructor Tcv.Destroy;
begin

  inherited;
end;

function Tcv.getBuildInformation: TString;
// type
// TgetBuildInformation = function(): PChar; cdecl;
// var
// strTempFuncName: String;
// tmpFunc        : TgetBuildInformation;
begin
  Result := nil;
  // GetEIP;
  // strTempFuncName := GetFunctionName(ClassName);
  //
  // Result  := '';
  // tmpFunc := GetFunctionEntryAddress(strTempFuncName);
  // if Assigned(tmpFunc) then
  // Result := PChar(Pointer(tmpFunc)^);
end;

{ TVideoCapture }

function TVideoCapture.get_(intWH: Integer): Double;
begin
  Result := 0.1;
end;

function TVideoCapture.grab: Boolean;
begin
  Result := True;
end;

function TVideoCapture.isOpened: Boolean;
begin
  Result := True;
end;

function TVideoCapture.set_(intWH: Integer; intValue: Double): Boolean;
begin
  Result := True;
end;

end.
