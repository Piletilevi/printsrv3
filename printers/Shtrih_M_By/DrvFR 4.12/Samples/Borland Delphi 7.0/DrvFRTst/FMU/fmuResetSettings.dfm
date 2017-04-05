object fmResetSettings: TfmResetSettings
  Left = 602
  Top = 165
  AutoScroll = False
  Caption = #1054#1073#1085#1091#1083#1077#1085#1080#1077
  ClientHeight = 167
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblInitEEPROM: TLabel
    Left = 191
    Top = 78
    Width = 119
    Height = 13
    Caption = '('#1076#1083#1103' '#1041#1077#1083#1086#1088#1091#1089#1089#1082#1086#1075#1086' '#1060#1056')'
  end
  object btnResetSummary: TButton
    Left = 8
    Top = 40
    Width = 177
    Height = 25
    Hint = 'ResetSummary'
    Caption = #1054#1073#1097#1077#1077' '#1075#1072#1096#1077#1085#1080#1077
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnResetSummaryClick
  end
  object btnResetSettings: TButton
    Left = 8
    Top = 8
    Width = 177
    Height = 25
    Hint = 'ResetSettings'
    Caption = #1058#1077#1093#1085#1086#1083#1086#1075#1080#1095#1077#1089#1082#1086#1077' '#1086#1073#1085#1091#1083#1077#1085#1080#1077
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = btnResetSettingsClick
  end
  object btnInitEEPROM: TButton
    Left = 8
    Top = 72
    Width = 177
    Height = 25
    Hint = 'ResetSummary'
    Caption = #1048#1085#1080#1094#1080#1072#1083#1080#1079#1080#1088#1086#1074#1072#1090#1100' EEPROM'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnInitEEPROMClick
  end
end
