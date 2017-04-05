unit fmu2DBarcode;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Spin, Buttons,
  // This
  untPages, untUtil, untDriver, FileUtils;

type
  { Tfm2DBarcode }

  Tfm2DBarcode = class(TPage)
    gbPrint2DBarcode: TGroupBox;
    lblBarcodeType: TLabel;
    cbBarcodeType: TComboBox;
    lblBarcodeDataLength: TLabel;
    seBarcodeDataLength: TSpinEdit;
    seStartBlockNumber: TSpinEdit;
    lblStartBlockNumber: TLabel;
    seBarcodeParameter1: TSpinEdit;
    lblBarcodeParameter1: TLabel;
    seBarcodeParameter2: TSpinEdit;
    lblBarcodeParameter2: TLabel;
    seBarcodeParameter3: TSpinEdit;
    lblBarcodeParameter3: TLabel;
    seBarcodeParameter4: TSpinEdit;
    lblBarcodeParameter4: TLabel;
    seBarcodeParameter5: TSpinEdit;
    lblBarcodeParameter5: TLabel;
    btnPrint2DBarcode: TButton;
    chbCutPaper: TCheckBox;
    OpenDialog: TOpenDialog;
    gbData: TGroupBox;
    btnOpenFile: TBitBtn;
    edtStatus: TEdit;
    Button1: TButton;
    cbBarcodeAlignment: TComboBox;
    lblBarcodeAlignment: TLabel;
    procedure btnLoadBlockDataClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPrint2DBarcodeClick(Sender: TObject);
    procedure btnOpenFileClick(Sender: TObject);
  private
    FData: WideString;
    procedure CutPaper;
    procedure Check(ResultCode: Integer);
  end;

implementation

{$R *.DFM}

{ Tfm2DBarcode }

procedure Tfm2DBarcode.CutPaper;
begin
  if chbCutPaper.Checked then
  begin
    // Feed paper
    Driver.UseJournalRibbon := False;
    Driver.UseReceiptRibbon := True;
    Driver.UseSlipDocument := False;
    Driver.StringQuantity := 10;
    Check(Driver.FeedDocument);
    // Cut paper
    Driver.CutType := True;
    Check(Driver.CutCheck);
  end;
end;

procedure Tfm2DBarcode.Check(ResultCode: Integer);
begin
  if ResultCode <> 0 then Abort;
end;

procedure Tfm2DBarcode.FormCreate(Sender: TObject);
begin
  cbBarcodeType.ItemIndex := 0;
  OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));
end;

procedure Tfm2DBarcode.btnLoadBlockDataClick(
  Sender: TObject);
var
  i: Integer;
  Count: Integer;
const
  BlockSize = 64;
begin
  EnableButtons(False);
  try
    Count := (Length(FData) + BlockSize -1) div BlockSize;
    for i := 0 to Count-1 do
    begin
      Driver.BlockType := 0;
      Driver.BlockNumber := i;
      Driver.BlockDataHex := StrToHex(Copy(FData, 1 + BlockSize*i, BlockSize));
      Check(Driver.LoadBlockData);
    end;
    seBarcodeDataLength.Value := Length(FData);
  finally
    EnableButtons(True);
  end;
end;

procedure Tfm2DBarcode.btnPrint2DBarcodeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BarcodeType := cbBarcodeType.ItemIndex;
    Driver.BarcodeDataLength := seBarcodeDataLength.Value;
    Driver.BarcodeStartBlockNumber := seStartBlockNumber.Value;
    Driver.BarcodeParameter1 := seBarcodeParameter1.Value;
    Driver.BarcodeParameter2 := seBarcodeParameter2.Value;
    Driver.BarcodeParameter3 := seBarcodeParameter3.Value;
    Driver.BarcodeParameter4 := seBarcodeParameter4.Value;
    Driver.BarcodeParameter5 := seBarcodeParameter5.Value;
    Driver.BarcodeAlignment := cbBarcodeAlignment.ItemIndex;
    Check(Driver.Print2DBarcode);

    CutPaper;
  finally
    EnableButtons(True);
  end;
end;

procedure Tfm2DBarcode.btnOpenFileClick(Sender: TObject);
resourcestring
  SFileOpened = 'Файл открыт, длина %d байт';
begin
  if OpenDialog.Execute then
  begin
    FData := ReadFileData(OpenDialog.FileName);
    edtStatus.Text := Format(SFileOpened, [Length(FData)]);
  end;
end;

end.

