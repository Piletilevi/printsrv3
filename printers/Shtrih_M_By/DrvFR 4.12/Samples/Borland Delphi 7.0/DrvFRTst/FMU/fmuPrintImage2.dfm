object fmPrintImage2: TfmPrintImage2
  Left = 397
  Top = 297
  AutoScroll = False
  Caption = #1048#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1080#1079' '#1092#1072#1081#1083#1072
  ClientHeight = 338
  ClientWidth = 574
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    574
    338)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 560
    Height = 324
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    DesignSize = (
      560
      324)
    object lblFirstLineNumber: TLabel
      Left = 8
      Top = 48
      Width = 114
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1087#1077#1088#1074#1086#1081' '#1089#1090#1088#1086#1082#1080':'
    end
    object lblLastLineNumber: TLabel
      Left = 8
      Top = 72
      Width = 132
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1087#1086#1089#1083#1077#1076#1085#1077#1081' '#1089#1090#1088#1086#1082#1080':'
    end
    object lblFileName: TLabel
      Left = 16
      Top = 20
      Width = 32
      Height = 13
      Caption = #1060#1072#1081#1083':'
    end
    object btnLoad: TButton
      Left = 407
      Top = 48
      Width = 140
      Height = 25
      Hint = 'LoadLineData'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = btnLoadClick
    end
    object pnlImage: TPanel
      Left = 8
      Top = 99
      Width = 387
      Height = 217
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvLowered
      BorderWidth = 5
      TabOrder = 5
      object Image: TImage
        Left = 6
        Top = 6
        Width = 375
        Height = 205
        Align = alClient
        Center = True
      end
    end
    object btnOpen: TBitBtn
      Left = 407
      Top = 16
      Width = 140
      Height = 25
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1082#1088#1099#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = btnOpenClick
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
    object btnDraw: TButton
      Tag = 12
      Left = 407
      Top = 80
      Width = 140
      Height = 25
      Hint = 'Draw'
      Anchors = [akTop, akRight]
      Caption = #1055#1077#1095#1072#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = btnDrawClick
    end
    object btnDrawEx: TButton
      Left = 407
      Top = 112
      Width = 140
      Height = 25
      Hint = 'DrawEx'
      Anchors = [akTop, akRight]
      Caption = #1056#1072#1089#1096#1080#1088#1077#1085#1085#1072#1103' '#1087#1077#1095#1072#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = btnDrawExClick
    end
    object edtFileName: TEdit
      Left = 56
      Top = 16
      Width = 339
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      MaxLength = 4096
      TabOrder = 0
    end
    object chbCenterImage: TCheckBox
      Left = 256
      Top = 48
      Width = 97
      Height = 17
      Caption = #1062#1077#1085#1090#1088#1080#1088#1086#1074#1072#1090#1100
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object chbShowProgress: TCheckBox
      Left = 256
      Top = 72
      Width = 73
      Height = 17
      Caption = #1055#1088#1086#1075#1088#1077#1089#1089
      TabOrder = 4
    end
    object seFirstLineNumber: TSpinEdit
      Left = 144
      Top = 44
      Width = 97
      Height = 22
      Hint = 'FirstLineNumber'
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 1
    end
    object seLastLineNumber: TSpinEdit
      Left = 144
      Top = 68
      Width = 97
      Height = 22
      Hint = 'LastLineNumber'
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Value = 200
    end
  end
  object OpenPictureDialog: TOpenPictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Options = [ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 408
    Top = 272
  end
end
