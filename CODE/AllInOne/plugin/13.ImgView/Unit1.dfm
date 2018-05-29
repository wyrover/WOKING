object frmImageView: TfrmImageView
  Left = 0
  Top = 0
  Caption = 'frmImageView'
  ClientHeight = 510
  ClientWidth = 741
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmImage
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  DesignSize = (
    741
    510)
  PixelsPerInch = 96
  TextHeight = 13
  object scrlbx1: TScrollBox
    Left = 8
    Top = 8
    Width = 725
    Height = 494
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clWhite
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 0
    OnDblClick = mniFileOpenClick
    OnMouseWheel = scrlbx1MouseWheel
    object imgView: TImage
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      OnDblClick = mniFileOpenClick
    end
  end
  object mmImage: TMainMenu
    AutoHotkeys = maManual
    Left = 364
    Top = 260
    object mniFile: TMenuItem
      Caption = #25991#20214
      object mniFileOpen: TMenuItem
        Caption = #25171#24320
        OnClick = mniFileOpenClick
      end
    end
    object mniSize: TMenuItem
      Caption = #22823#23567
      object mniSizeActual: TMenuItem
        Caption = #23454#38469#22823#23567
        OnClick = mniSizeActualClick
      end
      object mniSizeStretch: TMenuItem
        Caption = #25289#20280#36866#24212#31383#20307#22823#23567
        OnClick = mniSizeStretchClick
      end
    end
  end
  object dlgOpenPic1: TOpenPictureDialog
    Left = 364
    Top = 180
  end
end
