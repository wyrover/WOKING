object frmSystem: TfrmSystem
  Left = 0
  Top = 0
  Caption = #31995#32479#24037#20855#31665' v2.0'
  ClientHeight = 729
  ClientWidth = 1008
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  DesignSize = (
    1008
    729)
  PixelsPerInch = 96
  TextHeight = 13
  object pgcAll: TPageControl
    Left = 8
    Top = 8
    Width = 992
    Height = 713
    ActivePage = tsDataBase
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object tsSystem: TTabSheet
      Caption = #31995#32479#31616#20171
      object lbl1: TLabel
        Left = 20
        Top = 16
        Width = 96
        Height = 13
        Caption = #25805#20316#31995#32479#29256#26412#21495#65306
      end
    end
    object tsSearchPath: TTabSheet
      Caption = #31995#32479#25628#32034#36335#24452
      ImageIndex = 2
      DesignSize = (
        984
        685)
      object btnSysSearchAdd: TButton
        Left = 895
        Top = 8
        Width = 81
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #28155#21152
        TabOrder = 0
        OnClick = btnSysSearchAddClick
      end
      object btnSysSearchModify: TButton
        Left = 891
        Top = 132
        Width = 81
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #20462#25913
        TabOrder = 1
        OnClick = btnSysSearchModifyClick
      end
      object btnSysSearchUp: TButton
        Left = 895
        Top = 171
        Width = 81
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #19978#31227
        TabOrder = 2
        OnClick = btnSysSearchUpClick
      end
      object btnSysSearchDown: TButton
        Left = 895
        Top = 211
        Width = 81
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #19979#31227
        TabOrder = 3
        OnClick = btnSysSearchDownClick
      end
      object btnSysSearchUpTop: TButton
        Left = 895
        Top = 252
        Width = 81
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #19978#31227#21040#39030#31471
        TabOrder = 4
        OnClick = btnSysSearchUpTopClick
      end
      object btnSysSearchDownBottom: TButton
        Left = 895
        Top = 293
        Width = 81
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #19979#31227#21040#24213#31471
        TabOrder = 5
        OnClick = btnSysSearchDownBottomClick
      end
      object btnSysSearchBackup: TButton
        Left = 895
        Top = 334
        Width = 81
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #22791#20221
        TabOrder = 6
        OnClick = btnSysSearchBackupClick
      end
      object btnSysSearchRestore: TButton
        Left = 891
        Top = 373
        Width = 81
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #36824#21407
        TabOrder = 7
        OnClick = btnSysSearchRestoreClick
      end
      object btnSysSearchDel: TButton
        Left = 891
        Top = 91
        Width = 81
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #21024#38500
        TabOrder = 8
        OnClick = btnSysSearchDelClick
      end
      object btnInputSysSearch: TButton
        Left = 895
        Top = 48
        Width = 81
        Height = 33
        Anchors = [akTop, akRight]
        Caption = #36755#20837
        TabOrder = 9
        OnClick = btnInputSysSearchClick
      end
      object lstSystemSearchPath: TListBox
        Left = 8
        Top = 8
        Width = 877
        Height = 669
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 10
      end
    end
    object tsProcess: TTabSheet
      Caption = #36827#31243#21015#34920
      ImageIndex = 1
      DesignSize = (
        984
        685)
      object lvProcess: TListView
        Left = 8
        Top = 8
        Width = 966
        Height = 354
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            Caption = #24207#21015
            Width = 40
          end
          item
            Caption = #21517#31216
            Width = 150
          end
          item
            Caption = 'PID'
          end
          item
            Caption = #24179#21488
            Width = 40
          end
          item
            Caption = #36335#24452
            Width = 230
          end
          item
            Caption = #20844#21496
            Width = 170
          end
          item
            Caption = #25551#36848
            Width = 230
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
        PopupMenu = pmProcess
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = lvProcessClick
        OnColumnClick = lvProcessColumnClick
      end
      object lvModule: TListView
        Left = 3
        Top = 376
        Width = 966
        Height = 298
        Anchors = [akLeft, akRight, akBottom]
        Columns = <
          item
            Caption = #24207#21015
            Width = 40
          end
          item
            Caption = #21517#31216
            Width = 150
          end
          item
            Caption = #36335#24452
            Width = 320
          end
          item
            Caption = #22320#22336
            Width = 85
          end
          item
            Caption = #22823#23567
            Width = 85
          end
          item
            Caption = #20844#21496
            Width = 230
          end>
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        GridLines = True
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        ParentFont = False
        PopupMenu = pmModule
        TabOrder = 1
        ViewStyle = vsReport
        OnColumnClick = lvProcessColumnClick
      end
    end
    object tsPE: TTabSheet
      Caption = 'PE '#20998#26512
      ImageIndex = 5
    end
    object tsAutorun: TTabSheet
      Caption = #24320#26426#33258#21160#36816#34892
      ImageIndex = 7
    end
    object tsServer: TTabSheet
      Caption = #26381#21153
      ImageIndex = 6
    end
    object tsShell: TTabSheet
      Caption = 'Shell '#31649#29702
      ImageIndex = 8
    end
    object tsWebSoft: TTabSheet
      Caption = #32593#32476
      ImageIndex = 4
    end
    object tsDataBase: TTabSheet
      Caption = #25968#25454#24211
      ImageIndex = 3
      DesignSize = (
        984
        685)
      object btnLinkDataBase: TButton
        Left = 16
        Top = 16
        Width = 229
        Height = 33
        Caption = #36830#25509#25968#25454#24211
        TabOrder = 0
        OnClick = btnLinkDataBaseClick
      end
      object grpTableName: TGroupBox
        Left = 16
        Top = 60
        Width = 229
        Height = 329
        Anchors = [akLeft, akTop, akBottom]
        Caption = #25152#26377#34920#65306
        TabOrder = 1
        DesignSize = (
          229
          329)
        object lstTables: TListBox
          Left = 8
          Top = 16
          Width = 213
          Height = 305
          Anchors = [akLeft, akTop, akRight, akBottom]
          BorderStyle = bsNone
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          TabOrder = 0
          OnClick = lstTablesClick
        end
      end
      object grpFields: TGroupBox
        Left = 16
        Top = 395
        Width = 229
        Height = 282
        Anchors = [akLeft, akBottom]
        Caption = #23383#27573#65306
        TabOrder = 2
      end
      object lvData: TListView
        Left = 253
        Top = 16
        Width = 720
        Height = 661
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 3
        ViewStyle = vsReport
      end
    end
  end
  object pmProcess: TPopupMenu
    AutoHotkeys = maManual
    Left = 204
    Top = 116
    object mniOpenProcessPath: TMenuItem
      Caption = #25171#24320#25991#20214#20301#32622
      OnClick = mniOpenProcessPathClick
    end
    object mniRenameProcessName: TMenuItem
      Caption = #25991#20214#37325#21629#21517
      OnClick = mniRenameProcessNameClick
    end
    object mniDllInsertProcess: TMenuItem
      Caption = #36827#31243#27880#20837
      OnClick = mniDllInsertProcessClick
    end
    object mniLine01: TMenuItem
      Caption = '-'
    end
    object mniLoadPE: TMenuItem
      Caption = #21152#36733#21040'PE'#20998#26512
      OnClick = mniLoadPEClick
    end
  end
  object pmModule: TPopupMenu
    AutoHotkeys = maManual
    Left = 204
    Top = 508
    object mniOpenModulePath: TMenuItem
      Caption = #25171#24320#25991#20214#20301#32622
      OnClick = mniOpenModulePathClick
    end
    object mniEjectFromProcess: TMenuItem
      Caption = #20174#36827#31243#20013#24377#20986
      OnClick = mniEjectFromProcessClick
    end
    object mniDumpToDiskFile: TMenuItem
      Caption = 'Dump '#21040#30913#30424#25991#20214
    end
    object mniLine02: TMenuItem
      Caption = '-'
    end
    object mniCopySelectedModulePath: TMenuItem
      Caption = #22797#21046#25152#36873#27169#22359#36335#24452#21040#21098#20999#26495
      OnClick = mniCopySelectedModulePathClick
    end
    object mniCopySelectedModuleName: TMenuItem
      Caption = #22797#21046#25152#36873#27169#22359#21517#31216#21040#21098#20999#26495
      OnClick = mniCopySelectedModuleNameClick
    end
    object mniCopySelectedModuleMemoryAddress: TMenuItem
      Caption = #22797#21046#25152#36873#27169#22359#22320#22336#21040#21098#20999#26495
      OnClick = mniCopySelectedModuleMemoryAddressClick
    end
    object mniLine03: TMenuItem
      Caption = '-'
    end
    object mniSaveToFile: TMenuItem
      Caption = #27169#22359#21015#34920#20445#23384#21040#25991#20214
      OnClick = mniSaveToFileClick
    end
    object mniSelectedLineToSaveFile: TMenuItem
      Caption = #25152#36873#34892#20445#23384#21040#25991#20214
      OnClick = mniSelectedLineToSaveFileClick
    end
  end
  object adoconn: TADOConnection
    Left = 72
    Top = 108
  end
end