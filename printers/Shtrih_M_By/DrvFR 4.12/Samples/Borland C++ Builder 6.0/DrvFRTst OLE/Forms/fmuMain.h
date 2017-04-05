//---------------------------------------------------------------------------

#ifndef fmuMainH
#define fmuMainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>

//---------------------------------------------------------------------------
class TfmMain : public TForm
{
__published:	// IDE-managed Components
        TButton *btnShowProperties;
        TButton *btnConnect;
        TButton *btnDisconnect;
        TLabel *lblResult;
        TEdit *edtResult;
        TButton *btnBeep;
        TButton *btnSale;
        TButton *btnBuy;
        TButton *btnReturnSale;
        TButton *btnReturnBuy;
        TButton *btnStorno;
        TButton *btnCloseCheck;
        TButton *btnPrintReportWithCleaning;
        TButton *btnPrintReportWithoutCleaning;
        TButton *btnDiscount;
        TButton *btnStornoDiscount;
        TButton *btnCharge;
        TButton *btnStornoCharge;
        TButton *btnCancelCheck;
        TGroupBox *gbParams;
        TLabel *lblPrice;
        TLabel *lblQuantity;
        TLabel *lblDepartment;
        TLabel *lblTax1;
        TLabel *lblTax2;
        TLabel *lblTax3;
        TLabel *lblTax4;
        TLabel *Label10;
        TLabel *lblOperator;
        TLabel *lblSum1;
        TLabel *lblSumm2;
        TLabel *lblSumm3;
        TLabel *lblSumm4;
        TLabel *lblDiscount;
        TLabel *lblChange;
        TEdit *edtPrice;
        TEdit *edtQuantity;
        TEdit *edtDepartment;
        TComboBox *cbTax1;
        TComboBox *cbTax2;
        TComboBox *cbTax3;
        TComboBox *cbTax4;
        TEdit *edString;
        TEdit *edtOperator;
        TEdit *edtSumm1;
        TEdit *edtSumm2;
        TEdit *edtSumm3;
        TEdit *edtSumm4;
        TEdit *edtSumm;
        TEdit *edtChange;
        TLabel *lblPassword;
        TEdit *edtPassword;
        TButton *btnClose;
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall btnShowPropertiesClick(TObject *Sender);
        void __fastcall btnConnectClick(TObject *Sender);
        void __fastcall btnDisconnectClick(TObject *Sender);
        void __fastcall btnBeepClick(TObject *Sender);
        void __fastcall btnSaleClick(TObject *Sender);
        void __fastcall btnReturnSaleClick(TObject *Sender);
        void __fastcall btnBuyClick(TObject *Sender);
        void __fastcall btnReturnBuyClick(TObject *Sender);
        void __fastcall btnStornoClick(TObject *Sender);
        void __fastcall btnDiscountClick(TObject *Sender);
        void __fastcall btnStornoDiscountClick(TObject *Sender);
        void __fastcall btnChargeClick(TObject *Sender);
        void __fastcall btnStornoChargeClick(TObject *Sender);
        void __fastcall btnCloseCheckClick(TObject *Sender);
        void __fastcall btnCancelCheckClick(TObject *Sender);
        void __fastcall btnPrintReportWithoutCleaningClick(
          TObject *Sender);
        void __fastcall btnPrintReportWithCleaningClick(TObject *Sender);
        void __fastcall btnCloseClick(TObject *Sender);
private:
        Variant ECR;
        void __fastcall UpdateDriver();
        void __fastcall UpdateResult();
        tagCY StrToCurrency(AnsiString s);
public:
        __fastcall TfmMain(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfmMain *fmMain;
//---------------------------------------------------------------------------
#endif
