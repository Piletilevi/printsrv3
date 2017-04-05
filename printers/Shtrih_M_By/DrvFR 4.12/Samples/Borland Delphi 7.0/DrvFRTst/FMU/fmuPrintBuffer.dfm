object fmPrintBuffer: TfmPrintBuffer
  Left = 438
  Top = 194
  AutoScroll = False
  Caption = 'Буфер'
  ClientHeight = 386
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    487
    386)
  PixelsPerInch = 96
  TextHeight = 13
  object lblLineNumber: TLabel
    Left = 8
    Top = 14
    Width = 75
    Height = 13
    Caption = 'Номер строки:'
  end
  object lblPrintBufferFormat: TLabel
    Left = 8
    Top = 46
    Width = 83
    Height = 13
    Caption = 'Формат строки:'
  end
  object Memo: TMemo
    Left = 8
    Top = 72
    Width = 297
    Height = 305
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 4
    WordWrap = False
  end
  object btnReadPrintBufferLineNumber: TButton
    Left = 316
    Top = 8
    Width = 163
    Height = 25
    Hint = 'ReadPrintBufferLineNumber'
    Anchors = [akTop, akRight]
    Caption = 'Получить количество строк'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnReadPrintBufferLineNumberClick
  end
  object btnClearPrintBuffer: TButton
    Left = 316
    Top = 72
    Width = 163
    Height = 25
    Hint = 'ClearPrintBuffer'
    Anchors = [akTop, akRight]
    Caption = 'Очистить буфер печати'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnClearPrintBufferClick
  end
  object btnReadPrintBuffer: TButton
    Left = 316
    Top = 105
    Width = 163
    Height = 25
    Hint = 'Получить весь буфер'
    Anchors = [akTop, akRight]
    Caption = 'Получить весь буфер'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btnReadPrintBufferClick
  end
  object btnReadPrintBufferLine: TButton
    Left = 316
    Top = 40
    Width = 163
    Height = 25
    Hint = 'ReadPrintBufferLine'
    Anchors = [akTop, akRight]
    Caption = 'Получить строку по номеру'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnReadPrintBufferLineClick
  end
  object cbPrintBufferFormat: TComboBox
    Left = 101
    Top = 42
    Width = 204
    Height = 21
    Hint = 'PrintBufferFormat'
    Style = csDropDownList
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    ItemIndex = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = 'Без изменений'
    Items.Strings = (
      'Без изменений'
      'Только текст'
      'Все символы')
  end
  object btnClear: TButton
    Left = 316
    Top = 169
    Width = 163
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Очистить'
    TabOrder = 7
    OnClick = btnClearClick
  end
  object btnStop: TButton
    Left = 316
    Top = 137
    Width = 163
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Прервать'
    Enabled = False
    TabOrder = 6
    OnClick = btnStopClick
  end
  object seLineNumber: TSpinEdit
    Left = 101
    Top = 9
    Width = 204
    Height = 22
    Hint = 'LineNumber'
    MaxValue = 65535
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    Value = 0
  end
end
