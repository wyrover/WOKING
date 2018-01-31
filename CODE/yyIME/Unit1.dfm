object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'YY '#36755#20837#27861' v2.0'
  ClientHeight = 42
  ClientWidth = 275
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object srchbx1: TSearchBox
    Left = 13
    Top = 10
    Width = 121
    Height = 24
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyUp = srchbx1KeyUp
  end
  object pnl1: TPanel
    Left = 140
    Top = 9
    Width = 125
    Height = 26
    BevelOuter = bvNone
    Caption = 'pnl1'
    Enabled = False
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      125
      26)
    object edt2: TEdit
      Left = 4
      Top = 1
      Width = 117
      Height = 24
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
end
