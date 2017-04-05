unit fmuPrintBarcode;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Spin,
  // This
  untPages, untUtil, untDriver, untTypes;

type
  { TfmPrintBarcode }

  TfmPrintBarcode = class(TPage)
    lblData: TLabel;
    edtBarcode: TEdit;
    lblBarWidth: TLabel;
    chbCutPaper: TCheckBox;
    chbPrintMaxWidth: TCheckBox;
    btnPrintBarcodeLine: TButton;
    btnPrintBarcodeGraph: TButton;
    cbBarcodeAlignment: TComboBox;
    lblBarcodeType: TLabel;
    lblBarcodeAlignment: TLabel;
    seBarWidth: TSpinEdit;
    btnPrintBarcode: TButton;
    cbPrintBarcodeText: TComboBox;
    lblPrintBarcodeText: TLabel;
    lblLineNumber: TLabel;
    cbBarcodeType: TComboBox;
    chbLineSwapBytes: TCheckBox;
    seLineNumber: TSpinEdit;
    procedure btnPrintBarcodeLineClick(Sender: TObject);
    procedure btnPrintBarcodeGraphClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnPrintBarcodeClick(Sender: TObject);
  private
    procedure CutPaper;
    procedure PrintMaxWidthLine;
    procedure PrintMaxWidthGraph;
    procedure Check(ResultCode: Integer);
  public
    procedure Initialize; override;
  end;

implementation

{$R *.DFM}

{ TfmPrintBarcode }

procedure TfmPrintBarcode.Initialize;
begin
  cbBarcodeType.Items.Text := 'Code128A'#13#10'Code128B'#13#10'Code128C';
  cbBarcodeType.ItemIndex := 0;
  cbBarcodeAlignment.Items.Text := SAlignmentText;
  cbBarcodeAlignment.ItemIndex := 0;
end;

procedure TfmPrintBarcode.PrintMaxWidthGraph;
const
  Count = 10;
var
  i: Integer;
begin
  if not chbPrintMaxWidth.Checked then Exit;
  Sleep(100);
  Driver.LineData := StringOfChar(#$FF, 80);
  for i := 0 to Count-1 do
  begin
    Driver.LineNumber := i + 1;
    Check(Driver.LoadLineData);
  end;
  Driver.FirstLineNumber := 1;
  Driver.LastLineNumber := Count;
  Check(Driver.Draw);
end;

procedure TfmPrintBarcode.PrintMaxWidthLine;
var
  Count: Integer;
begin
  if not chbPrintMaxWidth.Checked then Exit;
  Driver.FontType := 1;
  Check(Driver.GetFontMetrics);
  Count := Driver.PrintWidth div 8;
  Driver.LineNumber := 10;
  Driver.LineData := StringOfChar(#$FF, Count);
  Check(Driver.PrintLine);
  Sleep(100);
end;

procedure TfmPrintBarcode.btnPrintBarcodeGraphClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.UseReceiptRibbon := True;
    Driver.LineNumber := seLineNumber.Value;
    Driver.Barcode := edtBarcode.Text;
    Driver.BarcodeType := cbBarcodeType.ItemIndex;
    Driver.BarWidth := seBarWidth.Value;
    Driver.BarcodeAlignment := cbBarcodeAlignment.ItemIndex;
    Driver.PrintBarcodeText := cbPrintBarcodeText.ItemIndex;
    Check(Driver.PrintBarcodeGraph);
    PrintMaxWidthGraph;
    CutPaper;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintBarcode.CutPaper;
begin
  if chbCutPaper.Checked then
  begin
    Driver.UseJournalRibbon := False;
    Driver.UseReceiptRibbon := True;
    Driver.UseSlipDocument := False;
    Driver.StringQuantity := 10;
    Check(Driver.FeedDocument);
    Driver.CutType := True;
    Check(Driver.CutCheck);
    Sleep(100);
  end;
end;

procedure TfmPrintBarcode.btnPrintBarcodeLineClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.UseReceiptRibbon := True;
    Driver.LineNumber := seLineNumber.Value;
    Driver.Barcode := edtBarcode.Text;
    Driver.BarcodeType := cbBarcodeType.ItemIndex;
    Driver.BarWidth := seBarWidth.Value;
    Driver.BarcodeAlignment := cbBarcodeAlignment.ItemIndex;
    Driver.PrintBarcodeText := cbPrintBarcodeText.ItemIndex;
    Driver.LineSwapBytes := chbLineSwapBytes.Checked;
    Check(Driver.PrintBarcodeLine);
    PrintMaxWidthLine;
    CutPaper;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintBarcode.btnTestClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.FontType := 3;
    Driver.StringForPrinting := StringOfChar('W', 90);
    Check(Driver.PrintStringWithFont);
    Check(Driver.PrintString);

    Driver.StringForPrinting := SPrintWidth576;
    Check(Driver.PrintString);
    Driver.LineNumber := 50;
    Driver.LineData := StringOfChar(#$FF, 72);
    Check(Driver.PrintLine);
    Driver.LineNumber := 50;
    Driver.LineData := #1 + StringOfChar(#0, 68) + #$80#$FF#$FF;
    Check(Driver.PrintLine);

    // Left bound
    Driver.StringForPrinting := SLeftBound;
    Check(Driver.PrintString);
    Driver.LineNumber := 50;
    Driver.LineData := #1 + StringOfChar(#0, 71);
    Check(Driver.PrintLine);

    // Right bound
    Driver.StringForPrinting := SRightBound;
    Check(Driver.PrintString);
    Driver.LineNumber := 50;
    Driver.LineData := StringOfChar(#0, 71) + #$80;
    Check(Driver.PrintLine);
    // 560
    Driver.StringForPrinting := SPrintWidth560;
    Check(Driver.PrintString);
    CutPaper;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintBarcode.Check(ResultCode: Integer);
begin
  if ResultCode <> 0 then Abort;
end;

procedure TfmPrintBarcode.btnPrintBarcodeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BarCode := edtBarcode.Text;
    Check(Driver.PrintBarCode);
    PrintMaxWidthLine;
    CutPaper;
  finally
    EnableButtons(True);
  end;
end;

end.

