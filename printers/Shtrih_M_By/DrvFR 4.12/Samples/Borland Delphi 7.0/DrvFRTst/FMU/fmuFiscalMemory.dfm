object fmFiscalMemory: TfmFiscalMemory
  Left = 367
  Top = 230
  AutoScroll = False
  Caption = #1060#1055
  ClientHeight = 410
  ClientWidth = 677
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    677
    410)
  PixelsPerInch = 96
  TextHeight = 13
  object lblBadRecords: TLabel
    Left = 216
    Top = 302
    Width = 128
    Height = 13
    Caption = #1050#1086#1083'-'#1074#1086' '#1089#1073#1086#1081#1085#1099#1093' '#1079#1072#1087#1080#1089#1077#1081':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblCheckingType: TLabel
    Left = 8
    Top = 302
    Width = 73
    Height = 13
    Caption = #1058#1080#1087' '#1087#1088#1086#1074#1077#1088#1082#1080':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object grpRecordsSum: TGroupBox
    Left = 8
    Top = 6
    Width = 663
    Height = 160
    Anchors = [akLeft, akTop, akRight]
    Caption = #1057#1091#1084#1084#1072' '#1079#1072#1087#1080#1089#1077#1081' '#1074' '#1060#1055
    TabOrder = 0
    DesignSize = (
      663
      160)
    object lblSumm1: TLabel
      Left = 16
      Top = 54
      Width = 49
      Height = 13
      Caption = #1055#1088#1086#1076#1072#1078#1072':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSumm3: TLabel
      Left = 16
      Top = 80
      Width = 46
      Height = 13
      Caption = #1055#1086#1082#1091#1087#1082#1072':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSumm2: TLabel
      Left = 16
      Top = 106
      Width = 86
      Height = 13
      Caption = #1042#1086#1079#1074#1088#1072#1090' '#1087#1088#1086#1076#1072#1078':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSumm4: TLabel
      Left = 16
      Top = 132
      Width = 89
      Height = 13
      Caption = #1042#1086#1079#1074#1088#1072#1090' '#1087#1086#1082#1091#1087#1086#1082':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblType: TLabel
      Left = 16
      Top = 28
      Width = 22
      Height = 13
      Caption = #1058#1080#1087':'
    end
    object edtSumm1: TEdit
      Left = 120
      Top = 50
      Width = 327
      Height = 21
      Hint = 'Summ1'
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
    end
    object edtSumm3: TEdit
      Left = 120
      Top = 102
      Width = 327
      Height = 21
      Hint = 'Summ3'
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 2
    end
    object edtSumm2: TEdit
      Left = 120
      Top = 76
      Width = 327
      Height = 21
      Hint = 'Summ2'
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 3
    end
    object edtSumm4: TEdit
      Left = 120
      Top = 128
      Width = 327
      Height = 21
      Hint = 'Summ4'
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 4
    end
    object btnGetFMRecordsSum: TBitBtn
      Left = 460
      Top = 24
      Width = 193
      Height = 25
      Hint = 'GetFMRecordsSum'
      Anchors = [akTop, akRight]
      Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1089#1091#1084#1084#1091' '#1079#1072#1087#1080#1089#1077#1081' '#1060#1055
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnGetFMRecordsSumClick
      NumGlyphs = 2
    end
    object cbFMType: TComboBox
      Left = 120
      Top = 24
      Width = 327
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = #1074#1089#1077' '#1079#1072#1087#1080#1089#1080
      Items.Strings = (
        #1074#1089#1077' '#1079#1072#1087#1080#1089#1080
        #1087#1086#1089#1083#1077' '#1087#1086#1089#1083#1077#1076#1085#1077#1081' '#1092#1080#1089#1082#1072#1083#1080#1079#1072#1094#1080#1080)
    end
  end
  object grpLastFMRecord: TGroupBox
    Left = 8
    Top = 167
    Width = 663
    Height = 86
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1086#1089#1083#1077#1076#1085#1103#1103' '#1079#1072#1087#1080#1089#1100' '#1074' '#1060#1055
    TabOrder = 1
    DesignSize = (
      663
      86)
    object lblFMType: TLabel
      Left = 16
      Top = 32
      Width = 22
      Height = 13
      Caption = #1058#1080#1087':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblFMDate: TLabel
      Left = 16
      Top = 58
      Width = 29
      Height = 13
      Caption = #1044#1072#1090#1072':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtFMType: TEdit
      Left = 120
      Top = 28
      Width = 327
      Height = 21
      Hint = 'TypeOfLastEntryFM'
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
    end
    object edtFMDate: TEdit
      Left = 120
      Top = 54
      Width = 327
      Height = 21
      Hint = 'Date'
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
    end
    object btnGetLastFMRecordDate: TBitBtn
      Left = 460
      Top = 26
      Width = 193
      Height = 25
      Hint = 'GetLastFMRecordDate'
      Anchors = [akTop, akRight]
      Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1081' '#1079#1072#1087#1080#1089#1080' '#1074' '#1060#1055
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnGetLastFMRecordDateClick
      NumGlyphs = 2
    end
  end
  object btnInitFM: TButton
    Left = 476
    Top = 264
    Width = 193
    Height = 25
    Hint = 'InitFM'
    Anchors = [akTop, akRight]
    Caption = #1048#1085#1080#1094#1080#1072#1083#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1060#1055
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnInitFMClick
  end
  object btnCheckFM: TButton
    Left = 476
    Top = 296
    Width = 193
    Height = 25
    Hint = 'CheckFM'
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1060#1055
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btnCheckFMClick
  end
  object edtRecordsCount: TEdit
    Left = 352
    Top = 298
    Width = 115
    Height = 21
    Hint = 'TypeOfLastEntryFM'
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    Color = clBtnFace
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ReadOnly = True
    ShowHint = True
    TabOrder = 4
  end
  object cbCheckingType: TComboBox
    Left = 88
    Top = 298
    Width = 121
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = #1042#1089#1077' '#1079#1072#1087#1080#1089#1080
    Items.Strings = (
      #1042#1089#1077' '#1079#1072#1087#1080#1089#1080
      #1047#1072#1087#1080#1089#1100' '#1089#1077#1088#1080#1081#1085#1086#1075#1086' '#1085#1086#1084#1077#1088#1072
      #1047#1072#1087#1080#1089#1080' '#1092#1080#1089#1082#1072#1083#1080#1079#1072#1094#1080#1081' ('#1087#1077#1088#1077#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1081' '#1050#1050#1052')'
      #1047#1072#1087#1080#1089#1080' '#1072#1082#1090#1080#1074#1080#1079#1072#1094#1080#1081' '#1069#1050#1051#1047
      #1047#1072#1087#1080#1089#1080' '#1089#1084#1077#1085#1085#1099#1093' '#1080#1090#1086#1075#1086#1074)
  end
end
