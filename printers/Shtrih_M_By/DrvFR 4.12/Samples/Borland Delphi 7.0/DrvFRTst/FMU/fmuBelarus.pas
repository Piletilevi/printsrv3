unit fmuBelarus;

interface

uses
  // VCL
  Windows, StdCtrls, Controls, Classes, SysUtils, ExtCtrls, Graphics,
  // This
  untPages, untUtil, untDriver, untTypes, Spin;

type
  { TfmBelarus }

  TfmBelarus = class(TPage)
    btnGetLongSerialNumberAndLongRNM: TButton;
    btnSetLongSerialNumber: TButton;
    btnFiscalizationWithLongRNM: TButton;
    edtDate: TEdit;
    edtSessionNumber: TEdit;
    edtFreeRegistration: TEdit;
    edtINN: TEdit;
    edtNewPasswordTI: TEdit;
    edtRNM: TEdit;
    edtSerialNumber: TEdit;
    lblSerialNumber: TLabel;
    lblRNM: TLabel;
    lblNewPasswordTI: TLabel;
    lblINN: TLabel;
    lblRegistrationNumber: TLabel;
    lblFreeRegistration: TLabel;
    lblSessionNumber: TLabel;
    lblDate: TLabel;
    btnFiscParams: TButton;
    seRegistrationNumber: TSpinEdit;
    procedure btnGetLongSerialNumberAndLongRNMClick(Sender: TObject);
    procedure btnSetLongSerialNumberClick(Sender: TObject);
    procedure btnFiscalizationWithLongRNMClick(Sender: TObject);
    procedure btnFiscParamsClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmBelarus }

procedure TfmBelarus.btnGetLongSerialNumberAndLongRNMClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    if Driver.GetLongSerialNumberAndLongRNM = 0 then
    begin
      edtRNM.Text := GetRNM(Driver.RNM);
      edtSerialNumber.Text := GetSerialNumber(Driver.SerialNumber);
    end else
    begin
      edtRNM.Clear;
      edtSerialNumber.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmBelarus.btnSetLongSerialNumberClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.SerialNumber := edtSerialNumber.Text;
    Driver.SetLongSerialNumber;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmBelarus.btnFiscalizationWithLongRNMClick(Sender: TObject);
begin
  if Driver.CapTaxPasswordLock then
  begin
    if MessageBox(Handle, PChar(SConfirmFiscalization), PChar(SAttention),
      MB_ICONEXCLAMATION or MB_YESNO or MB_DEFBUTTON2) <> ID_YES then Exit;
  end;

  EnableButtons(False);
  try
    CheckIntStr(edtNewPasswordTI.Text, SNewTaxPassword);
    Driver.NewPasswordTI := StrToInt(edtNewPasswordTI.Text);
    Driver.RNM := edtRNM.Text;
    Driver.INN := edtINN.Text;
    if Driver.FiscalizationWithLongRNM = 0 then
    begin
      seRegistrationNumber.Value := Driver.RegistrationNumber;
      edtFreeRegistration.Text := IntToStr(Driver.FreeRegistration);
      edtSessionNumber.Text := IntToStr(Driver.SessionNumber);
      edtDate.Text := DateToStr(Driver.Date);
    end
    else begin
      edtFreeRegistration.Clear;
      edtSessionNumber.Clear;
      edtDate.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmBelarus.btnFiscParamsClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.RegistrationNumber := seRegistrationNumber.Value;
    if Driver.GetFiscalizationParameters = 0 then
    begin
      edtNewPasswordTI.Text := IntToStr(Driver.NewPasswordTI);
      edtRNM.Text := GetRNM(Driver.RNM);
      edtINN.Text := GetINN(Driver.INN);
      edtSessionNumber.Text := IntToStr(Driver.SessionNumber);
      edtDate.Text := DateToStr(Driver.Date);
    end else
    begin
      edtDate.Clear;
      edtSessionNumber.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

end.
