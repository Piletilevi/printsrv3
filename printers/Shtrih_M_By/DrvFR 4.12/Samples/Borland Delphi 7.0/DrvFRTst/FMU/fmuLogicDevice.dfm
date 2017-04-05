object fmLogicDevice: TfmLogicDevice
  Left = 396
  Top = 513
  AutoScroll = False
  Caption = #1051#1059
  ClientHeight = 263
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    447
    263)
  PixelsPerInch = 96
  TextHeight = 13
  object lblLDIndex: TLabel
    Left = 8
    Top = 40
    Width = 41
    Height = 13
    Caption = #1048#1085#1076#1077#1082#1089':'
  end
  object lblLDCount: TLabel
    Left = 8
    Top = 210
    Width = 62
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
  end
  object lblBaudRate: TLabel
    Left = 8
    Top = 126
    Width = 51
    Height = 13
    Caption = #1057#1082#1086#1088#1086#1089#1090#1100':'
  end
  object lblComNumber: TLabel
    Left = 8
    Top = 98
    Width = 53
    Height = 13
    Caption = #1057'OM '#1087#1086#1088#1090':'
  end
  object lblLDNumber: TLabel
    Left = 8
    Top = 69
    Width = 37
    Height = 13
    Caption = #1053#1086#1084#1077#1088':'
  end
  object lblLDName: TLabel
    Left = 8
    Top = 12
    Width = 53
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
  end
  object lblTimeout: TLabel
    Left = 8
    Top = 154
    Width = 46
    Height = 13
    Caption = #1058#1072#1081#1084#1072#1091#1090':'
  end
  object lblComputer: TLabel
    Left = 8
    Top = 182
    Width = 61
    Height = 13
    Caption = #1050#1086#1084#1087#1100#1102#1090#1077#1088':'
  end
  object edtLDName: TEdit
    Left = 80
    Top = 8
    Width = 185
    Height = 21
    Hint = 'LDName'
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 4096
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object cbComNumber: TComboBox
    Left = 80
    Top = 93
    Width = 185
    Height = 21
    Hint = 'LDComNumber'
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
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
  object cbBaudRate: TComboBox
    Left = 80
    Top = 120
    Width = 185
    Height = 21
    Hint = 'LDBaudrate'
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Items.Strings = (
      '2400'
      '4800'
      '9600'
      '19200'
      '38400'
      '57600'
      '115200'
      '230400'
      '460800'
      '921600')
  end
  object edtLDCount: TEdit
    Left = 80
    Top = 206
    Width = 185
    Height = 21
    Hint = 'LDCount'
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 8
  end
  object edtComputerName: TEdit
    Left = 80
    Top = 176
    Width = 161
    Height = 21
    Hint = 'LDComputerName'
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 4096
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
  end
  object btnComputerName: TButton
    Left = 240
    Top = 177
    Width = 25
    Height = 23
    Hint = #1054#1073#1079#1086#1088
    Anchors = [akTop, akRight]
    Caption = '...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnComputerNameClick
  end
  object btnAddLD: TBitBtn
    Left = 279
    Top = 8
    Width = 161
    Height = 25
    Hint = 'AddLD'
    Anchors = [akTop, akRight]
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1051#1059
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnAddLDClick
    NumGlyphs = 2
  end
  object btnDeleteLD: TBitBtn
    Left = 279
    Top = 40
    Width = 161
    Height = 25
    Hint = 'DeleteLD'
    Anchors = [akTop, akRight]
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1051#1059
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = btnDeleteLDClick
    NumGlyphs = 2
  end
  object btnSetParamLD: TBitBtn
    Left = 279
    Top = 136
    Width = 161
    Height = 25
    Hint = 'SetParamLD'
    Anchors = [akTop, akRight]
    Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1051#1059
    ParentShowHint = False
    ShowHint = True
    TabOrder = 13
    OnClick = btnSetParamLDClick
    NumGlyphs = 2
  end
  object btnGetParamLD: TBitBtn
    Left = 279
    Top = 168
    Width = 161
    Height = 25
    Hint = 'GetParamLD'
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1051#1059
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    OnClick = btnGetParamLDClick
    NumGlyphs = 2
  end
  object btnSetActiveLD: TBitBtn
    Left = 279
    Top = 200
    Width = 161
    Height = 25
    Hint = 'SetActiveLD'
    Anchors = [akTop, akRight]
    Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1072#1082#1090#1080#1074#1085#1086#1077' '#1051#1059
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    OnClick = btnSetActiveLDClick
    NumGlyphs = 2
  end
  object btnGetActiveLD: TBitBtn
    Left = 279
    Top = 232
    Width = 161
    Height = 25
    Hint = 'GetActiveLD'
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1072#1082#1090#1080#1074#1085#1086#1077' '#1051#1059
    ParentShowHint = False
    ShowHint = True
    TabOrder = 16
    OnClick = btnGetActiveLDClick
    NumGlyphs = 2
  end
  object btnGetCountLD: TBitBtn
    Left = 279
    Top = 72
    Width = 161
    Height = 25
    Hint = 'GetCountLD'
    Anchors = [akTop, akRight]
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1051#1059
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = btnGetCountLDClick
  end
  object btnEnumLD: TBitBtn
    Left = 279
    Top = 104
    Width = 161
    Height = 25
    Hint = 'EnumLD'
    Anchors = [akTop, akRight]
    Caption = #1055#1077#1088#1077#1095#1080#1089#1083#1080#1090#1100' '#1051#1059
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = btnEnumLDClick
  end
  object seLDIndex: TSpinEdit
    Left = 80
    Top = 35
    Width = 185
    Height = 22
    Hint = 'LDIndex'
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Value = 0
  end
  object seLDNumber: TSpinEdit
    Left = 80
    Top = 64
    Width = 185
    Height = 22
    Hint = 'LDNumber'
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Value = 1
  end
  object seTimeout: TSpinEdit
    Left = 80
    Top = 148
    Width = 185
    Height = 22
    Hint = 'LDNumber'
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    Value = 1
  end
end
