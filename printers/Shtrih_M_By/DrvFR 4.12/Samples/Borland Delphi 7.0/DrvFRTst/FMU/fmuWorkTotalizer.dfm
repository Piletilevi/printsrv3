object fmWorkTotalizer: TfmWorkTotalizer
  Left = 269
  Top = 203
  AutoScroll = False
  Caption = #1054#1087#1077#1088#1072#1094#1080#1086#1085#1085#1099#1077' '#1088#1077#1075#1080#1089#1090#1088#1099
  ClientHeight = 326
  ClientWidth = 496
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    496
    326)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 481
    Height = 281
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object btnStop: TButton
    Left = 400
    Top = 296
    Width = 89
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100
    Enabled = False
    TabOrder = 2
    OnClick = btnStopClick
  end
  object btnReadAll: TButton
    Left = 288
    Top = 296
    Width = 105
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100' '#1074#1089#1077
    TabOrder = 1
    OnClick = btnReadAllClick
  end
end
