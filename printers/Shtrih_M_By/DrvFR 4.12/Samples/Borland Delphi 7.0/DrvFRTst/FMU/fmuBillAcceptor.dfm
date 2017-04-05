object fmBillAcceptor: TfmBillAcceptor
  Left = 522
  Top = 302
  AutoScroll = False
  Caption = #1050#1091#1087#1102#1088#1086#1087#1088#1080#1077#1084#1085#1080#1082
  ClientHeight = 346
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    554
    346)
  PixelsPerInch = 96
  TextHeight = 13
  object lblRegisterNumber: TLabel
    Left = 56
    Top = 311
    Width = 90
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = #1053#1072#1073#1086#1088' '#1088#1077#1075#1080#1089#1090#1088#1086#1074':'
  end
  object Memo: TMemo
    Left = 8
    Top = 0
    Width = 537
    Height = 265
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object btnGetCashBillStatus: TButton
    Left = 152
    Top = 272
    Width = 193
    Height = 25
    Hint = 'GetCashAcceptorStatus'
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1082#1091#1087#1102#1088#1086#1087#1088#1080#1077#1084#1085#1080#1082#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnGetCashBillStatusClick
  end
  object btnGetBillAcceptorRegisters: TButton
    Left = 352
    Top = 305
    Width = 193
    Height = 25
    Hint = 'GetCashAcceptorRegister'
    Anchors = [akRight, akBottom]
    Caption = #1056#1077#1075#1080#1089#1090#1088#1099' '#1082#1091#1087#1102#1088#1086#1087#1088#1080#1077#1084#1085#1080#1082#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnGetBillAcceptorRegistersClick
  end
  object btnBillAcceptorReport: TButton
    Left = 352
    Top = 272
    Width = 193
    Height = 25
    Hint = 'CashAcceptorReport'
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1082#1091#1087#1102#1088#1086#1087#1088#1080#1077#1084#1085#1080#1082#1091
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnBillAcceptorReportClick
  end
  object cbRegisterNumber: TComboBox
    Left = 152
    Top = 307
    Width = 193
    Height = 21
    Hint = 'RegisterNumber'
    Style = csDropDownList
    Anchors = [akRight, akBottom]
    ItemHeight = 13
    ItemIndex = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Text = #1050#1086#1083'-'#1074#1086' '#1082#1091#1087#1102#1088' '#1074' '#1090#1077#1082#1091#1097#1077#1084' '#1095#1077#1082#1077
    Items.Strings = (
      #1050#1086#1083'-'#1074#1086' '#1082#1091#1087#1102#1088' '#1074' '#1090#1077#1082#1091#1097#1077#1084' '#1095#1077#1082#1077
      #1050#1086#1083'-'#1074#1086' '#1082#1091#1087#1102#1088' '#1074' '#1090#1077#1082#1091#1097#1077#1081' '#1089#1084#1077#1085#1077
      #1054#1073#1097#1077#1077' '#1082#1086#1083'-'#1074#1086' '#1087#1088#1080#1085#1103#1090#1099#1093' '#1082#1091#1087#1102#1088)
  end
end
