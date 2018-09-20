object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #25968#25454#24211#26597#30475#22120' v2.0'
  ClientHeight = 686
  ClientWidth = 994
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    994
    686)
  PixelsPerInch = 96
  TextHeight = 13
  object btn1: TButton
    Left = 8
    Top = 8
    Width = 225
    Height = 33
    Caption = #25968#25454#24211#36830#25509
    TabOrder = 0
    OnClick = btn1Click
  end
  object grpTable: TGroupBox
    Left = 8
    Top = 52
    Width = 225
    Height = 510
    Caption = #34920#65306
    TabOrder = 1
    DesignSize = (
      225
      510)
    object lstTable: TListBox
      Left = 12
      Top = 18
      Width = 201
      Height = 479
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      TabOrder = 0
      OnClick = lstTableClick
    end
  end
  object grpField: TGroupBox
    Left = 8
    Top = 568
    Width = 225
    Height = 109
    Anchors = [akLeft, akTop, akBottom]
    Caption = #23383#27573#65306
    TabOrder = 2
    DesignSize = (
      225
      109)
    object lvFields: TListView
      Left = 12
      Top = 18
      Width = 201
      Height = 79
      Anchors = [akLeft, akTop, akRight, akBottom]
      Columns = <
        item
          Caption = #21517#31216
          Width = 100
        end
        item
          Caption = #31867#22411
          Width = 80
        end>
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object ADOConnection1: TADOConnection
    Left = 464
    Top = 232
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 564
    Top = 232
  end
end
