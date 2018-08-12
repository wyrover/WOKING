object frmCamera: TfrmCamera
  Left = 0
  Top = 0
  Caption = 'Camera'
  ClientHeight = 709
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmCamera
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  DesignSize = (
    1008
    709)
  PixelsPerInch = 96
  TextHeight = 13
  object grdpnlVideo: TGridPanel
    Left = 8
    Top = 8
    Width = 992
    Height = 693
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Caption = 'grdpnlVideo'
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = pnlVideo01
        Row = 0
      end
      item
        Column = 1
        Control = pnlVideo02
        Row = 0
      end
      item
        Column = 0
        Control = pnlVideo03
        Row = 1
      end
      item
        Column = 1
        Control = pnlVideo04
        Row = 1
      end>
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ShowCaption = False
    TabOrder = 0
    object pnlVideo01: TPanel
      Left = 0
      Top = 0
      Width = 496
      Height = 346
      Align = alClient
      Caption = 'pnlVideo01'
      Color = clBlack
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
    end
    object pnlVideo02: TPanel
      Left = 496
      Top = 0
      Width = 496
      Height = 346
      Align = alClient
      Caption = 'pnlVideo02'
      Color = clBlack
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
    end
    object pnlVideo03: TPanel
      Left = 0
      Top = 346
      Width = 496
      Height = 347
      Align = alClient
      Caption = 'pnlVideo03'
      Color = clBlack
      ParentBackground = False
      ShowCaption = False
      TabOrder = 2
    end
    object pnlVideo04: TPanel
      Left = 496
      Top = 346
      Width = 496
      Height = 347
      Align = alClient
      Caption = 'pnlVideo04'
      Color = clBlack
      ParentBackground = False
      ShowCaption = False
      TabOrder = 3
    end
  end
  object mmCamera: TMainMenu
    AutoHotkeys = maManual
    Left = 228
    Top = 264
    object mniCamera: TMenuItem
      Caption = #30456#26426
      object mniCameraAddUSBCamera: TMenuItem
        Caption = #28155#21152'USB'#30456#26426
      end
      object mniCameraAddIPCamera: TMenuItem
        Caption = #28155#21152'IP'#30456#26426
      end
    end
    object mniRecognize: TMenuItem
      Caption = #35782#21035
      object mniRecognizeCar: TMenuItem
        Caption = #36710#29260#35782#21035
        Checked = True
        OnClick = mniRecognizeCarClick
      end
      object mniRecognizeFace: TMenuItem
        Caption = #20154#33080#35782#21035
        OnClick = mniRecognizeFaceClick
      end
    end
    object mniEffect: TMenuItem
      Caption = #29305#25928
      object mniEffectRotate90: TMenuItem
        Caption = #26059#36716'90'#24230
      end
      object mniEffectRotate180: TMenuItem
        Caption = #26059#36716'180'#24230
      end
      object mniEffectRotate0: TMenuItem
        Caption = #26059#36716'360'#24230
      end
      object mniEffectHorMirror: TMenuItem
        Caption = #27700#24179#38236#20687
      end
      object mniEffectVerMirror: TMenuItem
        Caption = #22402#30452#38236#20687
      end
      object mniEffectTrans: TMenuItem
        Caption = #36716#32622
      end
      object mniEffectLine01: TMenuItem
        Caption = '-'
      end
      object mniEffectAdjustBrightness: TMenuItem
        Caption = #35843#33410#20142#24230'...'
      end
      object mniEffectAdjustChroma: TMenuItem
        Caption = #35843#33410#33394#24230'...'
      end
      object mniEffectAdustContrast: TMenuItem
        Caption = #35843#33410#23545#27604#24230'...'
      end
      object mniEffectAdjustSaturation: TMenuItem
        Caption = #35843#33410#39281#21644#24230'...'
      end
    end
    object mniConfig: TMenuItem
      Caption = #37197#32622
    end
    object mniHelp: TMenuItem
      Caption = #24110#21161
      object mniHelpAbout: TMenuItem
        Caption = #20851#20110
        OnClick = mniHelpAboutClick
      end
    end
  end
end
