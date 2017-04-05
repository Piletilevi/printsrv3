object fmPrintHeader: TfmPrintHeader
  Left = 320
  Top = 333
  AutoScroll = False
  Caption = #1050#1083#1080#1096#1077
  ClientHeight = 289
  ClientWidth = 544
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    544
    289)
  PixelsPerInch = 96
  TextHeight = 13
  object grpHeader: TGroupBox
    Left = 8
    Top = 136
    Width = 525
    Height = 113
    Anchors = [akLeft, akTop, akRight]
    Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    TabOrder = 0
    DesignSize = (
      525
      113)
    object lblDocumentName: TLabel
      Left = 57
      Top = 58
      Width = 57
      Height = 13
      Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDocumentNumber: TLabel
      Left = 20
      Top = 26
      Width = 94
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblOpenDocumentNumber: TLabel
      Left = 26
      Top = 83
      Width = 87
      Height = 13
      Caption = #1057#1082#1074#1086#1079#1085#1086#1081' '#1085#1086#1084#1077#1088':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtDocumentName: TEdit
      Left = 124
      Top = 51
      Width = 209
      Height = 21
      Hint = 'DocumentName'
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
      TabOrder = 1
      Text = #1047#1072#1075#1086#1083#1086#1074#1086#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object edtOpenDocumentNumber: TEdit
      Left = 124
      Top = 79
      Width = 209
      Height = 21
      Hint = 'OpenDocumentNumber'
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 2
    end
    object btnPrintDocumentTitle: TButton
      Left = 347
      Top = 20
      Width = 162
      Height = 25
      Hint = 'PrintDocumentTitle'
      Anchors = [akTop, akRight]
      Caption = #1055#1077#1095#1072#1090#1100' '#1079#1072#1075#1086#1083#1086#1074#1082#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnPrintDocumentTitleClick
    end
    object seDocumentNumber: TSpinEdit
      Left = 124
      Top = 22
      Width = 209
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object btnPrintDocumentTitle2: TButton
      Left = 347
      Top = 52
      Width = 162
      Height = 25
      Hint = 'PrintDocumentTitle'
      Anchors = [akTop, akRight]
      Caption = #1055#1077#1095#1072#1090#1100' '#1079#1072#1075#1086#1083#1086#1074#1082#1072' 2'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Visible = False
      OnClick = btnPrintDocumentTitle2Click
    end
  end
  object grpClishe: TGroupBox
    Left = 8
    Top = 8
    Width = 525
    Height = 121
    Anchors = [akLeft, akTop, akRight]
    Caption = #1050#1083#1080#1096#1077' '#1080' '#1088#1077#1082#1083#1072#1084#1085#1099#1081' '#1090#1077#1082#1089#1090
    TabOrder = 1
    DesignSize = (
      525
      121)
    object btnPrintCliche: TButton
      Left = 347
      Top = 84
      Width = 162
      Height = 25
      Hint = 'PrintCliche'
      Anchors = [akTop, akRight]
      Caption = #1055#1077#1095#1072#1090#1100' '#1082#1083#1080#1096#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnPrintClicheClick
    end
    object btnPrintTrailer: TButton
      Left = 347
      Top = 20
      Width = 162
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1055#1077#1095#1072#1090#1100' '#1088#1077#1082#1083#1072#1084#1085#1086#1075#1086' '#1090#1077#1082#1089#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnPrintTrailerClick
    end
    object btnFinishDocument: TBitBtn
      Left = 347
      Top = 52
      Width = 162
      Height = 25
      Hint = 'FinishDocument'
      Anchors = [akTop, akRight]
      Caption = #1050#1086#1085#1077#1094' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnFinishDocumentClick
      NumGlyphs = 2
    end
    object chkFinishDocumentMode: TCheckBox
      Left = 195
      Top = 56
      Width = 134
      Height = 17
      Anchors = [akTop, akRight]
      Caption = #1057' '#1088#1077#1082#1083#1072#1084#1085#1099#1084' '#1090#1077#1082#1089#1090#1086#1084
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
  end
end
