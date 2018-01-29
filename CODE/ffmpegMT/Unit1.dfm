object Form1: TForm1
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'Form1'
  ClientHeight = 530
  ClientWidth = 899
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    899
    530)
  PixelsPerInch = 96
  TextHeight = 13
  object chklst1: TCheckListBox
    Left = 8
    Top = 8
    Width = 773
    Height = 514
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = #23435#20307
    Font.Style = []
    ItemHeight = 15
    ParentFont = False
    TabOrder = 0
  end
  object btn1: TButton
    Left = 792
    Top = 52
    Width = 99
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #20462#25913
    TabOrder = 1
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 792
    Top = 8
    Width = 99
    Height = 33
    Anchors = [akTop, akRight]
    Caption = 'ffmpegVC'#30446#24405
    TabOrder = 2
    OnClick = btn2Click
  end
end
