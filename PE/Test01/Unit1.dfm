object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'PE Info v2.0'
  ClientHeight = 704
  ClientWidth = 1207
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  DesignSize = (
    1207
    704)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 12
    Top = 11
    Width = 65
    Height = 13
    Caption = #25171#24320#25991#20214#65306
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object srchbxOpenFile: TSearchBox
    Left = 78
    Top = 8
    Width = 1117
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnDblClick = srchbxOpenFileInvokeSearch
    OnInvokeSearch = srchbxOpenFileInvokeSearch
    ExplicitWidth = 895
  end
  object tvPE: TTreeView
    Left = 12
    Top = 37
    Width = 265
    Height = 659
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    Indent = 19
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    RowSelect = True
    ShowHint = True
    TabOrder = 1
    OnChange = tvPEChange
    ExplicitHeight = 560
  end
  object mmo1: TMemo
    Left = 283
    Top = 37
    Width = 912
    Height = 659
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #26032#23435#20307
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
    WantReturns = False
    WordWrap = False
    ExplicitWidth = 690
    ExplicitHeight = 560
  end
end
