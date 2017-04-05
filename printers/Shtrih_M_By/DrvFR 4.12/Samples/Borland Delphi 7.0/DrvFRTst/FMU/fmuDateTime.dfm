object fmDateTime: TfmDateTime
  Left = 454
  Top = 241
  Anchors = [akTop, akRight]
  AutoScroll = False
  Caption = #1044#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103
  ClientHeight = 299
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    441
    299)
  PixelsPerInch = 96
  TextHeight = 13
  object gbDate: TGroupBox
    Left = 8
    Top = 8
    Width = 427
    Height = 121
    Anchors = [akLeft, akTop, akRight]
    Caption = #1044#1072#1090#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      427
      121)
    object dtpDate: TDateTimePicker
      Left = 16
      Top = 22
      Width = 193
      Height = 21
      Hint = 'Date'
      Anchors = [akTop, akRight]
      Date = 37963.717178541700000000
      Time = 37963.717178541700000000
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btnCurrentDate: TButton
      Left = 221
      Top = 20
      Width = 201
      Height = 25
      Hint = #1058#1077#1082#1091#1097#1072#1103' '#1076#1072#1090#1072
      Anchors = [akTop, akRight]
      Caption = #1058#1077#1082#1091#1097#1072#1103' '#1076#1072#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnCurrentDateClick
    end
    object btnConfirmDate: TButton
      Left = 221
      Top = 84
      Width = 201
      Height = 25
      Hint = 'ConfirmDate'
      Anchors = [akTop, akRight]
      Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1076#1072#1090#1091
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnConfirmDateClick
    end
    object btnSetDate: TBitBtn
      Left = 221
      Top = 52
      Width = 201
      Height = 25
      Hint = 'SetDate'
      Anchors = [akTop, akRight]
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1076#1072#1090#1091
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnSetDateClick
      NumGlyphs = 2
    end
  end
  object gbTime: TGroupBox
    Left = 8
    Top = 136
    Width = 427
    Height = 89
    Anchors = [akLeft, akTop, akRight]
    Caption = #1042#1088#1077#1084#1103
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      427
      89)
    object dtpTime: TDateTimePicker
      Left = 16
      Top = 22
      Width = 193
      Height = 21
      Hint = 'Time'
      Anchors = [akTop, akRight]
      Date = 37963.716317465310000000
      Time = 37963.716317465310000000
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Kind = dtkTime
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btnCurrentTime: TButton
      Left = 221
      Top = 20
      Width = 201
      Height = 25
      Hint = #1058#1077#1082#1091#1097#1077#1077' '#1074#1088#1077#1084#1103
      Anchors = [akTop, akRight]
      Caption = #1058#1077#1082#1091#1097#1077#1077' '#1074#1088#1077#1084#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnCurrentTimeClick
    end
    object btnSetTime: TBitBtn
      Left = 221
      Top = 52
      Width = 201
      Height = 25
      Hint = 'SetTime'
      Anchors = [akTop, akRight]
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1074#1088#1077#1084#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnSetTimeClick
      NumGlyphs = 2
    end
  end
  object grpCurrentDateTime: TGroupBox
    Left = 8
    Top = 232
    Width = 427
    Height = 57
    Anchors = [akLeft, akTop, akRight]
    Caption = #1058#1077#1082#1091#1097#1080#1077' '#1076#1072#1090#1072' '#1080' '#1074#1088#1077#1084#1103
    TabOrder = 2
    DesignSize = (
      427
      57)
    object lblDateTime: TLabel
      Left = 153
      Top = 24
      Width = 56
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'lblDateTime'
    end
    object btnSetCurrentDateTime: TButton
      Left = 221
      Top = 18
      Width = 201
      Height = 25
      Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1077' '#1076#1072#1090#1091' '#1080' '#1074#1088#1077#1084#1103
      Anchors = [akTop, akRight]
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1077' '#1076#1072#1090#1091' '#1080' '#1074#1088#1077#1084#1103
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnSetCurrentDateTimeClick
    end
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 24
    Top = 248
  end
end
