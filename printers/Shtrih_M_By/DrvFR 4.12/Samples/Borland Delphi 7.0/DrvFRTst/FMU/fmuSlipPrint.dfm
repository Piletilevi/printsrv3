object fmSlipPrintEject: TfmSlipPrintEject
  Left = 352
  Top = 209
  AutoScroll = False
  Caption = #1055#1077#1095#1072#1090#1072#1090#1100'/'#1042#1099#1090#1086#1083#1082#1085#1091#1090#1100
  ClientHeight = 147
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object grpPrint: TGroupBox
    Left = 8
    Top = 8
    Width = 335
    Height = 73
    Caption = #1055#1077#1095#1072#1090#1100
    TabOrder = 0
    object lblInfoType: TLabel
      Left = 8
      Top = 44
      Width = 89
      Height = 13
      Caption = #1058#1080#1087' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080':'
    end
    object chkIsClearUnfiscalInfo: TCheckBox
      Left = 8
      Top = 18
      Width = 217
      Height = 17
      Hint = 'IsClearUnfiscalInfo'
      Alignment = taLeftJustify
      Caption = #1054#1095#1080#1097#1072#1090#1100' '#1085#1077#1092#1080#1089#1082#1072#1083#1100#1085#1091#1102' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 0
    end
    object ComboBox1: TComboBox
      Left = 104
      Top = 40
      Width = 121
      Height = 21
      Hint = 'InfoType'
      Style = csDropDownList
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
      Left = 235
      Top = 38
      Width = 89
      Height = 25
      Hint = 'PrintSlipDocument'
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnPrintSlipDocumentClick
    end
  end
  object grpEject: TGroupBox
    Left = 8
    Top = 88
    Width = 335
    Height = 49
    Caption = #1042#1099#1090#1086#1083#1082#1085#1091#1090#1100
    TabOrder = 1
    object lblEjectDirection: TLabel
      Left = 8
      Top = 22
      Width = 71
      Height = 13
      Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077':'
    end
    object btnEject: TButton
      Left = 235
      Top = 16
      Width = 89
      Height = 25
      Hint = 'EjectSlipDocument'
      Caption = #1042#1099#1090#1086#1083#1082#1085#1091#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnEjectClick
    end
    object cbEjectDirection: TComboBox
      Left = 104
      Top = 18
      Width = 121
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = #1074#1085#1080#1079
      Items.Strings = (
        #1074#1085#1080#1079
        #1074#1074#1077#1088#1093)
    end
  end
end
