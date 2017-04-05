object fmCashControl: TfmCashControl
  Left = 423
  Top = 218
  AutoScroll = False
  Caption = 'CashControl'
  ClientHeight = 320
  ClientWidth = 552
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    552
    320)
  PixelsPerInch = 96
  TextHeight = 13
  object lblProtocol: TLabel
    Left = 8
    Top = 256
    Width = 52
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1055#1088#1086#1090#1086#1082#1086#1083':'
  end
  object lblPort: TLabel
    Left = 176
    Top = 256
    Width = 28
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1055#1086#1088#1090':'
  end
  object lblLineCount_: TLabel
    Left = 8
    Top = 304
    Width = 109
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1072#1082#1077#1090#1086#1074': '
  end
  object lblLineCount: TLabel
    Left = 136
    Top = 304
    Width = 6
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = '0'
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 537
    Height = 233
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object rbTCP: TRadioButton
    Left = 72
    Top = 256
    Width = 49
    Height = 17
    Hint = 'TCP'
    Anchors = [akLeft, akBottom]
    Caption = 'TCP'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TabStop = True
  end
  object rbUDP: TRadioButton
    Left = 120
    Top = 256
    Width = 49
    Height = 17
    Hint = 'UDP'
    Anchors = [akLeft, akBottom]
    Caption = 'UDP'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object edtPort: TEdit
    Left = 216
    Top = 256
    Width = 97
    Height = 21
    Hint = #1055#1086#1088#1090
    Anchors = [akLeft, akBottom]
    MaxLength = 100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Text = '4000'
  end
  object btnOpenPort: TBitBtn
    Left = 336
    Top = 256
    Width = 113
    Height = 25
    Hint = #1054#1090#1082#1088#1099#1090#1100' '#1087#1086#1088#1090
    Anchors = [akLeft, akBottom]
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1086#1088#1090
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = btnOpenPortClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFF
      FFFFFFFFFF00FFFFFFFFFFFFFF000FFFFFFFFFFFFF0000FFFFFFFFFFFF00000F
      FFFFFFFFFF0000FFFFFFFFFFFF000FFFFFFFFFFFFF00FFFFFFFFFFFFFF0FFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Margin = 8
  end
  object btnClosePort: TBitBtn
    Left = 336
    Top = 288
    Width = 113
    Height = 25
    Hint = #1047#1072#1082#1088#1099#1090#1100' '#1087#1086#1088#1090
    Anchors = [akLeft, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100' '#1087#1086#1088#1090
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnClosePortClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF00000000FFFFFFFF00000000FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    Margin = 8
  end
  object btnClear: TBitBtn
    Left = 456
    Top = 256
    Width = 89
    Height = 25
    Hint = #1054#1090#1082#1088#1099#1090#1100' '#1087#1086#1088#1090
    Anchors = [akLeft, akBottom]
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = btnClearClick
  end
  object btnSaveData: TBitBtn
    Left = 456
    Top = 288
    Width = 89
    Height = 25
    Hint = #1054#1090#1082#1088#1099#1090#1100' '#1087#1086#1088#1090
    Anchors = [akLeft, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnSaveDataClick
  end
  object chbShowData: TCheckBox
    Left = 136
    Top = 280
    Width = 129
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1076#1072#1085#1085#1099#1077
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object chbCP866: TCheckBox
    Left = 8
    Top = 280
    Width = 112
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #1050#1086#1076#1080#1088#1086#1074#1082#1072' CP866'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    FileName = 'CashControl'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1092#1072#1081#1083' (*.txt)|*.txt'
    Left = 16
    Top = 176
  end
end
