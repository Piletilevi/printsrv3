object fmConnection: TfmConnection
  Left = 258
  Top = 204
  AutoScroll = False
  Caption = #1057#1074#1103#1079#1100
  ClientHeight = 379
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    391
    379)
  PixelsPerInch = 96
  TextHeight = 13
  object lblConnectionTimeout: TLabel
    Left = 16
    Top = 246
    Width = 99
    Height = 13
    Caption = #1058#1072#1081#1084#1072#1091#1090' '#1086#1078#1080#1076#1072#1085#1080#1103':'
  end
  object btnConnect: TBitBtn
    Left = 224
    Top = 16
    Width = 153
    Height = 25
    Hint = 'Connect'
    Anchors = [akTop, akRight]
    Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1089#1074#1103#1079#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnConnectClick
    NumGlyphs = 2
  end
  object btnDisconnect: TBitBtn
    Left = 224
    Top = 48
    Width = 153
    Height = 25
    Hint = 'Disconnect'
    Anchors = [akTop, akRight]
    Caption = #1056#1072#1079#1086#1088#1074#1072#1090#1100' '#1089#1074#1103#1079#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnDisconnectClick
    NumGlyphs = 2
  end
  object btnGetExchangeParam: TBitBtn
    Left = 224
    Top = 80
    Width = 153
    Height = 25
    Hint = 'GetExchangeParam'
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnGetExchangeParamClick
    NumGlyphs = 2
  end
  object btnSetExchangeParam: TBitBtn
    Left = 224
    Top = 112
    Width = 153
    Height = 25
    Hint = 'SetExchangeParam'
    Anchors = [akTop, akRight]
    Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnSetExchangeParamClick
    NumGlyphs = 2
  end
  object gbParams: TGroupBox
    Left = 16
    Top = 8
    Width = 193
    Height = 193
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 0
    object lblCOMNumber: TLabel
      Left = 16
      Top = 49
      Width = 28
      Height = 13
      Caption = #1055#1086#1088#1090':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblBaudRate: TLabel
      Left = 16
      Top = 77
      Width = 51
      Height = 13
      Caption = #1057#1082#1086#1088#1086#1089#1090#1100':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTimeout: TLabel
      Left = 16
      Top = 106
      Width = 46
      Height = 13
      Caption = #1058#1072#1081#1084#1072#1091#1090':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblPortNumber: TLabel
      Left = 16
      Top = 21
      Width = 60
      Height = 13
      Caption = #1048#1085#1090#1077#1088#1092#1077#1081#1089':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTCPPort: TLabel
      Left = 16
      Top = 134
      Width = 77
      Height = 13
      Caption = 'TCP '#1087#1086#1088#1090' ('#1082#1086#1076'):'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTcpPortReal: TLabel
      Left = 16
      Top = 162
      Width = 50
      Height = 13
      Caption = 'TCP '#1087#1086#1088#1090':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object cbCOMNumber: TComboBox
      Left = 96
      Top = 45
      Width = 81
      Height = 21
      Hint = 'ComNumber'
      Style = csDropDownList
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
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
      Left = 96
      Top = 73
      Width = 81
      Height = 21
      Hint = 'BaudRate'
      Style = csDropDownList
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
    object seTimeout: TSpinEdit
      Left = 96
      Top = 101
      Width = 81
      Height = 22
      Hint = 'Timeout'
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Value = 0
    end
    object cbPortNumber: TComboBox
      Left = 96
      Top = 17
      Width = 81
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbPortNumberChange
    end
    object edtTCPPortReal: TEdit
      Left = 96
      Top = 158
      Width = 81
      Height = 21
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 5
    end
    object seTCPPortCode: TSpinEdit
      Left = 96
      Top = 129
      Width = 81
      Height = 22
      Hint = 'Timeout'
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Value = 0
    end
  end
  object chkConnected: TCheckBox
    Tag = 1000
    Left = 16
    Top = 208
    Width = 153
    Height = 17
    Hint = 'Connected'
    Caption = #1059#1089#1090#1088#1086#1081#1089#1090#1074#1086' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1086
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = chkConnectedClick
  end
  object btnWaitConnection: TButton
    Left = 208
    Top = 240
    Width = 169
    Height = 25
    Hint = 'WaitConnection'
    Anchors = [akTop, akRight]
    Caption = #1054#1078#1080#1076#1072#1090#1100' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnWaitConnectionClick
  end
  object seConnectionTimeout: TSpinEdit
    Left = 120
    Top = 241
    Width = 73
    Height = 22
    Hint = 'ConnectionTimeout'
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Value = 0
  end
  object btnWaitForPrinting: TButton
    Left = 208
    Top = 272
    Width = 169
    Height = 25
    Hint = 'WaitForPrinting'
    Anchors = [akTop, akRight]
    Caption = #1054#1078#1080#1076#1072#1090#1100' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103' '#1087#1077#1095#1072#1090#1080
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = btnWaitForPrintingClick
  end
  object btnWaitForCheckClose: TButton
    Left = 209
    Top = 304
    Width = 169
    Height = 25
    Hint = 'WaitForCheckClose'
    Anchors = [akTop, akRight]
    Caption = #1054#1078#1080#1076#1072#1090#1100' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1095#1077#1082#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnWaitForCheckCloseClick
  end
end
