object fmPresenter: TfmPresenter
  Left = 295
  Top = 263
  AutoScroll = False
  Caption = #1055#1088#1077#1079#1077#1085#1090#1077#1088
  ClientHeight = 205
  ClientWidth = 287
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    287
    205)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOutputReceipt0: TButton
    Left = 136
    Top = 8
    Width = 145
    Height = 25
    Hint = 'OutputReceipt0'
    Anchors = [akTop, akRight]
    Caption = #1042#1099#1076#1072#1090#1100' '#1095#1077#1082
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnOutputReceipt0Click
  end
  object btnGetECRStatus: TButton
    Left = 136
    Top = 168
    Width = 145
    Height = 25
    Hint = 'GetECRStatus'
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1089#1086#1089#1090#1086#1103#1085#1080#1077
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = btnGetECRStatusClick
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 113
    Height = 190
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
  end
  object btnOpenScreen: TButton
    Left = 136
    Top = 104
    Width = 145
    Height = 25
    Hint = 'OpenScreen'
    Anchors = [akTop, akRight]
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1079#1072#1089#1083#1086#1085#1082#1091
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnOpenScreenClick
  end
  object btnCloseScreen: TButton
    Left = 136
    Top = 136
    Width = 145
    Height = 25
    Hint = 'CloseScreen'
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1082#1088#1099#1090#1100' '#1079#1072#1089#1083#1086#1085#1082#1091
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btnCloseScreenClick
  end
  object btnOutputReceipt1: TButton
    Left = 136
    Top = 40
    Width = 145
    Height = 25
    Hint = 'OutputReceipt1'
    Anchors = [akTop, akRight]
    Caption = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1090#1100' '#1095#1077#1082
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnOutputReceipt1Click
  end
  object btnOutputReceipt2: TButton
    Left = 136
    Top = 72
    Width = 145
    Height = 25
    Hint = 'OutputReceipt2'
    Anchors = [akTop, akRight]
    Caption = #1042#1099#1076#1072#1090#1100' '#1095#1077#1082' '#1089' '#1092#1080#1082#1089#1072#1094#1080#1077#1081
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnOutputReceipt2Click
  end
end
