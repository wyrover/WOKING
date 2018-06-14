object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 574
  ClientWidth = 866
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
  DesignSize = (
    866
    574)
  PixelsPerInch = 96
  TextHeight = 13
  object img1: TImage
    Left = 8
    Top = 8
    Width = 749
    Height = 558
    Anchors = [akLeft, akTop, akRight, akBottom]
    ParentShowHint = False
    ShowHint = True
    Stretch = True
    ExplicitHeight = 489
  end
  object btn1: TButton
    Left = 763
    Top = 8
    Width = 95
    Height = 33
    Hint = #22823#22270#20687#26102#65292#26368#22909#19981#35201#28857#20987
    Anchors = [akTop, akRight]
    Caption = '1.Pixel'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 763
    Top = 49
    Width = 95
    Height = 33
    Anchors = [akTop, akRight]
    Caption = '2.API'
    TabOrder = 1
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 763
    Top = 91
    Width = 95
    Height = 33
    Anchors = [akTop, akRight]
    Caption = '3.ScanLine'
    TabOrder = 2
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 763
    Top = 132
    Width = 95
    Height = 33
    Anchors = [akTop, akRight]
    Caption = '4.'#28014#28857#20248#21270
    TabOrder = 3
    OnClick = btn4Click
  end
  object btn5: TButton
    Left = 763
    Top = 174
    Width = 95
    Height = 33
    Anchors = [akTop, akRight]
    Caption = '5.MMX'
    TabOrder = 4
    OnClick = btn5Click
  end
  object btn6: TButton
    Left = 763
    Top = 215
    Width = 95
    Height = 33
    Anchors = [akTop, akRight]
    Caption = '6.SSE'
    TabOrder = 5
    OnClick = btn6Click
  end
  object btn7: TButton
    Left = 763
    Top = 257
    Width = 95
    Height = 33
    Anchors = [akTop, akRight]
    Caption = '7.'#24182#34892
    TabOrder = 6
    OnClick = btn7Click
  end
  object btnOpenImageFile: TButton
    Left = 763
    Top = 533
    Width = 95
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = #25171#24320
    TabOrder = 7
    OnClick = btnOpenImageFileClick
  end
  object btnReset: TButton
    Left = 763
    Top = 494
    Width = 95
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = #37325#32622
    TabOrder = 8
    OnClick = btnResetClick
  end
  object btnInvert: TButton
    Left = 763
    Top = 453
    Width = 95
    Height = 35
    Anchors = [akRight, akBottom]
    Caption = #21453#33394'MMX'
    TabOrder = 9
    OnClick = btnInvertClick
  end
  object dlgOpenPic1: TOpenPictureDialog
    Left = 796
    Top = 360
  end
end
