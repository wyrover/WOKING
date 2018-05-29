object frmProcessManager: TfrmProcessManager
  Left = 0
  Top = 0
  Caption = 'frmProcessManager'
  ClientHeight = 752
  ClientWidth = 1013
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  DesignSize = (
    1013
    752)
  PixelsPerInch = 96
  TextHeight = 13
  object lvProcess: TListView
    Left = 8
    Top = 8
    Width = 997
    Height = 401
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = #24207#21015
        Width = 40
      end
      item
        Caption = #21517#31216
        Width = 130
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
        Caption = #25551#36848
        Width = 340
      end
      item
        Caption = #20844#21496
        Width = 170
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
    Left = 8
    Top = 420
    Width = 997
    Height = 324
    Anchors = [akLeft, akRight, akBottom]
    Columns = <
      item
        Caption = #24207#21015
        Width = 40
      end
      item
        Caption = #21517#31216
        Width = 130
      end
      item
        Caption = #36335#24452
        Width = 300
      end
      item
        Caption = #22320#22336
        Width = 140
      end
      item
        Caption = #22823#23567
        Width = 85
      end
      item
        Caption = #29256#26412#21495
        Width = 120
      end
      item
        Caption = #20844#21496
        Width = 172
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
  object pmProcess: TPopupMenu
    AutoHotkeys = maManual
    Left = 588
    Top = 324
    object mniOpenProcessPath: TMenuItem
      Caption = #25171#24320#25991#20214#20301#32622
      OnClick = mniOpenProcessPathClick
    end
    object mniRenameProcessName: TMenuItem
      Caption = #25991#20214#37325#21629#21517
      OnClick = mniRenameProcessNameClick
    end
    object mniDeleteProcessFile: TMenuItem
      Caption = #21024#38500
      OnClick = mniDeleteProcessFileClick
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
    Left = 588
    Top = 380
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
      OnClick = mniDumpToDiskFileClick
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
    object mniCopyFileTo: TMenuItem
      Caption = #22797#21046#25152#36873#25991#20214#21040'...'
      OnClick = mniCopyFileToClick
    end
    object mniSaveToFile: TMenuItem
      Caption = #27169#22359#21015#34920#20445#23384#21040#25991#20214
    end
    object mniSelectedLineToSaveFile: TMenuItem
      Caption = #25152#36873#34892#20445#23384#21040#25991#20214
    end
  end
end
