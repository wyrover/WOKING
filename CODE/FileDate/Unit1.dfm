object frmFileDateTime: TfrmFileDateTime
  Left = 0
  Top = 0
  Caption = #25991#20214#26102#38388
  ClientHeight = 582
  ClientWidth = 1016
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
  DesignSize = (
    1016
    582)
  PixelsPerInch = 96
  TextHeight = 13
  object lv1: TListView
    Left = 8
    Top = 8
    Width = 997
    Height = 566
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = #25991#20214#21517#31216
        Width = 400
      end
      item
        Caption = #21019#24314#26102#38388
        Width = 150
      end
      item
        Caption = #26368#21518#19968#27425#35775#38382#26102#38388
        Width = 150
      end
      item
        Caption = #26368#21518#19968#27425#20462#25913#26102#38388
        Width = 150
      end>
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    GridLines = True
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
    OnColumnClick = lv1ColumnClick
    OnCompare = lv1Compare
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    Left = 504
    Top = 296
    object mniDirectory: TMenuItem
      Caption = #30446#24405
      object mniDirectoryFind: TMenuItem
        Caption = #27983#35272
        OnClick = mniDirectoryFindClick
      end
    end
    object mniColumn: TMenuItem
      Caption = #21015
      object mniColumnCopy: TMenuItem
        Caption = #22797#21046#21015
        OnClick = mniColumnCopyClick
      end
    end
  end
end
