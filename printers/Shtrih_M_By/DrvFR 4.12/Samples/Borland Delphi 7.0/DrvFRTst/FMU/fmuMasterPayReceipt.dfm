object fmMasterPayReceipt: TfmMasterPayReceipt
  Left = 472
  Top = 311
  AutoScroll = False
  Caption = #1063#1077#1082
  ClientHeight = 312
  ClientWidth = 552
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    552
    312)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 400
    Top = 72
    Width = 145
    Height = 33
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = #1063#1077#1082#1080' '#1089#1086#1093#1088#1072#1085#1103#1102#1090#1089#1103' '#1074' '#1092#1072#1081#1083#1077' Receipt.txt'
    WordWrap = True
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 385
    Height = 297
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 6
    WordWrap = False
  end
  object btnReadLastReceipt: TButton
    Left = 400
    Top = 184
    Width = 145
    Height = 33
    Hint = 'ReadLastReceipt'
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1088#1086#1089' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1095#1077#1082#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnReadLastReceiptClick
  end
  object btnReadLastReceiptLine: TButton
    Left = 400
    Top = 224
    Width = 145
    Height = 33
    Hint = 'ReadLastReceiptLine'
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1088#1086#1089' '#1089#1090#1088#1086#1082#1080
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnReadLastReceiptLineClick
  end
  object btnReadLastReceiptMac: TButton
    Left = 400
    Top = 264
    Width = 145
    Height = 33
    Hint = 'ReadLastReceiptMac'
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1088#1086#1089' '#1082#1086#1076#1072' '#1095#1077#1082#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btnReadLastReceiptMacClick
  end
  object btnReadReceipt: TButton
    Left = 400
    Top = 8
    Width = 145
    Height = 33
    Hint = 'ReadLastReceiptMac'
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1088#1086#1089' '#1074#1089#1077#1075#1086' '#1095#1077#1082#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = btnReadReceiptClick
  end
  object btnSave: TBitBtn
    Left = 400
    Top = 112
    Width = 145
    Height = 33
    Anchors = [akTop, akRight]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 2
    OnClick = btnSaveClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      8888880000000000000880330000008803088033000000880308803300000088
      0308803300000000030880333333333333088033000000003308803088888888
      0308803088888888030880308888888803088030888888880308803088888888
      0008803088888888080880000000000000088888888888888888}
  end
  object chbSaveReceipt: TCheckBox
    Left = 400
    Top = 48
    Width = 145
    Height = 17
    Anchors = [akTop, akRight]
    Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1095#1077#1082#1080' '#1074' '#1092#1072#1081#1083#1077
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    FileName = #1063#1077#1082'MasterPayK'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' (*.txt)|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 360
    Top = 176
  end
end
