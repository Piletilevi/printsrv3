object fmReports: TfmReports
  Left = 328
  Top = 208
  AutoScroll = False
  Caption = #1054#1090#1095#1077#1090#1099
  ClientHeight = 222
  ClientWidth = 429
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnPrintDepartmentReport: TButton
    Left = 8
    Top = 104
    Width = 177
    Height = 25
    Hint = 'PrintDepartmentReport'
    Caption = #1057#1085#1103#1090#1100' '#1086#1090#1095#1105#1090' '#1087#1086' '#1086#1090#1076#1077#1083#1072#1084
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnPrintDepartmentReportClick
  end
  object btnPrintReportWithCleaning: TButton
    Left = 8
    Top = 40
    Width = 177
    Height = 25
    Hint = 'PrintReportWithCleaning'
    Caption = #1057#1085#1103#1090#1100' '#1086#1090#1095#1105#1090' '#1089' '#1075#1072#1096#1077#1085#1080#1077#1084
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnPrintReportWithCleaningClick
  end
  object btnPrintTaxReport: TButton
    Left = 8
    Top = 136
    Width = 177
    Height = 25
    Hint = 'PrintTaxReport'
    Caption = #1057#1085#1103#1090#1100' '#1086#1090#1095#1077#1090' '#1087#1086' '#1085#1072#1083#1086#1075#1072#1084
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnPrintTaxReportClick
  end
  object btnPrintOperationReg: TButton
    Left = 8
    Top = 168
    Width = 177
    Height = 25
    Hint = 'PrintOperationReg'
    Caption = #1055#1077#1095#1072#1090#1100' '#1086#1087#1077#1088#1072#1094#1080#1086#1085#1085#1099#1093' '#1088#1077#1075#1080#1089#1090#1088#1086#1074
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btnPrintOperationRegClick
  end
  object btnPrintReportWithoutCleaning: TButton
    Left = 8
    Top = 72
    Width = 177
    Height = 25
    Hint = 'PrintReportWithoutCleaning'
    Caption = #1057#1085#1103#1090#1100' '#1086#1090#1095#1105#1090' '#1073#1077#1079' '#1075#1072#1096#1077#1085#1080#1103
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnPrintReportWithoutCleaningClick
  end
  object btnOpenSession: TButton
    Left = 8
    Top = 8
    Width = 177
    Height = 25
    Hint = 'OpenSession'
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1089#1084#1077#1085#1091
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = btnOpenSessionClick
  end
  object btnPrintZReportInBuffer: TButton
    Left = 192
    Top = 8
    Width = 233
    Height = 25
    Hint = 'PrintZReportInBuffer'
    Caption = #1057#1085#1103#1090#1100' '#1086#1090#1095#1105#1090' '#1089' '#1075#1072#1096#1077#1085#1080#1077#1084' '#1074' '#1073#1091#1092#1077#1088
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = btnPrintZReportInBufferClick
  end
  object btnPrintZReportFromBuffer: TButton
    Left = 192
    Top = 40
    Width = 233
    Height = 25
    Hint = 'PrintZReportFromBuffer'
    Caption = #1056#1072#1089#1087#1077#1095#1072#1090#1072#1090#1100' '#1086#1090#1095#1105#1090' '#1089' '#1075#1072#1096#1077#1085#1080#1077#1084' '#1080#1079' '#1073#1091#1092#1077#1088#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnPrintZReportFromBufferClick
  end
  object btnPrintCashierReport: TButton
    Left = 192
    Top = 72
    Width = 233
    Height = 25
    Hint = 'PrintCashierReport'
    Caption = #1057#1085#1103#1090#1100' '#1086#1090#1095#1105#1090' '#1087#1086' '#1082#1072#1089#1089#1080#1088#1072#1084
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = btnPrintCashierReportClick
  end
  object btnPrintHourlyReport: TButton
    Left = 192
    Top = 104
    Width = 233
    Height = 25
    Hint = 'PrintHourlyReport'
    Caption = #1057#1085#1103#1090#1100' '#1086#1090#1095#1105#1090' '#1087#1086#1095#1072#1089#1086#1074#1086#1081
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnPrintHourlyReportClick
  end
  object btnPrintWareReport: TButton
    Left = 192
    Top = 136
    Width = 233
    Height = 25
    Hint = 'PrintWareReport'
    Caption = #1057#1085#1103#1090#1100' '#1086#1090#1095#1105#1090' '#1087#1086' '#1090#1086#1074#1072#1088#1072#1084
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = btnPrintWareReportClick
  end
end
