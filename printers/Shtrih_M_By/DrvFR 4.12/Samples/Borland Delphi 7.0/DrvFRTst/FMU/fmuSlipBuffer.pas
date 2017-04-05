unit fmuSlipBuffer;

interface

uses
  // VCL
  ExtCtrls, Classes, Controls, StdCtrls, Buttons, SysUtils, ComCtrls,
  Dialogs, Spin,
  // This
  untPages, untDriver;

type
  { TfmSlipClearBuffer }

  TfmSlipBuffer = class(TPage)
    btnClearSlipDocumentBuffer: TButton;
    btnFill: TButton;
    btnClearString: TButton;
    memTextForPrinting: TMemo;
    lblStringNumber: TLabel;
    edtStringForPrinting: TEdit;
    lblStringForPrinting: TLabel;
    lblText: TLabel;
    btnFillText: TButton;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    lblstrn: TLabel;
    lblStringCount: TLabel;
    btnOpen: TBitBtn;
    btnSave: TBitBtn;
    bvl1: TBevel;
    seStringNumber: TSpinEdit;
    procedure btnClearSlipDocumentBufferClick(Sender: TObject);
    procedure btnFillClick(Sender: TObject);
    procedure btnClearStringClick(Sender: TObject);
    procedure btnFillTextClick(Sender: TObject);
    procedure memTextForPrintingChange(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  public
    procedure UpdateObject; override;
  end;

implementation

{$R *.DFM}

{ TfmSlipClearBuffer }

procedure TfmSlipBuffer.UpdateObject;
begin
  if DriverExists then
  begin
    Driver.StringNumber := seStringNumber.Value;
    Driver.StringforPrinting := edtStringforPrinting.Text;
  end;
end;

procedure TfmSlipBuffer.btnClearSlipDocumentBufferClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Check(Driver.ClearSlipDocumentBuffer);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipBuffer.btnFillClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    UpdateObject;
    Check(Driver.FillSlipDocumentWithUnfiscalInfo);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipBuffer.btnClearStringClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    UpdateObject;
    Check(Driver.ClearSlipDocumentBufferString);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipBuffer.btnFillTextClick(Sender: TObject);
var
  i: Integer;
begin
  EnableButtons(False);
  try
  for i := 0 to memTextForPrinting.Lines.Count - 1 do
  begin
    Driver.StringNumber := i + 1;
    Driver.StringForPrinting := memTextForPrinting.Lines.Strings[i];
    Check(Driver.FillSlipDocumentWithUnfiscalInfo);
  end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipBuffer.memTextForPrintingChange(Sender: TObject);
begin
  lblStringCount.Caption := IntToStr(memTextForPrinting.Lines.Count);
end;

procedure TfmSlipBuffer.btnOpenClick(Sender: TObject);
begin
  if dlgOpen.Execute then
    memTextForPrinting.Lines.LoadFromFile(dlgOpen.FileName);
end;

procedure TfmSlipBuffer.btnSaveClick(Sender: TObject);
begin
  if dlgSave.Execute then
    memTextForPrinting.Lines.SaveToFile(dlgSave.FileName);
end;

end.
