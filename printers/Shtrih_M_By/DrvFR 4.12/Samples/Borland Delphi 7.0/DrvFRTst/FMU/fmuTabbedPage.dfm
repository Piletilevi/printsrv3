object fmTabbedPage: TfmTabbedPage
  Left = 310
  Top = 365
  AutoScroll = False
  Caption = 'TabbedPage'
  ClientHeight = 313
  ClientWidth = 388
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 388
    Height = 313
    Align = alClient
    MultiLine = True
    TabOrder = 0
    OnChange = PageControlChange
    OnChanging = PageControlChanging
  end
end
