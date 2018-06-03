unit untOpenCVType;

interface

const
  c_strOpenCVDll     = 'opencv_world341.dll';
  CV_WINDOW_AUTOSIZE = 1;

type
  PChar = PAnsiChar;

  PDllFuncInfo = ^TDllFuncInfo;

  TDllFuncInfo = record
    strFunctionName: ShortString;
    intEntryAddress: Pointer;
  end;

type
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
    colorModel: array [0 .. 3] of ansichar; // [4];     ///* Ignored by OpenCV */
    channelSeq: array [0 .. 3] of ansichar; // * ditto */
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

implementation

end.
