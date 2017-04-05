object fmWriteSerial: TfmWriteSerial
  Left = 629
  Top = 256
  AutoScroll = False
  Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1080#1088#1086#1074#1072#1085#1080#1077
  ClientHeight = 326
  ClientWidth = 497
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    497
    326)
  PixelsPerInch = 96
  TextHeight = 13
  object gbSerialNumber: TGroupBox
    Left = 8
    Top = 101
    Width = 483
    Height = 53
    Anchors = [akLeft, akTop, akRight]
    Caption = #1047#1072#1074#1086#1076#1089#1082#1086#1081' '#1085#1086#1084#1077#1088
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      483
      53)
    object edtSerialNumber: TEdit
      Left = 16
      Top = 21
      Width = 265
      Height = 21
      Hint = 'SerialNumber'
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = '0'
    end
    object btnSetSerialNumber: TBitBtn
      Left = 295
      Top = 19
      Width = 176
      Height = 25
      Hint = 'SetSerialNumber'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnSetSerialNumberClick
      NumGlyphs = 2
    end
  end
  object gbLicense: TGroupBox
    Left = 8
    Top = 158
    Width = 483
    Height = 82
    Hint = #1055#1088#1086#1095#1080#1090#1072#1090#1100
    Anchors = [akLeft, akTop, akRight]
    Caption = #1051#1080#1094#1077#1085#1079#1080#1103
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      483
      82)
    object edtLicense: TEdit
      Left = 16
      Top = 18
      Width = 265
      Height = 21
      Hint = 'License'
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 100
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = '0'
    end
    object btnReadLicense: TBitBtn
      Left = 295
      Top = 18
      Width = 176
      Height = 25
      Hint = 'ReadLicense'
      Anchors = [akTop, akRight]
      Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnReadLicenseClick
      NumGlyphs = 2
    end
    object btnWriteLicense: TBitBtn
      Left = 295
      Top = 50
      Width = 176
      Height = 25
      Hint = 'WriteLicense'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnWriteLicenseClick
      NumGlyphs = 2
    end
  end
  object gbPointPosition: TGroupBox
    Left = 8
    Top = 244
    Width = 483
    Height = 45
    Hint = #1055#1088#1086#1095#1080#1090#1072#1090#1100
    Anchors = [akLeft, akTop, akRight]
    Caption = #1044#1077#1089#1103#1090#1080#1095#1085#1072#1103' '#1090#1086#1095#1082#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      483
      45)
    object lblPointPosition: TLabel
      Left = 120
      Top = 19
      Width = 101
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1079#1085#1072#1082#1086#1074':'
    end
    object btnSetPointPosition: TBitBtn
      Left = 295
      Top = 13
      Width = 176
      Height = 25
      Hint = 'SetPointPosition'
      Anchors = [akTop, akRight]
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1086#1083#1086#1078#1077#1085#1080#1077' '#1090#1086#1095#1082#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnSetPointPositionClick
      NumGlyphs = 2
    end
    object cbPointPosition: TComboBox
      Left = 232
      Top = 15
      Width = 49
      Height = 21
      Style = csDropDownList
      Anchors = [akTop, akRight]
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = '0'
      Items.Strings = (
        '0'
        '2')
    end
  end
  object grpServiceNumber: TGroupBox
    Left = 8
    Top = 8
    Width = 483
    Height = 89
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1072#1088#1086#1083#1100' '#1062#1058#1054
    TabOrder = 0
    DesignSize = (
      483
      89)
    object lblSCPassword: TLabel
      Left = 16
      Top = 38
      Width = 67
      Height = 13
      Caption = #1055#1072#1088#1086#1083#1100' '#1062#1058#1054':'
    end
    object lblNewSCPassword: TLabel
      Left = 16
      Top = 64
      Width = 102
      Height = 13
      Caption = #1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100' '#1062#1058#1054':'
    end
    object Label2: TLabel
      Left = 16
      Top = 16
      Width = 274
      Height = 13
      Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1085#1086#1074#1086#1075#1086' '#1087#1072#1088#1086#1083#1103' '#1062#1058#1054' '#1076#1083#1080#1085#1086#1081' '#1076#1086' 8 '#1089#1080#1084#1074#1086#1083#1086#1074
    end
    object edtSCPassword: TEdit
      Left = 136
      Top = 34
      Width = 145
      Height = 21
      Hint = 'SCPassword'
      Anchors = [akLeft, akTop, akRight]
      MaxLength = 100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = '0'
    end
    object edtNewSCPassword: TEdit
      Left = 136
      Top = 60
      Width = 145
      Height = 21
      Hint = 'NewSCPassword'
      Anchors = [akLeft, akTop, akRight]
      MaxLength = 100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '0'
    end
    object btnSetSCPassword: TBitBtn
      Left = 295
      Top = 34
      Width = 176
      Height = 25
      Hint = 'SetSCPassword'
      Anchors = [akTop, akRight]
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1072#1088#1086#1083#1100' '#1062#1058#1054
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnSetSCPasswordClick
      NumGlyphs = 2
    end
  end
end
