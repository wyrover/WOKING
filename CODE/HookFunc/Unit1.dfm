object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'HOOK '#20989#25968
  ClientHeight = 309
  ClientWidth = 645
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblProcess: TLabel
    Left = 16
    Top = 16
    Width = 65
    Height = 13
    Caption = #36827#31243#21015#34920#65306
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lblModule: TLabel
    Left = 16
    Top = 72
    Width = 65
    Height = 13
    Caption = #27169#22359#21015#34920#65306
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object lblFunc: TLabel
    Left = 16
    Top = 128
    Width = 65
    Height = 13
    Caption = #20989#25968#21015#34920#65306
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object cbbProcess: TComboBox
    Left = 28
    Top = 35
    Width = 225
    Height = 21
    Style = csDropDownList
    DropDownCount = 20
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = cbbProcessChange
  end
  object cbbMoudule: TComboBox
    Left = 28
    Top = 91
    Width = 225
    Height = 21
    Style = csDropDownList
    DropDownCount = 20
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object cbbFunc: TComboBox
    Left = 28
    Top = 147
    Width = 225
    Height = 21
    Style = csDropDownList
    DropDownCount = 20
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
end
