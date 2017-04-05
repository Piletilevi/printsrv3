object fmPrintBarcodePrinter: TfmPrintBarcodePrinter
  Left = 519
  Top = 306
  Anchors = [akLeft, akTop, akRight]
  AutoScroll = False
  Caption = 'Штрихкод 2'
  ClientHeight = 330
  ClientWidth = 612
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    612
    330)
  PixelsPerInch = 96
  TextHeight = 13
  object lblData: TLabel
    Left = 8
    Top = 12
    Width = 101
    Height = 13
    Caption = 'Данные штрихкода:'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblBarWidth: TLabel
    Left = 8
    Top = 44
    Width = 115
    Height = 13
    Caption = 'Ширина штриха, точек:'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblBarcodeType: TLabel
    Left = 8
    Top = 76
    Width = 79
    Height = 13
    Caption = 'Тип штрихкода:'
  end
  object lblLineNumber: TLabel
    Left = 8
    Top = 109
    Width = 132
    Height = 13
    Caption = 'Высота штрихкода, точек:'
  end
  object lblFontType: TLabel
    Left = 8
    Top = 141
    Width = 56
    Height = 13
    Caption = 'Шрифт HRI'
  end
  object lblHRIPosition: TLabel
    Left = 8
    Top = 173
    Width = 69
    Height = 13
    Caption = 'Позиция HRI:'
  end
  object edtBarcode: TEdit
    Left = 152
    Top = 8
    Width = 227
    Height = 21
    Hint = 'Barcode'
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 4096
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = '12345678901234567890'
  end
  object seBarWidth: TSpinEdit
    Left = 152
    Top = 40
    Width = 227
    Height = 22
    Hint = 'BarWidth'
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Value = 2
  end
  object btnPrintBarcodeUsingPrinter: TButton
    Left = 386
    Top = 8
    Width = 218
    Height = 25
    Hint = 'PrintBarcodeUsingPrinter'
    Anchors = [akTop, akRight]
    Caption = 'Печать штрихкода средствами принтера'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnPrintBarcodeUsingPrinterClick
  end
  object seFontType: TSpinEdit
    Left = 152
    Top = 136
    Width = 227
    Height = 22
    Hint = 'FontType'
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Value = 0
  end
  object seHRIPosition: TSpinEdit
    Left = 152
    Top = 168
    Width = 227
    Height = 22
    Hint = 'HRIPosition'
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Value = 0
  end
  object chbCutPaper: TCheckBox
    Left = 152
    Top = 200
    Width = 209
    Height = 17
    Hint = 'Выполнять отрезку'
    Caption = 'Выполнять отрезку'
    Checked = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 5
  end
  object cbBarcodeType: TComboBox
    Left = 152
    Top = 72
    Width = 227
    Height = 21
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    TabOrder = 6
  end
  object chbPrintMaxWidth: TCheckBox
    Left = 152
    Top = 224
    Width = 233
    Height = 17
    Caption = 'Печатать максимальную ширину'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object seLineNumber: TSpinEdit
    Left = 152
    Top = 104
    Width = 227
    Height = 22
    Hint = 'LineNumber'
    MaxValue = 1199
    MinValue = 0
    TabOrder = 8
    Value = 100
  end
end
