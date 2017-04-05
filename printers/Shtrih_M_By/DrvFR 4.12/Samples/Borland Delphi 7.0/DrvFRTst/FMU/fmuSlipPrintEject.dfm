object fmSlipPrintEject: TfmSlipPrintEject
  Left = 352
  Top = 209
  AutoScroll = False
  Caption = #1055#1077#1095#1072#1090#1100
  ClientHeight = 239
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    431
    239)
  PixelsPerInch = 96
  TextHeight = 13
  object grpPrint: TGroupBox
    Left = 8
    Top = 8
    Width = 417
    Height = 121
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1077#1095#1072#1090#1100
    TabOrder = 0
    DesignSize = (
      417
      121)
    object lblInfoType: TLabel
      Left = 8
      Top = 52
      Width = 89
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1058#1080#1087' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080':'
    end
    object chkIsClearUnfiscalInfo: TCheckBox
      Left = 8
      Top = 24
      Width = 233
      Height = 17
      Hint = 'IsClearUnfiscalInfo'
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = #1054#1095#1080#1097#1072#1090#1100' '#1085#1077#1092#1080#1089#1082#1072#1083#1100#1085#1091#1102' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 0
    end
    object cbInfoType: TComboBox
      Left = 104
      Top = 48
      Width = 137
      Height = 21
      Hint = 'InfoType'
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 13
      ItemIndex = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = #1074#1089#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
      Items.Strings = (
        #1090#1086#1083#1100#1082#1086' '#1085#1077#1092#1080#1089#1082#1072#1083#1100#1085#1072#1103
        #1090#1086#1083#1100#1082#1086' '#1092#1080#1089#1082#1072#1083#1100#1085#1072#1103
        #1074#1089#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103)
    end
    object btnPrintSlipDocument: TBitBtn
      Left = 256
      Top = 16
      Width = 150
      Height = 25
      Hint = 'PrintSlipDocument'
      Anchors = [akTop, akRight]
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnPrintSlipDocumentClick
    end
    object btnTestSlip: TButton
      Left = 256
      Top = 80
      Width = 150
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1058#1077#1089#1090#1086#1074#1099#1081' '#1095#1077#1082
      TabOrder = 4
      OnClick = btnTestSlipClick
    end
    object btnReprint: TButton
      Left = 256
      Top = 48
      Width = 150
      Height = 25
      Hint = 'ReprintSlipDocument'
      Anchors = [akTop, akRight]
      Caption = #1044#1086#1087#1077#1095#1072#1090#1072#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnReprintClick
    end
  end
  object grpEject: TGroupBox
    Left = 8
    Top = 136
    Width = 417
    Height = 65
    Anchors = [akLeft, akTop, akRight]
    Caption = #1054#1087#1077#1088#1072#1094#1080#1103' '#1089' '#1055#1044
    TabOrder = 1
    DesignSize = (
      417
      65)
    object lblEjectDirection: TLabel
      Left = 24
      Top = 28
      Width = 73
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1058#1080#1087' '#1086#1087#1077#1088#1072#1094#1080#1080':'
    end
    object btnEject: TButton
      Left = 259
      Top = 24
      Width = 150
      Height = 25
      Hint = 'EjectSlipDocument'
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnEjectClick
    end
    object cbEjectDirection: TComboBox
      Left = 107
      Top = 24
      Width = 137
      Height = 21
      Style = csDropDownList
      Anchors = [akTop, akRight]
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = #1074#1099#1090#1086#1083#1082#1085#1091#1090#1100' '#1074#1085#1080#1079
      Items.Strings = (
        #1074#1099#1090#1086#1083#1082#1085#1091#1090#1100' '#1074#1085#1080#1079
        #1074#1099#1090#1086#1083#1082#1085#1091#1090#1100' '#1074#1074#1077#1088#1093
        #1079#1072#1075#1088#1091#1079#1080#1090#1100)
    end
  end
end
