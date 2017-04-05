object fmFindDevice: TfmFindDevice
  Left = 355
  Top = 192
  AutoScroll = False
  Caption = #1055#1086#1080#1089#1082' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
  ClientHeight = 325
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    391
    325)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 3
    Top = 3
    Width = 385
    Height = 286
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object btnRead: TBitBtn
    Left = 296
    Top = 296
    Width = 89
    Height = 25
    Hint = #1055#1086#1080#1089#1082' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
    Anchors = [akRight, akBottom]
    Caption = #1055#1086#1080#1089#1082
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnReadClick
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000CE0E0000C40E00001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      7777777777777777777700000777770000070F000777770F00070F000777770F
      0007000000070000000700F000000F00000700F000700F00000700F000700F00
      00077000000000000077770F00070F0007777700000700000777777000777000
      77777770F07770F0777777700077700077777777777777777777}
  end
end
