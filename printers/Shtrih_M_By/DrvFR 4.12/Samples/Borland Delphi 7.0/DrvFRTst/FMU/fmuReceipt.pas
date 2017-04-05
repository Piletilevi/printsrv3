unit fmuReceipt;

interface

uses
  // VCL
  Windows, Messages, ComCtrls, StdCtrls, Controls, Classes, SysUtils,
  ExtCtrls, Graphics, Spin,
  // This
  untPages, untUtil, untDriver, untTypes, DrvFRLib_TLB;

type
  { TfmReceipt }

  TfmReceipt = class(TPage)
    btnSale: TButton;
    btnReturnSale: TButton;
    btnReturnBuy: TButton;
    btnBuy: TButton;
    btnStorno: TButton;
    btnCheckSubTotal: TButton;
    btnCashOutCome: TButton;
    btnCashInCome: TButton;
    btnCharge: TButton;
    btnStornoCharge: TButton;
    btnStornoDiscount: TButton;
    btnDiscount: TButton;
    btnOpenCheck: TButton;
    btnCloseCheck: TButton;
    btnRepeatDocument: TButton;
    btnSysAdminCancelCheck: TButton;
    btnCancelCheck: TButton;
    edtStringForPrint: TEdit;
    lblStringForPrint: TLabel;
    edtChange: TEdit;
    edtCheckSubTotal: TEdit;
    edtDiscountOnCheck: TEdit;
    cbTax4: TComboBox;
    cbTax3: TComboBox;
    cbTax2: TComboBox;
    cbTax1: TComboBox;
    edtSumm4: TEdit;
    edtSumm3: TEdit;
    edtSumm2: TEdit;
    lblSumm1: TLabel;
    lblSumm2: TLabel;
    lblSumm3: TLabel;
    lblSumm4: TLabel;
    lblTax1: TLabel;
    lblTax2: TLabel;
    lblTax3: TLabel;
    lblTax4: TLabel;
    lblDiscountOnCheck: TLabel;
    lblCheckSubTotal: TLabel;
    lblChange: TLabel;
    cbCheckType: TComboBox;
    lblCheckType: TLabel;
    lblDepartment: TLabel;
    edtQuantity: TEdit;
    lblQuantity: TLabel;
    lblPrice: TLabel;
    edtPrice: TEdit;
    edtName: TEdit;
    Label50: TLabel;
    Label1: TLabel;
    cbNumber: TComboBox;
    lblNumber: TLabel;
    btnSaleEx: TButton;
    seDepartment: TSpinEdit;
    btnBeep: TButton;
    edtSumm1: TEdit;
    btnCloseCheckKPK: TButton;
    lblKPKStr: TLabel;
    edtKPKStr: TEdit;
    lblExciseCode: TLabel;
    btnExciseOperation: TButton;
    edtBarcode: TEdit;
    lblBarcodeText: TLabel;
    lblOperationType: TLabel;
    cbOperationType: TComboBox;
    cbUseWareCode: TCheckBox;
    lblWareCode: TLabel;
    edtWareCode: TSpinEdit;
    seExciseCode: TSpinEdit;
    seNumber: TSpinEdit;
    procedure btnSaleClick(Sender: TObject);
    procedure btnBuyClick(Sender: TObject);
    procedure btnStornoClick(Sender: TObject);
    procedure btnReturnSaleClick(Sender: TObject);
    procedure btnReturnBuyClick(Sender: TObject);
    procedure btnCheckSubTotalClick(Sender: TObject);
    procedure btnCashInComeClick(Sender: TObject);
    procedure btnCashOutComeClick(Sender: TObject);
    procedure btnChargeClick(Sender: TObject);
    procedure btnStornoChargeClick(Sender: TObject);
    procedure btnDiscountClick(Sender: TObject);
    procedure btnStornoDiscountClick(Sender: TObject);
    procedure btnOpenCheckClick(Sender: TObject);
    procedure btnCloseCheckClick(Sender: TObject);
    procedure btnSysAdminCancelCheckClick(Sender: TObject);
    procedure btnRepeatDocumentClick(Sender: TObject);
    procedure btnCancelCheckClick(Sender: TObject);
    procedure cbNumberChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSaleExClick(Sender: TObject);
    procedure btnBeepClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnCloseCheckKPKClick(Sender: TObject);
    procedure btnExciseOperationClick(Sender: TObject);
    procedure cbCheckTypeDropDown(Sender: TObject);
  private
    procedure SetParams;
    procedure FillCheckTypes;
    procedure FillOperationTypes;
    function GetPrintWidth: Integer;
  public
    procedure UpdatePage; override;
  end;

