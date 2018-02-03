object frmHookPE: TfrmHookPE
  Left = 0
  Top = 0
  Caption = 'HOOK PE'
  ClientHeight = 587
  ClientWidth = 832
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    832
    587)
  PixelsPerInch = 96
  TextHeight = 13
  object lv1: TListView
    Left = 8
    Top = 8
    Width = 816
    Height = 233
    Anchors = [akLeft, akTop, akRight]
    Columns = <
      item
        Caption = #24207#21015
      end
      item
        Caption = #25991#20214#21517#31216
        Width = 700
      end>
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    GridLines = True
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
  end
  object btn1: TButton
    Left = 8
    Top = 548
    Width = 93
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Add'
    TabOrder = 1
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 731
    Top = 548
    Width = 93
    Height = 31
    Anchors = [akRight, akBottom]
    Caption = 'HOOK'
    TabOrder = 2
    OnClick = btn2Click
  end
  object mmo1: TMemo
    Left = 8
    Top = 252
    Width = 816
    Height = 285
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
end
