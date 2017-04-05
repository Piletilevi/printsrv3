unit fmuPrintHeader;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, Spin,
  // This
  untPages, untUtil, untDriver, DrvFRLib_TLB;

type
  { TfmPrintHeader }

  TfmPrintHeader = class(TPage)
    grpHeader: TGroupBox;
    lblDocumentName: TLabel;
    lblDocumentNumber: TLabel;
    lblOpenDocumentNumber: TLabel;
    edtDocumentName: TEdit;
    edtOpenDocumentNumber: TEdit;
    btnPrintDocumentTitle: TButton;
    grpClishe: TGroupBox;
    btnPrintCliche: TButton;
    btnPrintTrailer: TButton;
    btnFinishDocument: TBitBtn;
    chkFinishDocumentMode: TCheckBox;
    seDocumentNumber: TSpinEdit;
    btnPrintDocumentTitle2: TButton;
    procedure btnPrintTrailerClick(Sender: TObject);
    procedure btnFinishDocumentClick(Sender: TObject);
    procedure btnPrintClicheClick(Sender: TObject);
    procedure btnPrintDocumentTitleClick(Sender: TObject);
    procedure btnPrintDocumentTitle2Click(Sender: TObject);
  end;

var
  fmPrintHeader: TfmPrintHeader;

implementation

{$R *.DFM}

procedure TfmPrintHeader.btnPrintDocumentTitleClick(Sender: TObject);
var
  ResultCode: Integer;
begin
  EnableButtons(False);
  try
    Driver.DocumentNumber := seDocumentNumber.Value;
    Driver.DocumentName := edtDocumentName.Text;
    ResultCode := Driver.PrintDocumentTitle;

    if ResultCode = 0 then
      edtOpenDocumentNumber.Text := IntToStr(Driver.OpenDocumentNumber)
    else
      edtOpenDocumentNumber.Clear;
  finally
    EnableButtons(True);
  end;
end;
procedure TfmPrintHeader.btnPrintTrailerClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PrintTrailer;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintHeader.btnFinishDocumentClick(Sender: TObject);
const
  FinishDocumentModes: array [Boolean] of Integer =
    (fdmTrailerDisabled, fdmTrailerEnabled);
begin
  EnableButtons(False);
  try
    Driver.FinishDocumentMode := FinishDocumentModes[chkFinishDocumentMode.Checked];
    Driver.FinishDocument;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintHeader.btnPrintClicheClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PrintCliche;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintHeader.btnPrintDocumentTitle2Click(Sender: TObject);
var
  i: Integer;
begin
  EnableButtons(False);
  try
    Driver.DocumentNumber := 123;
    Driver.DocumentName := 'Doc';
    for i := 1 to 10 do
    begin
      if Driver.PrintDocumentTitle <> 0 then Break;
      if Driver.WaitForPrinting <> 0 then Break;
    end;
  finally
    EnableButtons(True);
  end;
end;

end.
