unit untOpenCVType;

interface

const
  c_strOpenCVDll     = 'opencv_world341.dll';
  CV_WINDOW_AUTOSIZE = 1;

  (* Adaptive threshold methods *)
  CV_ADAPTIVE_THRESH_MEAN_C     = 0;
  CV_ADAPTIVE_THRESH_GAUSSIAN_C = 1;

  (* Threshold types *)
  CV_THRESH_BINARY     = 0; (* value = value > threshold ? max_value : 0 *)
  CV_THRESH_BINARY_INV = 1; (* value = value > threshold ? 0 : max_value *)
  CV_THRESH_TRUNC      = 2; (* value = value > threshold ? threshold : value *)
  CV_THRESH_TOZERO     = 3; (* value = value > threshold ? value : 0 *)
  CV_THRESH_TOZERO_INV = 4; (* value = value > threshold ? 0 : value *)
  CV_THRESH_MASK       = 7;
  CV_THRESH_OTSU       = 8;

  (* Contour retrieval modes *)
  CV_RETR_EXTERNAL  = 0;
  CV_RETR_LIST      = 1;
  CV_RETR_CCOMP     = 2;
  CV_RETR_TREE      = 3;
  CV_RETR_FLOODFILL = 4;
  (* Contour approximation methods *)
  CV_CHAIN_CODE             = 0;
  CV_CHAIN_APPROX_NONE      = 1;
  CV_CHAIN_APPROX_SIMPLE    = 2;
  CV_CHAIN_APPROX_TC89_L1   = 3;
  CV_CHAIN_APPROX_TC89_KCOS = 4;
  CV_LINK_RUNS              = 5;

  CV_MAX_DIM = 32;

  (* Shape orientation *)
  CV_CLOCKWISE         = 1;
  CV_COUNTER_CLOCKWISE = 2;

  CV_GRAPH_VERTEX       = 1;
  CV_GRAPH_TREE_EDGE    = 2;
  CV_GRAPH_BACK_EDGE    = 4;
  CV_GRAPH_FORWARD_EDGE = 8;
  CV_GRAPH_CROSS_EDGE   = 16;
  CV_GRAPH_ANY_EDGE     = 30;
  CV_GRAPH_NEW_TREE     = 32;
  CV_GRAPH_BACKTRACKING = 64;
  CV_GRAPH_OVER         = -1;
  CV_GRAPH_ALL_ITEMS    = -1;

  CV_GAUSSIAN_5x5 = 7;

  CV_STEREO_BM_BASIC    = 0;
  CV_STEREO_BM_FISH_EYE = 1;
  CV_STEREO_BM_NARROW   = 2;

