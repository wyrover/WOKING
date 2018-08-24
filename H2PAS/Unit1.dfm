object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'H2PAS(dll)'
  ClientHeight = 655
  ClientWidth = 1223
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  DesignSize = (
    1223
    655)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 126
    Height = 12
    Caption = #22836#25991#20214'(*.H;*.HPP)  '#65306
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 39
    Width = 126
    Height = 12
    Caption = #21160#24577#24211#25991#20214#21517#31216'(dll)'#65306
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object SearchBox1: TSearchBox
    Left = 140
    Top = 8
    Width = 1073
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnDblClick = SearchBox1InvokeSearch
    OnInvokeSearch = SearchBox1InvokeSearch
  end
  object Edit1: TEdit
    Left = 140
    Top = 35
    Width = 201
    Height = 21
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object SynEdit1: TSynEdit
    Left = 8
    Top = 68
    Width = 601
    Height = 579
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 2
    CodeFolding.GutterShapeSize = 11
    CodeFolding.CollapsedLineColor = clGrayText
    CodeFolding.FolderBarLinesColor = clGrayText
    CodeFolding.IndentGuidesColor = clGray
    CodeFolding.IndentGuides = True
    CodeFolding.ShowCollapsedLine = False
    CodeFolding.ShowHintMark = True
    UseCodeFolding = False
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Highlighter = SynCppSyn1
    ReadOnly = True
    RightEdge = 0
    FontSmoothing = fsmNone
  end
  object SynEdit2: TSynEdit
    Left = 615
    Top = 68
    Width = 601
    Height = 579
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 3
    CodeFolding.GutterShapeSize = 11
    CodeFolding.CollapsedLineColor = clGrayText
    CodeFolding.FolderBarLinesColor = clGrayText
    CodeFolding.IndentGuidesColor = clGray
    CodeFolding.IndentGuides = True
    CodeFolding.ShowCollapsedLine = False
    CodeFolding.ShowHintMark = True
    UseCodeFolding = False
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Highlighter = SynPasSyn1
    RightEdge = 0
    FontSmoothing = fsmNone
  end
  object btnSaveToFile: TButton
    Left = 1138
    Top = 36
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #20445#23384
    Enabled = False
    TabOrder = 4
    OnClick = btnSaveToFileClick
  end
  object btnTrans: TButton
    Left = 1057
    Top = 36
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #32763#35793
    Enabled = False
    TabOrder = 5
    OnClick = btnTransClick
  end
  object SynCppSyn1: TSynCppSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    CommentAttri.Foreground = clGreen
    DirecAttri.Foreground = 33023
    KeyAttri.Foreground = 10485760
    SymbolAttri.Foreground = clBlue
    Left = 416
    Top = 256
  end
  object SynPasSyn1: TSynPasSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    KeyAttri.Foreground = clBlue
    StringAttri.Foreground = clGreen
    Left = 848
    Top = 304
  end
end
