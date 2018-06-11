object Form4: TForm4
  Left = 0
  Top = 0
  Caption = #23548#20986#20989#25968#21015#34920#65306
  ClientHeight = 556
  ClientWidth = 824
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  DesignSize = (
    824
    556)
  PixelsPerInch = 96
  TextHeight = 13
  object lvFunc: TListView
    Left = 8
    Top = 136
    Width = 808
    Height = 412
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = #24207#21015
      end
      item
        Caption = #22320#22336'(VA)'
        Width = 100
      end
      item
        Caption = #20559#31227'(RA)'
        Width = 100
      end
      item
        Caption = #21517#31216
        Width = 300
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
  end
  object grp1: TGroupBox
    Left = 8
    Top = 8
    Width = 807
    Height = 117
    Anchors = [akLeft, akTop, akRight]
    Caption = #36755#20986#20449#24687#65306
    TabOrder = 1
    object lbl62: TLabel
      Left = 12
      Top = 19
      Width = 72
      Height = 12
      Caption = #36755#20986#34920#20559#31227#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl63: TLabel
      Left = 12
      Top = 38
      Width = 72
      Height = 12
      Caption = #29305#24449#20540'    '#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl64: TLabel
      Left = 12
      Top = 58
      Width = 72
      Height = 12
      Caption = #22522#22336'      '#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl65: TLabel
      Left = 12
      Top = 77
      Width = 72
      Height = 12
      Caption = #21517#31216#22320#22336'  '#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl66: TLabel
      Left = 12
      Top = 97
      Width = 72
      Height = 12
      Caption = #21517#31216#23383#31526'  '#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl74: TLabel
      Left = 120
      Top = 97
      Width = 90
      Height = 12
      Caption = 'Characteristics'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl73: TLabel
      Left = 120
      Top = 77
      Width = 120
      Height = 12
      Caption = 'SizeOfOptionalHeader'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl72: TLabel
      Left = 120
      Top = 58
      Width = 90
      Height = 12
      Caption = 'NumberOfSymbols'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl71: TLabel
      Left = 120
      Top = 38
      Width = 120
      Height = 12
      Caption = 'PointerToSymbolTable'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl70: TLabel
      Left = 120
      Top = 19
      Width = 78
      Height = 12
      Caption = 'TimeDateStamp'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 296
      Top = 19
      Width = 96
      Height = 12
      Caption = #20989#25968#25968#37327'      '#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 296
      Top = 38
      Width = 96
      Height = 12
      Caption = #20989#25968#21517#25968#37327'    '#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 296
      Top = 58
      Width = 96
      Height = 12
      Caption = #20989#25968#22320#22336'      '#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 296
      Top = 77
      Width = 96
      Height = 12
      Caption = #20989#25968#21517#31216#22320#22336'  '#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 296
      Top = 97
      Width = 96
      Height = 12
      Caption = #20989#25968#21517#24207#21495#22320#22336#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 404
      Top = 19
      Width = 78
      Height = 12
      Caption = 'TimeDateStamp'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl7: TLabel
      Left = 404
      Top = 38
      Width = 120
      Height = 12
      Caption = 'PointerToSymbolTable'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 404
      Top = 58
      Width = 90
      Height = 12
      Caption = 'NumberOfSymbols'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl9: TLabel
      Left = 404
      Top = 77
      Width = 120
      Height = 12
      Caption = 'SizeOfOptionalHeader'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl10: TLabel
      Left = 404
      Top = 97
      Width = 90
      Height = 12
      Caption = 'Characteristics'
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
  end
end
