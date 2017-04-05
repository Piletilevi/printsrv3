object fmTestReceipt: TfmTestReceipt
  Left = 204
  Top = 176
  AutoScroll = False
  Caption = #1058#1077#1089#1090#1086#1074#1099#1081' '#1095#1077#1082
  ClientHeight = 78
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblSaleCount: TLabel
    Left = 16
    Top = 18
    Width = 103
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1088#1086#1076#1072#1078':'
  end
  object lblLineCount: TLabel
    Left = 16
    Top = 50
    Width = 94
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1090#1088#1086#1082':'
  end
  object seSaleCount: TSpinEdit
    Left = 122
    Top = 14
    Width = 60
    Height = 22
    Hint = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1088#1086#1076#1072#1078
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Value = 3
  end
  object seLineCount: TSpinEdit
    Left = 122
    Top = 46
    Width = 60
    Height = 22
    Hint = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1090#1088#1086#1082
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Value = 5
  end
  object btnTestReceipt: TButton
    Left = 189
    Top = 12
    Width = 106
    Height = 25
    Caption = #1058#1077#1089#1090#1086#1074#1099#1081' '#1095#1077#1082
    TabOrder = 2
    OnClick = btnTestReceiptClick
  end
end
