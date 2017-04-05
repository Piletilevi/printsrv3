object fmCommand: TfmCommand
  Left = 465
  Top = 279
  AutoScroll = False
  Caption = #1050#1086#1084#1072#1085#1076#1072
  ClientHeight = 386
  ClientWidth = 375
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    375
    386)
  PixelsPerInch = 96
  TextHeight = 13
  object lblTxData: TLabel
    Left = 8
    Top = 24
    Width = 76
    Height = 13
    Caption = #1050#1086#1084#1072#1085#1076#1072', HEX:'
  end
  object lblRxData: TLabel
    Left = 8
    Top = 48
    Width = 61
    Height = 13
    Caption = #1054#1090#1074#1077#1090', HEX:'
  end
  object btnSend: TBitBtn
    Left = 288
    Top = 80
    Width = 81
    Height = 25
    Hint = 'Connect'
    Anchors = [akTop, akRight]
    Caption = #1055#1077#1088#1077#1076#1072#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = btnSendClick
    NumGlyphs = 2
  end
  object edtTxData: TEdit
    Left = 96
    Top = 24
    Width = 273
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Text = '13 01 00 00 00'
  end
  object edtRxData: TEdit
    Left = 96
    Top = 48
    Width = 273
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
end
