unit fmuPrintText;

interface

uses
  // VCL
  Forms, ComCtrls, StdCtrls, Controls, ExtCtrls, Classes, SysUtils, Buttons,
  Graphics, Dialogs,
  // This
  untPages, untUtil, untDriver, DrvFRLib_TLB, Spin;

type
  { TfmPrintText }

  TfmPrintText = class(TPage)
    lblStringForPrinting: TLabel;
    edtStringForPrinting: TEdit;
    chbUseReceiptRibbon: TCheckBox;
    chbUseJournalRibbon: TCheckBox;
    lblFontType: TLabel;
    btnPrintStringWithFont: TBitBtn;
    btnPrintWideString: TBitBtn;
    btnPrintString: TBitBtn;
    grpPrintString: TGroupBox;
    grpPrintText: TGroupBox;
    btnPrint: TBitBtn;
    btnOpen: TBitBtn;
    btnSave: TBitBtn;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    lblStrCount_: TLabel;
    lblStrCount: TLabel;
    lblText: TLabel;
    seFontType: TSpinEdit;
    chbUseSlipDocument: TCheckBox;
    grpNonFiscalDocument: TGroupBox;
    btnOpenNonFiscalDocument: TButton;
    btnCloseNonFiscalDocument: TButton;
    Memo: TMemo;
    btnStop: TButton;
    chbCarryStrings: TCheckBox;
    chbDelayedPrint: TCheckBox;
    procedure btnPrintStringClick(Sender: TObject);
    procedure btnPrintWideStringClick(Sender: TObject);
    procedure btnPrintStringWithFontClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnOpenNonFiscalDocumentClick(Sender: TObject);
    procedure btnCloseNonFiscalDocumentClick(Sender: TObject);
    procedure MemoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    FStop: Boolean;
    procedure EnableButtons2;
  public
    procedure Initialize; override;
  end;

implementation

{$R *.DFM}

{ TfmPrintText }

procedure TfmPrintText.btnPrintStringClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.UseReceiptRibbon := chbUseReceiptRibbon.Checked;
    Driver.UseJournalRibbon := chbUseJournalRibbon.Checked;
    Driver.UseSlipDocument := chbUseSlipDocument.Checked;
    Driver.CarryStrings := chbCarryStrings.Checked;
    Driver.DelayedPrint := chbDelayedPrint.Checked;
    Driver.StringForPrinting := ParsePrintStr(edtStringForPrinting.Text);
    Driver.PrintString;
  finally
    EnableButtons2;
  end;
end;

procedure TfmPrintText.btnPrintWideStringClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.UseReceiptRibbon := chbUseReceiptRibbon.Checked;
    Driver.UseJournalRibbon := chbUseJournalRibbon.Checked;
    Driver.UseSlipDocument := chbUseSlipDocument.Checked;
    Driver.CarryStrings := chbCarryStrings.Checked;
    Driver.DelayedPrint := chbDelayedPrint.Checked;
    Driver.StringforPrinting := ParsePrintStr(edtStringforPrinting.Text);
    Driver.PrintWideString;
  finally
    EnableButtons2;
  end;
end;

procedure TfmPrintText.btnPrintStringWithFontClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.UseReceiptRibbon := chbUseReceiptRibbon.Checked;
    Driver.UseJournalRibbon := chbUseJournalRibbon.Checked;
    Driver.UseSlipDocument := chbUseSlipDocument.Checked;
    Driver.CarryStrings := chbCarryStrings.Checked;
    Driver.DelayedPrint := chbDelayedPrint.Checked;
    Driver.StringForPrinting := ParsePrintStr(edtStringForPrinting.Text);
    Driver.FontType := seFontType.Value;
    Driver.PrintStringWithFont;
  finally
    EnableButtons2;
  end;
end;

procedure TfmPrintText.btnPrintClick(Sender: TObject);
var
  i: Integer;
begin
  EnableButtons(False);
  try
    Driver.UseReceiptRibbon := chbUseReceiptRibbon.Checked;
    Driver.UseJournalRibbon := chbUseJournalRibbon.Checked;
    Driver.UseSlipDocument := chbUseSlipDocument.Checked;
    Driver.CarryStrings := chbCarryStrings.Checked;
    Driver.DelayedPrint := chbDelayedPrint.Checked;

    FStop := False;
    btnStop.Enabled := True;

    for i := 0 to Memo.Lines.Count-1 do
    begin
      if FStop then Break;
      Driver.StringForPrinting := Copy(Memo.Lines[i], 1, 40);
      Check(Driver.PrintString);
      Application.ProcessMessages;
    end;
  finally
    EnableButtons2;
  end;
end;

procedure TfmPrintText.btnOpenClick(Sender: TObject);
begin
  if not dlgOpen.Execute then
    Exit;
  Memo.Lines.LoadFromFile(dlgOpen.FileName);
end;

procedure TfmPrintText.btnSaveClick(Sender: TObject);
begin
  if not dlgSave.Execute then
    Exit;
  Memo.Lines.SaveToFile(dlgSave.FileName);  
end;

procedure TfmPrintText.Initialize;
begin
//  
end;

procedure TfmPrintText.btnOpenNonFiscalDocumentClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.OpenNonfiscalDocument;
  finally
    EnableButtons2;
  end;
end;

procedure TfmPrintText.btnCloseNonFiscalDocumentClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.CloseNonFiscalDocument;
  finally
    EnableButtons2;
  end;
end;

procedure TfmPrintText.MemoChange(Sender: TObject);
begin
  lblStrCount.Caption := IntToStr(Memo.Lines.Count);
end;

procedure TfmPrintText.FormShow(Sender: TObject);
begin
  MemoChange(Self);
end;

procedure TfmPrintText.btnStopClick(Sender: TObject);
begin
  FStop := True;
end;

procedure TfmPrintText.EnableButtons2;
begin
  EnableButtons(True);
  btnStop.Enabled := False;
end;

end.
