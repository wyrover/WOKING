object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 500
  ClientWidth = 832
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    832
    500)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 4
    Top = 8
    Width = 717
    Height = 482
    Anchors = [akLeft, akTop, akRight, akBottom]
    Stretch = True
  end
  object btn1: TButton
    Left = 732
    Top = 8
    Width = 92
    Height = 37
    Anchors = [akTop, akRight]
    Caption = #25171#24320
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btn1Click
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 152
    Top = 136
  end
end
