object fmPrintImage: TfmPrintImage
  Left = 557
  Top = 131
  AutoScroll = False
  Caption = 'Изображение'
  ClientHeight = 423
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    494
    423)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 479
    Height = 313
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    DesignSize = (
      479
      313)
    object lblImageSize_: TLabel
      Left = 16
      Top = 270
      Width = 113
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Размер изображения:'
    end
    object lblImageSize: TLabel
      Left = 131
      Top = 270
      Width = 3
      Height = 13
      Anchors = [akLeft, akBottom]
    end
    object btnLoadImage: TButton
      Left = 318
      Top = 112
      Width = 148
      Height = 25
      Hint = 'LoadLineData'
      Anchors = [akTop, akRight]
      Caption = 'Загрузка изображеня'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnLoadImageClick
    end
    object btnLoadLineDataEx: TButton
      Left = 318
      Top = 144
      Width = 148
      Height = 25
      Hint = 'LoadLineDataEx'
      Anchors = [akTop, akRight]
      Caption = 'Расширенная загрузка'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = btnLoadLineDataExClick
    end
    object btnWideLoadLineData: TButton
      Left = 318
      Top = 176
      Width = 148
      Height = 25
      Hint = 'WideLoadLineData'
      Anchors = [akTop, akRight]
      Caption = 'Загрузка одной командой'
      ModalResult = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = btnWideLoadLineDataClick
    end
    object btnMonochrome1: TButton
      Left = 318
      Top = 48
      Width = 148
      Height = 25
      Hint = 'Монохромизировать1'
      Anchors = [akTop, akRight]
      Caption = 'Монохромизировать1'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnMonochrome1Click
    end
    object btnMonochrome2: TButton
      Left = 318
      Top = 80
      Width = 148
      Height = 25
      Hint = 'Монохромизировать2'
      Anchors = [akTop, akRight]
      Caption = 'Монохромизировать2'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnMonochrome2Click
    end
    object pnlImage: TPanel
      Left = 16
      Top = 16
      Width = 292
      Height = 249
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvLowered
      TabOrder = 0
      object Image: TImage
        Left = 1
        Top = 1
        Width = 290
        Height = 247
        Align = alClient
      end
    end
    object ProgressBar: TProgressBar
      Left = 16
      Top = 288
      Width = 292
      Height = 17
      Anchors = [akLeft, akRight, akBottom]
      Max = 200
      Step = 1
      TabOrder = 1
      Visible = False
    end
    object btnOpenPicture: TBitBtn
      Left = 318
      Top = 16
      Width = 148
      Height = 25
      Hint = 'Открыть файл'
      Anchors = [akTop, akRight]
      Caption = 'Открыть файл'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnOpenPictureClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FF078DBE
        078DBE078DBE078DBE078DBE078DBE078DBE078DBE078DBE078DBE078DBE078D
        BE078DBEFF00FFFF00FF078DBE25A1D172C7E785D7FA66CDF965CDF965CDF965
        CDF965CDF865CDF965CDF866CEF939ADD8078DBEFF00FFFF00FF078DBE4CBCE7
        39A8D1A0E2FB6FD4FA6FD4F96ED4FA6FD4F96FD4FA6FD4FA6FD4FA6ED4F93EB1
        D984D7EB078DBEFF00FF078DBE72D6FA078DBEAEEAFC79DCFB79DCFB79DCFB79
        DCFB79DCFB7ADCFB79DCFA79DCFA44B5D9AEF1F9078DBEFF00FF078DBE79DDFB
        1899C79ADFF392E7FB84E4FB83E4FC83E4FC84E4FC83E4FC83E4FB84E5FC48B9
        DAB3F4F9078DBEFF00FF078DBE82E3FC43B7DC65C3E0ACF0FD8DEBFC8DEBFC8D
        EBFD8DEBFD8DEBFC8DEBFD0C85184CBBDAB6F7F96DCAE0078DBE078DBE8AEAFC
        77DCF3229CC6FDFFFFC8F7FEC9F7FEC9F7FEC9F7FEC8F7FE0C85183CBC5D0C85
        18DEF9FBD6F6F9078DBE078DBE93F0FE93F0FD1697C5078DBE078DBE078DBE07
        8DBE078DBE0C851852D97F62ED9741C4650C8518078DBE078DBE078DBE9BF5FE
        9AF6FE9AF6FE9BF5FD9BF6FE9AF6FE9BF5FE0C851846CE6C59E48858E18861EB
        9440C1650C8518FF00FF078DBEFEFEFEA0FBFFA0FBFEA0FBFEA1FAFEA1FBFE0C
        85180C85180C85180C851856E18447CD6E0C85180C85180C8518FF00FF078DBE
        FEFEFEA5FEFFA5FEFFA5FEFF078CB643B7DC43B7DC43B7DC0C85184EDD7936BA
        540C8518FF00FFFF00FFFF00FFFF00FF078DBE078DBE078DBE078DBEFF00FFFF
        00FFFF00FFFF00FF0C851840D0650C8518FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C85182AB7432DBA490C85
        18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FF0C851821B5380C8518FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF0C85180C85180C85180C8518FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0C85180C85180C
        85180C8518FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 328
    Width = 479
    Height = 84
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    DesignSize = (
      479
      84)
    object Label1: TLabel
      Left = 8
      Top = 21
      Width = 114
      Height = 13
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Номер первой строки:'
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 132
      Height = 13
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Номер последней строки:'
    end
    object btnDraw: TButton
      Tag = 12
      Left = 318
      Top = 16
      Width = 146
      Height = 25
      Hint = 'Draw'
      Anchors = [akTop, akRight]
      Caption = 'Печать изображения'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnDrawClick
    end
    object btnDrawEx: TButton
      Left = 318
      Top = 48
      Width = 146
      Height = 25
      Hint = 'DrawEx'
      Anchors = [akTop, akRight]
      Caption = 'Расширенная печать'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnDrawExClick
    end
    object seFirstLineNumber: TSpinEdit
      Left = 157
      Top = 16
      Width = 151
      Height = 22
      Hint = 'FirstLineNumber'
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 1
    end
    object seLastLineNumber: TSpinEdit
      Left = 157
      Top = 43
      Width = 151
      Height = 22
      Hint = 'LastLineNumber'
      MaxValue = 1200
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 200
    end
  end
  object OpenPictureDialog: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Options = [ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 32
    Top = 168
  end
end
