object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'IP'#25195#25551
  ClientHeight = 717
  ClientWidth = 1164
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    1164
    717)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 250
    Top = 10
    Width = 32
    Height = 15
    Caption = '--->'
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 8
    Top = 9
    Width = 60
    Height = 15
    Caption = #25195#25551#27573#65306
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 109
    Top = 10
    Width = 8
    Height = 15
    Caption = ':'
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl4: TLabel
    Left = 153
    Top = 10
    Width = 6
    Height = 15
    Caption = ':'
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lbl5: TLabel
    Left = 198
    Top = 10
    Width = 8
    Height = 15
    Caption = ':'
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lvIP: TListView
    Left = 8
    Top = 36
    Width = 1148
    Height = 673
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = #24207#25968
      end
      item
        Caption = 'IP'
        Width = 150
      end
      item
        Caption = #26102#38388
        Width = 200
      end
      item
        Caption = 'MAC'
        Width = 150
      end
      item
        Caption = #35745#31639#26426#21517#31216
        Width = 200
      end>
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #23435#20307
    Font.Style = []
    GridLines = True
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    TabOrder = 0
    ViewStyle = vsReport
    ExplicitWidth = 921
    ExplicitHeight = 508
  end
  object edt1: TEdit
    Left = 74
    Top = 7
    Width = 32
    Height = 23
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #23435#20307
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 1
    Text = '192'
  end
  object edt2: TEdit
    Left = 120
    Top = 7
    Width = 32
    Height = 23
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #23435#20307
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 2
    Text = '168'
  end
  object edt3: TEdit
    Left = 166
    Top = 7
    Width = 32
    Height = 23
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #23435#20307
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 3
    Text = '0'
  end
  object edt4: TEdit
    Left = 213
    Top = 7
    Width = 32
    Height = 23
    Enabled = False
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #23435#20307
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    Text = '1'
  end
  object edt5: TEdit
    Left = 287
    Top = 7
    Width = 32
    Height = 23
    Enabled = False
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #23435#20307
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
    Text = '255'
  end
  object btnStart: TButton
    Left = 333
    Top = 5
    Width = 75
    Height = 27
    Caption = #24320#22987#25195#25551
    TabOrder = 6
    OnClick = btnStartClick
  end
end
