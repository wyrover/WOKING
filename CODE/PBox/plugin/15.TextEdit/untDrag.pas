unit untDrag;

interface

//用来告诉Windows你的Form可以接受文件拖放
{$EXTERNALSYM DragAcceptFiles}procedure DragAcceptFiles(hWnd: Cardinal; fAccept: Boolean); stdcall;
//得到拖放文件名和文件个数的API
{$EXTERNALSYM DragQueryFile}
function DragQueryFile(hDrop: Cardinal; iFile: Cardinal; lpszFile: PChar; cch: Integer): Integer; stdcall;

{$EXTERNALSYM DragFinish}//释放Windows分配给拖放操作的内存
procedure DragFinish(hDrop: Cardinal); stdcall;
function GetDragFileCount(hDrop: Cardinal): Integer; //得到拖放的文件个数
function GetDragFileName(hDrop: Cardinal; FileIndex: Integer = 1): string;//得到拖放的文件名，通过FileIndex来指定文件编号，默认为第一个文件

implementation

const shell32 ='shell32.dll';

procedure DragAcceptFiles; external Shell32;
function DragQueryFile; external Shell32;
procedure DragFinish; external Shell32;

function GetDragFileCount(hDrop: Cardinal): Integer;
const
  DragFileCount               = High(Cardinal);
begin
  Result := DragQueryFile(hDrop, DragFileCount, nil, 0);
end;

function GetDragFileName(hDrop: Cardinal; FileIndex: Integer = 1): string;
const
  Size                        = 255;
var
  Len                         : Integer;
  FileName                    : string;
begin
  SetLength(FileName, Size);
  Len := DragQueryFile(hDrop, FileIndex - 1, PChar(FileName), Size);
  SetLength(FileName, Len);
  Result := FileName;
end;

end.

