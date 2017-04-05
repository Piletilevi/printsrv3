object fmEJReports: TfmEJReports
  Left = 362
  Top = 241
  AutoScroll = False
  Caption = #1054#1090#1095#1077#1090#1099
  ClientHeight = 430
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    554
    430)
  PixelsPerInch = 96
  TextHeight = 13
  object lblReportType: TLabel
    Left = 8
    Top = 228
    Width = 58
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1058#1080#1087' '#1086#1090#1095#1077#1090#1072':'
  end
  object lblDepartment: TLabel
    Left = 8
    Top = 257
    Width = 34
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1054#1090#1076#1077#1083':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblFirstSessionNumber: TLabel
    Left = 8
    Top = 286
    Width = 93
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1089#1084#1077#1085#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblLastSessionNumber: TLabel
    Left = 8
    Top = 315
    Width = 86
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1089#1084#1077#1085#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblStartDate: TLabel
    Left = 8
    Top = 343
    Width = 84
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblEndDate: TLabel
    Left = 8
    Top = 371
    Width = 77
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object btnGetEKLZDepartmentReportInSessionsRange: TBitBtn
    Left = 338
    Top = 224
    Width = 209
    Height = 25
    Hint = 'GetEKLZDepartmentReportInSessionsRange'
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1086#1090#1076#1077#1083#1072#1084' '#1074' '#1076#1080#1072#1087#1072#1079#1086#1085#1077' '#1089#1084#1077#1085
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnGetEKLZDepartmentReportInSessionsRangeClick
  end
  object btnStop: TBitBtn
    Left = 338
    Top = 352
    Width = 209
    Height = 25
    Hint = #1055#1088#1077#1088#1074#1072#1090#1100
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = btnStopClick
  end
  object btnGetEKLZSessionReportInSessionsRange: TBitBtn
    Left = 338
    Top = 256
    Width = 209
    Height = 25
    Hint = 'GetEKLZSessionReportInSessionsRange'
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1089#1084#1077#1085#1072#1084' '#1074' '#1076#1080#1072#1087#1072#1079#1086#1085#1077' '#1089#1084#1077#1085
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = btnGetEKLZSessionReportInSessionsRangeClick
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 539
    Height = 209
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
  object btnGetEKLZDepartmentReportInDatesRange: TBitBtn
    Left = 338
    Top = 288
    Width = 209
    Height = 25
    Hint = 'GetEKLZDepartmentReportInDatesRange'
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1086#1090#1076#1077#1083#1072#1084' '#1074' '#1076#1080#1072#1087#1072#1079#1086#1085#1077' '#1076#1072#1090
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnGetEKLZDepartmentReportInDatesRangeClick
  end
  object btnGetEKLZSessionReportInDatesRange: TBitBtn
    Left = 338
    Top = 320
    Width = 209
    Height = 25
    Hint = 'GetEKLZSessionReportInDatesRange'
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1089#1084#1077#1085#1072#1084' '#1074' '#1076#1080#1072#1087#1072#1079#1086#1085#1077' '#1076#1072#1090
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = btnGetEKLZSessionReportInDatesRangeClick
  end
  object dtpFirstSessionDate: TDateTimePicker
    Left = 104
    Top = 339
    Width = 217
    Height = 21
    Hint = 'FirstSessionDate'
    Anchors = [akLeft, akRight, akBottom]
    Date = 37963.794682118110000000
    Time = 37963.794682118110000000
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
  object dtpLastSessionDate: TDateTimePicker
    Left = 104
    Top = 367
    Width = 217
    Height = 21
    Hint = 'LastSessionDate'
    Anchors = [akLeft, akRight, akBottom]
    Date = 37963.794682118110000000
    Time = 37963.794682118110000000
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
  end
  object cbReportType: TComboBox
    Left = 104
    Top = 224
    Width = 217
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akRight, akBottom]
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = #1082#1086#1088#1086#1090#1082#1080#1081
    Items.Strings = (
      #1082#1086#1088#1086#1090#1082#1080#1081
      #1087#1086#1083#1085#1099#1081)
  end
  object seDepartment: TSpinEdit
    Left = 104
    Top = 252
    Width = 217
    Height = 22
    Hint = 'Department'
    Anchors = [akLeft, akRight, akBottom]
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Value = 0
  end
  object seFirstSessionNumber: TSpinEdit
    Left = 104
    Top = 281
    Width = 217
    Height = 22
    Anchors = [akLeft, akRight, akBottom]
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 1
  end
  object seLastSessionNumber: TSpinEdit
    Left = 104
    Top = 310
    Width = 217
    Height = 22
    Hint = 'LastSessionNumber'
    Anchors = [akLeft, akRight, akBottom]
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Value = 1
  end
end
