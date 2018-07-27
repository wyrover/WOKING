object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #22270#20687#32534#36753
  ClientHeight = 563
  ClientWidth = 870
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    870
    563)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 854
    Height = 547
    Anchors = [akLeft, akTop, akRight, akBottom]
    Stretch = True
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    Left = 160
    Top = 92
    object mniFile: TMenuItem
      Caption = #25991#20214
      object mniFileOpen: TMenuItem
        Caption = #25171#24320
        OnClick = mniFileOpenClick
      end
    end
    object mniTFColor: TMenuItem
      Caption = #39068#33394#21464#25442
      object mniTFColorGray: TMenuItem
        Caption = #28784#24230
        OnClick = mniTFColorGrayClick
      end
      object mniTFColorInvert: TMenuItem
        Caption = #21453#33394
        OnClick = mniTFColorInvertClick
      end
      object mniTFColorTwoValue: TMenuItem
        Caption = #20108#20540#21270
      end
    end
    object mniTFGeometric: TMenuItem
      Caption = #20960#20309#21464#25442
      object mniTFGeometricHorMirror: TMenuItem
        Caption = #27700#24179#38236#20687
      end
      object mniTFGeometricVerMirror: TMenuItem
        Caption = #22402#30452#38236#20687
      end
      object mniTFGeometricHorVerMirror: TMenuItem
        Caption = #27700#24179#38236#20687'+'#22402#30452#38236#20687
      end
      object mniTFGeometricTransposition: TMenuItem
        Caption = #36716#32622
      end
      object mniTFGeometricRotate: TMenuItem
        Caption = #26059#36716'...'
      end
    end
    object mniTFMorp: TMenuItem
      Caption = #24418#24577#23398#21464#25442
    end
    object mniRestore: TMenuItem
      Caption = #37325#32622
      OnClick = mniRestoreClick
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 164
    Top = 164
  end
end
