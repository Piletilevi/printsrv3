object fmMain: TfmMain
  Left = 361
  Top = 276
  ActiveControl = btnShowProperties
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1058#1077#1089#1090' '#1076#1088#1072#1081#1074#1077#1088#1072' '#1060#1056
  ClientHeight = 335
  ClientWidth = 623
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblResult: TLabel
    Left = 8
    Top = 304
    Width = 55
    Height = 13
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
  end
  object btnShowProperties: TButton
    Left = 480
    Top = 264
    Width = 137
    Height = 25
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1074#1086#1081#1089#1090#1074
    TabOrder = 17
    OnClick = btnShowPropertiesClick
  end
  object btnConnect: TButton
    Left = 480
    Top = 168
    Width = 137
    Height = 25
    Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100
    TabOrder = 14
    OnClick = btnConnectClick
  end
  object btnDisconnect: TButton
    Left = 480
    Top = 200
    Width = 137
    Height = 25
    Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100
    TabOrder = 15
    OnClick = btnDisconnectClick
  end
  object edtResult: TEdit
    Left = 72
    Top = 304
    Width = 465
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 18
  end
  object btnBeep: TButton
    Left = 480
    Top = 232
    Width = 137
    Height = 25
    Caption = #1043#1091#1076#1086#1082
    TabOrder = 16
    OnClick = btnBeepClick
  end
  object btnSale: TButton
    Left = 344
    Top = 8
    Width = 129
    Height = 25
    Caption = #1055#1088#1086#1076#1072#1078#1072
    TabOrder = 1
    OnClick = btnSaleClick
  end
  object btnBuy: TButton
    Left = 344
    Top = 72
    Width = 129
    Height = 25
    Caption = #1055#1086#1082#1091#1087#1082#1072
    TabOrder = 3
    OnClick = btnBuyClick
  end
  object btnReturnSale: TButton
    Left = 344
    Top = 40
    Width = 129
    Height = 25
    Caption = #1042#1086#1079#1074#1088#1072#1090' '#1087#1088#1086#1076#1072#1078#1080
    TabOrder = 2
    OnClick = btnReturnSaleClick
  end
  object btnReturnBuy: TButton
    Left = 344
    Top = 104
    Width = 129
    Height = 25
    Caption = #1042#1086#1079#1074#1088#1072#1090' '#1087#1086#1082#1091#1087#1082#1080
    TabOrder = 4
    OnClick = btnReturnBuyClick
  end
  object btnStorno: TButton
    Left = 344
    Top = 136
    Width = 129
    Height = 25
    Caption = #1057#1090#1086#1088#1085#1086
    TabOrder = 5
    OnClick = btnStornoClick
  end
  object btnCloseCheck: TButton
    Left = 480
    Top = 8
    Width = 137
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1080#1077' '#1095#1077#1082#1072
    TabOrder = 10
    OnClick = btnCloseCheckClick
  end
  object btnPrintReportWithCleaning: TButton
    Left = 480
    Top = 104
    Width = 137
    Height = 25
    Caption = #1054#1090#1095#1077#1090' '#1089' '#1075#1072#1096#1077#1085#1080#1077#1084
    TabOrder = 13
    OnClick = btnPrintReportWithCleaningClick
  end
  object btnPrintReportWithoutCleaning: TButton
    Left = 480
    Top = 72
    Width = 137
    Height = 25
    Caption = #1054#1090#1095#1077#1090' '#1073#1077#1079' '#1075#1072#1096#1077#1085#1080#1103
    TabOrder = 12
    OnClick = btnPrintReportWithoutCleaningClick
  end
  object btnDiscount: TButton
    Left = 344
    Top = 168
    Width = 129
    Height = 25
    Caption = #1057#1082#1080#1076#1082#1072
    TabOrder = 6
    OnClick = btnDiscountClick
  end
  object btnStornoDiscount: TButton
    Left = 344
    Top = 200
    Width = 129
    Height = 25
    Caption = #1057#1090#1086#1088#1085#1086' '#1089#1082#1080#1076#1082#1080
    TabOrder = 7
    OnClick = btnStornoDiscountClick
  end
  object btnCharge: TButton
    Left = 344
    Top = 232
    Width = 129
    Height = 25
    Caption = #1053#1072#1076#1073#1072#1074#1082#1072
    TabOrder = 8
    OnClick = btnChargeClick
  end
  object btnStornoCharge: TButton
    Left = 344
    Top = 264
    Width = 129
    Height = 25
    Caption = #1057#1090#1086#1088#1085#1086' '#1085#1072#1076#1073#1072#1074#1082#1080
    TabOrder = 9
    OnClick = btnStornoChargeClick
  end
  object btnCancelCheck: TButton
    Left = 480
    Top = 40
    Width = 137
    Height = 25
    Caption = #1040#1085#1085#1091#1083#1080#1088#1086#1074#1072#1085#1080#1077' '#1095#1077#1082#1072
    TabOrder = 11
    OnClick = btnCancelCheckClick
  end
  object gbParams: TGroupBox
    Left = 8
    Top = 8
    Width = 329
    Height = 281
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 0
    object lblPrice: TLabel
      Left = 16
      Top = 72
      Width = 29
      Height = 13
      Caption = #1062#1077#1085#1072':'
    end
    object lblQuantity: TLabel
      Left = 16
      Top = 96
      Width = 62
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
    end
    object lblDepartment: TLabel
      Left = 16
      Top = 120
      Width = 34
      Height = 13
      Caption = #1054#1090#1076#1077#1083':'
    end
    object lblTax1: TLabel
      Left = 168
      Top = 96
      Width = 40
      Height = 13
      Caption = #1053#1072#1083#1086#1075'1:'
    end
    object lblTax2: TLabel
      Left = 168
      Top = 120
      Width = 40
      Height = 13
      Caption = #1053#1072#1083#1086#1075'2:'
    end
    object lblTax3: TLabel
      Left = 168
      Top = 144
      Width = 40
      Height = 13
      Caption = #1053#1072#1083#1086#1075'3:'
    end
    object lblTax4: TLabel
      Left = 168
      Top = 168
      Width = 40
      Height = 13
      Caption = #1053#1072#1083#1086#1075'4:'
    end
    object Label10: TLabel
      Left = 16
      Top = 48
      Width = 36
      Height = 13
      Caption = #1057#1090#1088#1086#1082#1072
    end
    object lblOperator: TLabel
      Left = 168
      Top = 192
      Width = 52
      Height = 13
      Caption = #1054#1087#1077#1088#1072#1090#1086#1088':'
    end
    object lblSum1: TLabel
      Left = 16
      Top = 144
      Width = 43
      Height = 13
      Caption = #1057#1091#1084#1084#1072'1:'
    end
    object lblSumm2: TLabel
      Left = 16
      Top = 168
      Width = 43
      Height = 13
      Caption = #1057#1091#1084#1084#1072'2:'
    end
    object lblSumm3: TLabel
      Left = 16
      Top = 192
      Width = 43
      Height = 13
      Caption = #1057#1091#1084#1084#1072'3:'
    end
    object lblSumm4: TLabel
      Left = 16
      Top = 216
      Width = 43
      Height = 13
      Caption = #1057#1091#1084#1084#1072'4:'
    end
    object lblDiscount: TLabel
      Left = 168
      Top = 72
      Width = 40
      Height = 13
      Caption = #1057#1082#1080#1076#1082#1072':'
    end
    object lblChange: TLabel
      Left = 168
      Top = 216
      Width = 33
      Height = 13
      Caption = #1057#1076#1072#1095#1072':'
    end
    object lblPassword: TLabel
      Left = 16
      Top = 20
      Width = 41
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100':'
    end
    object edtPrice: TEdit
      Left = 80
      Top = 72
      Width = 81
      Height = 21
      TabOrder = 2
      Text = '100'
    end
    object edtQuantity: TEdit
      Left = 80
      Top = 96
      Width = 81
      Height = 21
      TabOrder = 3
      Text = '1'
    end
    object edtDepartment: TEdit
      Left = 80
      Top = 120
      Width = 81
      Height = 21
      TabOrder = 4
      Text = '1'
    end
    object cbTax1: TComboBox
      Left = 232
      Top = 96
      Width = 81
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 10
      Items.Strings = (
        #1053#1077#1090
        #1053#1072#1083#1086#1075'1'
        #1053#1072#1083#1086#1075'2'
        #1053#1072#1083#1086#1075'3'
        #1053#1072#1083#1086#1075'4')
    end
    object cbTax2: TComboBox
      Left = 232
      Top = 120
      Width = 81
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 11
      Items.Strings = (
        #1053#1077#1090
        #1053#1072#1083#1086#1075'1'
        #1053#1072#1083#1086#1075'2'
        #1053#1072#1083#1086#1075'3'
        #1053#1072#1083#1086#1075'4')
    end
    object cbTax3: TComboBox
      Left = 232
      Top = 144
      Width = 81
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 12
      Items.Strings = (
        #1053#1077#1090
        #1053#1072#1083#1086#1075'1'
        #1053#1072#1083#1086#1075'2'
        #1053#1072#1083#1086#1075'3'
        #1053#1072#1083#1086#1075'4')
    end
    object cbTax4: TComboBox
      Left = 232
      Top = 168
      Width = 81
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 13
      Items.Strings = (
        #1053#1077#1090
        #1053#1072#1083#1086#1075'1'
        #1053#1072#1083#1086#1075'2'
        #1053#1072#1083#1086#1075'3'
        #1053#1072#1083#1086#1075'4')
    end
    object edString: TEdit
      Left = 80
      Top = 48
      Width = 233
      Height = 21
      TabOrder = 1
      Text = #1057#1090#1088#1086#1082#1072' '#1076#1083#1103' '#1087#1077#1095#1072#1090#1080
    end
    object edtOperator: TEdit
      Left = 232
      Top = 192
      Width = 81
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 14
    end
    object edtSumm1: TEdit
      Left = 80
      Top = 144
      Width = 81
      Height = 21
      TabOrder = 5
      Text = '1000'
    end
    object edtSumm2: TEdit
      Left = 80
      Top = 168
      Width = 81
      Height = 21
      TabOrder = 6
      Text = '0'
    end
    object edtSumm3: TEdit
      Left = 80
      Top = 192
      Width = 81
      Height = 21
      TabOrder = 7
      Text = '0'
    end
    object edtSumm4: TEdit
      Left = 80
      Top = 216
      Width = 81
      Height = 21
      TabOrder = 8
      Text = '0'
    end
    object edtSumm: TEdit
      Left = 232
      Top = 72
      Width = 81
      Height = 21
      TabOrder = 9
      Text = '100'
    end
    object edtChange: TEdit
      Left = 232
      Top = 216
      Width = 81
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 15
    end
    object edtPassword: TEdit
      Left = 80
      Top = 20
      Width = 233
      Height = 21
      MaxLength = 8
      TabOrder = 0
      Text = '30'
    end
  end
  object btnClose: TButton
    Left = 544
    Top = 304
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 19
    OnClick = btnCloseClick
  end
end