implementation

{$R *.DFM}

procedure SetComboDropDownWidth(ComboBox: TComboBox);
var
  i: Integer;
  Canvas: TCanvas;
  MaxLength: Integer;
begin
  MaxLength := 0;
  Canvas := TCanvas.Create;
  try
    Canvas.Handle := GetDC(ComboBox.Handle);
    for i := 0 to ComboBox.Items.Count - 1 do
    begin
      if Canvas.TextWidth(ComboBox.Items[i]) > MaxLength then
        MaxLength := Canvas.TextWidth(ComboBox.Items[i]);
    end;
    SendMessage(ComboBox.Handle, CB_SETDROPPEDWIDTH, MaxLength + 10, 0);
  finally
    Canvas.Free;
  end;
end;


{ TfmReceipt }

function TfmReceipt.GetPrintWidth: Integer;
begin
  case Driver.UModel of
     0: Result := 36;   // SHTRIH-FR-F
     1: Result := 36;   // SHTRIH-FR-F (Kazakhstan)
     2: Result := 24;   // ELVES-MINI-FR-F
     3: Result := 20;   // FELIX-R-F
     4: Result := 36;   // SHTRIH-FR-K
     5: Result := 40;   // SHTRIH-950K
     6: Result := 32;   // ELVES-FR-K
     7: Result := 50;   // SHTRIH-MINI-FR-K
     8: Result := 36;   // SHTRIH-FR-F (Belorussia)
     9: Result := 48;   // SHTRIH-COMBO-FR-K, release 1
    10: Result := 40;   // Fiscal unit SHTRIH-POS-F
    11: Result := 40;   // SHTRIH-950K, release 2
    12: Result := 40; 	// SHTRIH-COMBO-FR-K, release 2
    14: Result := 50; 	// SHTRIH-MINI-FR-K 2
  else
    Result := 40;
  end;
end;

procedure TfmReceipt.SetParams;
var
  W: Integer;
  S: WideString;
begin
  CheckIntStr(edtSumm1.Text, SSumm1);
  CheckIntStr(edtPrice.Text, SPrice);
  CheckIntStr(edtQuantity.Text, SQuantity);

  Driver.Summ1 := StrToCurr(edtSumm1.text);
  Driver.Price := StrToCurr(edtPrice.text);
  Driver.Quantity := StrToFloat(edtQuantity.Text);
  Driver.Department := seDepartment.Value;
  Driver.Tax1 := cbTax1.ItemIndex;
  Driver.Tax2 := cbTax2.ItemIndex;
  Driver.Tax3 := cbTax3.ItemIndex;
  Driver.Tax4 := cbTax4.ItemIndex;
  Driver.UseWareCode := cbUseWareCode.Checked;
  Driver.WareCode := edtWareCode.Value;

  Driver.Connect;
  W := GetPrintWidth;
  case cbNumber.ItemIndex of
    0: S := edtName.Text;
    1: S := Format('%-*.*s%-4s%3d',[W-8, W-9, edtName.Text, SPump,
      seNumber.Value]);
    2: S := Format('%-*.*s%-5s%4d',[W-9, W-10, edtName.Text, STicket,
      seNumber.Value]);
  end;
  Driver.StringforPrinting := S;
end;

