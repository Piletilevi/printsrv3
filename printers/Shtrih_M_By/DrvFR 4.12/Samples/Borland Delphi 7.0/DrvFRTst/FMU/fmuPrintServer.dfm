object fmPrintServer: TfmPrintServer
  Left = 372
  Top = 223
  AutoScroll = False
  Caption = #1057#1077#1088#1074#1077#1088' '#1087#1077#1095#1072#1090#1080
  ClientHeight = 214
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    416
    214)
  PixelsPerInch = 96
  TextHeight = 13
  object lblComputerName: TLabel
    Left = 16
    Top = 12
    Width = 91
    Height = 13
    Caption = #1048#1084#1103' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblCOMNumber: TLabel
    Left = 16
    Top = 44
    Width = 53
    Height = 13
    Caption = 'COM '#1087#1086#1088#1090':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object edtComputerName: TEdit
    Left = 160
    Top = 8
    Width = 211
    Height = 21
    Hint = 'ComputerName'
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
  end
  object cbCOMNumber: TComboBox
    Left = 160
    Top = 40
    Width = 241
    Height = 21
    Hint = 'ComNumber'
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Items.Strings = (
      'COM1'
      'COM2'
      'COM3'
      'COM4'
      'COM5'
      'COM6'
      'COM7'
      'COM8'
      'COM9'
      'COM10'
      'COM11'
      'COM12'
      'COM13'
      'COM14'
      'COM15'
      'COM16'
      'COM17'
      'COM18'
      'COM19'
      'COM20'
      'COM21'
      'COM22'
      'COM23'
      'COM24'
      'COM25'
      'COM26'
      'COM27'
      'COM28'
      'COM29'
      'COM30'
      'COM31'
      'COM32')
  end
  object btnServerConnect: TBitBtn
    Left = 8
    Top = 88
    Width = 193
    Height = 25
    Hint = 'ServerConnect'
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1082' '#1089#1077#1088#1074#1077#1088#1091
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnServerConnectClick
    NumGlyphs = 2
  end
  object btnServerDisconnect: TBitBtn
    Left = 208
    Top = 88
    Width = 193
    Height = 25
    Hint = 'ServerDisconnect'
    Anchors = [akTop, akRight]
    Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103' '#1086#1090' '#1089#1077#1088#1074#1077#1088#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnServerDisconnectClick
    NumGlyphs = 2
  end
  object btnLockPort: TBitBtn
    Left = 8
    Top = 120
    Width = 193
    Height = 25
    Hint = 'LockPort'
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1085#1103#1090#1100' '#1087#1086#1088#1090
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btnLockPortClick
    NumGlyphs = 2
  end
  object btnAdminUnlockPort: TBitBtn
    Left = 208
    Top = 120
    Width = 193
    Height = 25
    Hint = 'AdminUnlockPort'
    Anchors = [akTop, akRight]
    Caption = #1054#1089#1074#1086#1073#1086#1076#1080#1090#1100' '#1087#1086#1088#1090' ('#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088')'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = btnAdminUnlockPortClick
    NumGlyphs = 2
  end
  object btnUnlockPort: TBitBtn
    Left = 8
    Top = 152
    Width = 193
    Height = 25
    Hint = 'UnlockPort'
    Anchors = [akTop, akRight]
    Caption = #1054#1089#1074#1086#1073#1086#1076#1080#1090#1100' '#1087#1086#1088#1090
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnUnlockPortClick
    NumGlyphs = 2
  end
  object btnAdminUnlockPorts: TBitBtn
    Left = 208
    Top = 152
    Width = 193
    Height = 25
    Hint = 'AdminUnlockPorts'
    Anchors = [akTop, akRight]
    Caption = #1054#1089#1074#1086#1073#1086#1076#1080#1090#1100' '#1087#1086#1088#1090#1099' ('#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088')'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = btnAdminUnlockPortsClick
    NumGlyphs = 2
  end
  object btnDeleteDriver: TBitBtn
    Left = 208
    Top = 184
    Width = 193
    Height = 25
    Hint = #1059#1076#1072#1083#1080#1090#1100' '#1076#1088#1072#1081#1074#1077#1088
    Anchors = [akTop, akRight]
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1088#1072#1081#1074#1077#1088
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = btnDeleteDriverClick
    NumGlyphs = 2
  end
  object btnCreateDriver: TBitBtn
    Left = 8
    Top = 184
    Width = 193
    Height = 25
    Hint = #1057#1086#1079#1076#1072#1090#1100' '#1076#1088#1072#1081#1074#1077#1088
    Anchors = [akTop, akRight]
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1076#1088#1072#1081#1074#1077#1088
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnCreateDriverClick
    NumGlyphs = 2
  end
  object btnComputerName: TBitBtn
    Left = 376
    Top = 8
    Width = 25
    Height = 25
    Hint = #1054#1073#1079#1086#1088
    Anchors = [akTop, akRight]
    Caption = '...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnComputerNameClick
  end
end
