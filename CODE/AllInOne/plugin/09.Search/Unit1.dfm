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
  DesignSize = (
    910
    540)
  PixelsPerInch = 96
  TextHeight = 13
  object lvFileList: TListView
    Left = 8
    Top = 56
    Width = 894
    Height = 476
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = #24207#21015
        Width = 100
      end
      item
        Caption = #25991#20214#21517#31216
        Width = 500
      end>
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'SimSun'
    Font.Style = []
    GridLines = True
    OwnerData = True
    OwnerDraw = True
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
    OnData = lvFileListData
    OnDrawItem = lvFileListDrawItem
  end
  object pnl1: TPanel
    Left = 8
    Top = 9
    Width = 894
    Height = 41
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Caption = 'pnl1'
    Ctl3D = False
    ParentCtl3D = False
    ShowCaption = False
    TabOrder = 1
  end
end
