object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
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
  object btn1: TButton
    Left = 16
    Top = 8
    Width = 145
    Height = 49
    Caption = 'fnTest'
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 167
    Top = 8
    Width = 145
    Height = 49
    Caption = 'CTest::CTest()'
    TabOrder = 1
    OnClick = btn2Click
  end
end
