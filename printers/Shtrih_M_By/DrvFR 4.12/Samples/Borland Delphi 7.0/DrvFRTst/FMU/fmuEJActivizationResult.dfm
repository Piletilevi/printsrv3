object fmEJActivizationResult: TfmEJActivizationResult
  Left = 588
  Top = 268
  AutoScroll = False
  Caption = #1048#1090#1086#1075' '#1072#1082#1090#1080#1074#1080#1079#1072#1094#1080#1080
  ClientHeight = 270
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    312
    270)
  PixelsPerInch = 96
  TextHeight = 13
  object btnGetEKLZActivizationResult: TBitBtn
    Left = 40
    Top = 237
    Width = 161
    Height = 25
    Hint = 'GetEKLZActivizationResult'
    Anchors = [akRight, akBottom]
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1080#1090#1086#1075' '#1072#1082#1090#1080#1074#1080#1079#1072#1094#1080#1080
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnGetEKLZActivizationResultClick
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 297
    Height = 217
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object btnStop: TBitBtn
    Left = 208
    Top = 237
    Width = 97
    Height = 25
    Hint = #1055#1088#1077#1088#1074#1072#1090#1100
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnStopClick
  end
end
