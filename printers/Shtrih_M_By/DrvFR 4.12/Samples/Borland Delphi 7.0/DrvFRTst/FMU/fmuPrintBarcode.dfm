object fmPrintBarcode: TfmPrintBarcode
  Left = 394
  Top = 173
  Anchors = [akLeft, akTop, akRight]
  AutoScroll = False
  Caption = #1064#1090#1088#1080#1093#1082#1086#1076
  ClientHeight = 330
  ClientWidth = 612
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    612
    330)
  PixelsPerInch = 96
  TextHeight = 13
  object lblData: TLabel
    Left = 8
    Top = 12
    Width = 101
    Height = 13
    Caption = #1044#1072#1085#1085#1099#1077' '#1096#1090#1088#1080#1093#1082#1086#1076#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblBarWidth: TLabel
    Left = 8
    Top = 44
    Width = 115
    Height = 13
    Caption = #1064#1080#1088#1080#1085#1072' '#1096#1090#1088#1080#1093#1072', '#1090#1086#1095#1077#1082':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblBarcodeType: TLabel
    Left = 8
    Top = 76
    Width = 79
    Height = 13
    Caption = #1058#1080#1087' '#1096#1090#1088#1080#1093#1082#1086#1076#1072':'
  end
  object lblBarcodeAlignment: TLabel
    Left = 8
    Top = 108
    Width = 78
    Height = 13
    Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077':'
  end
  object lblPrintBarcodeText: TLabel
    Left = 8
    Top = 172
    Width = 76
    Height = 13
    Caption = #1055#1077#1095#1072#1090#1100' '#1090#1077#1082#1089#1090#1072':'
  end
  object lblLineNumber: TLabel
    Left = 8
    Top = 141
    Width = 132
    Height = 13
    Caption = #1042#1099#1089#1086#1090#1072' '#1096#1090#1088#1080#1093#1082#1086#1076#1072', '#1090#1086#1095#1077#1082':'
  end
  object edtBarcode: TEdit
    Left = 152
    Top = 8
    Width = 227
    Height = 21
    Hint = 'Barcode'
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 4096
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = '12345678901234567890'
  end
  object chbCutPaper: TCheckBox
    Left = 152
    Top = 200
    Width = 209
    Height = 17
    Hint = #1042#1099#1087#1086#1083#1085#1103#1090#1100' '#1086#1090#1088#1077#1079#1082#1091
    Caption = #1042#1099#1087#1086#1083#1085#1103#1090#1100' '#1086#1090#1088#1077#1079#1082#1091
    Checked = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 4
  end
  object chbPrintMaxWidth: TCheckBox
    Left = 152
    Top = 224
    Width = 209
    Height = 17
    Hint = #1055#1077#1095#1072#1090#1072#1090#1100' '#1084#1072#1082#1089#1080#1084#1072#1083#1100#1085#1091#1102' '#1096#1080#1088#1080#1085#1091
    Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1084#1072#1082#1089#1080#1084#1072#1083#1100#1085#1091#1102' '#1096#1080#1088#1080#1085#1091
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
  object btnPrintBarcodeLine: TButton
    Left = 386
    Top = 40
    Width = 218
    Height = 25
    Hint = 'PrintBarcodeLine'
    Anchors = [akTop, akRight]
    Caption = #1055#1077#1095#1072#1090#1100' '#1096#1090#1088#1080#1093#1082#1086#1076#1072' '#1083#1080#1085#1080#1077#1081
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = btnPrintBarcodeLineClick
  end
  object btnPrintBarcodeGraph: TButton
    Left = 386
    Top = 72
    Width = 218
    Height = 25
    Hint = 'PrintBarcodeGraph'
    Anchors = [akTop, akRight]
    Caption = #1055#1077#1095#1072#1090#1100' '#1096#1090#1088#1080#1093#1082#1086#1076#1072' '#1075#1088#1072#1092#1080#1082#1086#1081
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnPrintBarcodeGraphClick
  end
  object cbBarcodeAlignment: TComboBox
    Left = 152
    Top = 104
    Width = 227
    Height = 21
    Hint = 'BarcodeAlignment'
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    ItemIndex = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = #1087#1086' '#1094#1077#1085#1090#1088#1091
    Items.Strings = (
      #1087#1086' '#1094#1077#1085#1090#1088#1091
      #1074#1083#1077#1074#1086
      #1074#1087#1088#1072#1074#1086)
  end
  object seBarWidth: TSpinEdit
    Left = 152
    Top = 40
    Width = 227
    Height = 22
    Hint = 'BarWidth'
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Value = 2
  end
  object btnPrintBarcode: TButton
    Left = 386
    Top = 8
    Width = 218
    Height = 25
    Hint = 'PrintBarCode'
    Anchors = [akTop, akRight]
    Caption = #1055#1077#1095#1072#1090#1100' '#1096#1090#1088#1080#1093#1082#1086#1076#1072' (EAN13)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnPrintBarcodeClick
  end
  object cbPrintBarcodeText: TComboBox
    Left = 152
    Top = 168
    Width = 227
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = #1085#1077' '#1087#1077#1095#1072#1090#1072#1090#1100
    Items.Strings = (
      #1085#1077' '#1087#1077#1095#1072#1090#1072#1090#1100
      #1087#1086#1076' '#1096#1090#1088#1080#1093#1082#1086#1076#1086#1084
      #1085#1072#1076' '#1096#1090#1088#1080#1093#1082#1086#1076#1086#1084
      #1087#1086#1076' '#1080' '#1085#1072#1076' '#1096#1090#1088#1080#1093#1082#1086#1076#1086#1084)
  end
  object cbBarcodeType: TComboBox
    Left = 152
    Top = 72
    Width = 225
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    ItemIndex = 1
    TabOrder = 10
    Text = 'Code128B'
    Items.Strings = (
      'Code128A'
      'Code128B'
      'Code128C')
  end
  object chbLineSwapBytes: TCheckBox
    Left = 152
    Top = 248
    Width = 145
    Height = 17
    Caption = #1055#1077#1088#1077#1074#1086#1088#1072#1095#1080#1074#1072#1090#1100' '#1073#1072#1081#1090#1099
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object seLineNumber: TSpinEdit
    Left = 152
    Top = 136
    Width = 227
    Height = 22
    Hint = 'LineNumber'
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 1199
    MinValue = 0
    TabOrder = 11
    Value = 100
  end
end
