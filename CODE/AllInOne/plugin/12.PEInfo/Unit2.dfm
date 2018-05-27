object Form2: TForm2
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #26631#24535#65306
  ClientHeight = 367
  ClientWidth = 1109
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 8
    Top = 8
    Width = 1097
    Height = 349
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 0
    object lbl1: TLabel
      Left = 244
      Top = 10
      Width = 651
      Height = 13
      Caption = 
        '// IMAGE_FILE_RELOCS_STRIPPED               = $0001;  { Relocati' +
        'on info stripped from file. }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 244
      Top = 76
      Width = 637
      Height = 13
      Caption = 
        '// IMAGE_FILE_LOCAL_SYMS_STRIPPED           = $0008;  { Local sy' +
        'mbols stripped from file. }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 244
      Top = 54
      Width = 630
      Height = 13
      Caption = 
        '// IMAGE_FILE_LINE_NUMS_STRIPPED            = $0004;  { Line nun' +
        'bers stripped from file. }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 244
      Top = 32
      Width = 833
      Height = 13
      Caption = 
        '// IMAGE_FILE_EXECUTABLE_IMAGE              = $0002;  { File is ' +
        'executable  (i.e. no unresolved externel references). }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl5: TLabel
      Left = 244
      Top = 98
      Width = 602
      Height = 13
      Caption = 
        '// IMAGE_FILE_AGGRESIVE_WS_TRIM             = $0010;  { Agressiv' +
        'ely trim working set }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 244
      Top = 165
      Width = 546
      Height = 13
      Caption = 
        '// IMAGE_FILE_32BIT_MACHINE                 = $0100;  { 32 bit w' +
        'ord machine. }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl7: TLabel
      Left = 243
      Top = 146
      Width = 651
      Height = 13
      Caption = 
        '// IMAGE_FILE_BYTES_REVERSED_LO             = $0080;  { Bytes of' +
        ' machine word are reversed. }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 244
      Top = 121
      Width = 609
      Height = 13
      Caption = 
        '// IMAGE_FILE_LARGE_ADDRESS_AWARE           = $0020;  { App can ' +
        'handle >2gb addresses }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl9: TLabel
      Left = 244
      Top = 187
      Width = 728
      Height = 13
      Caption = 
        '// IMAGE_FILE_DEBUG_STRIPPED                = $0200;  { Debuggin' +
        'g info stripped from file in .DBG file }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl10: TLabel
      Left = 244
      Top = 254
      Width = 490
      Height = 13
      Caption = 
        '// IMAGE_FILE_SYSTEM                        = $1000;  { System F' +
        'ile. }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl11: TLabel
      Left = 244
      Top = 232
      Width = 770
      Height = 13
      Caption = 
        '// IMAGE_FILE_NET_RUN_FROM_SWAP             = $0800;  { If Image' +
        ' is on Net, copy and run from the swap file. }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl12: TLabel
      Left = 243
      Top = 209
      Width = 854
      Height = 13
      Caption = 
        '// IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP       = $0400;  { If Image' +
        ' is on removable media, copy and run from the swap file. }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl13: TLabel
      Left = 244
      Top = 276
      Width = 504
      Height = 13
      Caption = 
        '// IMAGE_FILE_DLL                           = $2000;  { File is ' +
        'a DLL. }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl15: TLabel
      Left = 244
      Top = 321
      Width = 651
      Height = 13
      Caption = 
        '// IMAGE_FILE_BYTES_REVERSED_HI             = $8000;  { Bytes of' +
        ' machine word are reversed. }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbl16: TLabel
      Left = 244
      Top = 298
      Width = 679
      Height = 13
      Caption = 
        '// IMAGE_FILE_UP_SYSTEM_ONLY                = $4000;  { File sho' +
        'uld only be run on a UP machine }'
      Font.Charset = GB2312_CHARSET
      Font.Color = clTeal
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object chk1: TCheckBox
      Tag = 1
      Left = 8
      Top = 9
      Width = 200
      Height = 17
      Caption = #37325#23450#20301#24050#20998#31163
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object chk2: TCheckBox
      Tag = 2
      Left = 8
      Top = 30
      Width = 200
      Height = 17
      Caption = #21487#25191#34892#25991#20214
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object chk3: TCheckBox
      Tag = 4
      Left = 8
      Top = 52
      Width = 200
      Height = 17
      Caption = #34892#21495#24050#20998#31163
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object chk4: TCheckBox
      Tag = 8
      Left = 8
      Top = 74
      Width = 200
      Height = 17
      Caption = #26412#22320#31526#21512#24050#20998#31163
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object chk5: TCheckBox
      Tag = 16
      Left = 8
      Top = 96
      Width = 200
      Height = 17
      Caption = #20027#21160' WS '#20462#39280
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object chk6: TCheckBox
      Tag = 32
      Left = 8
      Top = 118
      Width = 200
      Height = 17
      Caption = #30041#24847#22823#22320#22336
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object chk7: TCheckBox
      Tag = 128
      Left = 8
      Top = 139
      Width = 200
      Height = 17
      Caption = #20445#30041#23383#33410'01'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object chk8: TCheckBox
      Tag = 256
      Left = 8
      Top = 162
      Width = 200
      Height = 17
      Caption = #26399#26395#26159' 32 '#20301#31995#32479
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object chk9: TCheckBox
      Tag = 512
      Left = 8
      Top = 184
      Width = 200
      Height = 17
      Caption = #35843#35797#20449#24687#24050#20998#31163
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object chk10: TCheckBox
      Tag = 1024
      Left = 8
      Top = 206
      Width = 200
      Height = 17
      Caption = #20174#20132#25442#21306#36816#34892#65288#21487#31227#21160#35774#22791#65289
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object chk11: TCheckBox
      Tag = 2048
      Left = 8
      Top = 228
      Width = 200
      Height = 17
      Caption = #20174#20132#25442#21306#36816#34892#65288#32593#32476#65289
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object chk12: TCheckBox
      Tag = 4096
      Left = 8
      Top = 250
      Width = 200
      Height = 17
      Caption = #25991#20214#31995#32479
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
    object chk13: TCheckBox
      Tag = 8192
      Left = 8
      Top = 272
      Width = 200
      Height = 17
      Caption = 'Dll '#25991#20214
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 12
    end
    object chk14: TCheckBox
      Tag = 16384
      Left = 8
      Top = 294
      Width = 200
      Height = 17
      Caption = #38750#22810#22788#29702#22120#31995#32479
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
    object chk15: TCheckBox
      Tag = 32768
      Left = 8
      Top = 317
      Width = 200
      Height = 17
      Caption = #20445#30041#23383#33410'02'
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 14
    end
  end
end
