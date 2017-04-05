unit fmuWriteSerial;

interface

uses
  // VCL
  ComCtrls, Controls, StdCtrls, ExtCtrls, Classes, SysUtils,
  Buttons, Graphics,
  // This
  untPages, untUtil, untDriver;

type
  { TfmWriteSerial }

  TfmWriteSerial = class(TPage)
    gbSerialNumber: TGroupBox;
    edtSerialNumber: TEdit;
    gbLicense: TGroupBox;
    edtLicense: TEdit;
    btnSetSerialNumber: TBitBtn;
    btnReadLicense: TBitBtn;
    btnWriteLicense: TBitBtn;
    gbPointPosition: TGroupBox;
    btnSetPointPosition: TBitBtn;
    cbPointPosition: TComboBox;
    lblPointPosition: TLabel;
    grpServiceNumber: TGroupBox;
    lblSCPassword: TLabel;
    lblNewSCPassword: TLabel;
    Label2: TLabel;
    edtSCPassword: TEdit;
    edtNewSCPassword: TEdit;
    btnSetSCPassword: TBitBtn;
    procedure btnSetSerialNumberClick(Sender: TObject);
    procedure btnReadLicenseClick(Sender: TObject);
    procedure btnWriteLicenseClick(Sender: TObject);
    procedure btnSetPointPositionClick(Sender: TObject);
    procedure btnSetSCPasswordClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmWriteSerial }

procedure TfmWriteSerial.btnSetSerialNumberClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.SerialNumber := edtSerialNumber.Text;
    Driver.SetSerialNumber;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmWriteSerial.btnReadLicenseClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    if Driver.ReadLicense = 0 then
      edtLicense.Text := GetLicense(Driver.License)
    else
      edtLicense.Clear;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmWriteSerial.btnWriteLicenseClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.License := edtLicense.Text;
    Driver.WriteLicense;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmWriteSerial.btnSetPointPositionClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PointPosition := cbPointPosition.ItemIndex > 0;
    Driver.SetPointPosition;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmWriteSerial.btnSetSCPasswordClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.SCPassword := StrToInt(edtSCPassword.Text);
    Driver.NewSCPassword := StrToInt(edtNewSCPassword.Text);
    Driver.SetSCPassword;
  finally
    EnableButtons(True);
  end;
end;

end.
