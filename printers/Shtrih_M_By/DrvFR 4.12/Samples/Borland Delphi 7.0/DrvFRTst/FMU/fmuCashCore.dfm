object fmCashCore: TfmCashCore
  Left = 204
  Top = 176
  AutoScroll = False
  Caption = 'CashCore'
  ClientHeight = 179
  ClientWidth = 328
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    328
    179)
  PixelsPerInch = 96
  TextHeight = 13
  object lblDrawer: TLabel
    Left = 7
    Top = 25
    Width = 63
    Height = 13
    Caption = #1050#1086#1076' '#1086#1096#1080#1073#1082#1080':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblErrorDescription: TLabel
    Left = 7
    Top = 60
    Width = 53
    Height = 13
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object btnOpenDrawer: TButton
    Tag = 2
    Left = 131
    Top = 19
    Width = 190
    Height = 25
    Hint = 'ReadErrorDescription'
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1086#1087#1080#1089#1072#1085#1080#1077' '#1086#1096#1080#1073#1082#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnOpenDrawerClick
  end
  object edtErrorCode: TSpinEdit
    Left = 72
    Top = 20
    Width = 49
    Height = 22
    Hint = 'ErrorCode'
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Value = 0
  end
  object edtErrorDescription: TEdit
    Left = 72
    Top = 56
    Width = 250
    Height = 21
    Hint = 'ErrorDescription'
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 2
  end
end
