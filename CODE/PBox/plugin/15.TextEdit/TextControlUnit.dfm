object TextControlForm: TTextControlForm
  Left = 257
  Top = 178
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #25991#26412#25991#20214#25511#21046#65306
  ClientHeight = 409
  ClientWidth = 657
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 517
    Height = 24
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    OnDblClick = Button1Click
  end
  object Button1: TButton
    Left = 532
    Top = 7
    Width = 75
    Height = 25
    Caption = #25171#24320
    TabOrder = 1
    OnClick = Button1Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 39
    Width = 641
    Height = 357
    Caption = #25805#20316#31867#22411#65306' '
    Color = clWhite
    Ctl3D = True
    ParentBackground = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 2
    object Label1: TLabel
      Left = 9
      Top = 176
      Width = 340
      Height = 13
      AutoSize = False
      Caption = #21024#38500#21253#21547#29305#23450#23383#31526#20018#30340#34892
    end
    object Label2: TLabel
      Left = 9
      Top = 225
      Width = 340
      Height = 13
      AutoSize = False
      Caption = #21024#38500#21253#21547#29305#23450#23383#31526#20018#21069#38754#30340#23383#31526#20018'('#21253#21547#26412#23383#31526#20018')'
    end
    object Label3: TLabel
      Left = 9
      Top = 250
      Width = 340
      Height = 13
      AutoSize = False
      Caption = #21024#38500#21253#21547#29305#23450#23383#31526#20018#21069#38754#30340#23383#31526#20018'('#19981#21253#21547#26412#23383#31526#20018')'
    end
    object Label4: TLabel
      Left = 9
      Top = 275
      Width = 340
      Height = 13
      AutoSize = False
      Caption = #21024#38500#21253#21547#29305#23450#23383#31526#20018#21518#38754#38754#30340#23383#31526#20018'('#21253#21547#26412#23383#31526#20018')'
    end
    object Label5: TLabel
      Left = 9
      Top = 300
      Width = 340
      Height = 13
      AutoSize = False
      Caption = #21024#38500#21253#21547#29305#23450#23383#31526#20018#21518#38754#38754#30340#23383#31526#20018'('#19981#21253#21547#26412#23383#31526#20018')'
    end
    object Label7: TLabel
      Left = 9
      Top = 51
      Width = 340
      Height = 13
      AutoSize = False
      Caption = #28155#21152#34892#21495'('#40664#35748#20174'0'#24320#22987')'
    end
    object Label8: TLabel
      Left = 9
      Top = 200
      Width = 340
      Height = 13
      AutoSize = False
      Caption = #21024#38500#19981#21253#21547#29305#23450#23383#31526#20018#30340#34892
    end
    object Label10: TLabel
      Left = 9
      Top = 325
      Width = 36
      Height = 13
      Caption = #25628#32034#65306
    end
    object Label11: TLabel
      Left = 316
      Top = 324
      Width = 36
      Height = 13
      Caption = #26367#25442#65306
    end
    object Label9: TLabel
      Left = 9
      Top = 26
      Width = 340
      Height = 13
      AutoSize = False
      Caption = #21024#38500#31354#34892
    end
    object Label12: TLabel
      Left = 9
      Top = 76
      Width = 340
      Height = 13
      AutoSize = False
      Caption = #21024#38500#34892#39318#23614#31354#26684
    end
    object Label6: TLabel
      Left = 9
      Top = 151
      Width = 340
      Height = 13
      AutoSize = False
      Caption = #21024#38500'Pas'#25991#20214#20013#30340#24110#21161
    end
    object Label14: TLabel
      Left = 9
      Top = 101
      Width = 340
      Height = 13
      AutoSize = False
      Caption = #22312#34892#23614#28155#21152#23383#31526#20018#65306
    end
    object Label15: TLabel
      Left = 9
      Top = 126
      Width = 340
      Height = 13
      AutoSize = False
      Caption = #22312#34892#39318#28155#21152#23383#31526#20018#65306
    end
    object Edit2: TEdit
      Left = 359
      Top = 172
      Width = 161
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Button2: TButton
      Tag = 2
      Left = 523
      Top = 171
      Width = 75
      Height = 21
      Caption = #30830#23450
      TabOrder = 1
      OnClick = Button2Click
    end
    object Edit3: TEdit
      Left = 359
      Top = 222
      Width = 161
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object Button3: TButton
      Tag = 3
      Left = 523
      Top = 221
      Width = 75
      Height = 21
      Caption = #30830#23450
      TabOrder = 3
      OnClick = Button2Click
    end
    object Edit4: TEdit
      Left = 359
      Top = 247
      Width = 161
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object Button4: TButton
      Tag = 4
      Left = 523
      Top = 246
      Width = 75
      Height = 21
      Caption = #30830#23450
      TabOrder = 5
      OnClick = Button2Click
    end
    object Edit5: TEdit
      Left = 359
      Top = 272
      Width = 161
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object Button5: TButton
      Tag = 5
      Left = 523
      Top = 271
      Width = 75
      Height = 21
      Caption = #30830#23450
      TabOrder = 7
      OnClick = Button2Click
    end
    object Edit6: TEdit
      Left = 359
      Top = 297
      Width = 161
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object Button6: TButton
      Tag = 6
      Left = 523
      Top = 296
      Width = 75
      Height = 21
      Caption = #30830#23450
      TabOrder = 9
      OnClick = Button2Click
    end
    object Button8: TButton
      Left = 523
      Top = 46
      Width = 75
      Height = 21
      Caption = #30830#23450
      TabOrder = 10
      OnClick = Button8Click
    end
    object Edit7: TEdit
      Left = 359
      Top = 197
      Width = 161
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
    object Button9: TButton
      Tag = 7
      Left = 523
      Top = 196
      Width = 75
      Height = 21
      Caption = #30830#23450
      TabOrder = 12
      OnClick = Button2Click
    end
    object Edit8: TEdit
      Left = 52
      Top = 323
      Width = 229
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
    object Edit9: TEdit
      Left = 359
      Top = 322
      Width = 161
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 14
    end
    object Button10: TButton
      Tag = 8
      Left = 523
      Top = 322
      Width = 75
      Height = 21
      Caption = #30830#23450
      TabOrder = 15
      OnClick = Button2Click
    end
    object Button11: TButton
      Left = 523
      Top = 21
      Width = 75
      Height = 21
      Caption = #30830#23450
      TabOrder = 16
      OnClick = Button11Click
    end
    object Button12: TButton
      Left = 523
      Top = 71
      Width = 75
      Height = 21
      Caption = #30830#23450
      TabOrder = 17
      OnClick = Button12Click
    end
    object Button7: TButton
      Tag = 7
      Left = 523
      Top = 146
      Width = 75
      Height = 21
      Caption = #30830#23450
      TabOrder = 18
      OnClick = Button7Click
    end
    object Edit10: TEdit
      Left = 359
      Top = 97
      Width = 161
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 19
    end
    object Edit11: TEdit
      Left = 359
      Top = 122
      Width = 161
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 20
    end
    object Button15: TButton
      Left = 523
      Top = 121
      Width = 75
      Height = 21
      Caption = #30830#23450
      TabOrder = 21
      OnClick = Button15Click
    end
    object Button14: TButton
      Left = 523
      Top = 96
      Width = 75
      Height = 21
      Caption = #30830#23450
      TabOrder = 22
      OnClick = Button14Click
    end
    object edtNumStartIndex: TEdit
      Left = 360
      Top = 46
      Width = 161
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 23
      OnKeyPress = edtNumStartIndexKeyPress
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'Text|(*.txt;*.pas;*.c;*.cpp;*.h;*.hpp)|*.txt;*.pas;*.c;*.cpp;*.h' +
      ';*.hpp'
    Left = 428
    Top = 4
  end
end
