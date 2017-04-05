object fmPrintOperations: TfmPrintOperations
  Left = 336
  Top = 194
  AutoScroll = False
  Caption = 'Операции'
  ClientHeight = 299
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    500
    299)
  PixelsPerInch = 96
  TextHeight = 13
  object grpFeed: TGroupBox
    Left = 5
    Top = 5
    Width = 486
    Height = 85
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Продвинуть документ'
    TabOrder = 0
    DesignSize = (
      486
      85)
    object lblStringQuantity: TLabel
      Left = 16
      Top = 27
      Width = 94
      Height = 13
      Caption = 'Количество строк:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnFeedDocument: TButton
      Left = 309
      Top = 21
      Width = 162
      Height = 25
      Hint = 'FeedDocument'
      Anchors = [akTop, akRight]
      Caption = 'Продвинуть документ'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnFeedDocumentClick
    end
    object chbUseReceiptRibbon2: TCheckBox
      Left = 28
      Top = 56
      Width = 105
      Height = 17
      Hint = 'UseReceiptRibbon'
      Anchors = [akTop, akRight]
      Caption = 'Чековая лента'
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
      TabOrder = 1
    end
    object chbUseJournalRibbon2: TCheckBox
      Left = 131
      Top = 56
      Width = 116
      Height = 17
      Hint = 'UseJournalRibbon'
      Anchors = [akTop, akRight]
      Caption = 'Контрольная лента'
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
      TabOrder = 2
    end
    object seStringQuantity: TSpinEdit
      Left = 155
      Top = 23
      Width = 138
      Height = 22
      Hint = 'StringQuantity'
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 15
    end
    object chkUseSlipDocument: TCheckBox
      Left = 256
      Top = 56
      Width = 41
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'ПД'
      TabOrder = 3
    end
  end
  object grpContinuePrint: TGroupBox
    Left = 5
    Top = 152
    Width = 486
    Height = 48
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Продолжить печать'
    TabOrder = 2
    DesignSize = (
      486
      48)
    object btnContinuePrint: TButton
      Left = 309
      Top = 13
      Width = 162
      Height = 25
      Hint = 'ContinuePrint'
      Anchors = [akTop, akRight]
      Caption = 'Продолжить печать'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnContinuePrintClick
    end
  end
  object grpTechTest: TGroupBox
    Left = 5
    Top = 206
    Width = 486
    Height = 56
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Тестовый прогон'
    TabOrder = 3
    DesignSize = (
      486
      56)
    object lblPeriod: TLabel
      Left = 8
      Top = 24
      Width = 138
      Height = 13
      Caption = 'Период прогона в минутах:'
    end
    object btnStartTechTest: TButton
      Left = 309
      Top = 19
      Width = 76
      Height = 25
      Hint = 'Test'
      Anchors = [akTop, akRight]
      Caption = 'Начать'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnStartTechTestClick
    end
    object btnStopTechTest: TButton
      Left = 395
      Top = 19
      Width = 76
      Height = 25
      Hint = 'InterruptTest'
      Anchors = [akTop, akRight]
      Caption = 'Прервать'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnStopTechTestClick
    end
    object sePeriod: TSpinEdit
      Left = 155
      Top = 20
      Width = 142
      Height = 22
      Hint = 'RunningPeriod'
      MaxValue = 99
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 1
    end
  end
  object grpCutCheck: TGroupBox
    Left = 5
    Top = 96
    Width = 486
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Отрезать чек'
    TabOrder = 1
    DesignSize = (
      486
      49)
    object lblCutType: TLabel
      Left = 16
      Top = 22
      Width = 66
      Height = 13
      Caption = 'Тип отрезки:'
    end
    object cbCutType: TComboBox
      Left = 155
      Top = 18
      Width = 138
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'полная'
      Items.Strings = (
        'полная'
        'неполная')
    end
    object btnCutCheck: TButton
      Left = 309
      Top = 16
      Width = 162
      Height = 25
      Hint = 'CutCheck'
      Anchors = [akTop, akRight]
      Caption = 'Отрезать чек'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnCutCheckClick
    end
  end
end
