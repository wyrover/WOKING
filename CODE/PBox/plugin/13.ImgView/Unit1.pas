unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Menus, Vcl.Imaging.jpeg, Vcl.Imaging.GIFImg, Vcl.Imaging.pngimage, Vcl.ExtDlgs;

type
  TImage = class(Vcl.ExtCtrls.TImage)
  protected
    procedure WMMOUSEWHEEL(var msg: TWMMouseWheel); message WM_MOUSEWHEEL;
  end;

type
  TfrmImageView = class(TForm)
    scrlbx1: TScrollBox;
    imgView: TImage;
    mmImage: TMainMenu;
    mniFile: TMenuItem;
    mniFileOpen: TMenuItem;
    dlgOpenPic1: TOpenPictureDialog;
    mniSize: TMenuItem;
    mniSizeActual: TMenuItem;
    mniSizeStretch: TMenuItem;
    procedure mniFileOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure scrlbx1MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure mniSizeActualClick(Sender: TObject);
    procedure mniSizeStretchClick(Sender: TObject);
  private
    { Private declarations }
    FbAutoSize: Boolean;
    procedure CenterStretchShowImage;
    procedure CenterActualSizeShowImage;
  public
    { Public declarations }
  end;

procedure ShowDllForm(var strTitle: PChar; var frm: TFormClass); stdcall;

implementation

{$R *.dfm}

procedure ShowDllForm(var strTitle: PChar; var frm: TFormClass); stdcall;
begin
  strTitle := '图片查看器';
  frm      := TfrmImageView;
end;

procedure TfrmImageView.FormCreate(Sender: TObject);
begin
  FbAutoSize             := True;
  mniSizeActual.Checked  := FbAutoSize;
  mniSizeStretch.Checked := not FbAutoSize;
end;

procedure TfrmImageView.CenterActualSizeShowImage;
begin
  if (imgView.Picture.Bitmap.Width >= scrlbx1.Width) and (imgView.Picture.Bitmap.Height >= scrlbx1.Height) then
  begin
    imgView.Left := 0;
    imgView.Top  := 0;
  end
  else if (imgView.Picture.Bitmap.Width < scrlbx1.Width) and (imgView.Picture.Bitmap.Height > scrlbx1.Height) then
  begin
    imgView.Left := (scrlbx1.Width - imgView.Width) div 2;
    imgView.Top  := 0;
  end
  else if (imgView.Picture.Bitmap.Width > scrlbx1.Width) and (imgView.Picture.Bitmap.Height < scrlbx1.Height) then
  begin
    imgView.Left := 0;
    imgView.Top  := (scrlbx1.Height - imgView.Height) div 2;
  end
  else if (imgView.Picture.Bitmap.Width < scrlbx1.Width) and (imgView.Picture.Bitmap.Height < scrlbx1.Height) then
  begin
    imgView.Left := (scrlbx1.Width - imgView.Width) div 2;
    imgView.Top  := (scrlbx1.Height - imgView.Height) div 2;
  end;
end;

procedure TfrmImageView.CenterStretchShowImage;
begin
  imgView.Height := scrlbx1.Height - 8;
  imgView.Width  := scrlbx1.Width - 8;
  imgView.Top    := 0;
  imgView.Left   := (scrlbx1.Width - imgView.Width) div 2;
end;

procedure TfrmImageView.FormResize(Sender: TObject);
begin
  if not FbAutoSize then
  begin
    CenterStretchShowImage;
  end;
end;

procedure TfrmImageView.mniFileOpenClick(Sender: TObject);
var
  pic: TPicture;
  bmp: TBitmap;
begin
  if not dlgOpenPic1.Execute then
    Exit;

  pic := TPicture.Create;
  bmp := TBitmap.Create;
  try
    pic.LoadFromFile(dlgOpenPic1.FileName);
    bmp.PixelFormat := pf32bit;
    bmp.Height      := pic.Height;
    bmp.Width       := pic.Width;
    bmp.Canvas.Draw(0, 0, pic.Graphic);
    imgView.AutoSize := FbAutoSize;
    imgView.Stretch  := not FbAutoSize;
    imgView.Picture.Bitmap.Assign(bmp);
    scrlbx1.HorzScrollBar.Position := 0;
    scrlbx1.VertScrollBar.Position := 0;
    if FbAutoSize then
      CenterActualSizeShowImage
    else
      CenterStretchShowImage;
  finally
    bmp.Free;
    pic.Free;
  end;
end;

procedure TfrmImageView.mniSizeActualClick(Sender: TObject);
begin
  FbAutoSize             := True;
  imgView.AutoSize       := FbAutoSize;
  imgView.Stretch        := not FbAutoSize;
  mniSizeActual.Checked  := FbAutoSize;
  mniSizeStretch.Checked := not FbAutoSize;
  CenterActualSizeShowImage;
end;

procedure TfrmImageView.mniSizeStretchClick(Sender: TObject);
begin
  FbAutoSize             := False;
  imgView.AutoSize       := FbAutoSize;
  imgView.Stretch        := not FbAutoSize;
  mniSizeActual.Checked  := FbAutoSize;
  mniSizeStretch.Checked := not FbAutoSize;
  CenterStretchShowImage;
end;

procedure TfrmImageView.scrlbx1MouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if WheelDelta < 0 then
    SendMessage(scrlbx1.Handle, WM_VSCROLL, SB_LINEDOWN, 0)
  else
    SendMessage(scrlbx1.Handle, WM_VSCROLL, SB_LINEUP, 0);
end;

{ TImage }

procedure TImage.WMMOUSEWHEEL(var msg: TWMMouseWheel);
begin
  { 将滚轮消息通知给父控件 Scrolbox 的滚轮事件 }
  PostMessage(TScrollBox(Parent).Handle, CM_MOUSEWHEEL, msg.WheelDelta, 0);
end;

end.
