object fmTable: TfmTable
  Left = 176
  Top = 126
  AutoScroll = False
  Caption = #1058#1072#1073#1083#1080#1094#1099
  ClientHeight = 348
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    467
    348)
  PixelsPerInch = 96
  TextHeight = 13
  object lblValue: TLabel
    Left = 8
    Top = 80
    Width = 51
    Height = 13
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
  end
  object lblRowNumber: TLabel
    Left = 8
    Top = 36
    Width = 64
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1088#1103#1076#1072':'
  end
  object lblTableNumber: TLabel
    Left = 8
    Top = 12
    Width = 83
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1090#1072#1073#1083#1080#1094#1099':'
  end
  object lblFieldNumber: TLabel
    Left = 8
    Top = 60
    Width = 64
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1087#1086#1083#1103':'
  end
  object Memo: TMemo
    Left = 8
    Top = 128
    Width = 276
    Height = 215
    TabStop = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object edtValue: TEdit
    Left = 8
    Top = 96
    Width = 276
    Height = 21
    Hint = #1047#1085#1072#1095#1077#1085#1080#1077
    Anchors = [akLeft, akTop, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    Text = '0123456789012345678901234567890123456789'
  end
  object btnGetTableStruct: TBitBtn
    Left = 291
    Top = 8
    Width = 170
    Height = 25
    Hint = 'GetTableStruct'
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1089#1090#1088#1091#1082#1090#1091#1088#1091' '#1090#1072#1073#1083#1080#1094#1099
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btnGetTableStructClick
    NumGlyphs = 2
  end
  object btnGetFieldStruct: TBitBtn
    Left = 291
    Top = 40
    Width = 170
    Height = 25
    Hint = 'GetFieldStruct'
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1089#1090#1088#1091#1082#1090#1091#1088#1091' '#1087#1086#1083#1103
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = btnGetFieldStructClick
    NumGlyphs = 2
  end
  object btnReadTable: TBitBtn
    Left = 291
    Top = 72
    Width = 170
    Height = 25
    Hint = 'ReadTable'
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1086#1095#1080#1090#1072#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = btnReadTableClick
    NumGlyphs = 2
  end
  object btnWriteTable: TBitBtn
    Left = 291
    Top = 104
    Width = 170
    Height = 25
    Hint = 'WriteTable'
    Anchors = [akTop, akRight]
    Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = btnWriteTableClick
    NumGlyphs = 2
  end
  object btnInitTable: TBitBtn
    Left = 291
    Top = 136
    Width = 170
    Height = 25
    Hint = 'InitTable'
    Anchors = [akTop, akRight]
    Caption = #1048#1085#1080#1094#1080#1072#1083#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1090#1072#1073#1083#1080#1094#1099
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = btnInitTableClick
  end
  object seTableNumber: TSpinEdit
    Left = 96
    Top = 8
    Width = 73
    Height = 22
    Hint = 'TableNumber'
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Value = 1
  end
  object seRowNumber: TSpinEdit
    Left = 96
    Top = 32
    Width = 73
    Height = 22
    Hint = 'RowNumber'
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    Value = 1
  end
  object seFieldNumber: TSpinEdit
    Left = 96
    Top = 56
    Width = 73
    Height = 22
    Hint = 'FieldNumber'
    MaxValue = 0
    MinValue = 0
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Value = 1
  end
  object btnShowTablesDlg: TButton
    Left = 291
    Top = 168
    Width = 170
    Height = 25
    Hint = 'ShowTablesDlg'
    Anchors = [akTop, akRight]
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1072#1073#1083#1080#1094'...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    OnClick = btnShowTablesDlgClick
  end
end
