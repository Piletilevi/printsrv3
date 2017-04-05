object fmTotalizers: TfmTotalizers
  Left = 92
  Top = 548
  AutoScroll = False
  Caption = #1056#1077#1075#1080#1089#1090#1088#1099
  ClientHeight = 173
  ClientWidth = 463
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    463
    173)
  PixelsPerInch = 96
  TextHeight = 13
  object lblRegisterNumber: TLabel
    Left = 8
    Top = 12
    Width = 86
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1088#1077#1075#1080#1089#1090#1088#1072':'
  end
  object lblNameOperationReg: TLabel
    Left = 8
    Top = 40
    Width = 102
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1088#1077#1075#1080#1089#1090#1088#1072':'
  end
  object lblContents: TLabel
    Left = 8
    Top = 68
    Width = 117
    Height = 13
    Caption = #1057#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1088#1077#1075#1080#1089#1090#1088#1072':'
  end
  object edtRegName: TEdit
    Left = 136
    Top = 36
    Width = 321
    Height = 21
    Hint = #1053#1072#1079#1074#1072#1085#1080#1077' '#1088#1077#1075#1080#1089#1090#1088#1072
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 1
  end
  object edtRegContent: TEdit
    Left = 136
    Top = 64
    Width = 321
    Height = 21
    Hint = #1057#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1088#1077#1075#1080#1089#1090#1088#1072
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 2
  end
  object btnGetOperationReg: TButton
    Left = 176
    Top = 92
    Width = 137
    Height = 25
    Hint = 'GetOperationReg'
    Anchors = [akTop, akRight]
    Caption = #1054#1087#1077#1088#1072#1094#1080#1086#1085#1085#1099#1081' '#1088#1077#1075#1080#1089#1090#1088
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnGetOperationRegClick
  end
  object btnGetCashReg: TButton
    Left = 320
    Top = 92
    Width = 137
    Height = 25
    Hint = 'GetCashReg'
    Anchors = [akTop, akRight]
    Caption = #1044#1077#1085#1077#1078#1085#1099#1081' '#1088#1077#1075#1080#1089#1090#1088
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnGetCashRegClick
  end
  object seRegisterNumber: TSpinEdit
    Left = 136
    Top = 8
    Width = 321
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object btnGetCashRegEx: TButton
    Left = 320
    Top = 124
    Width = 137
    Height = 25
    Hint = 'GetCashRegEx'
    Anchors = [akTop, akRight]
    Caption = #1044#1077#1085#1077#1078#1085#1099#1081' '#1088#1077#1075#1080#1089#1090#1088' (K)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btnGetCashRegExClick
  end
end
