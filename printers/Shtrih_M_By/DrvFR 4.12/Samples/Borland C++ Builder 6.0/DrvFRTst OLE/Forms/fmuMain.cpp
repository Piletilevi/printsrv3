

#include <vcl.h>
#pragma hdrstop

#include "fmuMain.h"

#pragma package(smart_init)
#pragma resource "*.dfm"
#include <comobj.hpp>

TfmMain *fmMain;

__fastcall TfmMain::TfmMain(TComponent* Owner)
        : TForm(Owner)
{
}

void __fastcall TfmMain::FormCreate(TObject *Sender)
{
   cbTax1->ItemIndex = 0;
   cbTax2->ItemIndex = 0;
   cbTax3->ItemIndex = 0;
   cbTax4->ItemIndex = 0;

   ECR = CreateOleObject("Addin.DrvFR");
}

void __fastcall TfmMain::UpdateResult()
{
  int ResultCode = ECR.OlePropertyGet("ResultCode");
  AnsiString ResultDescription = ECR.OlePropertyGet("ResultCodeDescription");
  edtResult->Text = Format("%d: %s", ARRAYOFCONST((ResultCode, ResultDescription)));
  edtOperator->Text = ECR.OlePropertyGet("OperatorNumber");
}

void __fastcall TfmMain::UpdateDriver()
{
  ECR.OlePropertySet("Password", StrToInt(edtPassword->Text));
  ECR.OlePropertySet("Price", StrToCurrency(edtPrice->Text));
  ECR.OlePropertySet("Quantity", double(StrToFloat(edtQuantity->Text)));
  ECR.OlePropertySet("Department", StrToInt(edtDepartment->Text));
  ECR.OlePropertySet("Tax1", cbTax1->ItemIndex);
  ECR.OlePropertySet("Tax2", cbTax2->ItemIndex);
  ECR.OlePropertySet("Tax3", cbTax3->ItemIndex);
  ECR.OlePropertySet("Tax4", cbTax4->ItemIndex);
  ECR.OlePropertySet("StringForPrinting", WideString(edString->Text));
}

void __fastcall TfmMain::btnShowPropertiesClick(TObject *Sender)
{
   ECR.OleFunction("ShowProperties");
}

void __fastcall TfmMain::btnConnectClick(TObject *Sender)
{
  ECR.OleFunction("Connect");
  UpdateResult();
}
void __fastcall TfmMain::btnDisconnectClick(TObject *Sender)
{
  ECR.OleFunction("Disconnect");
}

void __fastcall TfmMain::btnBeepClick(TObject *Sender)
{
  ECR.OlePropertySet("Password", StrToInt(edtPassword->Text));
  ECR.OleProcedure("Beep");
  UpdateResult();
}

tagCY TfmMain::StrToCurrency(AnsiString s)
{
        Variant v = StrToCurr(s);
        return v;
}

void __fastcall TfmMain::btnSaleClick(TObject *Sender)
{
  UpdateDriver();
  ECR.OleProcedure("Sale");
  UpdateResult();
}

void __fastcall TfmMain::btnReturnSaleClick(TObject *Sender)
{
  UpdateDriver();
  ECR.OleProcedure("ReturnSale");
  UpdateResult();
}


void __fastcall TfmMain::btnBuyClick(TObject *Sender)
{
  UpdateDriver();
  ECR.OleProcedure("Buy");
  UpdateResult();
}


void __fastcall TfmMain::btnReturnBuyClick(TObject *Sender)
{
  UpdateDriver();
  ECR.OleProcedure("ReturnBuy");
  UpdateResult();
}


void __fastcall TfmMain::btnStornoClick(TObject *Sender)
{
  UpdateDriver();
  ECR.OleProcedure("Storno");
  UpdateResult();
}


void __fastcall TfmMain::btnDiscountClick(TObject *Sender)
{
  UpdateDriver();
  ECR.OlePropertySet("Summ1", StrToCurrency(edtSumm->Text));
  ECR.OleProcedure("Discount");
  UpdateResult();
}


void __fastcall TfmMain::btnStornoDiscountClick(TObject *Sender)
{
  UpdateDriver();
  ECR.OlePropertySet("Summ1", StrToCurrency(edtSumm->Text));
  ECR.OleProcedure("StornoDiscount");
  UpdateResult();
}


void __fastcall TfmMain::btnChargeClick(TObject *Sender)
{
  UpdateDriver();
  ECR.OlePropertySet("Summ1", StrToCurrency(edtSumm->Text));
  ECR.OleProcedure("Charge");
  UpdateResult();
}

void __fastcall TfmMain::btnStornoChargeClick(TObject *Sender)
{
  UpdateDriver();
  ECR.OlePropertySet("Summ1", StrToCurrency(edtSumm->Text));
  ECR.OleProcedure("StornoCharge");
  UpdateResult();
}

void __fastcall TfmMain::btnCloseCheckClick(TObject *Sender)
{
  UpdateDriver();
  ECR.OlePropertySet("Summ1", StrToCurrency(edtSumm1->Text));
  ECR.OlePropertySet("Summ2", StrToCurrency(edtSumm2->Text));
  ECR.OlePropertySet("Summ3", StrToCurrency(edtSumm3->Text));
  ECR.OlePropertySet("Summ4", StrToCurrency(edtSumm4->Text));
  ECR.OleProcedure("CloseCheck");
  UpdateResult();
}

void __fastcall TfmMain::btnCancelCheckClick(TObject *Sender)
{
  UpdateDriver();
  ECR.OleProcedure("CancelCheck");
  UpdateResult();
}

void __fastcall TfmMain::btnPrintReportWithoutCleaningClick(TObject *Sender)
{
  ECR.OlePropertySet("Password", StrToInt(edtPassword->Text));
  ECR.OleProcedure("PrintReportWithoutCleaning");
  UpdateResult();
}

void __fastcall TfmMain::btnPrintReportWithCleaningClick(TObject *Sender)
{
  ECR.OlePropertySet("Password", StrToInt(edtPassword->Text));
  ECR.OleProcedure("PrintReportWithCleaning");
  UpdateResult();
}


void __fastcall TfmMain::btnCloseClick(TObject *Sender)
{
  Close();
}

