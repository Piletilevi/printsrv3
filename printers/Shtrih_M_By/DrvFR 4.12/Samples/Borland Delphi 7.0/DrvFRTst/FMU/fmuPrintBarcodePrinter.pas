unit fmuPrintBarcodePrinter;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, 
  // This
  untPages, untUtil, untDriver, Spin;

type
  { TfmPrintBarcode }

  TfmPrintBarcodePrinter = class(TPage)
    lblData: TLabel;
    edtBarcode: TEdit;
    lblBarWidth: TLabel;
    lblBarcodeType: TLabel;
    seBarWidth: TSpinEdit;
    lblLineNumber: TLabel;
    btnPrintBarcodeUsingPrinter: TButton;
    seFontType: TSpinEdit;
    lblFontType: TLabel;
    seHRIPosition: TSpinEdit;
    lblHRIPosition: TLabel;
    chbCutPaper: TCheckBox;
    cbBarcodeType: TComboBox;
    chbPrintMaxWidth: TCheckBox;
    seLineNumber: TSpinEdit;
    procedure btnPrintBarcodeUsingPrinterClick(Sender: TObject);
  private
    procedure CutPaper;
    procedure PrintMaxWidthLine;
    procedure Check(ResultCode: Integer);
  public
    procedure Initialize; override;
  end;

implementation
type
  TBarcode = record
    BarcodeType: Integer;
    Description: string;
  end;
const
  Barcodes: array[0..9] of TBarcode = (

    (BarcodeType: 0;
     Description: 'UPC-A'),

    (BarcodeType: 1;
     Description: 'UPC-E'),

    (BarcodeType: 2;
     Description: 'EAN13 (JAN)'),

    (BarcodeType: 3;
     Description: 'EAN8 (JAN)'),

    (BarcodeType: 4;
     Description: 'CODE39'),

    (BarcodeType: 5;
     Description: 'ITF'),

    (BarcodeType: 6;
     Description: 'CODABAR'),

    (BarcodeType: 7;
     Description: 'CODE93'),

    (BarcodeType: 8;
     Description: 'CODE128'),

    (BarcodeType: 20;
     Description: 'CODE32'));


{$R *.DFM}

{ TfmPrintBarcode }

procedure TfmPrintBarcodePrinter.Initialize;
var
  i : Integer;
begin
  for i := 0 to 9 do
    cbBarcodeType.AddItem(Barcodes[i].Description, TObject(Barcodes[i].BarcodeType));
  cbBarcodeType.ItemIndex := 0;  
end;

procedure TfmPrintBarcodePrinter.CutPaper;
begin
  if chbCutPaper.Checked then
  begin
    // Промотка
    Driver.UseJournalRibbon := False;
    Driver.UseReceiptRibbon := True;
    Driver.UseSlipDocument := False;
    Driver.StringQuantity := 10;
    Check(Driver.FeedDocument);
    // Отрезка
    Driver.CutType := True;
    Check(Driver.CutCheck);
    Sleep(100);
  end;
end;

procedure TfmPrintBarcodePrinter.PrintMaxWidthLine;
var
  Count: Integer; // количество байт
begin
  if not chbPrintMaxWidth.Checked then Exit;
  // Узнаем ширину печати
  Driver.FontType := 1;
  Check(Driver.GetFontMetrics);
  Count := Driver.PrintWidth div 8;
  // Печатаем
  Driver.LineNumber := 10;
  Driver.LineData := StringOfChar(#$FF, Count);
  Check(Driver.PrintLine);
end;

procedure TfmPrintBarcodePrinter.Check(ResultCode: Integer);
begin
  if ResultCode <> 0 then Abort;
end;

procedure TfmPrintBarcodePrinter.btnPrintBarcodeUsingPrinterClick(
  Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.LineNumber := seLineNumber.Value;
    Driver.BarWidth := seBarWidth.Value;
    Driver.HRIPosition := seHRIPosition.Value;
    Driver.FontType := seFontType.Value;
    Driver.BarcodeType := Integer(cbBarcodeType.Items.Objects[cbBarcodeType.ItemIndex]);
    Driver.BarCode := edtBarcode.Text;
    Check(Driver.PrintBarcodeUsingPrinter);
    CutPaper;
    PrintMaxWidthLine;
  finally
    EnableButtons(True);
  end;
end;

end.

