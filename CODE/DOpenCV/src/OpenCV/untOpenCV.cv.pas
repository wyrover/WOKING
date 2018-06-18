unit untOpenCV.cv;

interface

uses System.Classes, untOpenCVType, untOpenCV;

type
  Tcv                           = class; { cv                                                 ���� }
  T_InputArray                  = class; { cv::_InputArray                                    ���� }
  T_OutputArray                 = class; { cv::_OutputArray                                   ���� }
  TAlgorithm                    = class; { cv::Algorithm                                      ���� }
  TAVIReadContainer             = class; { cv::AVIReadContainer                               ���� }
  TAVIWriteContainer            = class; { cv::AVIWriteContainer                              ���� }
  TBFMatcher                    = class; { cv::BFMatcher                                      ���� }
  TBriskScaleSpace              = class; { cv::BriskScaleSpace                                ���� }
  TCascadeClassifier            = class; { cv::CascadeClassifier                              ���� }
  TCommandLineParser            = class; { cv::CommandLineParser                              ���� }
  Tcuda                         = class; { cv::cuda                                           ���� }
  TDeviceInfo                   = class; { cv::cuda::DeviceInfo                               ���� }
  TGpuMat                       = class; { cv::cuda::GpuMat                                   ���� }
  TBufferPool                   = class; { cv::cuda::BufferPool                               ���� }
  THostMem                      = class; { cv::cuda::HostMem                                  ���� }
  TStream                       = class; { cv::cuda::Stream                                   ���� }
  TTargetArchs                  = class; { cv::cuda::TargetArchs                              ���� }
  TDescriptorMatcher            = class; { cv::DescriptorMatcher                              ���� }
  Tdetail                       = class; { cv::detail                                         ���� }
  TDMatch                       = class; { cv::DMatch                                         ���� }
  Tdnn                          = class; { cv::dnn                                            ���� }
  Texperimental_dnn_v4          = class; { cv::dnn::experimental_dnn_v4                       ���� }
  TFeature2D                    = class; { cv::Feature2D                                      ���� }
  TFileNode                     = class; { cv::FileNode                                       ���� }
  TFileStorage                  = class; { cv::FileStorage                                    ���� }
  Tflann                        = class; { cv::flann                                          ���� }
  Tindex                        = class; { cv::flann::index                                   ���� }
  TFlannBasedMatcher            = class; { cv::FlannBasedMatcher                              ���� }
  Thal                          = class; { cv::hal                                            ���� }
  THOGDescriptor                = class; { cv::HOGDescriptor                                  ���� }
  Tinstr                        = class; { cv::instr                                          ���� }
  Tipp                          = class; { cv::ipp                                            ���� }
  TMat                          = class; { cv::Mat                                            ���� }
  TMatOp                        = class; { cv::MatOp                                          ���� }
  TMatSize                      = class; { cv::MatSize                                        ���� }
  Tml                           = class; { cv::ml                                             ���� }
  TEMImpl                       = class; { cv::ml:EMImpl                                      ���� }
  TStatModel                    = class; { cv::ml:StatModel                                   ���� }
  TSVM                          = class; { cv::ml:SVM                                         ���� }
  TMutex                        = class; { cv::Mutex                                          ���� }
  Tocl                          = class; { cv::ocl                                            ���� }
  TContext                      = class; { cv::ocl::Context                                   ���� }
  TDevice                       = class; { cv::ocl::Device                                    ���� }
  TImage2D                      = class; { cv::ocl::Image2D                                   ���� }
  Tinternal                     = class; { cv::ocl::internal                                  ���� }
  TKernel                       = class; { cv::ocl::Kernel                                    ���� }
  TProgram                      = class; { cv::ocl::Program                                   ���� }
  TQueue                        = class; { cv::ocl::Queue                                     ���� }
  Togl                          = class; { cv::ogl                                            ���� }
  TArrays                       = class; { cv::ogl::Arrays                                    ���� }
  TBuffer                       = class; { cv::ogl::Buffer                                    ���� }
  TTexture2D                    = class; { cv::ogl::Texture2D                                 ���� }
  TPointSetRegistrator          = class; { cv::PointSetRegistrator                            ���� }
  TCallback                     = class; { cv::PointSetRegistrator::Callback                  ���� }
  TRange                        = class; { cv::Range                                          ���� }
  TRNG                          = class; { cv::RNG                                            ���� }
  TSimilarRects                 = class; { cv::SimilarRects                                   ���� }
  Tsoftdouble                   = class; { cv::softdouble                                     ���� }
  Tsoftfloat                    = class; { cv::softfloat                                      ���� }
  TString                       = class; { cv::String                                         ���� }
  TSubdiv2D                     = class; { cv::Subdiv2D                                       ���� }
  TUMat                         = class; { cv::UMat                                           ���� }
  TUMatData                     = class; { cv::UMatData                                       ���� }
  Tutils                        = class; { cv::utils                                          ���� }
  Tfs                           = class; { cv::utils::fs                                      ���� }
  Ttrace                        = class; { cv::utils::trace                                   ���� }
  Tdetails                      = class; { cv::utils::details                                 ���� }
  TRegion                       = class; { cv::utils::details::Region                         ���� }
  TTraceManager                 = class; { cv::utils::details::TraceManager                   ���� }
  TVideoCapture                 = class; { cv::VideoCapture                                   ���� }
  Tvideostab                    = class; { cv::videostab                                      ���� }
  TInpaintingPipeline           = class; { cv::videostab::InpaintingPipeline                  ���� }
  TMotionStabilizationPipeline  = class; { cv::videostab::MotionStabilizationPipeline         ���� }
  TFastMarchingMethod           = class; { cv::videostab::FastMarchingMethod                  ���� }
  TFromFileMotionReader         = class; { cv::videostab::FromFileMotionReader                ���� }
  TMotionEstimatorL1            = class; { cv::videostab::MotionEstimatorL1                   ���� }
  TNullFrameSource              = class; { cv::videostab::NullFrameSource                     ���� }
  TOnePassStabilizer            = class; { cv::videostab::OnePassStabilizer                   ���� }
  TStabilizerBase               = class; { cv::videostab::StabilizerBase                      ���� }
  TMotionEstimatorRansacL2      = class; { cv::videostab::MotionEstimatorRansacL2             ���� }
  TKeypointBasedMotionEstimator = class; { cv::videostab::KeypointBasedMotionEstimator        ���� }
  TGaussianMotionFilters        = class; { cv::videostab::GaussianMotionFilter                ���� }
  TTwoPassStabilizer            = class; { cv::videostab::TwoPassStabilizer                   ���� }
  TToFileMotionWriter           = class; { cv::videostab::ToFileMotionWriter                  ���� }
  TVideoWriter                  = class; { cv::VideoWriter                                    ���� }
  TEMDHistogramCostExtractor    = class; { cv::EMDHistogramCostExtractor                      ���� }
  TEMDL1HistogramCostExtractor  = class; { cv::EMDL1HistogramCostExtractor                    ���� }
  TException                    = class; { cv::Exception                                      ���� }
  TFarnebackOpticalFlow         = class; { cv::FarnebackOpticalFlow                           ���� }
  TFastFeatureDetector          = class; { cv::FastFeatureDetector                            ���� }
  TFileNodeIterator             = class; { cv::FileNodeIterator                               ���� }
  TFormatted                    = class; { cv::Formatted                                      ���� }
  TGeneralizedHough             = class; { cv::GeneralizedHough                               ���� }
  TGeneralizedHoughBallard      = class; { cv::GeneralizedHoughBallard                        ���� }
  TGeneralizedHoughGuil         = class; { cv::GeneralizedHoughGuil                           ���� }
  TGFTTDetector                 = class; { cv::GFTTDetector                                   ���� }
  THausdorffDistanceExtractor   = class; { cv::HausdorffDistanceExtractor                     ���� }
  THistogramCostExtractor       = class; { cv::HistogramCostExtractor                         ���� }
  TKalmanFilter                 = class; { cv::KalmanFilter                                   ���� }
  TKAZE                         = class; { cv::KAZE                                           ���� }
  TKeyPoint                     = class; { cv::KeyPoint                                       ���� }
  KeyPointsFilter               = class; { cv::KeyPointsFilter                                ���� }
  TLDA                          = class; { cv::LDA                                            ���� }
  TLineIterator                 = class; { cv::LineIterator                                   ���� }
  TLineSegmentDetector          = class; { cv::LineSegmentDetector                            ���� }
  TLMSolver                     = class; { cv::LMSolver                                       ���� }
  TMatAllocator                 = class; { cv::MatAllocator                                   ���� }
  TMatConstIterator             = class; { cv::MatConstIterator                               ���� }
  TMatExpr                      = class; { cv::MatExpr                                        ���� }
  TMergeDebevec                 = class; { cv::MergeDebevec                                   ���� }
  TMergeExposures               = class; { cv::MergeExposures                                 ���� }
  TMergeMertens                 = class; { cv::MergeMertens                                   ���� }
  TMergeRobertson               = class; { cv::MergeRobertson                                 ���� }
  TMinProblemSolver             = class; { cv::MinProblemSolver                               ���� }

  { cv ��ĳ�Ա���� }
  Tcv = Class(TOpenCV)
  public
    VideoCapture: TVideoCapture;
    constructor Create(hDllHandle: THandle; ListFunc: TList);
    destructor Destroy; override;
    function getBuildInformation: TString; cdecl;
  end;

  { cv::VideoCapture ���� }
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
