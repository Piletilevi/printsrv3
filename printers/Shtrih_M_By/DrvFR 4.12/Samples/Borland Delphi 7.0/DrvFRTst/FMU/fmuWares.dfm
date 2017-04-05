object fmWares: TfmWares
  Left = 211
  Top = 178
  AutoScroll = False
  Caption = #1058#1086#1074#1072#1088#1099
  ClientHeight = 501
  ClientWidth = 655
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    655
    501)
  PixelsPerInch = 96
  TextHeight = 13
  object lblWareCode: TLabel
    Left = 8
    Top = 12
    Width = 60
    Height = 13
    Caption = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072':'
  end
  object lblPrice: TLabel
    Left = 8
    Top = 63
    Width = 29
    Height = 13
    Caption = #1062#1077#1085#1072':'
  end
  object lblDepartment: TLabel
    Left = 8
    Top = 89
    Width = 34
    Height = 13
    Caption = #1054#1090#1076#1077#1083':'
  end
  object lblTax1: TLabel
    Left = 8
    Top = 114
    Width = 43
    Height = 13
    Caption = #1053#1072#1083#1086#1075' 1:'
  end
  object lblTax2: TLabel
    Left = 8
    Top = 139
    Width = 43
    Height = 13
    Caption = #1053#1072#1083#1086#1075' 2:'
  end
  object lblTax3: TLabel
    Left = 8
    Top = 164
    Width = 43
    Height = 13
    Caption = #1053#1072#1083#1086#1075' 3:'
  end
  object lblTax4: TLabel
    Left = 8
    Top = 189
    Width = 43
    Height = 13
    Caption = #1053#1072#1083#1086#1075' 4:'
  end
  object lblStringForPrinting: TLabel
    Left = 8
    Top = 38
    Width = 33
    Height = 13
    Caption = #1058#1077#1082#1089#1090':'
  end
  object btnReadWare: TButton
    Left = 457
    Top = 4
    Width = 192
    Height = 25
    Hint = 'ReadWare'
    Anchors = [akTop, akRight]
    Caption = #1057#1095#1080#1090#1072#1090#1100' '#1090#1086#1074#1072#1088' '#1080#1079' '#1073#1072#1079#1099' '#1090#1086#1074#1072#1088#1086#1074
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnReadWareClick
  end
  object btnUpdateWare: TButton
    Left = 456
    Top = 36
    Width = 194
    Height = 25
    Hint = 'UpdateWare'
    Anchors = [akTop, akRight]
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1090#1086#1074#1072#1088' '#1074' '#1073#1072#1079#1077' '#1090#1086#1074#1072#1088#1086#1074
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = btnUpdateWareClick
  end
  object edtWareCode: TSpinEdit
    Left = 72
    Top = 8
    Width = 81
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object btnDeleteWare: TButton
    Left = 456
    Top = 68
    Width = 194
    Height = 25
    Hint = 'DeleteWare'
    Anchors = [akTop, akRight]
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1090#1086#1074#1072#1088
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = btnDeleteWareClick
  end
  object cbTax1: TComboBox
    Left = 72
    Top = 110
    Width = 81
    Height = 21
    Hint = 'Tax1'
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Text = #1085#1077#1090
    Items.Strings = (
      #1085#1077#1090
      '1 '#1075#1088#1091#1087#1087#1072
      '2 '#1075#1088#1091#1087#1087#1072
      '3 '#1075#1088#1091#1087#1087#1072
      '4 '#1075#1088#1091#1087#1087#1072)
  end
  object cbTax2: TComboBox
    Left = 72
    Top = 135
    Width = 81
    Height = 21
    Hint = 'Tax2'
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    Text = #1085#1077#1090
    Items.Strings = (
      #1085#1077#1090
      '1 '#1075#1088#1091#1087#1087#1072
      '2 '#1075#1088#1091#1087#1087#1072
      '3 '#1075#1088#1091#1087#1087#1072
      '4 '#1075#1088#1091#1087#1087#1072)
  end
  object cbTax3: TComboBox
    Left = 72
    Top = 160
    Width = 81
    Height = 21
    Hint = 'Tax3'
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Text = #1085#1077#1090
    Items.Strings = (
      #1085#1077#1090
      '1 '#1075#1088#1091#1087#1087#1072
      '2 '#1075#1088#1091#1087#1087#1072
      '3 '#1075#1088#1091#1087#1087#1072
      '4 '#1075#1088#1091#1087#1087#1072)
  end
  object cbTax4: TComboBox
    Left = 72
    Top = 185
    Width = 81
    Height = 21
    Hint = 'Tax4'
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    Text = #1085#1077#1090
    Items.Strings = (
      #1085#1077#1090
      '1 '#1075#1088#1091#1087#1087#1072
      '2 '#1075#1088#1091#1087#1087#1072
      '3 '#1075#1088#1091#1087#1087#1072
      '4 '#1075#1088#1091#1087#1087#1072)
  end
  object edtPrice: TEdit
    Left = 72
    Top = 59
    Width = 81
    Height = 21
    Hint = 'Price'
    MaxLength = 100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Text = '0'
  end
  object edtDepartment: TSpinEdit
    Left = 72
    Top = 84
    Width = 81
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object edtStringForPrinting: TEdit
    Left = 72
    Top = 34
    Width = 375
    Height = 21
    Hint = 'StringForPrinting'
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object memOut: TMemo
    Left = 8
    Top = 216
    Width = 639
    Height = 278
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 8
  end
  object btnGetWareBaseCashRegs: TButton
    Left = 456
    Top = 100
    Width = 194
    Height = 25
    Hint = 'GetWareBaseCashRegs'
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100' '#1088#1077#1075#1080#1089#1090#1088#1099
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = btnGetWareBaseCashRegsClick
  end
end
