object fmPrintTest: TfmPrintTest
  Left = 307
  Top = 207
  AutoScroll = False
  Caption = 'Тесты'
  ClientHeight = 311
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  DesignSize = (
    506
    311)
  PixelsPerInch = 96
  TextHeight = 13
  object grpPrintLock: TGroupBox
    Left = 8
    Top = 8
    Width = 489
    Height = 153
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Печать с блокировкой'
    TabOrder = 0
    DesignSize = (
      489
      153)
    object lblRepCount2: TLabel
      Left = 16
      Top = 24
      Width = 112
      Height = 13
      Caption = 'Количество повторов:'
    end
    object lblRepCount: TLabel
      Left = 144
      Top = 24
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lblErrCount2: TLabel
      Left = 16
      Top = 41
      Width = 103
      Height = 13
      Caption = 'Количество ошибок:'
    end
    object lblErrCount: TLabel
      Left = 144
      Top = 41
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lblSpeed: TLabel
      Left = 16
      Top = 58
      Width = 106
      Height = 13
      Caption = 'Скорость, команд/c:'
    end
    object lblTxSpeed: TLabel
      Left = 144
      Top = 58
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label1: TLabel
      Left = 16
      Top = 92
      Width = 87
      Height = 13
      Caption = 'Процент ошибок:'
    end
    object lblErrRate: TLabel
      Left = 144
      Top = 92
      Width = 6
      Height = 13
      Caption = '0'
    end
    object lblTimeLeft2: TLabel
      Left = 16
      Top = 109
      Width = 108
      Height = 13
      Caption = 'Время теста, секунд:'
    end
    object lblTimeLeft: TLabel
      Left = 144
      Top = 109
      Width = 6
      Height = 13
      Caption = '0'
    end
    object Label2: TLabel
      Left = 16
      Top = 75
      Width = 108
      Height = 13
      Caption = 'Время команды, мс.:'
    end
    object lblCommandTime: TLabel
      Left = 144
      Top = 75
      Width = 6
      Height = 13
      Caption = '0'
    end
    object btnStartPrintWithLock: TButton
      Left = 312
      Top = 16
      Width = 169
      Height = 25
      Hint = 'Начать'
      Anchors = [akTop, akRight]
      Caption = 'Начать'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnStartPrintWithLockClick
    end
    object btnStopPrintWithLock: TButton
      Left = 312
      Top = 48
      Width = 169
      Height = 25
      Hint = 'Прервать'
      Anchors = [akTop, akRight]
      Caption = 'Прервать'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnStopPrintWithLockClick
    end
    object chbStopOnError: TCheckBox
      Left = 16
      Top = 128
      Width = 177
      Height = 17
      Hint = 'Остановка при ошибке'
      Caption = 'Остановка при ошибке'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
  end
  object grpSpeedPrintTest: TGroupBox
    Left = 8
    Top = 168
    Width = 489
    Height = 82
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Скорость печати'
    TabOrder = 1
    DesignSize = (
      489
      82)
    object lblStringCount: TLabel
      Left = 8
      Top = 22
      Width = 94
      Height = 13
      Caption = 'Количество строк:'
    end
    object lblSpeed_: TLabel
      Left = 8
      Top = 54
      Width = 146
      Height = 13
      Caption = 'Скорость печати, строк/сек:'
    end
    object lblSpeedPrinting: TLabel
      Left = 160
      Top = 54
      Width = 6
      Height = 13
      Caption = '0'
    end
    object btnStartSpeedPrintTest: TButton
      Left = 312
      Top = 16
      Width = 169
      Height = 25
      Hint = 'Тест скорости печати'
      Anchors = [akTop, akRight]
      Caption = 'Тест скорости печати'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnStartSpeedPrintTestClick
    end
    object btnStopSpeedPrintTest: TButton
      Left = 312
      Top = 48
      Width = 169
      Height = 25
      Hint = 'Прервать'
      Anchors = [akTop, akRight]
      Caption = 'Прервать'
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnStopSpeedPrintTestClick
    end
    object sePrintCount: TSpinEdit
      Left = 112
      Top = 18
      Width = 191
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 1
    end
  end
  object grpTestFonts: TGroupBox
    Left = 8
    Top = 256
    Width = 489
    Height = 47
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Тест печати шрифтов'
    TabOrder = 2
    DesignSize = (
      489
      47)
    object btnFonts: TButton
      Left = 312
      Top = 14
      Width = 169
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Тест печати шрифтов'
      TabOrder = 0
      OnClick = btnFontsClick
    end
  end
end
