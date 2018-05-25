object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #31243#24207#21592#24037#20855#31665
  ClientHeight = 510
  ClientWidth = 846
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    846
    510)
  PixelsPerInch = 96
  TextHeight = 13
  object pgcAll: TPageControl
    Left = 8
    Top = 8
    Width = 830
    Height = 494
    ActivePage = tsConfig
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object tsConfig: TTabSheet
      Caption = #37197#32622
      ExplicitWidth = 281
      ExplicitHeight = 165
      object chkTrayIco: TCheckBox
        Left = 20
        Top = 16
        Width = 201
        Height = 17
        Caption = #20851#38381#26102#19981#36864#20986#65292#26368#23567#21270#21040#25176#30424#21306
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  object trycnTools: TTrayIcon
    Hint = #31243#24207#21592#24037#20855#31665
    PopupMenu = pmTools
    Left = 416
    Top = 260
  end
  object pmTools: TPopupMenu
    AutoHotkeys = maManual
    Left = 416
    Top = 196
    object mniShowForm: TMenuItem
      Caption = #26174#31034
      OnClick = mniShowFormClick
    end
    object mniConfig: TMenuItem
      Caption = #37197#32622
      OnClick = mniConfigClick
    end
    object mniLine0ne: TMenuItem
      Caption = '-'
    end
    object mniExit: TMenuItem
      Caption = #36864#20986
      OnClick = mniExitClick
    end
  end
end
