object fmPrintText: TfmPrintText
  Left = 275
  Top = 229
  AutoScroll = False
  Caption = #1058#1077#1082#1089#1090
  ClientHeight = 394
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    616
    394)
  PixelsPerInch = 96
  TextHeight = 13
  object grpPrintString: TGroupBox
    Left = 8
    Top = 71
    Width = 597
    Height = 115
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1077#1095#1072#1090#1100' '#1089#1090#1088#1086#1082
    TabOrder = 1
    DesignSize = (
      597
      115)
    object lblStringForPrinting: TLabel
      Left = 16
      Top = 22
      Width = 39
      Height = 13
      Caption = #1057#1090#1088#1086#1082#1072':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblFontType: TLabel
      Left = 16
      Top = 53
      Width = 37
      Height = 13
      Caption = #1064#1088#1080#1092#1090':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnPrintWideString: TBitBtn
      Left = 422
      Top = 48
      Width = 162
      Height = 25
      Hint = 'PrintWideString'
      Anchors = [akTop, akRight]
      Caption = #1046#1080#1088#1085#1072#1103' '#1089#1090#1088#1086#1082#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = btnPrintWideStringClick
    end
    object btnPrintString: TBitBtn
      Left = 422
      Top = 16
      Width = 162
      Height = 25
      Hint = 'PrintString'
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      Caption = #1055#1077#1095#1072#1090#1100' '#1089#1090#1088#1086#1082#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = btnPrintStringClick
    end
    object btnPrintStringWithFont: TBitBtn
      Left = 422
      Top = 80
      Width = 162
      Height = 25
      Hint = 'PrintStringWithFont'
      Anchors = [akTop, akRight]
      Caption = #1057#1090#1088#1086#1082#1072' '#1096#1088#1080#1092#1090#1086#1084
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = btnPrintStringWithFontClick
    end
    object edtStringForPrinting: TEdit
      Left = 64
      Top = 18
      Width = 345
      Height = 21
      Hint = 'StringForPrinting'
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
      Text = #1057#1090#1088#1086#1082#1072' '#1076#1083#1103' '#1087#1077#1095#1072#1090#1080
    end
    object chbUseReceiptRibbon: TCheckBox
      Left = 139
      Top = 52
      Width = 105
      Height = 17
      Hint = 'UseReceiptRibbon'
      Anchors = [akTop, akRight]
      Caption = #1063#1077#1082#1086#1074#1072#1103' '#1083#1077#1085#1090#1072
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
    object chbUseJournalRibbon: TCheckBox
      Left = 243
      Top = 52
      Width = 121
      Height = 17
      Hint = 'UseJournalRibbon'
      Anchors = [akTop, akRight]
      Caption = #1050#1086#1085#1090#1088#1086#1083#1100#1085#1072#1103' '#1083#1077#1085#1090#1072
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
      TabOrder = 3
    end
    object seFontType: TSpinEdit
      Left = 64
      Top = 49
      Width = 65
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
    object chbUseSlipDocument: TCheckBox
      Left = 371
      Top = 52
      Width = 41
      Height = 17
      Anchors = [akTop, akRight]
      Caption = #1055#1044
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
      TabOrder = 4
    end
    object chbCarryStrings: TCheckBox
      Left = 139
      Top = 76
      Width = 126
      Height = 17
      Hint = 'UseReceiptRibbon'
      Anchors = [akTop, akRight]
      Caption = #1055#1077#1088#1077#1085#1086#1089#1080#1090#1100' '#1089#1090#1088#1086#1082#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
    object chbDelayedPrint: TCheckBox
      Left = 267
      Top = 76
      Width = 126
      Height = 17
      Hint = 'UseReceiptRibbon'
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1083#1086#1078#1077#1085#1085#1072#1103' '#1087#1077#1095#1072#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
  end
  object grpPrintText: TGroupBox
    Left = 8
    Top = 192
    Width = 597
    Height = 193
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #1055#1077#1095#1072#1090#1100' '#1090#1077#1082#1089#1090#1072
    TabOrder = 2
    DesignSize = (
      597
      193)
    object lblStrCount_: TLabel
      Left = 272
      Top = 16
      Width = 94
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1090#1088#1086#1082':'
    end
    object lblStrCount: TLabel
      Left = 406
      Top = 16
      Width = 3
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
    end
    object lblText: TLabel
      Left = 6
      Top = 16
      Width = 33
      Height = 13
      Caption = #1058#1077#1082#1089#1090':'
    end
    object btnPrint: TBitBtn
      Left = 422
      Top = 24
      Width = 162
      Height = 25
      Hint = 'PrintString'
      Anchors = [akTop, akRight]
      BiDiMode = bdLeftToRight
      Caption = #1055#1077#1095#1072#1090#1100
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnPrintClick
    end
    object btnOpen: TBitBtn
      Left = 423
      Top = 88
      Width = 162
      Height = 25
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
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
      Margin = 30
    end
    object btnSave: TBitBtn
      Left = 423
      Top = 120
      Width = 162
      Height = 25
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083
      Anchors = [akTop, akRight]
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083
      TabOrder = 4
      OnClick = btnSaveClick
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF97433F97433FB59A9BB59A9BB59A9BB5
        9A9BB59A9BB59A9BB59A9B93303097433FFF00FFFF00FFFF00FFFF00FF97433F
        D66868C66060E5DEDF92292A92292AE4E7E7E0E3E6D9DFE0CCC9CC8F201FAF46
        4697433FFF00FFFF00FFFF00FF97433FD06566C25F5FE9E2E292292A92292AE2
        E1E3E2E6E8DDE2E4CFCCCF8F2222AD464697433FFF00FFFF00FFFF00FF97433F
        D06565C15D5DECE4E492292A92292ADFDDDFE1E6E8E0E5E7D3D0D28A1E1EAB44
        4497433FFF00FFFF00FFFF00FF97433FD06565C15B5CEFE6E6EDE5E5E5DEDFE0
        DDDFDFE0E2E0E1E3D6D0D2962A2AB24A4A97433FFF00FFFF00FFFF00FF97433F
        CD6263C86060C96767CC7272CA7271C66969C46464CC6D6CCA6667C55D5DCD65
        6597433FFF00FFFF00FFFF00FF97433FB65553C27B78D39D9CD7A7A5D8A7A6D8
        A6A5D7A09FD5A09FD7A9A7D8ABABCC666797433FFF00FFFF00FFFF00FF97433F
        CC6667F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC66
        6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
        F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FF97433F
        CC6667F9F9F9CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDF9F9F9CC66
        6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
        F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FF97433F
        CC6667F9F9F9CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDF9F9F9CC66
        6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
        F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FFFF00FF
        97433FF9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F99743
        3FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      Margin = 30
    end
    object Memo: TMemo
      Left = 8
      Top = 32
      Width = 401
      Height = 145
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        #171#1052#1086#1081' '#1076#1103#1076#1103' '#1089#1072#1084#1099#1093' '#1095#1077#1089#1090#1085#1099#1093' '#1087#1088#1072#1074#1080#1083','
        #1050#1086#1075#1076#1072' '#1085#1077' '#1074' '#1096#1091#1090#1082#1091' '#1079#1072#1085#1077#1084#1086#1075','
        #1054#1085' '#1091#1074#1072#1078#1072#1090#1100' '#1089#1077#1073#1103' '#1079#1072#1089#1090#1072#1074#1080#1083
        #1048' '#1083#1091#1095#1096#1077' '#1074#1099#1076#1091#1084#1072#1090#1100' '#1085#1077' '#1084#1086#1075'.'
        #1045#1075#1086' '#1087#1088#1080#1084#1077#1088' '#1076#1088#1091#1075#1080#1084' '#1085#1072#1091#1082#1072';'
        #1053#1086', '#1073#1086#1078#1077' '#1084#1086#1081', '#1082#1072#1082#1072#1103' '#1089#1082#1091#1082#1072
        #1057' '#1073#1086#1083#1100#1085#1099#1084' '#1089#1080#1076#1077#1090#1100' '#1080' '#1076#1077#1085#1100' '#1080' '#1085#1086#1095#1100','
        #1053#1077' '#1086#1090#1093#1086#1076#1103' '#1085#1080' '#1096#1072#1075#1091' '#1087#1088#1086#1095#1100'!'
        #1050#1072#1082#1086#1077' '#1085#1080#1079#1082#1086#1077' '#1082#1086#1074#1072#1088#1089#1090#1074#1086
        #1055#1086#1083#1091#1078#1080#1074#1086#1075#1086' '#1079#1072#1073#1072#1074#1083#1103#1090#1100','
        #1045#1084#1091' '#1087#1086#1076#1091#1096#1082#1080' '#1087#1086#1087#1088#1072#1074#1083#1103#1090#1100','
        #1055#1077#1095#1072#1083#1100#1085#1086' '#1087#1086#1076#1085#1086#1089#1080#1090#1100' '#1083#1077#1082#1072#1088#1089#1090#1074#1086','
        #1042#1079#1076#1099#1093#1072#1090#1100' '#1080' '#1076#1091#1084#1072#1090#1100' '#1087#1088#1086' '#1089#1077#1073#1103':'
        #1050#1086#1075#1076#1072' '#1078#1077' '#1095#1077#1088#1090' '#1074#1086#1079#1100#1084#1077#1090' '#1090#1077#1073#1103'!'#187)
      MaxLength = 4096
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
      OnChange = MemoChange
    end
    object btnStop: TButton
      Left = 424
      Top = 56
      Width = 161
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1055#1088#1077#1088#1074#1072#1090#1100
      Enabled = False
      TabOrder = 2
      OnClick = btnStopClick
    end
  end
  object grpNonFiscalDocument: TGroupBox
    Left = 8
    Top = 8
    Width = 597
    Height = 57
    Anchors = [akLeft, akTop, akRight]
    Caption = #1053#1077#1092#1080#1089#1082#1072#1083#1100#1085#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
    TabOrder = 0
    DesignSize = (
      597
      57)
    object btnOpenNonFiscalDocument: TButton
      Left = 170
      Top = 19
      Width = 200
      Height = 25
      Hint = 'OpenNonFiscalDocument'
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1085#1077#1092#1080#1089#1082#1072#1083#1100#1085#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnOpenNonFiscalDocumentClick
    end
    object btnCloseNonFiscalDocument: TButton
      Left = 384
      Top = 19
      Width = 200
      Height = 25
      Hint = 'CloseNonFiscalDocument'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1082#1088#1099#1090#1100' '#1085#1077#1092#1080#1089#1082#1072#1083#1100#1085#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnCloseNonFiscalDocumentClick
    end
  end
  object dlgOpen: TOpenDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' (*.txt)|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Left = 440
    Top = 344
  end
  object dlgSave: TSaveDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' (*.txt)|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 472
    Top = 344
  end
end
