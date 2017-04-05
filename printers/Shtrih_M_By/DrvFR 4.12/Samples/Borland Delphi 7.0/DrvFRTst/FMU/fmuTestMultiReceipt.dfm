object fmTestMultiReceipt: TfmTestMultiReceipt
  Left = 530
  Top = 257
  AutoScroll = False
  Caption = #1058#1077#1089#1090#1086#1074#1099#1077' '#1095#1077#1082#1080
  ClientHeight = 390
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblReceiptType: TLabel
    Left = 16
    Top = 24
    Width = 48
    Height = 13
    Caption = #1058#1080#1087' '#1095#1077#1082#1072':'
  end
  object lblDepartment: TLabel
    Left = 16
    Top = 53
    Width = 34
    Height = 13
    Caption = #1054#1090#1076#1077#1083':'
  end
  object lblQuantity: TLabel
    Left = 16
    Top = 81
    Width = 62
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
  end
  object lblPrice: TLabel
    Left = 16
    Top = 109
    Width = 29
    Height = 13
    Caption = #1062#1077#1085#1072':'
  end
  object lblOperationCount: TLabel
    Left = 16
    Top = 194
    Width = 88
    Height = 13
    Caption = #1054#1087#1077#1088#1072#1094#1080#1081' '#1074' '#1095#1077#1082#1077':'
  end
  object lblReceiptCount: TLabel
    Left = 16
    Top = 224
    Width = 69
    Height = 13
    Caption = #1050#1086#1083'-'#1074#1086' '#1095#1077#1082#1086#1074':'
  end
  object lblSessionCount: TLabel
    Left = 16
    Top = 288
    Width = 66
    Height = 13
    Caption = #1050#1086#1083'-'#1074#1086' '#1089#1084#1077#1085':'
  end
  object btnStart: TButton
    Left = 157
    Top = 336
    Width = 106
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 21
    OnClick = btnStartClick
  end
  object cbReceiptType: TComboBox
    Left = 112
    Top = 20
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = #1087#1088#1086#1076#1072#1078#1072
    Items.Strings = (
      #1087#1088#1086#1076#1072#1078#1072
      #1087#1086#1082#1091#1087#1082#1072
      #1074#1086#1079#1074#1088#1072#1090' '#1087#1088#1086#1076#1072#1078#1080
      #1074#1086#1079#1074#1088#1072#1090' '#1087#1086#1082#1091#1087#1082#1080)
  end
  object chkRandomReceiptType: TCheckBox
    Left = 240
    Top = 22
    Width = 145
    Height = 17
    Caption = #1057#1083#1091#1095#1072#1081#1085#1099#1081' '#1090#1080#1087' '#1095#1077#1082#1072
    TabOrder = 1
    OnClick = OnUpdatePage
  end
  object seDepartment: TSpinEdit
    Left = 112
    Top = 48
    Width = 121
    Height = 22
    MaxValue = 16
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object chkRandomDepartment: TCheckBox
    Left = 240
    Top = 51
    Width = 177
    Height = 17
    Caption = #1057#1083#1091#1095#1072#1081#1085#1099#1081' '#1086#1090#1076#1077#1083
    TabOrder = 3
    OnClick = OnUpdatePage
  end
  object edtQuantity: TEdit
    Left = 112
    Top = 77
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '0'
  end
  object chkRandomQuantity: TCheckBox
    Left = 240
    Top = 79
    Width = 161
    Height = 17
    Caption = #1057#1083#1091#1095#1072#1081#1085#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086
    TabOrder = 5
    OnClick = OnUpdatePage
  end
  object edtPrice: TEdit
    Left = 112
    Top = 105
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '0'
  end
  object chkRandomPrice: TCheckBox
    Left = 240
    Top = 107
    Width = 161
    Height = 17
    Caption = #1057#1083#1091#1095#1072#1081#1085#1072#1103' '#1094#1077#1085#1072
    TabOrder = 7
    OnClick = OnUpdatePage
  end
  object seOperationCount: TSpinEdit
    Left = 112
    Top = 189
    Width = 121
    Height = 22
    MaxValue = 2147483647
    MinValue = 1
    TabOrder = 14
    Value = 1
  end
  object chkRandomOperationCount: TCheckBox
    Left = 240
    Top = 192
    Width = 193
    Height = 17
    Caption = #1057#1083#1091#1095#1072#1081#1085#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1087#1077#1088#1072#1094#1080#1081
    TabOrder = 15
    OnClick = OnUpdatePage
  end
  object btnStop: TButton
    Left = 272
    Top = 336
    Width = 106
    Height = 25
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100
    Enabled = False
    TabOrder = 22
    OnClick = btnStopClick
  end
  object edtDiscount: TEdit
    Left = 112
    Top = 133
    Width = 121
    Height = 21
    TabOrder = 9
    Text = '0'
  end
  object chkRandomDiscount: TCheckBox
    Left = 240
    Top = 135
    Width = 137
    Height = 17
    Caption = #1057#1083#1091#1095#1072#1081#1085#1072#1103' '#1089#1082#1080#1076#1082#1072
    TabOrder = 10
    OnClick = OnUpdatePage
  end
  object edtCharge: TEdit
    Left = 112
    Top = 161
    Width = 121
    Height = 21
    TabOrder = 12
    Text = '0'
  end
  object chkRandomCharge: TCheckBox
    Left = 240
    Top = 163
    Width = 137
    Height = 17
    Caption = #1057#1083#1091#1095#1072#1081#1085#1072#1103' '#1085#1072#1076#1073#1072#1074#1082#1072
    TabOrder = 13
    OnClick = OnUpdatePage
  end
  object chkDiscount: TCheckBox
    Left = 16
    Top = 135
    Width = 65
    Height = 17
    Caption = #1057#1082#1080#1076#1082#1072':'
    TabOrder = 8
    OnClick = OnUpdatePage
  end
  object chkCharge: TCheckBox
    Left = 16
    Top = 163
    Width = 81
    Height = 17
    Caption = #1053#1072#1076#1073#1072#1074#1082#1072':'
    TabOrder = 11
    OnClick = OnUpdatePage
  end
  object seReceiptCount: TSpinEdit
    Left = 112
    Top = 219
    Width = 121
    Height = 22
    MaxValue = 2147483647
    MinValue = 1
    TabOrder = 16
    Value = 1
  end
  object chkCloseSession: TCheckBox
    Left = 16
    Top = 256
    Width = 121
    Height = 17
    Caption = #1047#1072#1082#1088#1099#1074#1072#1090#1100' '#1089#1084#1077#1085#1091
    TabOrder = 18
    OnClick = OnUpdatePage
  end
  object seSessionCount: TSpinEdit
    Left = 112
    Top = 283
    Width = 121
    Height = 22
    MaxValue = 2147483647
    MinValue = 1
    TabOrder = 19
    Value = 1
  end
  object chkInfSessionCount: TCheckBox
    Left = 240
    Top = 286
    Width = 177
    Height = 17
    Caption = #1041#1077#1089#1082#1086#1085#1077#1095#1085#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1084#1077#1085
    TabOrder = 20
    OnClick = OnUpdatePage
  end
  object chkRandomReceiptCount: TCheckBox
    Left = 240
    Top = 222
    Width = 185
    Height = 17
    Caption = #1057#1083#1091#1095#1072#1081#1085#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1095#1077#1082#1086#1074
    TabOrder = 17
    OnClick = OnUpdatePage
  end
end
