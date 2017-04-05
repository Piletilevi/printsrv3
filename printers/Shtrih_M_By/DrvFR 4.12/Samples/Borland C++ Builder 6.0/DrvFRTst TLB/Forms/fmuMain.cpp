

#include <vcl.h>
#pragma hdrstop

#include "fmuMain.h"

#pragma package(smart_init)
#pragma resource "*.dfm"
#include <oleauto.hpp>
// This
#include "DrvFRLib_TLB.h"

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

   ECR.CreateInstance(WideString("Addin.DrvFR"));
}

void __fastcall TfmMain::UpdateResult()
{
  int ResultCode = ECR->ResultCode;
  AnsiString ResultDescription = ECR->ResultCodeDescription;
  edtResult->Text = Format("%d: %s", ARRAYOFCONST((ResultCode, ResultDescription)));
  edtOperator->Text = ECR->OperatorNumber;
}

void __fastcall TfmMain::UpdateDriver()
{
  ECR->Password = StrToInt(edtPassword->Text);
  ECR->Price = StrToCurrency(edtPrice->Text);
  ECR->Quantity = StrToFloat(edtQuantity->Text);
  ECR->Department = StrToInt(edtDepartment->Text);
  ECR->Tax1 = cbTax1->ItemIndex;
  ECR->Tax2 = cbTax2->ItemIndex;
  ECR->Tax3 = cbTax3->ItemIndex;
  ECR->Tax4 = cbTax4->ItemIndex;
  ECR->set_StringForPrinting(WideString(edString->Text));
}

void __fastcall TfmMain::btnShowPropertiesClick(TObject *Sender)
{
   ECR->ShowProperties();
}

void __fastcall TfmMain::btnConnectClick(TObject *Sender)
{
  ECR->Connect();
  UpdateResult();
}
void __fastcall TfmMain::btnDisconnectClick(TObject *Sender)
{
  ECR->Disconnect();
}

void __fastcall TfmMain::btnBeepClick(TObject *Sender)
{
  ECR->Password = StrToInt(edtPassword->Text);
  ECR->Beep();
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
  ECR->Sale();
  UpdateResult();
}

void __fastcall TfmMain::btnReturnSaleClick(TObject *Sender)
{
  UpdateDriver();
  ECR->ReturnSale();
  UpdateResult();
}


void __fastcall TfmMain::btnBuyClick(TObject *Sender)
{
   UpdateDriver();
   ECR->Buy();
   UpdateResult();
}


void __fastcall TfmMain::btnReturnBuyClick(TObject *Sender)
{
   UpdateDriver();
   ECR->ReturnBuy();
   UpdateResult();
}


void __fastcall TfmMain::btnStornoClick(TObject *Sender)
{
   UpdateDriver();
   ECR->Storno();
   UpdateResult();
}


void __fastcall TfmMain::btnDiscountClick(TObject *Sender)
{
  UpdateDriver();
  ECR->Summ1 = StrToCurrency(edtSumm->Text);
  ECR->Discount();
  UpdateResult();
}


void __fastcall TfmMain::btnStornoDiscountClick(TObject *Sender)
{
  UpdateDriver();
  ECR->StornoDiscount();
  UpdateResult();
}


void __fastcall TfmMain::btnChargeClick(TObject *Sender)
{
  UpdateDriver();
  ECR->Summ1 = StrToCurrency(edtSumm->Text);
  ECR->Charge();
  UpdateResult();
}


void __fastcall TfmMain::btnStornoChargeClick(TObject *Sender)
{
  UpdateDriver();
  ECR->Summ1 = StrToCurrency(edtSumm->Text);
  ECR->StornoCharge();
  UpdateResult();
}


void __fastcall TfmMain::btnCloseCheckClick(TObject *Sender)
{
  UpdateDriver();
  ECR->Summ1 = StrToCurrency(edtSumm1->Text);
  ECR->Summ2 = StrToCurrency(edtSumm2->Text);
  ECR->Summ3 = StrToCurrency(edtSumm3->Text);
  ECR->Summ4 = StrToCurrency(edtSumm4->Text);
  ECR->CloseCheck();
  UpdateResult();
}

void __fastcall TfmMain::btnCancelCheckClick(TObject *Sender)
{
  UpdateDriver();
  ECR->CancelCheck();
  UpdateResult();
}

void __fastcall TfmMain::btnPrintReportWithoutCleaningClick(TObject *Sender)
{
  ECR->Password = StrToInt(edtPassword->Text);
  ECR->PrintReportWithoutCleaning();
  UpdateResult();
}

void __fastcall TfmMain::btnPrintReportWithCleaningClick(TObject *Sender)
{
  ECR->Password = StrToInt(edtPassword->Text);
  ECR->PrintReportWithCleaning();
  UpdateResult();
}


void __fastcall TfmMain::btnCloseClick(TObject *Sender)
{
  Close();
}

