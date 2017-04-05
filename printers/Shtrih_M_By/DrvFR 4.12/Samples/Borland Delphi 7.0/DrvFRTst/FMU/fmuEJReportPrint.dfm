object fmEJReportPrint: TfmEJReportPrint
  Left = 292
  Top = 213
  AutoScroll = False
  Caption = #1055#1077#1095#1072#1090#1100' '#1086#1090#1095#1077#1090#1086#1074
  ClientHeight = 192
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    480
    192)
  PixelsPerInch = 96
  TextHeight = 13
  object lblDepartment: TLabel
    Left = 67
    Top = 48
    Width = 34
    Height = 13
    Caption = #1054#1090#1076#1077#1083':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblStartDate: TLabel
    Left = 17
    Top = 135
    Width = 84
    Height = 13
    Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblEndDate: TLabel
    Left = 24
    Top = 163
    Width = 77
    Height = 13
    Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblFirstSessionNumber: TLabel
    Left = 8
    Top = 78
    Width = 93
    Height = 13
    Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1089#1084#1077#1085#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblLastSessionNumber: TLabel
    Left = 15
    Top = 107
    Width = 86
    Height = 13
    Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1089#1084#1077#1085#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblReportType: TLabel
    Left = 43
    Top = 20
    Width = 58
    Height = 13
    Caption = #1058#1080#1087' '#1086#1090#1095#1077#1090#1072':'
  end
  object dtpStartDate: TDateTimePicker
    Left = 107
    Top = 131
    Width = 150
    Height = 21
    Hint = 'FirstSessionDate'
    Anchors = [akLeft, akTop, akRight]
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
    TabOrder = 4
  end
  object dtpEndDate: TDateTimePicker
    Left = 107
    Top = 159
    Width = 150
    Height = 21
    Hint = 'LastSessionDate'
    Anchors = [akLeft, akTop, akRight]
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
  object btnEKLZDepartmentReportInDatesRange: TButton
    Left = 271
    Top = 80
    Width = 201
    Height = 25
    Hint = 'EKLZDepartmentReportInDatesRange'
    Anchors = [akTop, akRight]
    Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1086#1090#1076#1077#1083#1072#1084' '#1074' '#1076#1080#1072#1087#1072#1079#1086#1085#1077' '#1076#1072#1090
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = btnEKLZDepartmentReportInDatesRangeClick
  end
  object btnEKLZSessionReportInDatesRange: TButton
    Left = 271
    Top = 112
    Width = 201
    Height = 25
    Hint = 'EKLZSessionReportInDatesRange'
    Anchors = [akTop, akRight]
    Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1089#1084#1077#1085#1072#1084' '#1074' '#1076#1080#1072#1087#1072#1079#1086#1085#1077' '#1076#1072#1090
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnEKLZSessionReportInDatesRangeClick
  end
  object btnEKLZDepartmentReportInSessionsRange: TButton
    Left = 271
    Top = 16
    Width = 201
    Height = 25
    Hint = 'EKLZDepartmentReportInSessionsRange'
    Anchors = [akTop, akRight]
    Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1086#1090#1076#1077#1083#1072#1084' '#1074' '#1076#1080#1072#1087#1072#1079#1086#1085#1077' '#1089#1084#1077#1085
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = btnEKLZDepartmentReportInSessionsRangeClick
  end
  object btnEKLZSessionReportInSessionsRange: TButton
    Left = 271
    Top = 48
    Width = 201
    Height = 25
    Hint = 'EKLZSessionReportInSessionsRange'
    Anchors = [akTop, akRight]
    Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1089#1084#1077#1085#1072#1084' '#1074' '#1076#1080#1072#1087#1072#1079#1086#1085#1077' '#1089#1084#1077#1085
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnEKLZSessionReportInSessionsRangeClick
  end
  object cbReportType: TComboBox
    Left = 107
    Top = 16
    Width = 150
    Height = 21
    Hint = 'ReportType'
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    ItemIndex = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = #1082#1086#1088#1086#1090#1082#1080#1081
    Items.Strings = (
      #1082#1086#1088#1086#1090#1082#1080#1081
      #1087#1086#1083#1085#1099#1081)
  end
  object btnInterruptPrint: TButton
    Left = 271
    Top = 144
    Width = 201
    Height = 25
    Hint = 'StopEKLZDocumentPrinting'
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100' '#1087#1077#1095#1072#1090#1100' '#1086#1090#1095#1077#1090#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = btnInterruptPrintClick
  end
  object seDepartment: TSpinEdit
    Left = 107
    Top = 44
    Width = 150
    Height = 22
    Hint = 'Department'
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Value = 0
  end
  object seFirstSessionNumber: TSpinEdit
    Left = 107
    Top = 73
    Width = 150
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 1
  end
  object seLastSessionNumber: TSpinEdit
    Left = 107
    Top = 102
    Width = 150
    Height = 22
    Hint = 'LastSessionNumber'
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Value = 1
  end
end
