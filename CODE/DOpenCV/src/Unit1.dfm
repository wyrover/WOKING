object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Test01'
  ClientHeight = 584
  ClientWidth = 942
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmMain
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    942
    584)
  PixelsPerInch = 96
  TextHeight = 13
  object img1: TImage
    Left = 8
    Top = 8
    Width = 926
    Height = 568
    Anchors = [akLeft, akTop, akRight, akBottom]
    Stretch = True
    ExplicitWidth = 825
    ExplicitHeight = 516
  end
  object dlgOpenPic1: TOpenPictureDialog
    Left = 372
    Top = 244
  end
  object mmMain: TMainMenu
    AutoHotkeys = maManual
    Left = 276
    Top = 240
    object mnuFile: TMenuItem
      Caption = #25991#20214
      object mnuFileOpen: TMenuItem
        Caption = #25171#24320
        OnClick = mnuFileOpenClick
      end
      object mnuFileSaveAs: TMenuItem
        Caption = #21478#23384#20026'...'
        OnClick = mnuFileSaveAsClick
      end
    end
    object mnuCT: TMenuItem
      Caption = #39068#33394#21464#25442
    end
    object mnuGT: TMenuItem
      Caption = #20960#20309#21464#25442
    end
    object mnuMT: TMenuItem
      Caption = #24418#24577#23398#21464#25442
    end
    object mnuOR: TMenuItem
      Caption = #23545#35937#35782#21035
    end
    object mnuHelp: TMenuItem
      Caption = #24110#21161
      object mnuHelpAbout: TMenuItem
        Caption = #29256#26412
        OnClick = mnuHelpAboutClick
      end
    end
  end
end
