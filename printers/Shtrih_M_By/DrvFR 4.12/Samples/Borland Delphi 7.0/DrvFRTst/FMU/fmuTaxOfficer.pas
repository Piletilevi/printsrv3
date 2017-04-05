unit fmuTaxOfficer;

interface

uses
  // VCL
  Windows, ComCtrls, Controls, StdCtrls, ExtCtrls, Classes, SysUtils,
  Graphics, Dialogs,
  // This
  untPages, untUtil, untDriver, untTypes, Spin;

type
  { TfmTaxOfficer }

  TfmTaxOfficer = class(TPage)
    btnFiscalization: TButton;
    btnGetFiscalizationParameters: TButton;
    btnGetRangeDatesAndSessions: TButton;
    btnFiscalReportforDatesRange: TButton;
    btnFiscalReportforSessionRange: TButton;
    btnInterruptFullReport: TButton;
    edtNewPasswordTI: TEdit;
    edtRNM: TEdit;
    edtINN: TEdit;
    edtFreeRegistration: TEdit;
    edtSessionNumber: TEdit;
    edtDate: TEdit;
    dtpFirstSessionDate: TDateTimePicker;
    dtpLastSessionDate: TDateTimePicker;
    lblLastSessionNumber: TLabel;
    lblFirstSessionNumber: TLabel;
    lblLastSessionDate: TLabel;
    lblFirstSessionDate: TLabel;
    lblDate: TLabel;
    lblSessionNumber: TLabel;
    lblFreeRegistration: TLabel;
    lblRegistrationNumber: TLabel;
    lblINN: TLabel;
    lblRNM: TLabel;
    lblNewPasswordTI: TLabel;
    cbReportType: TComboBox;
    lblReportType: TLabel;
    btnOperationalTaxReport: TButton;
    seFirstSessionNumber: TSpinEdit;
    seLastSessionNumber: TSpinEdit;
    seRegistrationNumber: TSpinEdit;
    procedure btnFiscalizationClick(Sender: TObject);
    procedure btnGetFiscalizationParametersClick(Sender: TObject);
    procedure btnGetRangeDatesAndSessionsClick(Sender: TObject);
    procedure btnFiscalReportforDatesRangeClick(Sender: TObject);
    procedure btnFiscalReportforSessionRangeClick(Sender: TObject);
    procedure btnInterruptFullReportClick(Sender: TObject);
    procedure btnOperationalTaxReportClick(Sender: TObject);
    procedure edtNewPasswordTIKeyPress(Sender: TObject; var Key: Char);
  private
    function ConfirmNI: Boolean;  
  end;

implementation

{$R *.DFM}

{ TfmTaxOfficer }

procedure TfmTaxOfficer.btnFiscalizationClick(Sender: TObject);
begin
  if Driver.CapTaxPasswordLock then
  begin
    if MessageBox(Handle, PChar(SConfirmFiscalization), PChar(SAttention),
      MB_ICONEXCLAMATION or MB_YESNO or MB_DEFBUTTON2) <> ID_YES then Exit;
  end;

  if not ConfirmNI then Exit;

  EnableButtons(False);
  try
    CheckIntStr(edtNewPasswordTI.Text, SNewTaxPassword);
    Driver.NewPasswordTI := StrToInt(edtNewPasswordTI.Text);
    Driver.RNM := edtRNM.Text;
    Driver.INN := edtINN.Text;
    if Driver.Fiscalization = 0 then
    begin
      seRegistrationNumber.Value := Driver.RegistrationNumber;
      edtFreeRegistration.Text := IntToStr(Driver.FreeRegistration);
      edtSessionNumber.Text := IntToStr(Driver.SessionNumber);
      edtDate.Text := DateToStr(Driver.Date);
    end else
    begin
      edtFreeRegistration.Clear;
      edtSessionNumber.Clear;
      edtDate.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmTaxOfficer.btnGetFiscalizationParametersClick(Sender: TObject);
begin
  if not ConfirmNI then Exit;

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

procedure TfmTaxOfficer.btnGetRangeDatesAndSessionsClick(Sender: TObject);
begin
  if not ConfirmNI then Exit;

  EnableButtons(False);
  try
    if Driver.GetRangeDatesAndSessions = 0 then
    begin
      seFirstSessionNumber.Value := Driver.FirstSessionNumber;
      seLastSessionNumber.Value := Driver.LastSessionNumber;
      dtpFirstSessionDate.Date := Driver.FirstSessionDate;
      dtpLastSessionDate.Date := Driver.LastSessionDate;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmTaxOfficer.btnFiscalReportforDatesRangeClick(Sender: TObject);
begin
  if not ConfirmNI then Exit;

  EnableButtons(False);
  try
    Driver.ReportType := Boolean(cbReportType.ItemIndex);
    Driver.FirstSessionDate := dtpFirstSessionDate.Date;
    Driver.LastSessionDate := dtpLastSessionDate.Date;
    if Driver.FiscalReportforDatesRange = 0 then
    begin
      seFirstSessionNumber.Value := Driver.FirstSessionNumber;
      seLastSessionNumber.Value := Driver.LastSessionNumber;
      dtpFirstSessionDate.Date := Driver.FirstSessionDate;
      dtpLastSessionDate.Date := Driver.LastSessionDate;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmTaxOfficer.btnFiscalReportforSessionRangeClick(Sender: TObject);
begin
  if not ConfirmNI then Exit;

  EnableButtons(False);
  try
    Driver.ReportType := Boolean(cbReportType.ItemIndex);
    Driver.FirstSessionNumber := seFirstSessionNumber.Value;
    Driver.LastSessionNumber := seLastSessionNumber.Value;
    if Driver.FiscalReportforSessionRange = 0 then
    begin
      seFirstSessionNumber.Value := Driver.FirstSessionNumber;
      seLastSessionNumber.Value := Driver.LastSessionNumber;
      dtpFirstSessionDate.Date := Driver.FirstSessionDate;
      dtpLastSessionDate.Date := Driver.LastSessionDate;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmTaxOfficer.btnInterruptFullReportClick(Sender: TObject);
begin
  if not ConfirmNI then Exit;

  EnableButtons(False);
  try
    Driver.InterruptFullReport;
  finally
    EnableButtons(True);
  end;
end;

function TfmTaxOfficer.ConfirmNI: Boolean;
var
  S: WideString;
begin
  Result := True;
  if not Driver.CapTaxPasswordLock then Exit;
  if Driver.EnteredTaxPassword = Driver.Password then Exit;

  S := Format(STaxPasswordConfirmation, [Driver.Password]);
  Result := MessageBoxW(Handle, PWideChar(S), PWideChar(WideString(SAttention)),
    MB_ICONEXCLAMATION or MB_YESNO) = ID_YES;
end;

procedure TfmTaxOfficer.btnOperationalTaxReportClick(Sender: TObject);
begin
  if not ConfirmNI then Exit;
  EnableButtons(False);
  try
    Driver.PrintOperationalTaxReport;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmTaxOfficer.edtNewPasswordTIKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0'..'9', Chr(VK_TAB), Chr(VK_DELETE), Chr(VK_BACK)]) then
    Key := #0;
end;

end.
