object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'lib '#25991#26684#24335
  ClientHeight = 581
  ClientWidth = 840
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  DesignSize = (
    840
    581)
  PixelsPerInch = 96
  TextHeight = 13
  object mmo1: TMemo
    Left = 8
    Top = 8
    Width = 824
    Height = 565
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object mm1: TMainMenu
    AutoHotkeys = maManual
    Left = 68
    Top = 104
    object mniFile: TMenuItem
      Caption = #25991#20214
      object mniFileOpen: TMenuItem
        Caption = #25171#24320#38745#24577#24211#25991#20214
        OnClick = mniFileOpenClick
      end
    end
  end
end
