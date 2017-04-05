object fmMain: TfmMain
  Left = 224
  Top = 173
  Width = 752
  Height = 558
  Caption = #1058#1077#1089#1090' '#1076#1088#1072#1081#1074#1077#1088#1072
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 742
    Height = 504
    BevelOuter = bvNone
    TabOrder = 0
    object Splitter: TSplitter
      Left = 125
      Top = 0
      Width = 2
      Height = 418
      MinSize = 60
      ResizeStyle = rsUpdate
      OnCanResize = SplitterCanResize
    end
    object ListBox: TListBox
      Left = 0
      Top = 0
      Width = 125
      Height = 418
      Style = lbOwnerDrawFixed
      Align = alLeft
      Constraints.MaxWidth = 125
      Constraints.MinWidth = 50
      ItemHeight = 22
      ScrollWidth = 120
      TabOrder = 0
      OnClick = ListBoxClick
      OnDrawItem = ListBoxDrawItem
    end
    object pnlSite: TPanel
      Left = 127
      Top = 0
      Width = 615
      Height = 418
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
    object pnlInfo: TPanel
      Left = 0
      Top = 418
      Width = 742
      Height = 86
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        742
        86)
      object Bevel2: TBevel
        Left = 604
        Top = 14
        Width = 135
        Height = 69
        Anchors = [akTop, akRight]
      end
      object Bevel1: TBevel
        Left = -6
        Top = 4
        Width = 749
        Height = 13
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
      end
      object lblRxData: TLabel
        Left = 7
        Top = 64
        Width = 46
        Height = 13
        Caption = #1055#1088#1080#1085#1103#1090#1086':'
      end
      object lblTxData: TLabel
        Left = 7
        Top = 40
        Width = 53
        Height = 13
        Caption = #1055#1077#1088#1077#1076#1072#1085#1086':'
      end
      object lblResult: TLabel
        Left = 7
        Top = 16
        Width = 55
        Height = 13
        Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090':'
      end
      object lblTime: TLabel
        Left = 469
        Top = 40
        Width = 36
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1042#1088#1077#1084#1103':'
      end
      object lblOperator: TLabel
        Left = 469
        Top = 64
        Width = 52
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1054#1087#1077#1088#1072#1090#1086#1088':'
      end
      object lblPassword: TLabel
        Left = 469
        Top = 14
        Width = 41
        Height = 13
        Anchors = [akTop, akRight]
        Caption = #1055#1072#1088#1086#1083#1100':'
      end
      object edtInput: TEdit
        Left = 72
        Top = 38
        Width = 389
        Height = 21
        Hint = #1055#1077#1088#1077#1076#1072#1085#1086
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 1
      end
      object edtOutput: TEdit
        Left = 72
        Top = 62
        Width = 389
        Height = 21
        Hint = #1055#1088#1080#1085#1103#1090#1086
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 2
      end
      object edtResult: TEdit
        Left = 72
        Top = 14
        Width = 389
        Height = 21
        Hint = #1055#1077#1088#1077#1076#1072#1085#1086
        Anchors = [akLeft, akTop, akRight]
        Color = clBtnFace
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 0
      end
      object edtTime: TEdit
        Left = 524
        Top = 38
        Width = 73
        Height = 21
        Hint = #1055#1077#1088#1077#1076#1072#1085#1086
        Anchors = [akTop, akRight]
        Color = clBtnFace
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 4
      end
      object btnProperties: TButton
        Left = 612
        Top = 20
        Width = 121
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1089#1074#1086#1081#1089#1090#1074
        TabOrder = 6
        OnClick = btnPropertiesClick
      end
      object btnClose: TButton
        Left = 612
        Top = 52
        Width = 121
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1047#1072#1082#1088#1099#1090#1100
        TabOrder = 7
        OnClick = btnCloseClick
      end
      object edtOperator: TEdit
        Left = 524
        Top = 62
        Width = 73
        Height = 21
        Hint = #1055#1077#1088#1077#1076#1072#1085#1086
        Anchors = [akTop, akRight]
        Color = clBtnFace
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 5
      end
      object edtPassword: TEdit
        Left = 524
        Top = 13
        Width = 73
        Height = 21
        Hint = #1055#1077#1088#1077#1076#1072#1085#1086
        Anchors = [akTop, akRight]
        MaxLength = 100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnChange = edtPasswordChange
        OnExit = edtPasswordExit
        OnKeyPress = edtPasswordKeyPress
      end
    end
  end
  object MainMenu: TMainMenu
    Left = 201
    Top = 89
    object miFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object miShowProperties: TMenuItem
        Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1076#1088#1072#1081#1074#1077#1088#1072'...'
        OnClick = miShowPropertiesClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Caption = #1042'&'#1099#1093#1086#1076
        OnClick = miExitClick
      end
    end
    object miHelp: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1082#1072
      object miAbout: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
        OnClick = btnAboutClick
      end
      object miMailto: TMenuItem
        Caption = #1053#1072#1087#1080#1089#1072#1090#1100' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1072#1084'...'
        OnClick = miMailtoClick
      end
    end
  end
end
