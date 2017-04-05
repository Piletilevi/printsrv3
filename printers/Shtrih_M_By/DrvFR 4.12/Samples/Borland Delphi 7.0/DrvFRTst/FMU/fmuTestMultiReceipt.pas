unit fmuTestMultiReceipt;

interface

uses
  // VCL
  StdCtrls, Controls, Classes, SysUtils, ExtCtrls, Buttons, Graphics, Forms,
  // This
  untPages, CompName, untUtil, untDriver, Spin, untTypes;

type
  { TfmTestMultiReceipt }

  TfmTestMultiReceipt = class(TPage)
    btnStart: TButton;
    cbReceiptType: TComboBox;
    lblReceiptType: TLabel;
    chkRandomReceiptType: TCheckBox;
    seDepartment: TSpinEdit;
    chkRandomDepartment: TCheckBox;
    lblDepartment: TLabel;
    edtQuantity: TEdit;
    chkRandomQuantity: TCheckBox;
    lblQuantity: TLabel;
    edtPrice: TEdit;
    lblPrice: TLabel;
    chkRandomPrice: TCheckBox;
    lblOperationCount: TLabel;
    seOperationCount: TSpinEdit;
    chkRandomOperationCount: TCheckBox;
    btnStop: TButton;
    edtDiscount: TEdit;
    chkRandomDiscount: TCheckBox;
    edtCharge: TEdit;
    chkRandomCharge: TCheckBox;
    chkDiscount: TCheckBox;
    chkCharge: TCheckBox;
    seReceiptCount: TSpinEdit;
    lblReceiptCount: TLabel;
    chkCloseSession: TCheckBox;
    seSessionCount: TSpinEdit;
    lblSessionCount: TLabel;
    chkInfSessionCount: TCheckBox;
    chkRandomReceiptCount: TCheckBox;
    procedure btnStartClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure OnUpdatePage(Sender: TObject);
  private
    FStopFlag: Boolean;
    function GetReceiptType: Integer;
    function GetDepartment: Integer;
    function GetQuantity: Double;
    function GetPrice: Currency;
    function GetOperationCount: Integer;
    function GetReceiptCount: Integer;
    function GetSessionCount: Integer;
    function Operation(Number: Integer; ReceiptType: Integer): Currency;
    procedure Receipt(Number: Integer; ReceiptType: Integer);
    procedure Session(Number: Integer);
    function Discount(MaxSumm: Currency): Currency;
    function Charge(MaxSumm: Currency): Currency;
    function GetDiscountSumm(MaxSumm: Currency): Currency;
    function GetChargeSumm(MaxSumm: Currency): Currency;
  end;

implementation

const
  MaxOperationCount = 20;
  MaxReceiptCount = 100;
  MaxPrice = 1000;
  MaxQuantity = 10;
  ChargeProb = 3;
  DiscountProb = 3;

{$R *.DFM}

{ TfmTestMultiReceipt }

procedure TfmTestMultiReceipt.btnStartClick(Sender: TObject);
var
  i: Integer;
begin
  EnableButtons(False);
  btnStop.Enabled := True;
  try
    Check(Driver.LockPort);
    Check(Driver.GetECRStatus);
    if Driver.ECRMode = 8 then
      Check(Driver.SysAdminCancelCheck);
    Check(Driver.WaitForPrinting);
    Randomize;
    FStopFlag := False;
    i := 1;
    while True do
    begin
      if FStopFlag then Abort;
      if (GetSessionCount >= 0) and (i > GetSessionCount) then Break;
      Session(i);
      Inc(i);
    end;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
    Driver.UnlockPort;
  end;
end;

procedure TfmTestMultiReceipt.OnUpdatePage(Sender: TObject);
begin
  cbReceiptType.Enabled := not chkRandomReceiptType.Checked;
  seDepartment.Enabled := not chkRandomDepartment.Checked;
  edtQuantity.Enabled := not chkRandomQuantity.Checked;
  edtPrice.Enabled := not chkRandomPrice.Checked;
  edtDiscount.Enabled := (not chkRandomDiscount.Checked) and (chkDiscount.Checked);
  edtCharge.Enabled := (not chkRandomCharge.Checked) and (chkCharge.Checked);
  seOperationCount.Enabled := not chkRandomOperationCount.Checked;
  seReceiptCount.Enabled := not chkRandomReceiptCount.Checked;
  chkRandomDiscount.Enabled := chkDiscount.Checked;
  chkRandomCharge.Enabled := chkCharge.Checked;
  seSessionCount.Enabled := (not chkInfSessionCount.Checked) and (chkCloseSession.Checked);
  chkInfSessionCount.Enabled := chkCloseSession.Checked;
end;

procedure TfmTestMultiReceipt.FormShow(Sender: TObject);
begin
  OnUpdatePage(Self);
end;

function TfmTestMultiReceipt.GetReceiptType: Integer;
begin
  if chkRandomReceiptType.Checked then
    Result := Random(4)
  else
    Result := cbReceiptType.ItemIndex;
end;

function TfmTestMultiReceipt.GetDepartment: Integer;
begin
  if chkRandomDepartment.Checked then
    Result := Random(17)
  else
    Result := seDepartment.Value;
end;

function TfmTestMultiReceipt.GetOperationCount: Integer;
begin
  if chkRandomOperationCount.Checked then
    Result := Random(MaxOperationCount) + 1
  else
    Result := seOperationCount.Value;
