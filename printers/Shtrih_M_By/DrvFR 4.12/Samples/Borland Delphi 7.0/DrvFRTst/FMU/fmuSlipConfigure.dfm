object fmSlipConfigure: TfmSlipConfigure
  Left = 336
  Top = 232
  AutoScroll = False
  Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103
  ClientHeight = 313
  ClientWidth = 615
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  DesignSize = (
    615
    313)
  PixelsPerInch = 96
  TextHeight = 13
  object btnConfigureStandardSlipDocument: TBitBtn
    Left = 423
    Top = 40
    Width = 184
    Height = 25
    Hint = 'ConfigureStandardSlipDocument'
    Anchors = [akTop, akRight]
    Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103' '#1089#1090#1072#1085#1076#1072#1088#1090#1085#1086#1075#1086' '#1055#1044
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnConfigureStandardSlipDocumentClick
  end
  object btnConfigureSlipDocument: TBitBtn
    Left = 423
    Top = 8
    Width = 184
    Height = 25
    Hint = 'ConfigureSlipDocument'
    Anchors = [akTop, akRight]
    Caption = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103' '#1055#1044
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnConfigureSlipDocumentClick
  end
  object vleParams: TValueListEditor
    Left = 8
    Top = 8
    Width = 403
    Height = 297
    Anchors = [akLeft, akTop, akRight, akBottom]
    DisplayOptions = [doColumnTitles, doKeyColFixed]
    Strings.Strings = (
      '=')
    TabOrder = 0
    TitleCaptions.Strings = (
      #1055#1072#1088#1072#1084#1077#1090#1088
      #1047#1085#1072#1095#1077#1085#1080#1077)
    OnSetEditText = vleParamsSetEditText
    ColWidths = (
      276
      121)
  end
  object btnLoadFromTables: TButton
    Left = 423
    Top = 112
    Width = 184
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1090#1072#1073#1083#1080#1094
    TabOrder = 4
    OnClick = btnLoadFromTablesClick
  end
  object btnDefaultValues: TButton
    Left = 423
    Top = 80
    Width = 184
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    TabOrder = 3
    OnClick = btnDefaultValuesClick
  end
  object btnSaveToTables: TButton
    Left = 423
    Top = 144
    Width = 184
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1074' '#1090#1072#1073#1083#1080#1094#1099
    TabOrder = 5
    OnClick = btnSaveToTablesClick
  end
end
