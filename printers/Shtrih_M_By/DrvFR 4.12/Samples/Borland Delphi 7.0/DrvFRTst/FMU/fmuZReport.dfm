object fmZReport: TfmZReport
  Left = 658
  Top = 444
  AutoScroll = False
  Caption = 'Z-'#1086#1090#1095#1077#1090
  ClientHeight = 326
  ClientWidth = 498
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    498
    326)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 481
    Height = 265
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object btnRead: TBitBtn
    Left = 304
    Top = 289
    Width = 89
    Height = 25
    Hint = 'GetOperationReg'
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnReadClick
  end
  object btnStop: TButton
    Left = 400
    Top = 289
    Width = 89
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100
    Enabled = False
    TabOrder = 2
    OnClick = btnStopClick
  end
end
