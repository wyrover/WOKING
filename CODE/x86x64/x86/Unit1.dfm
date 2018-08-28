object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'X86'
  ClientHeight = 300
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 96
    Top = 96
    Width = 413
    Height = 89
    Caption = 'SendCopyDataToX64'
    TabOrder = 0
    OnClick = Button1Click
  end
end
