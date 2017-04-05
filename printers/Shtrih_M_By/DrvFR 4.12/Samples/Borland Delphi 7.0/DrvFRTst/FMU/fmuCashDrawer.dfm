object fmCashDrawer: TfmCashDrawer
  Left = 204
  Top = 176
  AutoScroll = False
  Caption = #1044#1077#1085#1077#1078#1085#1099#1081' '#1103#1097#1080#1082
  ClientHeight = 57
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblDrawer: TLabel
    Left = 7
    Top = 25
    Width = 131
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1076#1077#1085#1077#1078#1085#1086#1075#1086' '#1103#1097#1080#1082#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object btnOpenDrawer: TButton
    Tag = 2
    Left = 211
    Top = 19
    Width = 145
    Height = 25
    Hint = 'OpenDrawer'
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1077#1085#1077#1078#1085#1099#1081' '#1103#1097#1080#1082
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = btnOpenDrawerClick
  end
  object seDrawer: TSpinEdit
    Left = 144
    Top = 20
    Width = 60
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
end
