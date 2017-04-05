object fmSlipDiscountCharge: TfmSlipDiscountCharge
  Left = 621
  Top = 281
  AutoScroll = False
  Caption = #1057#1082#1080#1076#1082#1072'/'#1053#1072#1076#1073#1072#1074#1082#1072
  ClientHeight = 317
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
    317)
  PixelsPerInch = 96
  TextHeight = 13
  object lblCount: TLabel
    Left = 146
    Top = 291
    Width = 163
    Height = 13
    Anchors = [akRight, akBottom]
    Caption = #1055#1077#1088#1074#1072#1103' '#1089#1090#1088#1086#1082#1072' '#1073#1083#1086#1082#1072' '#1086#1087#1077#1088#1072#1094#1080#1080':'
  end
  object btnStdDiscount: TBitBtn
    Left = 423
    Top = 40
    Width = 184
    Height = 25
    Hint = 'DiscountOnSlipDocument'
    Anchors = [akTop, akRight]
    Caption = #1057#1090#1072#1085#1076#1072#1088#1090#1085#1072#1103' '#1089#1082#1080#1076#1082#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnStdDiscountClick
  end
  object btnDiscount: TBitBtn
    Left = 423
    Top = 8
    Width = 184
    Height = 25
    Hint = 'StandardDiscountOnSlipDocument'
    Anchors = [akTop, akRight]
    Caption = #1057#1082#1080#1076#1082#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btnDiscountClick
  end
  object btnCharge: TButton
    Left = 423
    Top = 79
    Width = 184
    Height = 25
    Hint = 'ChargeOnSlipDocument'
    Anchors = [akTop, akRight]
    Caption = #1053#1072#1076#1073#1072#1074#1082#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnChargeClick
  end
  object btnStdCharge: TButton
    Left = 423
    Top = 111
    Width = 184
    Height = 25
    Hint = 'StandardChargeOnSlipDocument'
    Anchors = [akTop, akRight]
    Caption = #1057#1090#1072#1085#1076#1072#1088#1090#1085#1072#1103' '#1085#1072#1076#1073#1072#1074#1082#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btnStdChargeClick
  end
  object vleParams: TValueListEditor
    Left = 8
    Top = 8
    Width = 403
    Height = 273
    Anchors = [akLeft, akTop, akRight, akBottom]
    DisplayOptions = [doColumnTitles, doKeyColFixed]
    Strings.Strings = (
      '=')
    TabOrder = 0
    TitleCaptions.Strings = (
      #1055#1072#1088#1072#1084#1077#1090#1088
      #1047#1085#1072#1095#1077#1085#1080#1077)
    OnDrawCell = vleParamsDrawCell
    OnSetEditText = vleParamsSetEditText
    ColWidths = (
      184
      213)
  end
  object btnLoadFromTables: TButton
    Left = 423
    Top = 183
    Width = 184
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1090#1072#1073#1083#1080#1094
    TabOrder = 7
    OnClick = btnLoadFromTablesClick
  end
  object btnDefaultValues: TButton
    Left = 423
    Top = 151
    Width = 184
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    TabOrder = 6
    OnClick = btnDefaultValuesClick
  end
  object btnSaveToTables: TButton
    Left = 423
    Top = 215
    Width = 184
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1074' '#1090#1072#1073#1083#1080#1094#1099
    TabOrder = 8
    OnClick = btnSaveToTablesClick
  end
  object seCount: TSpinEdit
    Left = 314
    Top = 287
    Width = 97
    Height = 22
    Anchors = [akRight, akBottom]
    MaxValue = 32767
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
end
