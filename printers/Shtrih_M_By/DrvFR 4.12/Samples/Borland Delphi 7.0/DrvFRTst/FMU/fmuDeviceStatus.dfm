object fmDeviceStatus: TfmDeviceStatus
  Left = 420
  Top = 162
  AutoScroll = False
  Caption = #1047#1072#1087#1088#1086#1089#1099
  ClientHeight = 326
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    391
    326)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 233
    Height = 311
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
  object btnEcrStatus: TButton
    Left = 248
    Top = 8
    Width = 142
    Height = 25
    Hint = 'GetECRStatus'
    Anchors = [akTop, akRight]
    Caption = #1044#1083#1080#1085#1085#1099#1081' '#1079#1072#1087#1088#1086#1089
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnEcrStatusClick
  end
  object btnShortEcrStatus: TButton
    Left = 248
    Top = 40
    Width = 142
    Height = 25
    Hint = 'GetShortECRStatus'
    Anchors = [akTop, akRight]
    Caption = #1050#1088#1072#1090#1082#1080#1081' '#1079#1072#1087#1088#1086#1089
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnShortEcrStatusClick
  end
  object btnDeviceMetrics: TButton
    Left = 248
    Top = 72
    Width = 142
    Height = 25
    Hint = 'GetDeviceMetrics'
    Anchors = [akTop, akRight]
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnDeviceMetricsClick
  end
  object btnResetPrinter: TButton
    Left = 248
    Top = 168
    Width = 142
    Height = 25
    Hint = #1057#1073#1088#1086#1089#1080#1090#1100' '#1089#1086#1089#1090#1086#1103#1085#1080#1077
    Anchors = [akTop, akRight]
    Caption = #1057#1073#1088#1086#1089#1080#1090#1100' '#1089#1086#1089#1090#1086#1103#1085#1080#1077
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = btnResetPrinterClick
  end
  object btnGetModelParams: TButton
    Left = 248
    Top = 104
    Width = 142
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1084#1086#1076#1077#1083#1080
    TabOrder = 4
    OnClick = btnGetModelParamsClick
  end
  object btnDriverVersion: TButton
    Left = 248
    Top = 136
    Width = 142
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1042#1077#1088#1089#1080#1103' '#1076#1088#1072#1081#1074#1077#1088#1072
    TabOrder = 5
    OnClick = btnDriverVersionClick
  end
end
