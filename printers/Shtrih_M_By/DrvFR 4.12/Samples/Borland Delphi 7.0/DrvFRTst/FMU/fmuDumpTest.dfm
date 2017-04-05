object fmDumpTest: TfmDumpTest
  Left = 381
  Top = 306
  Width = 440
  Height = 202
  Caption = 'fmDumpTest'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    432
    168)
  PixelsPerInch = 96
  TextHeight = 13
  object btnReadDump: TButton
    Left = 320
    Top = 128
    Width = 107
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Read dump'
    TabOrder = 0
    OnClick = btnReadDumpClick
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 417
    Height = 113
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
  end
end
