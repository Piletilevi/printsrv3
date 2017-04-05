object fm2DBarcode: Tfm2DBarcode
  Left = 429
  Top = 234
  Anchors = [akLeft, akTop, akRight]
  AutoScroll = False
  Caption = '2D '#1096#1090#1088#1080#1093#1082#1086#1076
  ClientHeight = 472
  ClientWidth = 536
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
  object gbPrint2DBarcode: TGroupBox
    Left = 8
    Top = 112
    Width = 377
    Height = 297
    Caption = #1055#1077#1095#1072#1090#1100' '#1076#1074#1091#1084#1077#1088#1085#1086#1075#1086' '#1096#1090#1088#1080#1093#1082#1086#1076#1072
    TabOrder = 0
    DesignSize = (
      377
      297)
    object lblBarcodeType: TLabel
      Left = 16
      Top = 32
      Width = 79
      Height = 13
      Caption = #1058#1080#1087' '#1096#1090#1088#1080#1093#1082#1086#1076#1072':'
    end
    object lblBarcodeDataLength: TLabel
      Left = 16
      Top = 56
      Width = 76
      Height = 13
      Caption = #1044#1083#1080#1085#1072' '#1076#1072#1085#1085#1099#1093':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblStartBlockNumber: TLabel
      Left = 16
      Top = 80
      Width = 87
      Height = 13
      Caption = #1053#1072#1095#1072#1083#1100#1085#1099#1081' '#1073#1083#1086#1082':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblBarcodeParameter1: TLabel
      Left = 16
      Top = 104
      Width = 63
      Height = 13
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088' 1:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblBarcodeParameter2: TLabel
      Left = 16
      Top = 128
      Width = 63
      Height = 13
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088' 2:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblBarcodeParameter3: TLabel
      Left = 16
      Top = 152
      Width = 63
      Height = 13
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088' 3:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblBarcodeParameter4: TLabel
      Left = 16
      Top = 176
      Width = 63
      Height = 13
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088' 4:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblBarcodeParameter5: TLabel
      Left = 16
      Top = 200
      Width = 63
      Height = 13
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088' 5:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblBarcodeAlignment: TLabel
      Left = 16
      Top = 228
      Width = 78
      Height = 13
      Caption = #1042#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1077':'
    end
    object cbBarcodeType: TComboBox
      Left = 120
      Top = 32
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        'PDF 417'
        'DATAMATRIX'
        'AZTEC'
        'QR code')
    end
    object seBarcodeDataLength: TSpinEdit
      Left = 120
      Top = 56
      Width = 121
      Height = 22
      Hint = 'BarWidth'
      MaxValue = 65535
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 0
    end
    object seStartBlockNumber: TSpinEdit
      Left = 120
      Top = 80
      Width = 121
      Height = 22
      Hint = 'BarWidth'
      MaxValue = 255
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Value = 0
    end
    object seBarcodeParameter1: TSpinEdit
      Left = 120
      Top = 104
      Width = 121
      Height = 22
      Hint = 'BarWidth'
      MaxValue = 255
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Value = 0
    end
    object seBarcodeParameter2: TSpinEdit
      Left = 120
      Top = 128
      Width = 121
      Height = 22
      Hint = 'BarWidth'
      MaxValue = 255
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Value = 0
    end
    object seBarcodeParameter3: TSpinEdit
      Left = 120
      Top = 152
      Width = 121
      Height = 22
      Hint = 'BarWidth'
      MaxValue = 255
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Value = 0
    end
    object seBarcodeParameter4: TSpinEdit
      Left = 120
      Top = 176
      Width = 121
      Height = 22
      Hint = 'BarWidth'
      MaxValue = 255
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Value = 0
    end
    object seBarcodeParameter5: TSpinEdit
      Left = 120
      Top = 200
      Width = 121
      Height = 22
      Hint = 'BarWidth'
      MaxValue = 255
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      Value = 0
    end
    object btnPrint2DBarcode: TButton
      Left = 248
      Top = 32
      Width = 121
      Height = 25
      Caption = #1053#1072#1087#1077#1095#1072#1090#1072#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnClick = btnPrint2DBarcodeClick
    end
    object chbCutPaper: TCheckBox
      Left = 16
      Top = 256
      Width = 121
      Height = 17
      Hint = #1042#1099#1087#1086#1083#1085#1103#1090#1100' '#1086#1090#1088#1077#1079#1082#1091
      Caption = #1042#1099#1087#1086#1083#1085#1103#1090#1100' '#1086#1090#1088#1077#1079#1082#1091
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
    end
    object cbBarcodeAlignment: TComboBox
      Left = 120
      Top = 224
      Width = 121
      Height = 21
      Hint = 'BarcodeAlignment'
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      ItemIndex = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      Text = #1087#1086' '#1094#1077#1085#1090#1088#1091
      Items.Strings = (
        #1087#1086' '#1094#1077#1085#1090#1088#1091
        #1074#1083#1077#1074#1086
        #1074#1087#1088#1072#1074#1086)
    end
  end
  object gbData: TGroupBox
    Left = 8
    Top = 8
    Width = 377
    Height = 97
    Caption = #1044#1072#1085#1085#1099#1077
    TabOrder = 1
    object btnOpenFile: TBitBtn
      Left = 248
      Top = 24
      Width = 121
      Height = 25
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
      TabOrder = 0
      OnClick = btnOpenFileClick
    end
    object edtStatus: TEdit
      Left = 16
      Top = 24
      Width = 225
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 1
      Text = #1060#1072#1081#1083' '#1085#1077' '#1086#1090#1082#1088#1099#1090
    end
    object Button1: TButton
      Left = 248
      Top = 64
      Width = 121
      Height = 25
      Hint = 'LoadBlockData'
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnLoadBlockDataClick
    end
  end
  object OpenDialog: TOpenDialog
    Left = 280
    Top = 200
  end
end
