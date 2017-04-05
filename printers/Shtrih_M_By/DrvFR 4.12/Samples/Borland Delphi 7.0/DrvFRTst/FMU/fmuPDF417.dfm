object fmPDF417: TfmPDF417
  Left = 359
  Top = 207
  Anchors = [akLeft, akTop, akRight]
  AutoScroll = False
  Caption = 'PDF417'
  ClientHeight = 444
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 239
    Height = 13
    Caption = #1055#1077#1095#1072#1090#1100' '#1096#1090#1088#1080#1093'-'#1082#1086#1076#1072' PDF417 '#1085#1072' '#1087#1088#1080#1085#1090#1077#1088#1077' VKP80'
  end
  object gbPDF417: TGroupBox
    Left = 8
    Top = 104
    Width = 377
    Height = 209
    Caption = 'PDF417'
    TabOrder = 1
    DesignSize = (
      377
      209)
    object lblColumnCount: TLabel
      Left = 16
      Top = 24
      Width = 137
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1086#1083#1086#1085#1086#1082', 0..30:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblRowCount: TLabel
      Left = 16
      Top = 48
      Width = 137
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1088#1103#1076#1086#1074', 0, 3..90:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblModuleWidth: TLabel
      Left = 16
      Top = 72
      Width = 106
      Height = 13
      Caption = #1064#1080#1088#1080#1085#1072' '#1084#1086#1076#1091#1083#1103', 2..8:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSymbolHeight: TLabel
      Left = 16
      Top = 96
      Width = 112
      Height = 13
      Caption = #1042#1099#1089#1086#1090#1072' '#1089#1080#1084#1074#1086#1083#1072', 2..8:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblErrorCorrectionLevel: TLabel
      Left = 16
      Top = 120
      Width = 145
      Height = 13
      Caption = #1059#1088#1086#1074#1077#1085#1100' '#1082#1086#1088#1088#1077#1082#1094#1080#1080' '#1086#1096#1080#1073#1086#1082':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblBarcodeAlignment: TLabel
      Left = 16
      Top = 144
      Width = 78
      Height = 13
      Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077':'
    end
    object seRowCount: TSpinEdit
      Left = 168
      Top = 48
      Width = 97
      Height = 22
      Hint = 'BarWidth'
      MaxValue = 255
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 0
    end
    object btnPrintPDF417: TButton
      Left = 272
      Top = 24
      Width = 97
      Height = 25
      Caption = #1053#1072#1087#1077#1095#1072#1090#1072#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = btnPrintPDF417Click
    end
    object cbModuleWidth: TComboBox
      Left = 168
      Top = 72
      Width = 97
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8')
    end
    object cbSymbolHeight: TComboBox
      Left = 168
      Top = 96
      Width = 97
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      Items.Strings = (
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8')
    end
    object seErrorCorrectionLevel: TSpinEdit
      Left = 168
      Top = 120
      Width = 97
      Height = 22
      Hint = 'BarWidth'
      MaxValue = 255
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Value = 0
    end
    object cbColumnCount: TComboBox
      Left = 168
      Top = 24
      Width = 97
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8')
    end
    object chbCutPaper: TCheckBox
      Left = 16
      Top = 176
      Width = 121
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
      TabOrder = 6
    end
    object cbBarcodeAlignment: TComboBox
      Left = 168
      Top = 144
      Width = 97
      Height = 21
      Hint = 'BarcodeAlignment'
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      ItemIndex = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Text = #1087#1086' '#1094#1077#1085#1090#1088#1091
      Items.Strings = (
        #1087#1086' '#1094#1077#1085#1090#1088#1091
        #1074#1083#1077#1074#1086
        #1074#1087#1088#1072#1074#1086)
    end
  end
  object btnCutPaper: TButton
    Left = 248
    Top = 320
    Width = 137
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1086#1090#1088#1077#1079#1082#1091
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnCutPaperClick
  end
  object gbData: TGroupBox
    Left = 8
    Top = 32
    Width = 377
    Height = 65
    Caption = #1044#1072#1085#1085#1099#1077
    TabOrder = 0
    object btnOpenFile: TBitBtn
      Left = 272
      Top = 24
      Width = 97
      Height = 25
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
      TabOrder = 0
      OnClick = btnOpenFileClick
    end
    object edtStatus: TEdit
      Left = 16
      Top = 24
      Width = 249
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
      Text = #1060#1072#1081#1083' '#1085#1077' '#1086#1090#1082#1088#1099#1090
    end
  end
  object OpenDialog: TOpenDialog
    Left = 8
    Top = 400
  end
end
