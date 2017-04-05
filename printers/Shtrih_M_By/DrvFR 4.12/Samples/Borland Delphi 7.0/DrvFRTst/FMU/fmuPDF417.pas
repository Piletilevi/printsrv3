unit fmuPDF417;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Spin, Buttons,
  // This
  untPages, untUtil, untDriver, FileUtils;

type
  { Tfm2DBarcode }

  TfmPDF417 = class(TPage)
    gbPDF417: TGroupBox;
    lblColumnCount: TLabel;
    seRowCount: TSpinEdit;
    lblRowCount: TLabel;
    lblModuleWidth: TLabel;
    btnPrintPDF417: TButton;
    OpenDialog: TOpenDialog;
    cbModuleWidth: TComboBox;
    lblSymbolHeight: TLabel;
    cbSymbolHeight: TComboBox;
    lblErrorCorrectionLevel: TLabel;
    seErrorCorrectionLevel: TSpinEdit;
    btnCutPaper: TButton;
    gbData: TGroupBox;
    btnOpenFile: TBitBtn;
    edtStatus: TEdit;
    cbColumnCount: TComboBox;
    Label1: TLabel;
    chbCutPaper: TCheckBox;
    lblBarcodeAlignment: TLabel;
    cbBarcodeAlignment: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnPrintPDF417Click(Sender: TObject);
    procedure btnOpenFileClick(Sender: TObject);
    procedure btnCutPaperClick(Sender: TObject);
  private
    FData: string;
    procedure CutPaper;
    procedure Check(ResultCode: Integer);
  end;

implementation

{$R *.DFM}

const
  BARCODE_TYPE_PDF417     = 0;
  BARCODE_TYPE_DATAMATRIX = 1;
  BARCODE_TYPE_AZTEC      = 2;

{ Tfm2DBarcode }

procedure TfmPDF417.CutPaper;
begin
  // Feed
  Driver.UseJournalRibbon := False;
  Driver.UseReceiptRibbon := True;
  Driver.UseSlipDocument := False;
  Driver.StringQuantity := 10;
  Check(Driver.FeedDocument);
  // Cut
  Driver.CutType := True;
  Check(Driver.CutCheck);
end;

procedure TfmPDF417.Check(ResultCode: Integer);
begin
  if ResultCode <> 0 then Abort;
end;

procedure TfmPDF417.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  cbModuleWidth.ItemIndex := 1;
  cbSymbolHeight.ItemIndex := 1;

  cbColumnCount.Items.Clear;
  cbColumnCount.Items.Add('0, autoselect');
  for i := 1 to 30 do
  begin
    cbColumnCount.Items.Add(IntToStr(i));
  end;
  cbColumnCount.ItemIndex := 0;
  OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));
end;

procedure TfmPDF417.btnPrintPDF417Click(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BarcodeType := BARCODE_TYPE_PDF417;
    Driver.BlockDataHex := StrToHex(FData);
    Driver.BarcodeParameter1 := cbColumnCount.ItemIndex;
    Driver.BarcodeParameter2 := seRowCount.Value;
    Driver.BarcodeParameter3 := cbModuleWidth.ItemIndex + 2;
    Driver.BarcodeParameter4 := cbSymbolHeight.ItemIndex + 2;
    Driver.BarcodeParameter5 := seErrorCorrectionLevel.Value;
    Driver.BarcodeAlignment := cbBarcodeAlignment.ItemIndex;
    Check(Driver.LoadAndPrint2DBarcode);

    if chbCutPaper.Checked then
      CutPaper;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPDF417.btnOpenFileClick(Sender: TObject);
resourcestring
  SFileOpened = 'Файл открыт, длина %d байт';
begin
  if OpenDialog.Execute then
  begin
    FData := ReadFileData(OpenDialog.FileName);
    edtStatus.Text := Format(SFileOpened, [Length(FData)]);
  end;
end;

procedure TfmPDF417.btnCutPaperClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    CutPaper;
  finally
    EnableButtons(True);
  end;
end;

end.