end;

function TfmTestMultiReceipt.GetQuantity: Double;
begin
  if chkRandomQuantity.Checked then
    Result := (Random * MaxQuantity) + 1
  else
    Result := StrToFloat(edtQuantity.Text);
end;

function TfmTestMultiReceipt.GetReceiptCount: Integer;
begin
  if chkRandomReceiptCount.Checked then
    Result := Random(MaxReceiptCount) + 1
  else
    Result := seReceiptCount.Value;
end;

function TfmTestMultiReceipt.GetSessionCount: Integer;
begin
  if not chkCloseSession.Checked then
  begin
    Result := 1;
    Exit;
  end;
  if chkInfSessionCount.Checked then
    Result := -1
  else
    Result := seSessionCount.Value;
end;

function TfmTestMultiReceipt.GetPrice: Currency;
begin
  if chkRandomPrice.Checked then
    Result := (MaxPrice * Random) + 1
  else
    Result := StrToCurr(edtPrice.Text);
end;

function TfmTestMultiReceipt.Operation(Number: Integer; ReceiptType: Integer): Currency;
var
 P: Currency;
 Q: Double;
begin
  P := GetPrice;
  Q := GetQuantity;
  Driver.Price := P;
  Driver.Quantity := Q;
  Result := P * Q;
  Driver.Department := GetDepartment;
  Driver.Tax1 := 0;
  Driver.Tax2 := 0;
  Driver.Tax3 := 0;
  Driver.Tax4 := 0;
  case ReceiptType of
    0: begin
         Driver.StringforPrinting := Format('%s ¹ %d', [SSale, Number]);
         Check(Driver.Sale);
       end;
    1: begin
         Driver.StringforPrinting := Format('%s ¹ %d', [SBuy, Number]);
         Check(Driver.Buy);
       end;
    2: begin
         Driver.StringforPrinting := Format('%s ¹ %d', [SRetSale, Number]);
         Check(Driver.ReturnSale);
       end;
    3: begin
         Driver.StringforPrinting := Format('%s ¹ %d', [SRetBuy, Number]);
         Check(Driver.ReturnBuy);
       end;
  end;
  Check(Driver.WaitForPrinting);
  Application.ProcessMessages;
end;

procedure TfmTestMultiReceipt.Receipt(Number, ReceiptType: Integer);
var
  i: Integer;
  k: Integer;
  RecType: Integer;
begin
  Driver.CheckType := ReceiptType;
  Check(Driver.OpenCheck);
  k := GetOperationCount;
  RecType := ReceiptType;
  for i := 1 to k do
  begin
    if FStopFlag then Abort;
    Operation(i, RecType);
    if chkDiscount.Checked then
    begin
      Check(Driver.CheckSubTotal);
      Discount(Driver.Summ1);
    end;
    if chkCharge.Checked then
    begin
      Check(Driver.CheckSubTotal);
      Charge(Driver.Summ1);
    end;
  end;
  Driver.StringForPrinting := Format('%s #%d', [SReceipt, Number]);
  Check(Driver.CheckSubTotal);
  Driver.Summ2 := 0;
  Driver.Summ3 := 0;
  Driver.Summ4 := 0;
  Check(Driver.CloseCheck);
  Check(Driver.WaitForPrinting);
end;

procedure TfmTestMultiReceipt.btnStopClick(Sender: TObject);
begin
  FStopFlag := True;
end;

procedure TfmTestMultiReceipt.Session(Number: Integer);
var
  i: Integer;
  k: Integer;
begin
  if FStopFlag then Abort;
  k := GetReceiptCount;
  for i := 1 to k do
  begin
    Receipt(i, GetReceiptType);
  end;
  if chkCloseSession.Checked then
    Check(Driver.PrintReportWithCleaning);
  Check(Driver.WaitForPrinting);
end;

function TfmTestMultiReceipt.Charge(MaxSumm: Currency): Currency;
begin
  Result := 0;
  if (chkRandomCharge.Checked) and (Random(ChargeProb) <> 1) then
    Exit;
  Result := GetChargeSumm(MaxSumm);
  Driver.Tax1 := 0;
  Driver.Tax2 := 0;
  Driver.Tax3 := 0;
  Driver.Tax4 := 0;
  Driver.Summ1 := Result;
  Driver.StringForPrinting := '';
  Check(Driver.Charge);
end;

function TfmTestMultiReceipt.Discount(MaxSumm: Currency): Currency;
begin
  Result := 0;
  if (chkRandomDiscount.Checked) and (Random(DiscountProb) <> 1) then
    Exit;
  Result := GetDiscountSumm(MaxSumm);
  Driver.Tax1 := 0;
  Driver.Tax2 := 0;
  Driver.Tax3 := 0;
  Driver.Tax4 := 0;
  Driver.Summ1 := Result;
  Driver.StringForPrinting := '';
  Check(Driver.Discount);
end;

function TfmTestMultiReceipt.GetChargeSumm(MaxSumm: Currency): Currency;
begin
  if chkRandomCharge.Checked then
    Result := Random * MaxSumm
  else
    Result := StrToCurr(edtCharge.Text);
end;

function TfmTestMultiReceipt.GetDiscountSumm(MaxSumm: Currency): Currency;
begin
  if chkRandomDiscount.Checked then
    Result := Random * MaxSumm
  else
    Result := StrToCurr(edtDiscount.Text);
end;

end.