type
  PDllFuncInfo        = ^TDllFuncInfo;
  TcvString           = string;
  PChar               = PAnsiChar;
  float               = Single;
  pfloat              = ^float;
  PCvMat              = ^CvMat;
  ppCvMat             = ^PCvMat;
  pCvPoint            = ^TCvPoint;
  PCvMatDataUnion     = ^CvMatDataUnion;
  pCvArr              = Pointer;
  TCvArrArray         = array [0 .. 0] of pCvArr;
  pCvArrArray         = ^TCvArrArray;
  pCvScalar           = ^CvScalar;
  size_t              = Cardinal;
  pCvSeq              = ^CvSeq;
  pCvMemStorage       = ^CvMemStorage;
  pschar              = ^ShortInt;
  pCvMemBlock         = ^CvMemBlock;
  pCvSeqBlock         = ^CvSeqBlock;
  PCvSlice            = ^CvSlice;
  CVChar              = AnsiChar;
  TCVChar             = CVChar;
  pCVChar             = PAnsiChar;
  TpCVCharArray       = array [0 .. 0] of pCVChar;
  ppCVChar            = ^TpCVCharArray;
  pCvRect             = ^CvRect;
  pCvBox2D            = ^CvBox2D;
  pCvSize2D32f        = ^CvSize2D32f;
  pCvHistogram        = ^CvHistogram;
  pCvMatND            = ^CvMatND;
  pCvSize             = ^CvSize;
  pCvPoint2D32f       = ^CvPoint2D32f;
  pCvTermCriteria     = ^CvTermCriteria;
  pCvPoint2D64f       = ^CvPoint2D64f;
  pCvConnectedComp    = ^CvConnectedComp;
  pCvSeqReader        = ^CvSeqReader;
  pCvGraph            = ^CvGraph;
  PCV_GRAPH_FIELDS    = ^CV_GRAPH_FIELDS;
  PCV_SEQUENCE_FIELDS = ^CV_SEQUENCE_FIELDS;
  pCvSet              = ^TCvSet;
  pCvSparseMat        = ^CvSparseMat;
  pCvCapture          = ^CvCapture;
  pCvGraphVtx         = ^CvGraphVtx;
  pCvGraphEdge        = ^CvGraphEdge;
  pCvGraphScanner     = ^CvGraphScanner;
  pCvKalman           = ^CvKalman;
  pCvPoint3D32f       = ^CvPoint3D32f;
  pCvPoint3D64f       = ^CvPoint3D64f;
  PCvPOSITObject      = ^CvPOSITObject;
  pCvSeqWriter        = ^CvSeqWriter;
  pCvStereoBMState    = ^CvStereoBMState;
  pIplConvKernel      = ^IplConvKernel;
  pIplConvKernelFP    = ^IplConvKernelFP;
  CvVideoWriter       = Integer;
  pCvVideoWriter      = ^CvVideoWriter;
  ppCvVideoWriter     = ^pCvVideoWriter;

  TDllFuncInfo = record
    strFunctionNameC: String;   // C   类型函数名称
    strFunctionNameCpp: String; // C++ 类型函数全名 <长度有可能超过 255 >
    intEntryAddress: Pointer;   // 函数入口地址
  end;

  TCvLoadImageIsColor = (                  //
    CV_LOAD_IMAGE_UNCHANGED = -1,          // 8bit, color or not
    CV_LOAD_IMAGE_GRAYSCALE = 0,           // 8bit, gray
    CV_LOAD_IMAGE_COLOR = 1,               // ?, color
    CV_LOAD_IMAGE_ANYDEPTH = 2,            // any depth, ?
    CV_LOAD_IMAGE_ANYCOLOR = 4,            // ?, any color
    CV_LOAD_IMAGE_IGNORE_ORIENTATION = 128 // ?, no rotate
    );

  PPIplImage = ^PIplImage;
  PIplImage  = ^IplImage;
  P_IplROI   = ^_IplROI;

  IplROI = packed record
    coi: Integer;     // 0 - no COI (all channels are selected), 1 - 0th channel is selected ...
    xOffset: Integer; //
    yOffset: Integer; //
    width: Integer;   //
    height: Integer;  //
  end;

  _IplROI = IplROI;

  TiplCallBack = procedure(img: PIplImage; xIndex: Integer; yIndex: Integer; mode: Integer); cdecl;

  IplTileInfo = record
    callBack: TiplCallBack;
    id: Pointer;
    tileData: PAnsiChar;
    width: Integer;
    height: Integer;
  end;

  PIplTileInfo = ^IplTileInfo;

  IplImage = record
    nSize: Integer;                         // /* sizeof(IplImage) */
    id: Integer;                            // /* version (=0)*/
    nChannels: Integer;                     // /* Most of OpenCV functions support 1,2,3 or 4 channels */
    alphaChannel: Integer;                  // /* Ignored by OpenCV */
    depth: Integer;                         // /* Pixel depth in bits: IPL_DEPTH_8U, IPL_DEPTH_8S, IPL_DEPTH_16S,    // IPL_DEPTH_32S, IPL_DEPTH_32F and IPL_DEPTH_64F are supported.  */
    colorModel: array [0 .. 3] of AnsiChar; // [4];     ///* Ignored by OpenCV */
    channelSeq: array [0 .. 3] of AnsiChar; // * ditto */
    dataOrder: Integer;                     // /* 0 - interleaved color channels, 1 - separate color channels.     // cvCreateImage can only create interleaved images */
    origin: Integer;                        // /* 0 - top-left origin,       // 1 - bottom-left origin (Windows bitmaps style).  */
    align: Integer;                         // * Alignment of image rows (4 or 8).      // OpenCV ignores it and uses widthStep instead.    */
    width: Integer;                         // /* Image width in pixels.                           */
    height: Integer;                        // /* Image height in pixels.                          */
    roi: P_IplROI;                          // /* Image ROI. If NULL, the whole image is selected. */
    maskROI: PIplImage;                     // /* Must be NULL. */
    imageId: Pointer;                       // /* "           " */
    tileInfo: PIplTileInfo;                 // struct _IplTileInfo *tileInfo;  ///* "           " */
    imageSize: Integer;                     // * Image data size in bytes       // (==image->height*image->widthStep       // in case of interleaved data)*/
    imageData: Pointer;                     // * Pointer to aligned image data.         */
    widthStep: Integer;                     // * Size of aligned image row in bytes.    */
    BorderMode: array [0 .. 3] of Integer;  // [4];     ///* Ignored by OpenCV.                     */
    BorderConst: array [0 .. 3] of Integer; // [4];    ///* Ditto.                                 */
    imageDataOrigin: PAnsiChar;             // * Pointer to very origin of image data           // (not necessarily aligned) -                                                         // needed for correct deallocation */
  end;

  TCvPoint = record
    x: Integer;
    y: Integer;
  end;

  CvPoint2D32f = record
    x: float;
    y: float;
    class operator Subtract(a, b: CvPoint2D32f): CvPoint2D32f;
    function Norm: Single;
    function cvPoint: TCvPoint;
  end;

  CvMatDataUnion = record
    case Byte of
      0:
        (ptr: PByte);
      1:
        (s: PSmallInt);
      2:
        (i: PInteger);
      3:
        (fl: pSingle);
      4:
        (db: pDouble);
  end;

  CvMat = record
  public
    _type: Integer;
    step: Integer;
    refcount: PInteger;
    hdr_refcount: Integer;
    data: CvMatDataUnion;
    rows: Integer;
    cols: Integer;
  private
    function GetMatByte(const row, col: Integer): Byte; inline;
    function GetMatDouble(const row, col: Integer): Double; inline;
    function GetMatInteger(const row, col: Integer): Integer; inline;
    function GetMatSingle(const row, col: Integer): Single; inline;
    procedure SetMatByte(const row, col: Integer; const Value: Byte); inline;
    procedure SetMatDouble(const row, col: Integer; const Value: Double); inline;
    procedure SetMatInteger(const row, col, Value: Integer); inline;
    procedure SetMatSingle(const row, col: Integer; const Value: Single); inline;
  public
    function AsDouble: pDouble; inline;
    function AsInteger: PInteger; inline;
    function AsByte: PByte; inline;
    function AsSingle: pSingle; inline;
    property MatDouble[const row, col: Integer]: Double Read GetMatDouble write SetMatDouble;
    property MatSingle[const row, col: Integer]: Single Read GetMatSingle write SetMatSingle;
    property MatInteger[const row, col: Integer]: Integer Read GetMatInteger write SetMatInteger;
    property MatByte[const row, col: Integer]: Byte Read GetMatByte write SetMatByte;
  end;

  CvScalar = record
    val: array [0 .. 3] of Double;
    class operator LessThan(a, b: CvScalar): Boolean;
    class operator GreaterThan(a, b: CvScalar): Boolean;
  end;

  CvMemBlock = record
    prev: pCvMemBlock;
    next: pCvMemBlock;
  end;

  CvMemStorage = record
    signature: Integer;
    bottom: pCvMemBlock;
    top: pCvMemBlock; (* First allocated block. *)
    parent: pCvMemStorage;
    (* Current memory block - top of the stack. *)    (* We get new blocks from parent as needed. *)
    block_size: Integer;                              (* Block size. *)
    free_space: Integer;                              (* Remaining free space in current block. *)
  end;

  CvSeqBlock = record
    prev: pCvSeqBlock;    (* Previous sequence block. *)
    next: pCvSeqBlock;    (* Next sequence block. *)
    start_index: Integer; (* Index of the first element in the block + *)
    count: Integer;       (* Number of elements in the block. *)
    data: Pointer;        (* Pointer to the first element of the block. *)
  end;

  CvSeq = record
    flags: Integer;           (* Miscellaneous flags. *)
    header_size: Integer;     (* Size of sequence header. *)
    h_prev: pCvSeq;           (* Previous sequence. *)
    h_next: pCvSeq;           (* Next sequence. *)
    v_prev: pCvSeq;           (* 2nd previous sequence. *)
    v_next: pCvSeq;           (* 2nd next sequence. *)
    total: Integer;           (* Total number of elements. *)
    elem_size: Integer;       (* Size of sequence element in bytes. *)
    block_max: Pointer;       (* Maximal bound of the last block. *)
    ptr: pschar;              (* Current write pointer. *)
    delta_elems: Integer;     (* Grow seq this many at a time. *)
    storage: pCvMemStorage;   (* Where the seq is stored. *)
    free_blocks: pCvSeqBlock; (* Free blocks list. *)
    first: pCvSeqBlock;       (* Pointer to the first sequence block. *)
  end;

  CvSlice = record
    start_index, end_index: Integer;
  end;

  pCvAttrList = ^CvAttrList;

  CvAttrList = record
    attr: ppCVChar;
    (* NULL-terminated array of (attribute_name,attribute_value) pairs. *)
    next: pCvAttrList; (* Pointer to next chunk of the attributes list. *)
  end;

  CvRect = record
    x: Integer;
    y: Integer;
    width: Integer;
    height: Integer;
  end;

  CvSize2D32f = record
    width: Single;
    height: Single;
  end;

  CvBox2D = record
    center: CvPoint2D32f; (* Center of the box. *)
    size: CvSize2D32f;    (* Box width and length. *)
    angle: Single;        (* Angle between the horizontal axis *)
  end;

  TBoxPoints = array [0 .. 3] of CvPoint2D32f;

  CvMatNDdata = CvMatDataUnion;

  CvMatNDdim = record
    size: Integer;
    step: Integer;
  end;

  CvMatND = record
    _type: Integer;
    dims: Integer;
    refcount: ^Integer;
    hdr_refcount: Integer;
    data: CvMatNDdata;
    dim: array [0 .. CV_MAX_DIM - 1] of CvMatNDdim;
  end;

  CvHistogram = record
    _type: Integer;
    bins: PIplImage;
    thresh: array [0 .. CV_MAX_DIM - 1, 0 .. 1] of Single;
    (* For uniform histograms. *)
    thresh2: pSingle; (* For non-uniform histograms. *)
    mat: CvMatND;     (* Embedded matrix header for array histograms. *)
  end;

  CvSize = record
    width: Integer;
    height: Integer;
  end;

  TCvDistanceFunction = function(var a: Single; var b: Single; user_param: Pointer): Single; cdecl;

  CvTermCriteria = record
    cType: Integer;
    max_iter: Integer;
    epsilon: Double;
  end;

  CvPoint2D64f = record
    x: Double;
    y: Double;
  end;

  CvConnectedComp = record
    area: Double;
    Value: CvScalar;
    rect: CvRect;
    contour: ^CvSeq;
  end;

  CvSeqReader = record
    header_size: Integer;
    Seq: pCvSeq;          // * sequence, beign read */
    block: pCvSeqBlock;   // * current block */
    ptr: Pointer;         // * pointer to element be read next */
    block_min: Pointer;   // * pointer to the beginning of block */
    block_max: Pointer;   // * pointer to the end of block */
    delta_index: Integer; // * = seq->first->start_index   */
    prev_elem: Pointer;   // * pointer to previous element */
  end;

  CV_TREE_NODE_FIELDS<node_type> = record
    flags: Integer;       (* Miscellaneous flags. *)
    header_size: Integer; (* Size of sequence header. *)
    h_prev: ^node_type;   (* Previous sequence. *)
    h_next: ^node_type;   (* Next sequence. *)
    v_prev: ^node_type;   (* 2nd previous sequence. *)
    v_next: ^node_type;   (* 2nd next sequence. *)
  end;

  CV_SEQUENCE_FIELDS = record
    CV_TREE_NODE_FIELDS: CV_TREE_NODE_FIELDS<CvSeq>;
    total: Integer;           (* Total number of elements. *)
    elem_size: Integer;       (* Size of sequence element in bytes. *)
    block_max: pschar;        (* Maximal bound of the last block. *)
    ptr: pschar;              (* Current write pointer. *)
    delta_elems: Integer;     (* Grow seq this many at a time. *)
    storage: pCvMemStorage;   (* Where the seq is stored. *)
    free_blocks: pCvSeqBlock; (* Free blocks list. *)
    first: pCvSeqBlock;       (* Pointer to the first sequence block. *)
  end;

  pCvSetElem = ^TCvSetElem;

  TCvSetElem = record
    flags: Integer;
    next_free: pCvSetElem;
  end;

  CV_SET_FIELDS = record
    CV_SEQUENCE_FIELDS: CV_SEQUENCE_FIELDS;
    free_elems: pCvSetElem;
    active_count: Integer;
  end;

  TCvSet = record
    flags: Integer;           (* Miscellaneous flags. *)
    header_size: Integer;     (* Size of sequence header. *)
    h_prev: pCvSeq;           (* Previous sequence. *)
    h_next: pCvSeq;           (* Next sequence. *)
    v_prev: pCvSeq;           (* 2nd previous sequence. *)
    v_next: pCvSeq;           (* 2nd next sequence. *)
    total: Integer;           (* Total number of elements. *)
    elem_size: Integer;       (* Size of sequence element in bytes. *)
    block_max: Pointer;       (* Maximal bound of the last block. *)
    ptr: Pointer;             (* Current write pointer. *)
    delta_elems: Integer;     (* Grow seq this many at a time. *)
    storage: pCvMemStorage;   (* Where the seq is stored. *)
    free_blocks: pCvSeqBlock; (* Free blocks list. *)
    first: pCvSeqBlock;       (* Pointer to the first sequence block. *)
    free_elems: pCvSetElem;
    active_count: Integer;
  end;

  CV_GRAPH_FIELDS = record
    CV_SET_FIELDS: CV_SET_FIELDS;
    edges: pCvSet;
  end;

  CvGraph = record
    CV_GRAPH_FIELDS: CV_GRAPH_FIELDS;
    edges: pCvSet;
  end;

  CvSparseMat = record
    cType: Integer;
    dims: Integer;
    refcount: ^Integer;
    hdr_refcount: Integer;
    heap: pCvSet;
    hashtable: ^Pointer;
    hashsize: Integer;
    valoffset: Integer;
    idxoffset: Integer;
    size: array [0 .. CV_MAX_DIM - 1] of Integer;
  end;

  CvCapture = record
  end;

  CV_GRAPH_EDGE_FIELDS = record
    flags: Integer;
    weight: Single;
    next: array [0 .. 1] of pCvGraphEdge;
    vtx: array [0 .. 1] of pCvGraphVtx;
  end;

  CvGraphEdge = record
    CV_GRAPH_EDGE_FIELDS: CV_GRAPH_EDGE_FIELDS;
  end;

  CV_GRAPH_VERTEX_FIELDS = record
    flags: Integer;
    first: pCvGraphEdge;
  end;

  CvGraphVtx = record
    CV_GRAPH_VERTEX_FIELDS: CV_GRAPH_VERTEX_FIELDS;
  end;

  CvGraphScanner = record
    vtx: pCvGraphVtx;   (* current graph vertex (or current edge origin) *)
    dst: pCvGraphVtx;   (* current graph edge destination vertex *)
    edge: pCvGraphEdge; (* current edge *)
    graph: pCvGraph;    (* the graph *)
    stack: pCvSeq;      (* the graph vertex stack *)
    index: Integer;     (* the lower bound of certainly visited vertices *)
    mask: Integer;      (* event mask *)
  end;

  CvKalman = record
    MP: Integer; (* number of measurement vector dimensions *)
    DP: Integer; (* number of state vector dimensions *)
    CP: Integer; (* number of control vector dimensions *)

    (* backward compatibility fields *)
    // {$IFDEF 1}
    PosterState: pSingle;           (* =state_pre->data.fl *)
    PriorState: pSingle;            (* =state_post->data.fl *)
    DynamMatr: pSingle;             (* =transition_matrix->data.fl *)
    MeasurementMatr: pSingle;       (* =measurement_matrix->data.fl *)
    MNCovariance: pSingle;          (* =measurement_noise_cov->data.fl *)
    PNCovariance: pSingle;          (* =process_noise_cov->data.fl *)
    KalmGainMatr: pSingle;          (* =gain->data.fl *)
    PriorErrorCovariance: pSingle;  (* =error_cov_pre->data.fl *)
    PosterErrorCovariance: pSingle; (* =error_cov_post->data.fl *)
    _Temp1: pSingle;                (* temp1->data.fl *)
    _Temp2: pSingle;                (* temp2->data.fl *)
    // {$ENDIF}
    state_pre: PCvMat; (* predicted state (x'(k)):
      x(k)=A*x(k-1)+B*u(k) *)
    state_post: PCvMat; (* corrected state (x(k)):
      x(k)=x'(k)+K(k)*(z(k)-H*x'(k)) *)
    transition_matrix: PCvMat; (* state transition matrix (A) *)
    control_matrix: PCvMat; (* control matrix (B)
      (it is not used if there is no control) *)
    measurement_matrix: PCvMat;    (* measurement matrix (H) *)
    process_noise_cov: PCvMat;     (* process noise covariance matrix (Q) *)
    measurement_noise_cov: PCvMat; (* measurement noise covariance matrix (R) *)
    error_cov_pre: PCvMat; (* priori error estimate covariance matrix (P'(k)):
      P'(k)=A*P(k-1)*At + Q) *)
    gain: PCvMat; (* Kalman gain matrix (K(k)):
      K(k)=P'(k)*Ht*inv(H*P'(k)*Ht+R) *)
    error_cov_post: PCvMat; (* posteriori error estimate covariance matrix (P(k)):
      P(k)=(I-K(k)*H)*P'(k) *)
    Temp1: PCvMat; (* temporary matrices *)
    Temp2: PCvMat;
    temp3: PCvMat;
    temp4: PCvMat;
    temp5: PCvMat;
  end;

  CvPoint3D32f = record
    x: Single;
    y: Single;
    z: Single;
  end;

  CvPoint3D64f = record
    x: Double;
    y: Double;
    z: Double;
  end;

  CvPOSITObject = record
    N: Integer;
    inv_matr: pSingle;
    obj_vecs: pSingle;
    img_vecs: pSingle;
  end;

  CvSeqWriter = record
    header_size: Integer;
    Seq: pCvSeq;        // * the sequence written */
    block: pCvSeqBlock; // * current block */
    ptr: Pointer;       // * pointer to free space */
    block_min: Pointer; // * pointer to the beginning of block*/
    block_max: Pointer; // * pointer to the end of block */
  end;

  CvStereoBMState = record
    // pre-filtering (normalization of input images)
    preFilterType: Integer; // =CV_STEREO_BM_NORMALIZED_RESPONSE now
    preFilterSize: Integer; // averaging window size: ~5x5..21x21
    preFilterCap: Integer;  // the output of pre-filtering is clipped by [-preFilterCap,preFilterCap]

    // correspondence using Sum of Absolute Difference (SAD)
    SADWindowSize: Integer;       // ~5x5..21x21
    minDisparity: Integer;        // minimum disparity (can be negative)
    numberOfDisparities: Integer; // maximum disparity - minimum disparity (> 0)

    // post-filtering
    textureThreshold: Integer; // the disparity is only computed for pixels
    // with textured enough neighborhood
    uniquenessRatio: Integer; // accept the computed disparity d* only if
    // SAD(d) >= SAD(d*)*(1 + uniquenessRatio/100.)
    // for any d != d*+/-1 within the search range.
    speckleWindowSize: Integer; // disparity variation window
    speckleRange: Integer;      // acceptable range of variation in window

    trySmallerWindows: Integer; // if 1, the results may be more accurate,
    // at the expense of slower processing
    roi1, roi2: CvRect;
    disp12MaxDiff: Integer;

    // temporary buffers
    preFilteredImg0: PCvMat;
    preFilteredImg1: PCvMat;
    slidingSumBuf: PCvMat;
    cost: PCvMat;
    disp: PCvMat;
  end;

  IplConvKernel = record
    nCols: Integer;
    nRows: Integer;
    anchorX: Integer;
    anchorY: Integer;
    values: ^Integer;
    nShiftR: Integer;
  end;

  IplConvKernelFP = record
    nCols: Integer;
    nRows: Integer;
    anchorX: Integer;
    anchorY: Integer;
    values: ^Single;
  end;

  CvTrackbarCallback  = procedure(pos: Integer); cdecl;
  CvTrackbarCallback2 = procedure(pos: Integer; userdata: Pointer); cdecl;

  { 函数定义 }
  Tcv2DRotationMatrix                = function(center: CvPoint2D32f; angle: Double; scale: Double; map_matrix: PCvMat): PCvMat; cdecl;
  TcvAbsDiff                         = procedure(const src1: pCvArr; const src2: pCvArr; dst: pCvArr); cdecl;
  TcvAbsDiffS                        = procedure(const src: pCvArr; dst: pCvArr; Value: CvScalar); cdecl;
  TcvAcc                             = procedure(const image: pCvArr; sum: pCvArr; const mask: pCvArr = nil); cdecl;
  TcvAdaptiveThreshold               = procedure(const src: pCvArr; dst: pCvArr; max_value: Double; adaptive_method: Integer = CV_ADAPTIVE_THRESH_MEAN_C; threshold_type: Integer = CV_THRESH_BINARY; block_size: Integer = 3; param1: Double = 5); cdecl;
  TcvAdd                             = procedure(const src1, src2: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl;
  TcvAddS                            = procedure(const src: pCvArr; Value: CvScalar; dst: pCvArr; const mask: pCvArr = nil); cdecl;
  TcvAddWeighted                     = procedure(const src1: pCvArr; alpha: Double; const src2: pCvArr; beta: Double; gamma: Double; dst: pCvArr); cdecl;
  TcvAlloc                           = function(size: size_t): Pointer; cdecl;
  TcvAnd                             = procedure(const src1: pCvArr; const src2: pCvArr; dst: pCvArr; masl: pCvArr = nil); cdecl;
  TcvAndS                            = procedure(const src: pCvArr; Value: CvScalar; dst: pCvArr; const mask: pCvArr = nil); cdecl;
  TcvApproxChains                    = function(src_seq: pCvSeq; storage: pCvMemStorage; method: Integer = CV_CHAIN_APPROX_SIMPLE; parameter: Double = 0; minimal_perimeter: Integer = 0; recursive: Integer = 0): pCvSeq; cdecl;
  TcvApproxPoly                      = function(const src_seq: pCvSeq; header_size: Integer; storage: pCvMemStorage; method: Integer; eps: Double; recursive: Integer = 0): pCvSeq; cdecl;
  TcvArcLength                       = function(const curve: Pointer; slice: CvSlice; is_closed: Integer): Double; cdecl;
  TcvAttrValue                       = function(const attr: pCvAttrList; const attr_name: pCVChar): pCVChar; cdecl;
  TcvAvg                             = function(const arr: pCvArr; const mask: pCvArr = nil): CvScalar; cdecl;
  TcvAvgSdv                          = procedure(const arr: pCvArr; mean: pCvScalar; std_dev: pCvScalar; const mask: pCvArr = nil); cdecl;
  TcvBackProjectPCA                  = procedure(const proj: pCvArr; const mean: pCvArr; const eigenvects: pCvArr; result: pCvArr); cdecl;
  TcvBoundingRect                    = function(points: pCvArr; update: Integer = 0): CvRect; cdecl;
  TcvBoxPoints                       = procedure(box: CvBox2D; pt: TBoxPoints); cdecl;
  TcvCalcArrBackProject              = procedure(var image: pCvArr; dst: pCvArr; const hist: pCvHistogram); cdecl;
  TcvCalcArrBackProjectPatch         = procedure(var image: pCvArr; dst: pCvArr; range: CvSize; hist: pCvHistogram; method: Integer; factor: Double); cdecl;
  TcvCalcArrHist                     = procedure(var arr: pCvArr; hist: pCvHistogram; accumulate: Integer = 0; const mask: pCvArr = nil); cdecl;
  TcvCalcBayesianProb                = procedure(Var src: pCvHistogram; number: Integer; Var dst: pCvHistogram); cdecl;
  TcvCalcCovarMatrix                 = procedure(const vects: pCvArrArray; count: Integer; cov_mat: pCvArr; avg: pCvArr; flags: Integer); cdecl;
  TcvCalcEMD2                        = function(const signature1: pCvArr; const signature2: pCvArr; distance_type: Integer; distance_func: TCvDistanceFunction = nil; const cost_matrix: pCvArr = nil; flow: pCvArr = nil; lower_bound: pfloat = nil; userdata: Pointer = nil): float; cdecl;
  TcvCalcMatMulDeriv                 = procedure(const a: PCvMat; const b: PCvMat; dABdA: PCvMat; dABdB: PCvMat); cdecl;
  TcvCalcOpticalFlowFarneback        = procedure(const prev: PCvMat; const next: PCvMat; flow: PCvMat; pyr_scale: Double; levels: Integer; winsize: Integer; iterations: Integer; poly_n: Integer; poly_sigma: Double; flags: Integer); cdecl;
  TcvCalcOpticalFlowPyrLK            = procedure(const prev: PIplImage; const curr: PIplImage; prev_pyr: PIplImage; curr_pyr: PIplImage; const prev_features: pCvPoint2D32f; curr_features: pCvPoint2D32f; count: Integer; win_size: CvSize; level: Integer; status: pCVChar; track_error: pSingle; criteria: CvTermCriteria; flags: Integer); cdecl;
  TcvCalcPCA                         = procedure(const data: pCvArr; mean: pCvArr; eigenvals: pCvArr; eigenvects: pCvArr; flags: Integer); cdecl;
  TcvCalcProbDensity                 = procedure(const hist1: pCvHistogram; const hist2: pCvHistogram; dst_hist: pCvHistogram; scale: Double = 255); cdecl;
  TcvCalibrateCamera2                = function(const object_points: PCvMat; const image_points: PCvMat; const point_counts: PCvMat; image_size: CvSize; camera_matrix: PCvMat; distortion_coeffs: PCvMat; rotation_vectors: PCvMat; translation_vectors: PCvMat; flags: Integer; term_crit: CvTermCriteria): Double; cdecl;
  TcvCalibrationMatrixValues         = procedure(const camera_matrix: PCvMat; image_size: CvSize; aperture_width: Double = 0; aperture_height: Double = 0; fovx: pDouble = nil; fovy: pDouble = nil; focal_length: pDouble = nil; principal_point: pCvPoint2D64f = nil; pixel_aspect_ratio: pDouble = nil); cdecl;
  TcvCamShift                        = function(const prob_image: PIplImage; window: CvRect; criteria: CvTermCriteria; comp: pCvConnectedComp; box: pCvBox2D = nil): Integer; cdecl;
  TcvCanny                           = procedure(const image: pCvArr; edges: pCvArr; threshold1: Double; threshold2: Double; aperture_size: Integer = 3); cdecl;
  TcvCartToPolar                     = procedure(const x: pCvArr; const y: pCvArr; magnitude: pCvArr; angle: pCvArr = nil; angle_in_degrees: Integer = 0); cdecl;
  TcvCbrt                            = function(Value: float): float; cdecl;
  TcvChangeSeqBlock                  = procedure(reader: pCvSeqReader; direction: Integer); cdecl;
  TcvCheckArr                        = function(const arr: pCvArr; flags: Integer = 0; min_val: Double = 0; max_val: Double = 0): Integer; cdecl;
  TcvCheckChessboard                 = function(const image: pCvArr; size: CvSize): Integer; cdecl;
  TcvCheckContourConvexity           = function(const contour: pCvSeq): Integer; cdecl;
  TcvCheckHardwareSupport            = function(feature: Integer): Integer; cdecl;
  TcvCheckTermCriteria               = function(criteria: CvTermCriteria; default_eps: Double; default_max_iters: Integer): CvTermCriteria; cdecl;
  TcvCircle                          = procedure(img: pCvArr; center: TCvPoint; radius: Integer; color: CvScalar; thickness: Integer = 1; line_type: Integer = 8; shift: Integer = 0); cdecl;
  TcvClearGraph                      = procedure(graph: pCvGraph); cdecl;
  TcvClearHist                       = procedure(hist: pCvHistogram); cdecl;
  TcvClearMemStorage                 = procedure(storage: pCvMemStorage); cdecl;
  TcvClearND                         = procedure(arr: pCvArr; idx: PInteger); cdecl;
  TcvClearSeq                        = procedure(Seq: pCvSeq); cdecl;
  TcvClearSet                        = procedure(set_header: pCvSet); cdecl;
  TcvClipLine                        = function(img_size: CvSize; pt1: pCvPoint; pt2: pCvPoint): Integer; cdecl;
  TcvClone                           = function(const struct_ptr: Pointer): Pointer; cdecl;
  TcvCloneGraph                      = function(const graph: pCvGraph; storage: pCvMemStorage): pCvGraph; cdecl;
  TcvCloneImage                      = function(const image: PIplImage): PIplImage; cdecl;
  TcvCloneMat                        = function(const mat: PCvMat): PCvMat; cdecl;
  TcvCloneMatND                      = function(const mat: pCvMatND): pCvMatND; cdecl;
  TcvCloneSparseMat                  = function(const mat: pCvSparseMat): pCvSparseMat; cdecl;
  TcvCmp                             = procedure(const src1, src2: pCvArr; dst: pCvArr; cmp_op: Integer); cdecl;
  TcvCmpS                            = procedure(const src: pCvArr; Value: Double; dst: pCvArr; cmp_op: Integer); cdecl;
  TcvColorToScalar                   = function(packed_color: Double; arrtype: Integer): CvScalar; cdecl;
  TcvCompareHist                     = function(hist1: pCvHistogram; hist2: pCvHistogram; method: Integer): Double; cdecl;
  TcvCompleteSymm                    = procedure(matrix: PCvMat; LtoR: Integer = 0); cdecl;
  TcvComposeRT                       = procedure(const _rvec1: PCvMat; const _tvec1: PCvMat; const _rvec2: PCvMat; const _tvec2: PCvMat; _rvec3: PCvMat; _tvec3: PCvMat; dr3dr1: PCvMat = nil; dr3dt1: PCvMat = nil; dr3dr2: PCvMat = nil; dr3dt2: PCvMat = nil; dt3dr1: PCvMat = nil; dt3dt1: PCvMat = nil; dt3dr2: PCvMat = nil; dt3dt2: PCvMat = nil); cdecl;
  TcvComputeCorrespondEpilines       = procedure(const points: PCvMat; which_image: Integer; const fundamental_matrix: PCvMat; correspondent_lines: PCvMat); cdecl;
  TcvContourArea                     = function(const contour: pCvArr; slice: CvSlice; oriented: Integer = 0): Double; cdecl;
  TcvConvertImage                    = procedure(const src: pCvArr; dst: pCvArr; flags: Integer = 0); cdecl;
  TcvConvertMaps                     = procedure(const mapx: pCvArr; const mapy: pCvArr; mapxy: pCvArr; mapalpha: pCvArr); cdecl;
  TcvConvertPointsHomogeneous        = procedure(const src: PCvMat; dst: PCvMat); cdecl;
  TcvConvertScale                    = procedure(const src: pCvArr; dst: pCvArr; scale: Double = 1; shift: Double = 0); cdecl;
  TcvConvertScaleAbs                 = procedure(const src: pCvArr; dst: pCvArr; scale: Double = 1; shift: Double = 0); cdecl;
  TcvConvexHull2                     = function(const input: pCvSeq; hull_storage: Pointer = nil; orientation: Integer = CV_CLOCKWISE; return_points: Integer = 0): pCvSeq; cdecl;
  TcvConvexityDefects                = function(contour: pCvSeq; convexhull: pCvSeq; storage: pCvMemStorage = nil): pCvSeq; cdecl;
  TcvCopy                            = procedure(const src: pCvArr; dst: pCvArr; const mask: pCvArr = nil); cdecl;
  TcvCopyHist                        = procedure(const src: pCvHistogram; Var dst: pCvHistogram); cdecl;
  TcvCopyMakeBorder                  = procedure(const src: pCvArr; dst: pCvArr; offset: TCvPoint; bordertype: Integer; Value: CvScalar); cdecl;
  TcvCornerEigenValsAndVecs          = procedure(const image: pCvArr; eigenvv: pCvArr; block_size: Integer; aperture_size: Integer = 3); cdecl;
  TcvCornerHarris                    = procedure(const image: pCvArr; harris_response: pCvArr; block_size: Integer; aperture_size: Integer = 3; k: Double = 0.04); cdecl;
  TcvCornerMinEigenVal               = procedure(const image: pCvArr; eigenval: pCvArr; block_size: Integer; aperture_size: Integer = 3); cdecl;
  TcvCorrectMatches                  = procedure(F: PCvMat; points1: PCvMat; points2: PCvMat; new_points1: PCvMat; new_points2: PCvMat); cdecl;
  TcvCountNonZero                    = function(arr: pCvArr): Integer; cdecl;
  TcvCreateCameraCapture             = function(index: Longint): pCvCapture; cdecl;
  TcvCreateChildMemStorage           = function(parent: pCvMemStorage): pCvMemStorage; cdecl;
  TcvCreateData                      = procedure(arr: pCvArr); cdecl;
  TcvCreateFileCapture               = function(const filename: pCVChar): pCvCapture; cdecl;
  TcvCreateFileCaptureWithPreference = function(const filename: pCVChar; apiPreference: Integer): pCvCapture; cdecl;
  TcvCreateGraph                     = function(graph_flags: Integer; header_size: Integer; vtx_size: Integer; edge_size: Integer; storage: pCvMemStorage): pCvGraph; cdecl;
  TcvCreateGraphScanner              = function(graph: pCvGraph; vtx: pCvGraphVtx = nil; mask: Integer = CV_GRAPH_ALL_ITEMS): pCvGraphScanner; cdecl;
  TcvCreateHist                      = function(dims: Integer; sizes: PInteger; _type: Integer; ranges: Pointer = nil; uniform: Integer = 1): pCvHistogram; cdecl;
  TcvCreateImage                     = function(size: CvSize; depth, channels: Integer): PIplImage; cdecl;
  TcvCreateImageHeader               = function(size: CvSize; depth: Integer; channels: Integer): PIplImage; cdecl;
  TcvCreateKalman                    = function(dynam_params: Integer; measure_params: Integer; control_params: Integer = 0): pCvKalman; cdecl;
  TcvCreateMat                       = function(rows, cols, cType: Integer): PCvMat; cdecl;
  TcvCreateMatHeader                 = function(rows: Integer; cols: Integer; cType: Integer): PCvMat; cdecl;
  TcvCreateMatND                     = function(dims: Integer; const sizes: PInteger; cType: Integer): pCvMatND; cdecl;
  TcvCreateMatNDHeader               = function(dims: Integer; const sizes: PInteger; cType: Integer): pCvMatND; cdecl;
  TcvCreateMemStorage                = function(block_size: Integer = 0): pCvMemStorage; cdecl;
  TcvCreatePOSITObject               = function(points: pCvPoint3D32f; point_count: Integer): PCvPOSITObject; cdecl;
  TcvCreatePyramid                   = function(const img: pCvArr; extra_layers: Integer; rate: Double; const layer_sizes: pCvSize = nil; bufarr: pCvArr = nil; calc: Integer = 1; filter: Integer = CV_GAUSSIAN_5x5): ppCvMat; cdecl;
  TcvCreateSeq                       = function(seq_flags: Integer; header_size: NativeUInt; elem_size: NativeUInt; storage: pCvMemStorage): pCvSeq; cdecl;
  TcvCreateSeqBlock                  = procedure(writer: pCvSeqWriter); cdecl;
  TcvCreateSet                       = function(set_flags: Integer; header_size: Integer; elem_size: Integer; storage: pCvMemStorage): pCvSet; cdecl;
  TcvCreateSparseMat                 = function(dims: Integer; sizes: PInteger; cType: Integer): pCvSparseMat; cdecl;
  TcvCreateStereoBMState             = function(preset: Integer = CV_STEREO_BM_BASIC; numberOfDisparities: Integer = 0): pCvStereoBMState; cdecl;
  TcvCreateStructuringElementEx      = function(cols: Integer; rows: Integer; anchor_x: Integer; anchor_y: Integer; shape: Integer; values: PInteger = nil): pIplConvKernel; cdecl;
  TcvCreateTrackbar                  = function(const trackbar_name: pCVChar; const window_name: pCVChar; Value: PInteger; count: Integer; on_change: CvTrackbarCallback): Integer; cdecl;
  TcvCreateTrackbar2                 = function(const trackbar_name: pCVChar; const window_name: pCVChar; Value: PInteger; count: Integer; on_change: CvTrackbarCallback2; userdata: Pointer = nil): Integer; cdecl;
  TcvCreateVideoWriter               = function(const filename: pCVChar; fourcc: Integer; fps: Double; frame_size: CvSize; is_color: Integer = 1): pCvVideoWriter; cdecl;
  TcvCrossProduct                    = procedure(const src1: pCvArr; const src2: pCvArr; dst: pCvArr); cdecl;
  TcvCvtColor                        = procedure(const src: pCvArr; dst: pCvArr; code: Integer); cdecl;
  TcvCvtSeqToArray                   = procedure(const Seq: pCvSeq; elements: pCvArr; slice: CvSlice); cdecl;
  TcvDCT                             = procedure(const src: pCvArr; dst: pCvArr; flags: Integer); cdecl;
  TcvDFT                             = procedure(const src: pCvArr; dst: pCvArr; flags: Integer; nonzero_rows: Integer = 0); cdecl;
  TcvDecodeImage                     = function(const buf: PCvMat; iscolor: TCvLoadImageIsColor = CV_LOAD_IMAGE_COLOR): PIplImage; cdecl;
  TcvDecodeImageM                    = function(const buf: PCvMat; iscolor: TCvLoadImageIsColor = CV_LOAD_IMAGE_COLOR): PCvMat; cdecl;
  TcvDecomposeProjectionMatrix       = procedure(const projMatr: PCvMat; calibMatr: PCvMat; rotMatr: PCvMat; posVect: PCvMat; rotMatrX: PCvMat = nil; rotMatrY: PCvMat = nil; rotMatrZ: PCvMat = nil; eulerAngles: pCvPoint3D64f = nil); cdecl;

  TcvLoadImage           = function(const strFileName: PChar; const iscolor: TCvLoadImageIsColor = CV_LOAD_IMAGE_COLOR): PIplImage; cdecl;
  TcvNamedWindow         = function(const strTitle: PChar; flags: Integer): Integer; cdecl;
  TcvShowImage           = procedure(name: PChar; image: Pointer); cdecl;
  TcvWaitKey             = function(const delay: Integer = 0): Integer; cdecl;
  TcvReleaseImage        = procedure(var image: PIplImage); cdecl;
  TcvDestroyWindow       = procedure(const name: PChar); cdecl;
  TcvgetBuildInformation = function: TcvString;

implementation

function CV_MAT_ELEM_PTR_FAST(const mat: CvMat; const row, col, pix_size: Integer): Pointer; inline;
begin
  Assert((row < mat.rows) and (col < mat.cols) and (row >= 0) and (col >= 0));
  result := Pointer(Integer(mat.data.ptr) + mat.step * row + pix_size * col);
end;

function CV_MAT_ELEM(const mat: CvMat; const elemsize: Integer; const row, col: Integer): Pointer; inline;
begin
  result := CV_MAT_ELEM_PTR_FAST(mat, row, col, elemsize);
end;

{ CvPoint2D32f }

function CvPoint2D32f.cvPoint: TCvPoint;
begin
  result.x := Trunc(x);
  result.y := Trunc(y);
end;

function CvPoint2D32f.Norm: Single;
begin
  result := sqrt(x * x + y * y);
end;

class operator CvPoint2D32f.Subtract(a, b: CvPoint2D32f): CvPoint2D32f;
begin
  result.x := a.x - b.x;
  result.y := a.y - b.y;
end;

{ CvMat }

function CvMat.AsByte: PByte;
begin
  result := data.ptr;
end;

function CvMat.AsDouble: pDouble;
begin
  result := data.db;
end;

function CvMat.AsInteger: PInteger;
begin
  result := data.i;
end;

function CvMat.AsSingle: pSingle;
begin
  result := data.fl;
end;

function CvMat.GetMatByte(const row, col: Integer): Byte;
begin
  result := PByte(CV_MAT_ELEM(Self, SizeOf(Byte), row, col))^;
end;

function CvMat.GetMatDouble(const row, col: Integer): Double;
begin
  result := pDouble(CV_MAT_ELEM(Self, SizeOf(Double), row, col))^;
end;

function CvMat.GetMatInteger(const row, col: Integer): Integer;
begin
  result := PInteger(CV_MAT_ELEM(Self, SizeOf(Integer), row, col))^;
end;

function CvMat.GetMatSingle(const row, col: Integer): Single;
begin
  result := pSingle(CV_MAT_ELEM(Self, SizeOf(Single), row, col))^;
end;

procedure CvMat.SetMatByte(const row, col: Integer; const Value: Byte);
begin
  PByte(CV_MAT_ELEM(Self, SizeOf(Byte), row, col))^ := Value;
end;

procedure CvMat.SetMatDouble(const row, col: Integer; const Value: Double);
begin
  pDouble(CV_MAT_ELEM(Self, SizeOf(Double), row, col))^ := Value;
end;

procedure CvMat.SetMatInteger(const row, col, Value: Integer);
begin
  PInteger(CV_MAT_ELEM(Self, SizeOf(Integer), row, col))^ := Value;
end;

procedure CvMat.SetMatSingle(const row, col: Integer; const Value: Single);
begin
  pSingle(CV_MAT_ELEM(Self, SizeOf(Single), row, col))^ := Value;
end;

{ CvScalar }

class operator CvScalar.GreaterThan(a, b: CvScalar): Boolean;
begin
  result := (a.val[0] > b.val[0]) and (a.val[1] > b.val[1]) and (a.val[2] > b.val[2]) and (a.val[3] >= b.val[3]);
end;

class operator CvScalar.LessThan(a, b: CvScalar): Boolean;
begin
  result := (a.val[0] < b.val[0]) and (a.val[1] < b.val[1]) and (a.val[2] < b.val[2]) and (a.val[3] <= b.val[3]);
end;

end.
