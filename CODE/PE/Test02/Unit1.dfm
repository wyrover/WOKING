object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'PEInfo'
  ClientHeight = 557
  ClientWidth = 805
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    805
    557)
  PixelsPerInch = 96
  TextHeight = 13
  object srchbxPEFileName: TSearchBox
    Left = 8
    Top = 8
    Width = 789
    Height = 24
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    OnInvokeSearch = srchbxPEFileNameInvokeSearch
  end
  object pnl1: TPanel
    Left = 8
    Top = 38
    Width = 789
    Height = 511
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    DesignSize = (
      787
      509)
    object pgc1: TPageControl
      Left = 9
      Top = 6
      Width = 769
      Height = 494
      ActivePage = ts3
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Visible = False
      object ts1: TTabSheet
        Caption = #31616#20171
        object lblPEInfo: TLabel
          Left = 40
          Top = 32
          Width = 15
          Height = 27
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -27
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object ts2: TTabSheet
        Caption = '1'#12289'DOS '#25991#20214#22836
        ImageIndex = 1
        ExplicitLeft = 0
        object lbl1: TLabel
          Left = 20
          Top = 12
          Width = 56
          Height = 15
          Caption = 'e_magic'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl2: TLabel
          Left = 20
          Top = 35
          Width = 48
          Height = 15
          Caption = 'e_cblp'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl3: TLabel
          Left = 20
          Top = 58
          Width = 32
          Height = 15
          Caption = 'e_cp'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl4: TLabel
          Left = 20
          Top = 81
          Width = 48
          Height = 15
          Caption = 'e_crlc'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl5: TLabel
          Left = 20
          Top = 174
          Width = 32
          Height = 15
          Caption = 'e_ss'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl6: TLabel
          Left = 20
          Top = 151
          Width = 80
          Height = 15
          Caption = 'e_maxalloc'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl7: TLabel
          Left = 20
          Top = 128
          Width = 80
          Height = 15
          Caption = 'e_minalloc'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl8: TLabel
          Left = 20
          Top = 104
          Width = 72
          Height = 15
          Caption = 'e_cparhdr'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl9: TLabel
          Left = 20
          Top = 267
          Width = 32
          Height = 15
          Caption = 'e_cs'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl10: TLabel
          Left = 20
          Top = 244
          Width = 32
          Height = 15
          Caption = 'e_ip'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl11: TLabel
          Left = 20
          Top = 221
          Width = 48
          Height = 15
          Caption = 'e_csum'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl12: TLabel
          Left = 20
          Top = 197
          Width = 32
          Height = 15
          Caption = 'e_sp'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl13: TLabel
          Left = 20
          Top = 360
          Width = 56
          Height = 15
          Caption = 'e_oemid'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl14: TLabel
          Left = 20
          Top = 337
          Width = 40
          Height = 15
          Caption = 'e_res'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl15: TLabel
          Left = 20
          Top = 313
          Width = 48
          Height = 15
          Caption = 'e_ovno'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl16: TLabel
          Left = 20
          Top = 290
          Width = 64
          Height = 15
          Caption = 'e_lfarlc'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl18: TLabel
          Left = 20
          Top = 430
          Width = 64
          Height = 15
          Caption = 'e_lfanew'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl19: TLabel
          Left = 20
          Top = 406
          Width = 48
          Height = 15
          Caption = 'e_res2'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl20: TLabel
          Left = 20
          Top = 383
          Width = 72
          Height = 15
          Caption = 'e_oeminfo'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl17: TLabel
          Left = 184
          Top = 12
          Width = 63
          Height = 15
          Caption = 'e_magic'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl21: TLabel
          Left = 184
          Top = 35
          Width = 48
          Height = 15
          Caption = 'e_cblp'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl22: TLabel
          Left = 184
          Top = 58
          Width = 32
          Height = 15
          Caption = 'e_cp'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl23: TLabel
          Left = 184
          Top = 81
          Width = 48
          Height = 15
          Caption = 'e_crlc'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl24: TLabel
          Left = 184
          Top = 104
          Width = 72
          Height = 15
          Caption = 'e_cparhdr'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl25: TLabel
          Left = 184
          Top = 128
          Width = 80
          Height = 15
          Caption = 'e_minalloc'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl26: TLabel
          Left = 184
          Top = 151
          Width = 80
          Height = 15
          Caption = 'e_maxalloc'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl27: TLabel
          Left = 184
          Top = 174
          Width = 32
          Height = 15
          Caption = 'e_ss'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl28: TLabel
          Left = 184
          Top = 197
          Width = 32
          Height = 15
          Caption = 'e_sp'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl29: TLabel
          Left = 184
          Top = 221
          Width = 48
          Height = 15
          Caption = 'e_csum'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl30: TLabel
          Left = 184
          Top = 244
          Width = 32
          Height = 15
          Caption = 'e_ip'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl31: TLabel
          Left = 184
          Top = 267
          Width = 32
          Height = 15
          Caption = 'e_cs'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl32: TLabel
          Left = 184
          Top = 290
          Width = 64
          Height = 15
          Caption = 'e_lfarlc'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl33: TLabel
          Left = 184
          Top = 313
          Width = 48
          Height = 15
          Caption = 'e_ovno'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl34: TLabel
          Left = 184
          Top = 337
          Width = 40
          Height = 15
          Caption = 'e_res'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl35: TLabel
          Left = 184
          Top = 360
          Width = 56
          Height = 15
          Caption = 'e_oemid'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl36: TLabel
          Left = 184
          Top = 383
          Width = 72
          Height = 15
          Caption = 'e_oeminfo'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl37: TLabel
          Left = 184
          Top = 406
          Width = 48
          Height = 15
          Caption = 'e_res2'
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl38: TLabel
          Left = 184
          Top = 430
          Width = 72
          Height = 15
          Caption = 'e_lfanew'
          Font.Charset = GB2312_CHARSET
          Font.Color = clRed
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl39: TLabel
          Left = 16
          Top = 23
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl40: TLabel
          Left = 16
          Top = 46
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl41: TLabel
          Left = 16
          Top = 93
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl42: TLabel
          Left = 16
          Top = 69
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl43: TLabel
          Left = 16
          Top = 116
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl44: TLabel
          Left = 16
          Top = 139
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl45: TLabel
          Left = 16
          Top = 163
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl46: TLabel
          Left = 16
          Top = 186
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl47: TLabel
          Left = 16
          Top = 373
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl48: TLabel
          Left = 16
          Top = 349
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl49: TLabel
          Left = 16
          Top = 326
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl50: TLabel
          Left = 16
          Top = 303
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl51: TLabel
          Left = 16
          Top = 279
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl52: TLabel
          Left = 16
          Top = 256
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl53: TLabel
          Left = 16
          Top = 233
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl54: TLabel
          Left = 16
          Top = 209
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl55: TLabel
          Left = 16
          Top = 420
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
        object lbl56: TLabel
          Left = 16
          Top = 396
          Width = 726
          Height = 19
          Caption = 
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213 +
            #8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213#8213
          Font.Charset = GB2312_CHARSET
          Font.Color = clSilver
          Font.Height = -13
          Font.Name = #24494#36719#38597#40657
          Font.Style = []
          ParentFont = False
        end
      end
      object ts3: TTabSheet
        Caption = '2'#12289'DOS STUB'
        ImageIndex = 2
        ExplicitLeft = 0
        DesignSize = (
          761
          463)
        object mmoHexView: TMemo
          Left = 8
          Top = 8
          Width = 745
          Height = 449
          Anchors = [akLeft, akTop, akRight, akBottom]
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
      end
      object ts4: TTabSheet
        Caption = '3'#12289'NT HEADER'
        ImageIndex = 3
      end
      object ts5: TTabSheet
        Caption = '4'#12289#33410#34920
        ImageIndex = 4
      end
      object ts6: TTabSheet
        Caption = '5'#12289#33410#25968#25454
        ImageIndex = 5
      end
    end
  end
end
