unit fmuTestReceipt;

interface

uses
  // VCL
  StdCtrls, Controls, Classes, SysUtils, ExtCtrls, Buttons, Graphics,
  // This
  untPages, CompName, untUtil, untDriver, Spin, untTypes;

type
  { TfmTestReceipt }

  TfmTestReceipt = class(TPage)
    lblSaleCount: TLabel;
    seSaleCount: TSpinEdit;
    lblLineCount: TLabel;
    seLineCount: TSpinEdit;
    btnTestReceipt: TButton;
    procedure btnTestReceiptClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmTestReceipt }

procedure TfmTestReceipt.btnTestReceiptClick(Sender: TObject);
var
  i, j: Integer;
  SaleCount: Integer;
  LineCount: Integer;
begin
  EnableButtons(False);
  try
    Check(Driver.LockPort);
    Check(Driver.GetECRStatus);
    if Driver.ECRMode = 8 then
      Check(Driver.SysAdminCancelCheck);
    SaleCount := seSaleCount.Value;
    LineCount := seLineCount.Value;
    for i := 1 to SaleCount do
    begin
      // Sale
      Driver.Price := 0.01;
      Driver.Quantity := 0.001;
      Driver.Department := 1;
      Driver.Tax1 := 0;
      Driver.Tax2 := 0;
      Driver.Tax3 := 0;
      Driver.Tax4 := 0;
      Driver.StringforPrinting := Format('%s ¹ %d', [SSale, i]);
      Check(Driver.Sale);
       // Text
      Driver.UseJournalRibbon := False;
      Driver.UseReceiptRibbon := True;
      for j := 1 to LineCount do
      begin
        Driver.StringforPrinting := Format('%s ¹ %d, %s %d', [
          SSale, i, SLine, j]);
        Check(Driver.PrintString);
      end;
    end;
    // Close receipt
    Driver.Summ1 := 0.00;
    Driver.StringForPrinting := '';
    Check(Driver.CloseCheck);
  finally
    EnableButtons(True);
    Driver.UnlockPort;
  end;
end;

end.