procedure TfmReceipt.btnSaleClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    UpdateObject;
    SetParams;
    Driver.Sale;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnBuyClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    SetParams;
    Driver.Buy;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnStornoClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    SetParams;
    Driver.Storno;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnReturnSaleClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    SetParams;
    Driver.ReturnSale;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnReturnBuyClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    SetParams;
    Driver.ReturnBuy;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnCheckSubTotalClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    if Driver.CheckSubTotal = 0 then
      edtCheckSubTotal.Text := Driver.AmountToStr(Driver.Summ1)
    else
      edtCheckSubTotal.Clear;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnCashInComeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    CheckIntStr(edtSumm1.Text, SSumm1);
    Driver.Summ1 := StrToCurr(edtSumm1.Text);
    Driver.CashInCome;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnCashOutComeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    CheckIntStr(edtSumm1.Text, SSumm1);
    Driver.Summ1 := StrToCurr(edtSumm1.text);
    Driver.CashOutCome;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnChargeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    SetParams;
    Driver.Charge;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnStornoChargeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    SetParams;
    Driver.StornoCharge;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnDiscountClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    SetParams;
    Driver.Discount;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnStornoDiscountClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    SetParams;
    Driver.StornoDiscount;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnOpenCheckClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.CheckType := Integer(cbCheckType.Items.Objects[cbCheckType.ItemIndex]);
    Driver.OpenCheck;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnCloseCheckClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    CheckIntStr(edtSumm1.Text, SSumm1);
    CheckIntStr(edtSumm2.Text, SSumm2);
    CheckIntStr(edtSumm3.Text, SSumm3);
    CheckIntStr(edtSumm4.Text, SSumm4);
    CheckIntStr(edtDiscountOnCheck.Text, SDiscount);

    Driver.Summ1 := StrToCurr(edtSumm1.Text);
    Driver.Summ2 := StrToCurr(edtSumm2.Text);
    Driver.Summ3 := StrToCurr(edtSumm3.Text);
    Driver.Summ4 := StrToCurr(edtSumm4.Text);
    Driver.Tax1 := cbTax1.ItemIndex;
    Driver.Tax2 := cbTax2.ItemIndex;
    Driver.Tax3 := cbTax3.ItemIndex;
    Driver.Tax4 := cbTax4.ItemIndex;
    Driver.DiscountOnCheck := StrToFloat(edtDiscountOnCheck.Text);
    Driver.StringforPrinting := edtStringForPrint.Text;
    if Driver.CloseCheck <> 0 then
      edtChange.Clear
    else
      edtChange.Text := Driver.AmountToStr(Driver.Change);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnSysAdminCancelCheckClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.SysAdminCancelCheck;
    Driver.OperationBlockFirstString := 0;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnRepeatDocumentClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.RepeatDocument;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnCancelCheckClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.CancelCheck;
    Driver.OperationBlockFirstString := 0;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.cbNumberChange(Sender: TObject);
begin
  if cbNumber.ItemIndex = 0 then
  begin
    seNumber.Enabled := False;
    seNumber.Color := clBtnFace;
  end else
  begin
    seNumber.Enabled := True;
    seNumber.Color := clWindow;
  end;
end;

procedure TfmReceipt.FormCreate(Sender: TObject);
begin
  FillCheckTypes;
  FillOperationTypes;
  cbNumber.ItemIndex := 0;
  cbNumberChange(Self);
end;

procedure TfmReceipt.btnSaleExClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    SetParams;
    Driver.SaleEx;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnBeepClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.Beep;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.FormResize(Sender: TObject);
var
  W: Integer;
begin
  W := btnSale.Left - edtSumm1.Left - 7;
  edtSumm1.Width := W;
  edtSumm2.Width := W;
  edtSumm3.Width := W;
  edtSumm4.Width := W;
  edtCheckSubTotal.Width := W;
  edtChange.Width := W;
  edtDiscountOnCheck.Width := btnSale.Left - edtDiscountOnCheck.Left - 7;
  edtKPKStr.Width := W;
  seExciseCode.Width := btnSale.Left - seExciseCode.Left - 7;
end;

