object fmBelarus: TfmBelarus
  Left = 450
  Top = 303
  AutoScroll = False
  Caption = #1041#1077#1083#1072#1088#1091#1089#1100
  ClientHeight = 271
  ClientWidth = 406
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblSerialNumber: TLabel
    Left = 8
    Top = 8
    Width = 93
    Height = 13
    Caption = #1047#1072#1074#1086#1076#1089#1082#1086#1081' '#1085#1086#1084#1077#1088':'
  end
  object lblRNM: TLabel
    Left = 8
    Top = 32
    Width = 27
    Height = 13
    Caption = #1056#1053#1052':'
  end
  object lblNewPasswordTI: TLabel
    Left = 8
    Top = 56
    Width = 95
    Height = 13
    Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100' '#1053#1048':'
  end
  object lblINN: TLabel
    Left = 8
    Top = 80
    Width = 27
    Height = 13
    Caption = #1059#1053#1055':'
  end
  object lblRegistrationNumber: TLabel
    Left = 8
    Top = 104
    Width = 114
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1092#1080#1089#1082#1072#1083#1080#1079#1072#1094#1080#1080':'
  end
  object lblFreeRegistration: TLabel
    Left = 8
    Top = 128
    Width = 129
    Height = 13
    Caption = #1054#1089#1090#1072#1083#1086#1089#1100' '#1092#1080#1089#1082#1072#1083#1080#1079#1072#1094#1080#1081':'
  end
  object lblSessionNumber: TLabel
    Left = 8
    Top = 152
    Width = 166
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1089#1084#1077#1085#1099' '#1076#1086' '#1092#1080#1089#1082#1072#1083#1080#1079#1072#1094#1080#1080':'
  end
  object lblDate: TLabel
    Left = 8
    Top = 176
    Width = 106
    Height = 13
    Caption = #1044#1072#1090#1072' '#1092#1080#1089#1082#1072#1083#1080#1079#1072#1094#1080#1080':'
  end
  object btnGetLongSerialNumberAndLongRNM: TButton
    Left = 8
    Top = 208
    Width = 193
    Height = 25
    Hint = 'GetLongSerialNumberAndLongRNM'
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1079#1072#1074#1086#1076#1089#1082#1086#1081' '#1085#1086#1084#1077#1088' '#1080' '#1056#1053#1052
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = btnGetLongSerialNumberAndLongRNMClick
  end
  object btnSetLongSerialNumber: TButton
    Left = 208
    Top = 208
    Width = 193
    Height = 25
    Hint = 'SetLongSerialNumber'
    Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1079#1072#1074#1086#1076#1089#1082#1086#1081' '#1085#1086#1084#1077#1088
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = btnSetLongSerialNumberClick
  end
  object btnFiscalizationWithLongRNM: TButton
    Left = 208
    Top = 240
    Width = 193
    Height = 25
    Hint = 'FiscalizationWithLongRNM'
    Caption = #1060#1080#1089#1082#1072#1083#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1089' '#1056#1053#1052
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = btnFiscalizationWithLongRNMClick
  end
  object edtDate: TEdit
    Left = 192
    Top = 176
    Width = 209
    Height = 21
    Hint = 'Date'
    TabStop = False
    Color = clBtnFace
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 7
  end
  object edtSessionNumber: TEdit
    Left = 192
    Top = 152
    Width = 209
    Height = 21
    Hint = 'SessionNumber'
    TabStop = False
    Color = clBtnFace
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 6
  end
  object edtFreeRegistration: TEdit
    Left = 192
    Top = 128
    Width = 209
    Height = 21
    Hint = 'FreeRegistration'
    TabStop = False
    Color = clBtnFace
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 5
  end
  object edtINN: TEdit
    Left = 192
    Top = 80
    Width = 209
    Height = 21
    Hint = 'INN'
    MaxLength = 100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Text = '0'
  end
  object edtNewPasswordTI: TEdit
    Left = 192
    Top = 56
    Width = 209
    Height = 21
    Hint = 'NewPasswordTI'
    MaxLength = 100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = '0'
  end
  object edtRNM: TEdit
    Left = 192
    Top = 32
    Width = 209
    Height = 21
    Hint = 'RNM'
    MaxLength = 100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object edtSerialNumber: TEdit
    Left = 192
    Top = 8
    Width = 209
    Height = 21
    Hint = 'SerialNumber'
    MaxLength = 100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object btnFiscParams: TButton
    Left = 8
    Top = 240
    Width = 193
    Height = 25
    Hint = 'GetFiscalizationParameters'
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1092#1080#1089#1082#1072#1083#1080#1079#1072#1094#1080#1080
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnFiscParamsClick
  end
  object seRegistrationNumber: TSpinEdit
    Left = 192
    Top = 104
    Width = 209
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 0
  end
end
