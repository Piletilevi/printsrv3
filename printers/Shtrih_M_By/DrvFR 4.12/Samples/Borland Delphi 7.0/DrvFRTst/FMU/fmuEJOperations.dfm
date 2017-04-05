object fmEJOperations: TfmEJOperations
  Left = 208
  Top = 618
  AutoScroll = False
  Caption = #1054#1087#1077#1088#1072#1094#1080#1080
  ClientHeight = 287
  ClientWidth = 652
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    652
    287)
  PixelsPerInch = 96
  TextHeight = 13
  object grpActivization: TGroupBox
    Left = 7
    Top = 8
    Width = 637
    Height = 57
    Anchors = [akLeft, akTop, akRight]
    Caption = #1040#1082#1090#1080#1074#1080#1079#1072#1094#1080#1103
    TabOrder = 0
    DesignSize = (
      637
      57)
    object btnEKLZActivization: TButton
      Left = 347
      Top = 17
      Width = 137
      Height = 25
      Hint = 'EKLZActivization'
      Anchors = [akTop, akRight]
      Caption = #1040#1082#1090#1080#1074#1080#1079#1072#1094#1080#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnEKLZActivizationClick
    end
    object btnEKLZActivizationResult: TButton
      Left = 491
      Top = 17
      Width = 137
      Height = 25
      Hint = 'EKLZActivizationResult'
      Anchors = [akTop, akRight]
      Caption = #1048#1090#1086#1075' '#1072#1082#1090#1080#1074#1080#1079#1072#1094#1080#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnEKLZActivizationResultClick
    end
  end
  object grpArchive: TGroupBox
    Left = 8
    Top = 72
    Width = 636
    Height = 81
    Anchors = [akLeft, akTop, akRight]
    Caption = #1040#1088#1093#1080#1074
    TabOrder = 1
    DesignSize = (
      636
      81)
    object btnInitEKLZArchive: TButton
      Left = 347
      Top = 14
      Width = 137
      Height = 25
      Hint = 'InitEKLZArchive'
      Anchors = [akTop, akRight]
      Caption = #1048#1085#1080#1094#1080#1072#1083#1080#1079#1072#1094#1080#1103' '#1072#1088#1093#1080#1074#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnInitEKLZArchiveClick
    end
    object btnCloseEKLZArchive: TButton
      Left = 491
      Top = 14
      Width = 137
      Height = 25
      Hint = 'CloseEKLZArchive'
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1082#1088#1099#1090#1080#1077' '#1072#1088#1093#1080#1074#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnCloseEKLZArchiveClick
    end
    object btnTestEKLZArchiveIntegrity: TButton
      Left = 491
      Top = 44
      Width = 137
      Height = 25
      Hint = 'TestEKLZArchiveIntegrity'
      Anchors = [akTop, akRight]
      Caption = #1058#1077#1089#1090' '#1072#1088#1093#1080#1074#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnTestEKLZArchiveIntegrityClick
    end
  end
  object grpInterrupt: TGroupBox
    Left = 8
    Top = 160
    Width = 636
    Height = 57
    Anchors = [akLeft, akTop, akRight]
    Caption = #1055#1088#1077#1082#1088#1072#1097#1077#1085#1080#1077
    TabOrder = 2
    DesignSize = (
      636
      57)
    object btnEKLZInterrupt: TBitBtn
      Left = 491
      Top = 19
      Width = 137
      Height = 25
      Hint = 'EKLZInterrupt'
      Anchors = [akTop, akRight]
      Caption = #1055#1088#1077#1082#1088#1072#1097#1077#1085#1080#1077
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnEKLZInterruptClick
      NumGlyphs = 2
    end
  end
  object grpResultCode: TGroupBox
    Left = 8
    Top = 224
    Width = 636
    Height = 57
    Anchors = [akLeft, akTop, akRight]
    Caption = #1050#1086#1076' '#1086#1096#1080#1073#1082#1080
    TabOrder = 3
    DesignSize = (
      636
      57)
    object lblEKLZResultCode: TLabel
      Left = 318
      Top = 24
      Width = 63
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #1050#1086#1076' '#1086#1096#1080#1073#1082#1080':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnSetEKLZResultCode: TButton
      Left = 491
      Top = 18
      Width = 137
      Height = 25
      Hint = 'SetEKLZResultCode'
      Anchors = [akTop, akRight]
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1082#1086#1076' '#1086#1096#1080#1073#1082#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnSetEKLZResultCodeClick
    end
    object seEKLZResultCode: TSpinEdit
      Left = 392
      Top = 19
      Width = 89
      Height = 22
      Hint = 'EKLZResultCode'
      Anchors = [akTop, akRight]
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Value = 0
    end
  end
end
