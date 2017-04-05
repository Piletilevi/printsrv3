object fmModemParam: TfmModemParam
  Left = 320
  Top = 276
  AutoScroll = False
  Caption = #1052#1086#1076#1077#1084
  ClientHeight = 264
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    352
    264)
  PixelsPerInch = 96
  TextHeight = 13
  object lblParameterValue: TLabel
    Left = 8
    Top = 24
    Width = 51
    Height = 13
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
  end
  object lblParameterNumber: TLabel
    Left = 40
    Top = 192
    Width = 76
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = #1053#1086#1084#1077#1088' (1..255):'
  end
  object lblCharCount: TLabel
    Left = 192
    Top = 8
    Width = 153
    Height = 13
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1080#1084#1074#1086#1083#1086#1074': 0'
  end
  object btnReadModemParameter: TBitBtn
    Left = 224
    Top = 192
    Width = 122
    Height = 25
    Hint = 'ReadModemParameter'
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnReadModemParameterClick
    NumGlyphs = 2
  end
  object btnWriteModemParameter: TBitBtn
    Left = 224
    Top = 224
    Width = 122
    Height = 25
    Hint = 'WriteModemParameter'
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnWriteModemParameterClick
    NumGlyphs = 2
  end
  object seParameterNumber: TSpinEdit
    Left = 128
    Top = 192
    Width = 89
    Height = 22
    Hint = 'ParameterNumber'
    Anchors = [akRight, akBottom]
    MaxValue = 255
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Value = 1
  end
  object memParameterValue: TMemo
    Left = 72
    Top = 24
    Width = 273
    Height = 161
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier'
    Font.Style = []
    MaxLength = 200
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnChange = memParameterValueChange
  end
end
