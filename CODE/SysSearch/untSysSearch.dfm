object frmSysSearch: TfrmSysSearch
  Left = 0
  Top = 0
  Caption = #31995#32479#25628#32034#36335#24452' v2.0'
  ClientHeight = 696
  ClientWidth = 1156
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
    1156
    696)
  PixelsPerInch = 96
  TextHeight = 13
  object lst1: TListBox
    Left = 8
    Top = 8
    Width = 1049
    Height = 680
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnDblClick = btnSysSearchModifyClick
  end
  object btnSysSearchAdd: TButton
    Left = 1066
    Top = 8
    Width = 81
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #28155#21152
    TabOrder = 1
    OnClick = btnSysSearchAddClick
  end
  object btnSysSearchModify: TButton
    Left = 1066
    Top = 130
    Width = 81
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #20462#25913
    TabOrder = 2
    OnClick = btnSysSearchModifyClick
  end
  object btnSysSearchUp: TButton
    Left = 1066
    Top = 171
    Width = 81
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #19978#31227
    TabOrder = 3
    OnClick = btnSysSearchUpClick
  end
  object btnSysSearchDown: TButton
    Left = 1066
    Top = 211
    Width = 81
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #19979#31227
    TabOrder = 4
    OnClick = btnSysSearchDownClick
  end
  object btnSysSearchUpTop: TButton
    Left = 1066
    Top = 252
    Width = 81
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #19978#31227#21040#39030#31471
    TabOrder = 5
    OnClick = btnSysSearchUpTopClick
  end
  object btnSysSearchDownBottom: TButton
    Left = 1066
    Top = 293
    Width = 81
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #19979#31227#21040#24213#31471
    TabOrder = 6
    OnClick = btnSysSearchDownBottomClick
  end
  object btnSysSearchBackup: TButton
    Left = 1066
    Top = 334
    Width = 81
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #22791#20221
    TabOrder = 7
    OnClick = btnSysSearchBackupClick
  end
  object btnSysSearchRestore: TButton
    Left = 1066
    Top = 375
    Width = 81
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #36824#21407
    TabOrder = 8
    OnClick = btnSysSearchRestoreClick
  end
  object btnSysSearchDel: TButton
    Left = 1066
    Top = 89
    Width = 81
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #21024#38500
    TabOrder = 9
    OnClick = btnSysSearchDelClick
  end
  object btnInputSysSearch: TButton
    Left = 1066
    Top = 48
    Width = 81
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #36755#20837
    TabOrder = 10
    OnClick = btnInputSysSearchClick
  end
end