procedure TfmReceipt.btnCloseCheckKPKClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    CheckIntStr(edtSumm1.Text, SSumm1);
    CheckIntStr(edtSumm2.Text, SSumm2);
    CheckIntStr(edtSumm3.Text, SSumm3);
    CheckIntStr(edtSumm4.Text, SSumm4);
    CheckIntStr(edtDiscountOnCheck.Text, SDiscount);

    Driver.Summ1 := StrToCurr(edtSumm1.Text);
    Driver.Summ2 := StrToCurr(edtSumm2.Text);
    Driver.Summ3 := StrToCurr(edtSumm3.Text);
    Driver.Summ4 := StrToCurr(edtSumm4.Text);
    Driver.Tax1 := cbTax1.ItemIndex;
    Driver.Tax2 := cbTax2.ItemIndex;
    Driver.Tax3 := cbTax3.ItemIndex;
    Driver.Tax4 := cbTax4.ItemIndex;
    Driver.DiscountOnCheck := StrToFloat(edtDiscountOnCheck.Text);
    Driver.StringforPrinting := edtStringForPrint.Text;
    if Driver.CloseCheckWithKPK <> 0 then
    begin
      edtChange.Clear;
      edtKPKStr.Clear;
    end
    else
    begin
      edtChange.Text := Driver.AmountToStr(Driver.Change);
      edtKPKStr.Text := Driver.KPKStr;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.btnExciseOperationClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    CheckIntStr(edtPrice.Text, SPrice);
    Driver.OperationType := Integer(cbOperationType.Items.Objects[cbOperationType.ItemIndex]);
    Driver.ExciseCode := seExciseCode.Value;
    Driver.Department := seDepartment.Value;
    Driver.Price := StrToCurr(edtPrice.text);
    Driver.Tax1 := cbTax1.ItemIndex;
    Driver.Tax2 := cbTax2.ItemIndex;
    Driver.Tax3 := cbTax3.ItemIndex;
    Driver.Tax4 := cbTax4.ItemIndex;
    Driver.StringForPrinting := edtStringForPrint.Text;
    Driver.BarCode := edtBarcode.Text;
    Driver.ExcisableOperation;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReceipt.FillCheckTypes;
begin
  cbCheckType.Clear;
  cbCheckType.AddItem(SSale, TObject($00));
  cbCheckType.AddItem(SBuy, TObject($01));
  cbCheckType.AddItem(SRetSale, TObject($02));
  cbCheckType.AddItem(SRetBuy, TObject($03));
end;

procedure TfmReceipt.FillOperationTypes;
begin
  cbOperationType.Clear;
  cbOperationType.AddItem(SSale, TObject($00));
  cbOperationType.AddItem(SBuy, TObject($01));
  cbOperationType.AddItem(SRetSale, TObject($02));
  cbOperationType.AddItem(SRetBuy, TObject($03));
  cbOperationType.AddItem(SSaleStorno, TObject($10));
  cbOperationType.AddItem(SBuyStorno, TObject($11));
  cbOperationType.AddItem(SRetSaleStorno, TObject($12));
  cbOperationType.AddItem(SRetBuyStorno, TObject($13));
end;

procedure TfmReceipt.cbCheckTypeDropDown(Sender: TObject);
begin
  SetComboDropDownWidth(cbCheckType);
end;

procedure TfmReceipt.UpdatePage;
resourcestring
  SStorno = 'Сторно';
  SCancelCheck = 'Аннулировать';
  SStornoCharge = 'Сторно надбавки';
  SStornoDiscount = 'Сторно скидки';

  SBelStorno = 'Коррекция';
  SBelCancelCheck = 'Отменить чек';
  SBelStornoCharge = 'Коррекция надбавки';
  SBelStornoDiscount = 'Коррекция скидки';
var
  ModelID: Integer;
begin
  inherited UpdatePage;

  if DriverExists then
  begin
    Driver.ModelParamNumber := mpID;
    if Driver.ReadModelParamValue = 0 then
    begin
      ModelID := StrToInt(Driver.ModelParamValue);
      if ModelID = 3 then
      begin
        btnStorno.Caption := SBelStorno;
        btnStornoCharge.Caption := SBelStornoCharge;
        btnStornoDiscount.Caption := SBelStornoDiscount;
        btnCancelCheck.Caption := SBelCancelCheck;
      end else
      begin
        btnStorno.Caption := SStorno;
        btnStornoCharge.Caption := SStornoCharge;
        btnStornoDiscount.Caption := SStornoDiscount;
        btnCancelCheck.Caption := SCancelCheck;
      end;
    end;
  end;
end;

end.
