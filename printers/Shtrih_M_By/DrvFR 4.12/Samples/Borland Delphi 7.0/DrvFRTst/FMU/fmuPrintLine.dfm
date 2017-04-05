object fmPrintLine: TfmPrintLine
  Left = 355
  Top = 185
  AutoScroll = False
  Caption = #1051#1080#1085#1080#1103
  ClientHeight = 294
  ClientWidth = 421
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    421
    294)
  PixelsPerInch = 96
  TextHeight = 13
  object gbPrintLine: TGroupBox
    Left = 8
    Top = 8
    Width = 409
    Height = 137
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1077#1095#1072#1090#1100' '#1087#1088#1086#1080#1079#1074#1086#1083#1100#1085#1086#1081' '#1083#1080#1085#1080#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      409
      137)
    object lblLineData: TLabel
      Left = 8
      Top = 36
      Width = 69
      Height = 13
      Caption = #1044#1072#1085#1085#1099#1077', Hex:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblLineNumber: TLabel
      Left = 8
      Top = 68
      Width = 110
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086', 0..65535:'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object chbLineSwapBytes: TCheckBox
      Left = 128
      Top = 96
      Width = 145
      Height = 17
      Caption = #1055#1077#1088#1077#1074#1086#1088#1072#1095#1080#1074#1072#1090#1100' '#1073#1072#1081#1090#1099
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edtLineData: TEdit
      Left = 128
      Top = 32
      Width = 273
      Height = 21
      Hint = 'LineData'
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
      Text = 'FF FF FF FF FF FF FF FF FF FF FF FF '
    end
    object btnPrintLine: TButton
      Left = 296
      Top = 96
      Width = 105
      Height = 25
      Hint = 'PrintLine'
      Anchors = [akTop, akRight]
      Caption = #1055#1077#1095#1072#1090#1100' '#1083#1080#1085#1080#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnPrintLineClick
    end
    object seLineNumber: TSpinEdit
      Left = 128
      Top = 64
      Width = 273
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 65535
      MinValue = 1
      TabOrder = 1
      Value = 10
    end
  end
  object gbBlackLine: TGroupBox
    Left = 8
    Top = 152
    Width = 409
    Height = 137
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1077#1095#1072#1090#1100' '#1095#1077#1088#1085#1086#1081' '#1083#1080#1085#1080#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      409
      137)
    object lblLineCount: TLabel
      Left = 8
      Top = 36
      Width = 95
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1083#1080#1085#1080#1081':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblByteCount: TLabel
      Left = 8
      Top = 68
      Width = 98
      Height = 13
      Caption = #1044#1083#1080#1085#1072' '#1083#1080#1085#1080#1080', '#1073#1072#1081#1090':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnBlackLine: TButton
      Left = 296
      Top = 96
      Width = 105
      Height = 25
      Hint = 'PrintLine'
      Anchors = [akTop, akRight]
      Caption = #1055#1077#1095#1072#1090#1100' '#1083#1080#1085#1080#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnBlackLineClick
    end
    object seLineCount: TSpinEdit
      Left = 128
      Top = 32
      Width = 273
      Height = 22
      Hint = 'LineNumber'
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 20
    end
    object seByteCount: TSpinEdit
      Left = 128
      Top = 64
      Width = 273
      Height = 22
      Hint = #1044#1083#1080#1085#1072' '#1083#1080#1085#1080#1080
      Anchors = [akLeft, akTop, akRight]
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Value = 0
    end
  end
end
