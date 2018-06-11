object frmFileSearch: TfrmFileSearch
  Left = 0
  Top = 0
  Caption = #25991#20214#25628#32034
  ClientHeight = 540
  ClientWidth = 910
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  DesignSize = (
    910
    540)
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 8
    Top = 8
    Width = 894
    Height = 41
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'pnl1'
    Ctl3D = False
    ParentCtl3D = False
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      892
      39)
    object chk1: TCheckBox
      Left = 840
      Top = 12
      Width = 41
      Height = 17
      Anchors = [akTop, akRight]
      Caption = #25490#24207
      TabOrder = 0
    end
  end
  object lvFileList: TVirtualStringTree
    Left = 8
    Top = 63
    Width = 894
    Height = 469
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    Header.AutoSizeIndex = 0
    Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
    ParentFont = False
    TabOrder = 1
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toFullRowSelect]
    OnGetText = lvFileListGetText
    OnInitNode = lvFileListInitNode
    Columns = <
      item
        Position = 0
        Width = 100
        WideText = #24207#21015
      end
      item
        Position = 1
        Width = 750
        WideText = #21517#31216
      end>
  end
end
