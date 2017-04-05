unit fmuWares;

interface

uses
    // VCL
  Windows, ComCtrls, StdCtrls, Controls, Classes, SysUtils, Forms, ExtCtrls,
  Graphics, Grids, Spin, 
  // This
  untPages, untUtil, untDriver;

type
  { TfmTotalizers }

  TfmWares = class(TPage)
    lblWareCode: TLabel;
    btnReadWare: TButton;
    btnUpdateWare: TButton;
    edtWareCode: TSpinEdit;
    btnDeleteWare: TButton;
    cbTax1: TComboBox;
    cbTax2: TComboBox;
    cbTax3: TComboBox;
    cbTax4: TComboBox;
    edtPrice: TEdit;
    edtDepartment: TSpinEdit;
    lblPrice: TLabel;
    lblDepartment: TLabel;
    lblTax1: TLabel;
    lblTax2: TLabel;
    lblTax3: TLabel;
    lblTax4: TLabel;
    edtStringForPrinting: TEdit;
    lblStringForPrinting: TLabel;
    memOut: TMemo;
    btnGetWareBaseCashRegs: TButton;
    procedure btnReadWareClick(Sender: TObject);
    procedure btnUpdateWareClick(Sender: TObject);
    procedure btnDeleteWareClick(Sender: TObject);
    procedure btnGetWareBaseCashRegsClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmTotalizers }

procedure TfmWares.btnReadWareClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.WareCode := edtWareCode.Value;
    if Driver.ReadWare <> 0 then Exit;
    edtDepartment.Value := Driver.Department;
    edtPrice.Text := Driver.AmountToStr(Driver.Price);
    edtStringForPrinting.Text :=  Driver.StringForPrinting;
    cbTax1.ItemIndex := Driver.Tax1;
    cbTax2.ItemIndex := Driver.Tax2;
    cbTax3.ItemIndex := Driver.Tax3;
    cbTax4.ItemIndex := Driver.Tax4;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmWares.btnUpdateWareClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.WareCode := edtWareCode.Value;
    Driver.Department := edtDepartment.Value;
    Driver.Price := StrToCurr(edtPrice.Text);
    Driver.StringForPrinting := edtStringForPrinting.Text;
    Driver.Tax1 := cbTax1.ItemIndex;
    Driver.Tax2 := cbTax2.ItemIndex;
    Driver.Tax3 := cbTax3.ItemIndex;
    Driver.Tax4 := cbTax4.ItemIndex;
    Driver.UpdateWare;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmWares.btnDeleteWareClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.WareCode := edtWareCode.Value;
    Driver.RemoveWare;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmWares.btnGetWareBaseCashRegsClick(Sender: TObject);
resourcestring
  SRegSaleRec = '–егистр продаж по данному товару в чеке';
  SRegBuyRec = '–егистр покупок по данному товару в чеке';
  SRegSaleReturnRec = '–егистр возврата продаж по данному товару в чеке';
  SRegBuyReturnRec = '–егистр возврата покупок по данному товару в чеке';
  SRegSaleSession = '–егистр продаж по данному товару за смену';
  SRegBuySession = '–егистр покупок по данному товару за смену';
  SRegSaleReturnSession = '–егистр возврата продаж по данному товару за смену';
  SRegBuyReturnSession = '–егистр возврата покупок по данному товару за смену';
  SGetWareBaseCashRegs = '«апрос денежных регистров по коду товара';

begin
  EnableButtons(False);
  try
    memOut.Lines.Clear;
    Driver.WareCode := edtWareCode.Value;
    if Driver.GetWareBaseCashRegs <> 0 then
      Exit;
    memOut.Lines.Add(Format('%s: %d', [SGetWareBaseCashRegs, Driver.WareCode]));
    memOut.Lines.Add('');
    memOut.Lines.Add(Format('%s: %.2f', [SRegSaleRec, Driver.RegSaleRec]));
    memOut.Lines.Add(Format('%s: %.2f', [SRegBuyRec, Driver.RegBuyRec]));
    memOut.Lines.Add(Format('%s: %.2f', [SRegSaleReturnRec, Driver.RegSaleReturnRec]));
    memOut.Lines.Add(Format('%s: %.2f', [SRegBuyReturnRec, Driver.RegBuyReturnRec]));
    memOut.Lines.Add(Format('%s: %.2f', [SRegSaleSession, Driver.RegSaleSession]));
    memOut.Lines.Add(Format('%s: %.2f', [SRegBuySession, Driver.RegBuySession]));
    memOut.Lines.Add(Format('%s: %.2f', [SRegSaleReturnSession, Driver.RegSaleReturnSession]));
    memOut.Lines.Add(Format('%s: %.2f', [SRegBuyReturnSession, Driver.RegBuyReturnSession]));
  finally
    EnableButtons(True);
  end;
end;

end.
