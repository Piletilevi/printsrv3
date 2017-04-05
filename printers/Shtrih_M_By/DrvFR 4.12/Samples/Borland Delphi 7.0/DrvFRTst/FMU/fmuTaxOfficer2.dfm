object fmTaxOfficer2: TfmTaxOfficer2
  Left = 527
  Top = 206
  AutoScroll = False
  Caption = #1053#1048' 2'
  ClientHeight = 358
  ClientWidth = 516
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    516
    358)
  PixelsPerInch = 96
  TextHeight = 13
  object lblLastSessionNumber: TLabel
    Left = 8
    Top = 88
    Width = 86
    Height = 13
    Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1089#1084#1077#1085#1072':'
  end
  object lblFirstSessionNumber: TLabel
    Left = 8
    Top = 62
    Width = 93
    Height = 13
    Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1089#1084#1077#1085#1072':'
  end
  object lblLastSessionDate: TLabel
    Left = 8
    Top = 37
    Width = 77
    Height = 13
    Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072':'
  end
  object lblFirstSessionDate: TLabel
    Left = 8
    Top = 12
    Width = 84
    Height = 13
    Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072':'
  end
  object lblSessionNumber: TLabel
    Left = 8
    Top = 241
    Width = 74
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1089#1084#1077#1085#1099':'
  end
  object lblSumm1: TLabel
    Left = 8
    Top = 140
    Width = 49
    Height = 13
    Caption = #1055#1088#1086#1076#1072#1078#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblSumm3: TLabel
    Left = 8
    Top = 165
    Width = 46
    Height = 13
    Caption = #1055#1086#1082#1091#1087#1082#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblSumm2: TLabel
    Left = 8
    Top = 190
    Width = 86
    Height = 13
    Caption = #1042#1086#1079#1074#1088#1072#1090' '#1087#1088#1086#1076#1072#1078':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblSumm4: TLabel
    Left = 8
    Top = 215
    Width = 89
    Height = 13
    Caption = #1042#1086#1079#1074#1088#1072#1090' '#1087#1086#1082#1091#1087#1086#1082':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblECRDate: TLabel
    Left = 8
    Top = 266
    Width = 29
    Height = 13
    Caption = #1044#1072#1090#1072':'
  end
  object lblEKLZNumber: TLabel
    Left = 8
    Top = 291
    Width = 82
    Height = 13
    Caption = #1056#1077#1075#1080#1089#1090#1088'. '#1085#1086#1084#1077#1088':'
  end
  object lblRegistrationNumber: TLabel
    Left = 8
    Top = 114
    Width = 82
    Height = 13
    Caption = #8470' '#1072#1082#1090#1080#1074#1080#1079#1072#1094#1080#1080':'
  end
  object edtSessionNumber: TEdit
    Left = 104
    Top = 237
    Width = 151
    Height = 21
    Hint = 'SessionNumber'
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 9
  end
  object dtpFirstSessionDate: TDateTimePicker
    Left = 104
    Top = 8
    Width = 151
    Height = 21
    Hint = 'FirstSessionDate'
    Anchors = [akLeft, akTop, akRight]
    Date = 37963.865613229200000000
    Time = 37963.865613229200000000
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object dtpLastSessionDate: TDateTimePicker
    Left = 104
    Top = 33
    Width = 151
    Height = 21
    Hint = 'LastSessionDate'
    Anchors = [akLeft, akTop, akRight]
    Date = 37963.865613229200000000
    Time = 37963.865613229200000000
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object edtSumm1: TEdit
    Left = 104
    Top = 136
    Width = 151
    Height = 21
    Hint = 'Summ1'
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 5
  end
  object edtSumm2: TEdit
    Left = 104
    Top = 161
    Width = 151
    Height = 21
    Hint = 'Summ3'
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 6
  end
  object edtSumm3: TEdit
    Left = 104
    Top = 186
    Width = 151
    Height = 21
    Hint = 'Summ2'
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 7
  end
  object edtSumm4: TEdit
    Left = 104
    Top = 211
    Width = 151
    Height = 21
    Hint = 'Summ4'
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 8
  end
  object edtECRDate: TEdit
    Left = 104
    Top = 262
    Width = 151
    Height = 21
    Hint = 'Date'
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 10
  end
  object btnGetShortReportInSessionRange: TButton
    Left = 263
    Top = 40
    Width = 242
    Height = 25
    Hint = 'GetShortReportInSessionRange'
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1088#1086#1089' '#1082#1086#1088#1086#1090#1082#1086#1075#1086' '#1086#1090#1095#1077#1090#1072' '#1087#1086' '#1076#1080#1072#1087#1072#1079#1086#1085#1091' '#1089#1084#1077#1085
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    OnClick = btnGetShortReportInSessionRangeClick
  end
  object btnGetShortReportInDatesRange: TButton
    Left = 263
    Top = 8
    Width = 242
    Height = 25
    Hint = 'GetShortReportInDatesRange'
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1088#1086#1089' '#1082#1086#1088#1086#1090#1082#1086#1075#1086' '#1086#1090#1095#1077#1090#1072' '#1087#1086' '#1076#1080#1072#1087#1072#1079#1086#1085#1091' '#1076#1072#1090
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = btnGetShortReportInDatesRangeClick
  end
  object btnReadEKLZActivizationParams: TButton
    Left = 263
    Top = 72
    Width = 242
    Height = 25
    Hint = 'btnReadEKLZActivizationParams'
    Anchors = [akTop, akRight]
    Caption = #1063#1090#1077#1085#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1072#1082#1090#1080#1074#1080#1079#1072#1094#1080#1080' '#1069#1050#1051#1047
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    OnClick = btnReadEKLZActivizationParamsClick
  end
  object edtEKLZNumber: TEdit
    Left = 104
    Top = 287
    Width = 151
    Height = 21
    Hint = 'EKLZNumber'
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 11
  end
  object seFirstSessionNumber: TSpinEdit
    Left = 104
    Top = 58
    Width = 151
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 1
  end
  object seLastSessionNumber: TSpinEdit
    Left = 104
    Top = 84
    Width = 151
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 1
  end
  object seRegistrationNumber: TSpinEdit
    Left = 104
    Top = 110
    Width = 151
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 1
  end
end
