object fmReportBuffer: TfmReportBuffer
  Left = 372
  Top = 168
  AutoScroll = False
  Caption = #1041#1091#1092#1077#1088' '#1086#1090#1095#1077#1090#1072
  ClientHeight = 330
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    525
    330)
  PixelsPerInch = 96
  TextHeight = 13
  object lblLineNumber: TLabel
    Left = 8
    Top = 39
    Width = 75
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1089#1090#1088#1086#1082#1080':'
  end
  object lblPrintBufferFormat: TLabel
    Left = 8
    Top = 65
    Width = 83
    Height = 13
    Caption = #1060#1086#1088#1084#1072#1090' '#1089#1090#1088#1086#1082#1080':'
  end
  object lbl1: TLabel
    Left = 8
    Top = 13
    Width = 70
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1086#1090#1095#1077#1090#1072
  end
  object Memo: TMemo
    Left = 8
    Top = 86
    Width = 336
    Height = 234
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 7
    WordWrap = False
  end
  object btnGetAllReports: TButton
    Left = 353
    Top = 72
    Width = 163
    Height = 25
    Hint = #1055#1086#1083#1091#1095#1080#1090#1100' '#1074#1077#1089#1100' '#1073#1091#1092#1077#1088
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1074#1077#1089#1100' '#1073#1091#1092#1077#1088
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnGetAllReportsClick
  end
  object btnGetReportStringFromBuffer: TButton
    Left = 353
    Top = 8
    Width = 163
    Height = 25
    Hint = 'ReadPrintBufferLine'
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1089#1090#1088#1086#1082#1091
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnGetReportStringFromBufferClick
  end
  object cbPrintBufferFormat: TComboBox
    Left = 101
    Top = 61
    Width = 243
    Height = 21
    Hint = 'PrintBufferFormat'
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    ItemIndex = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = #1041#1077#1079' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
    Items.Strings = (
      #1041#1077#1079' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
      'HEX '#1092#1086#1088#1084#1072#1090
      #1058#1086#1083#1100#1082#1086' ASCII '#1090#1077#1082#1089#1090)
  end
  object btnClear: TButton
    Left = 353
    Top = 176
    Width = 163
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 6
    OnClick = btnClearClick
  end
  object btnStop: TButton
    Left = 353
    Top = 104
    Width = 163
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100
    TabOrder = 4
    OnClick = btnStopClick
  end
  object btnSave: TBitBtn
    Left = 353
    Top = 144
    Width = 163
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100'...'
    TabOrder = 5
    OnClick = btnSaveClick
    Margin = 10
    Spacing = 25
  end
  object btnGetReport: TButton
    Left = 353
    Top = 40
    Width = 163
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1086#1090#1095#1077#1090
    TabOrder = 2
    OnClick = btnGetReportClick
  end
  object seLineNumber: TSpinEdit
    Left = 101
    Top = 35
    Width = 243
    Height = 22
    Hint = 'LineNumber'
    MaxValue = 65535
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    Value = 0
  end
  object seDocumentNumber: TSpinEdit
    Left = 101
    Top = 9
    Width = 243
    Height = 22
    Hint = 'LineNumber'
    MaxValue = 65535
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    Value = 0
  end
  object dlgSave: TSaveDialog
    DefaultExt = '.txt'
    Filter = 'txt|*.txt|*.*|*.*'
    Left = 352
    Top = 224
  end
end
