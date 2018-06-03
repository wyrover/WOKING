object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Test01'
  ClientHeight = 532
  ClientWidth = 841
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
    841
    532)
  PixelsPerInch = 96
  TextHeight = 13
  object img1: TImage
    Left = 8
    Top = 8
    Width = 701
    Height = 516
    Anchors = [akLeft, akTop, akRight, akBottom]
    Stretch = True
  end
  object btn1: TButton
    Left = 720
    Top = 8
    Width = 113
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #27979#35797'01'
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 720
    Top = 49
    Width = 113
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #27979#35797'02'
    TabOrder = 1
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 720
    Top = 91
    Width = 113
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #27979#35797'03'
    TabOrder = 2
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 720
    Top = 132
    Width = 113
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'btn1'
    TabOrder = 3
  end
  object btn5: TButton
    Left = 720
    Top = 174
    Width = 113
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'btn1'
    TabOrder = 4
  end
  object btn6: TButton
    Left = 720
    Top = 215
    Width = 113
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'btn1'
    TabOrder = 5
  end
  object btn7: TButton
    Left = 720
    Top = 257
    Width = 113
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'btn1'
    TabOrder = 6
  end
  object btn8: TButton
    Left = 720
    Top = 299
    Width = 113
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'btn1'
    TabOrder = 7
  end
  object mmo1: TMemo
    Left = 8
    Top = 8
    Width = 701
    Height = 516
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'SimSun'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 8
    WordWrap = False
  end
  object dlgOpenPic1: TOpenPictureDialog
    Left = 372
    Top = 244
  end
end
