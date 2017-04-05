object fmPrintAttribute: TfmPrintAttribute
  Left = 340
  Top = 291
  AutoScroll = False
  Caption = 'Реквизиты'
  ClientHeight = 228
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    489
    228)
  PixelsPerInch = 96
  TextHeight = 13
  object lblAttrinuteNumber: TLabel
    Left = 8
    Top = 14
    Width = 129
    Height = 13
    Caption = 'Номер реквизита, 0..255:'
  end
  object lblAttributeValue: TLabel
    Left = 8
    Top = 38
    Width = 107
    Height = 13
    Caption = 'Значение реквизита:'
  end
  object btnPrintAttribute: TButton
    Left = 289
    Top = 8
    Width = 193
    Height = 25
    Hint = 'PrintAttribute'
    Anchors = [akTop, akRight]
    Caption = 'Печать реквизита'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnPrintAttributeClick
  end
  object btnPrintAttributes: TButton
    Left = 289
    Top = 40
    Width = 193
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Печать реквизитов'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 3
    OnClick = btnPrintAttributesClick
  end
  object seAttributeNumber: TSpinEdit
    Left = 144
    Top = 9
    Width = 137
    Height = 22
    Hint = 'AttributeNumber'
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Value = 1
  end
  object memAttribute: TMemo
    Left = 144
    Top = 40
    Width = 137
    Height = 97
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      'test1')
    MaxLength = 4096
    ScrollBars = ssBoth
    TabOrder = 1
  end
end
