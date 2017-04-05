unit fmuPrintOperations;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls,
  // This
  untPages, untDriver, Spin;

type
  { TfmPrintOperations }

  TfmPrintOperations = class(TPage)
    grpFeed: TGroupBox;
    lblStringQuantity: TLabel;
    btnFeedDocument: TButton;
    chbUseReceiptRibbon2: TCheckBox;
    chbUseJournalRibbon2: TCheckBox;
    btnContinuePrint: TButton;
    seStringQuantity: TSpinEdit;
    grpContinuePrint: TGroupBox;
    grpTechTest: TGroupBox;
    lblPeriod: TLabel;
    btnStartTechTest: TButton;
    btnStopTechTest: TButton;
    sePeriod: TSpinEdit;
    chkUseSlipDocument: TCheckBox;
    grpCutCheck: TGroupBox;
    lblCutType: TLabel;
    cbCutType: TComboBox;
    btnCutCheck: TButton;
    procedure btnFeedDocumentClick(Sender: TObject);
    procedure btnContinuePrintClick(Sender: TObject);
    procedure btnStartTechTestClick(Sender: TObject);
    procedure btnStopTechTestClick(Sender: TObject);
    procedure btnCutCheckClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmPrintOperations }


procedure TfmPrintOperations.btnFeedDocumentClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.UseReceiptRibbon := chbUseReceiptRibbon2.Checked;
    Driver.UseJournalRibbon := chbUseJournalRibbon2.Checked;
    Driver.UseSlipDocument := chkUseSlipDocument.Checked;
    Driver.StringQuantity := seStringQuantity.Value;
    Driver.FeedDocument;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintOperations.btnContinuePrintClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ContinuePrint;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintOperations.btnStartTechTestClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.RunningPeriod := sePeriod.Value;
    Driver.Test;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintOperations.btnStopTechTestClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.InterruptTest;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintOperations.btnCutCheckClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.CutType := cbCutType.ItemIndex = 1;
    Driver.CutCheck;
  finally
    EnableButtons(True);
  end;
end;

end.
