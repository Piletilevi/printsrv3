object fmEJDocument: TfmEJDocument
  Left = 315
  Top = 211
  AutoScroll = False
  Caption = #1044#1086#1082#1091#1084#1077#1085#1090' '#1087#1086' '#1050#1055#1050
  ClientHeight = 358
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    601
    358)
  PixelsPerInch = 96
  TextHeight = 13
  object lblKPKNumber: TLabel
    Left = 8
    Top = 12
    Width = 62
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1050#1055#1050':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Memo: TMemo
    Left = 8
    Top = 40
    Width = 586
    Height = 273
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    WordWrap = False
  end
  object btnGetEKLZDocument: TBitBtn
    Left = 192
    Top = 325
    Width = 177
    Height = 25
    Hint = 'GetEKLZDocument'
    Anchors = [akLeft, akBottom]
    Caption = #1047#1072#1087#1088#1086#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1069#1050#1051#1047' '#1087#1086' '#1050#1055#1050
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnGetEKLZDocumentClick
  end
  object btnStop: TBitBtn
    Left = 377
    Top = 325
    Width = 97
    Height = 25
    Hint = #1055#1088#1077#1088#1074#1072#1090#1100
    Anchors = [akLeft, akBottom]
    Caption = #1055#1088#1077#1088#1074#1072#1090#1100
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnStopClick
  end
  object btnReadEKLZDocument: TButton
    Left = 8
    Top = 325
    Width = 177
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1055#1077#1095#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1069#1050#1051#1047' '#1087#1086' '#1050#1055#1050
    TabOrder = 2
    OnClick = btnReadEKLZDocumentClick
  end
  object seKPKNumber: TSpinEdit
    Left = 88
    Top = 8
    Width = 121
    Height = 22
    Hint = 'KPKNumber'
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Value = 0
  end
end
