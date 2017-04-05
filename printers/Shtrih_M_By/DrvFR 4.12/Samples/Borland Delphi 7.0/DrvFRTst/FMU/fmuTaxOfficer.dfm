object fmTaxOfficer: TfmTaxOfficer
  Left = 304
  Top = 200
  AutoScroll = False
  Caption = #1053#1048
  ClientHeight = 324
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    457
    324)
  PixelsPerInch = 96
  TextHeight = 13
  object lblLastSessionNumber: TLabel
    Left = 8
    Top = 188
    Width = 86
    Height = 13
    Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1089#1084#1077#1085#1072':'
  end
  object lblFirstSessionNumber: TLabel
    Left = 8
    Top = 164
    Width = 93
    Height = 13
    Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1089#1084#1077#1085#1072':'
  end
  object lblLastSessionDate: TLabel
    Left = 8
    Top = 140
    Width = 77
    Height = 13
    Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072':'
  end
  object lblFirstSessionDate: TLabel
    Left = 8
    Top = 116
    Width = 84
    Height = 13
    Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072':'
  end
  object lblDate: TLabel
    Left = 8
    Top = 212
    Width = 106
    Height = 13
    Caption = #1044#1072#1090#1072' '#1092#1080#1089#1082#1072#1083#1080#1079#1072#1094#1080#1080':'
  end
  object lblSessionNumber: TLabel
    Left = 8
    Top = 284
    Width = 190
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1089#1084#1077#1085#1099' '#1087#1077#1088#1077#1076' '#1092#1080#1089#1082#1072#1083#1080#1079#1072#1094#1080#1077#1081':'
  end
  object lblFreeRegistration: TLabel
    Left = 8
    Top = 260
    Width = 202
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1089#1090#1072#1074#1096#1080#1093#1089#1103' '#1092#1080#1089#1082#1072#1083#1080#1079#1072#1094#1080#1081':'
  end
  object lblRegistrationNumber: TLabel
    Left = 8
    Top = 236
    Width = 114
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1092#1080#1089#1082#1072#1083#1080#1079#1072#1094#1080#1080':'
  end
  object lblINN: TLabel
    Left = 8
    Top = 68
    Width = 27
    Height = 13
    Caption = #1048#1053#1053':'
  end
  object lblRNM: TLabel
    Left = 8
    Top = 44
    Width = 27
    Height = 13
    Caption = #1056#1053#1052':'
  end
  object lblNewPasswordTI: TLabel
    Left = 8
    Top = 20
    Width = 95
    Height = 13
    Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100' '#1053#1048':'
  end
  object lblReportType: TLabel
    Left = 8
    Top = 92
    Width = 58
    Height = 13
    Caption = #1058#1080#1087' '#1086#1090#1095#1077#1090#1072':'
  end
  object btnFiscalization: TButton
    Left = 277
    Top = 16
    Width = 169
    Height = 25
    Hint = 'Fiscalization'
    Anchors = [akTop, akRight]
    Caption = #1060#1080#1089#1082#1072#1083#1080#1079#1072#1094#1080#1103
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = btnFiscalizationClick
  end
  object btnGetFiscalizationParameters: TButton
    Left = 277
    Top = 48
    Width = 169
    Height = 25
    Hint = 'GetFiscalizationParameters'
    Anchors = [akTop, akRight]
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1092#1080#1089#1082#1072#1083#1080#1079#1072#1094#1080#1080
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    OnClick = btnGetFiscalizationParametersClick
  end
  object btnGetRangeDatesAndSessions: TButton
    Left = 277
    Top = 80
    Width = 169
    Height = 25
    Hint = 'GetRangeDatesAndSessions'
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1076#1080#1072#1087#1072#1079#1086#1085' '#1076#1072#1090' '#1080' '#1089#1084#1077#1085
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    OnClick = btnGetRangeDatesAndSessionsClick
  end
  object btnFiscalReportforDatesRange: TButton
    Left = 277
    Top = 112
    Width = 169
    Height = 25
    Hint = 'FiscalReportforDatesRange'
    Anchors = [akTop, akRight]
    Caption = #1054#1090#1095#1105#1090' '#1087#1086' '#1076#1080#1072#1087#1072#1079#1086#1085#1091' '#1076#1072#1090
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    OnClick = btnFiscalReportforDatesRangeClick
  end
  object btnFiscalReportforSessionRange: TButton
    Left = 277
    Top = 144
    Width = 169
    Height = 25
    Hint = 'FiscalReportforSessionRange'
    Anchors = [akTop, akRight]
    Caption = #1054#1090#1095#1105#1090' '#1087#1086' '#1076#1080#1072#1087#1072#1079#1086#1085#1091' '#1089#1084#1077#1085
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    OnClick = btnFiscalReportforSessionRangeClick
  end
  object btnInterruptFullReport: TButton
    Left = 277
    Top = 176
    Width = 169
    Height = 25
    Hint = 'InterruptFullReport'
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100' '#1087#1086#1083#1085#1099#1081' '#1086#1090#1095#1105#1090
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    OnClick = btnInterruptFullReportClick
  end
  object edtNewPasswordTI: TEdit
    Left = 128
    Top = 16
    Width = 137
    Height = 21
    Hint = 'NewPasswordTI'
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = '0'
    OnKeyPress = edtNewPasswordTIKeyPress
  end
  object edtRNM: TEdit
    Left = 128
    Top = 40
    Width = 137
    Height = 21
    Hint = 'RNM'
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Text = '0'
    OnKeyPress = edtNewPasswordTIKeyPress
  end
  object edtINN: TEdit
    Left = 128
    Top = 64
    Width = 137
    Height = 21
    Hint = 'INN'
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = '0'
    OnKeyPress = edtNewPasswordTIKeyPress
  end
  object edtFreeRegistration: TEdit
    Left = 216
    Top = 256
    Width = 49
    Height = 21
    Hint = 'FreeRegistration'
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 10
  end
  object edtSessionNumber: TEdit
    Left = 216
    Top = 280
    Width = 49
    Height = 21
    Hint = 'SessionNumber'
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 11
  end
  object edtDate: TEdit
    Left = 128
    Top = 208
    Width = 137
    Height = 21
    Hint = 'Date'
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 8
  end
  object dtpFirstSessionDate: TDateTimePicker
    Left = 128
    Top = 112
    Width = 137
    Height = 21
    Hint = 'FirstSessionDate'
    Anchors = [akLeft, akTop, akRight]
    Date = 37963.865613229200000000
    Time = 37963.865613229200000000
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object dtpLastSessionDate: TDateTimePicker
    Left = 128
    Top = 136
    Width = 137
    Height = 21
    Hint = 'LastSessionDate'
    Anchors = [akLeft, akTop, akRight]
    Date = 37963.865613229200000000
    Time = 37963.865613229200000000
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
  object cbReportType: TComboBox
    Left = 128
    Top = 88
    Width = 137
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = #1082#1086#1088#1086#1090#1082#1080#1081
    Items.Strings = (
      #1082#1086#1088#1086#1090#1082#1080#1081
      #1076#1083#1080#1085#1085#1099#1081)
  end
  object btnOperationalTaxReport: TButton
    Left = 277
    Top = 208
    Width = 169
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1054#1087#1077#1088#1072#1090#1080#1074#1085#1099#1081' '#1086#1090#1095#1077#1090' '#1053#1048
    TabOrder = 18
    OnClick = btnOperationalTaxReportClick
  end
  object seFirstSessionNumber: TSpinEdit
    Left = 128
    Top = 160
    Width = 137
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    TabOrder = 6
    Value = 0
  end
  object seLastSessionNumber: TSpinEdit
    Left = 128
    Top = 184
    Width = 137
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    TabOrder = 7
    Value = 0
  end
  object seRegistrationNumber: TSpinEdit
    Left = 128
    Top = 232
    Width = 137
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    TabOrder = 9
    Value = 0
  end
end
