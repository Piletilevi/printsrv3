unit fmuTaxOfficer2;

interface

uses
  // VCL
  Windows, ComCtrls, Controls, StdCtrls, ExtCtrls, Classes, SysUtils, Graphics,
  Dialogs, Spin,
  // This
  untPages, untUtil, untDriver, untTypes;

type
  { TfmTaxOfficer2 }

  TfmTaxOfficer2 = class(TPage)
    edtSessionNumber: TEdit;
    dtpFirstSessionDate: TDateTimePicker;
    dtpLastSessionDate: TDateTimePicker;
    lblLastSessionNumber: TLabel;
    lblFirstSessionNumber: TLabel;
    lblLastSessionDate: TLabel;
    lblFirstSessionDate: TLabel;
    lblSessionNumber: TLabel;
    lblSumm1: TLabel;
    edtSumm1: TEdit;
    lblSumm3: TLabel;
    edtSumm2: TEdit;
    lblSumm2: TLabel;
    edtSumm3: TEdit;
    lblSumm4: TLabel;
    edtSumm4: TEdit;
    lblECRDate: TLabel;
    edtECRDate: TEdit;
    btnGetShortReportInSessionRange: TButton;
    btnGetShortReportInDatesRange: TButton;
    btnReadEKLZActivizationParams: TButton;
    lblEKLZNumber: TLabel;
    edtEKLZNumber: TEdit;
    lblRegistrationNumber: TLabel;
    seFirstSessionNumber: TSpinEdit;
    seLastSessionNumber: TSpinEdit;
    seRegistrationNumber: TSpinEdit;
    procedure btnInterruptFullReportClick(Sender: TObject);
    procedure btnGetShortReportInSessionRangeClick(Sender: TObject);
    procedure btnGetShortReportInDatesRangeClick(Sender: TObject);
    procedure btnReadEKLZActivizationParamsClick(Sender: TObject);
  private
    procedure ClearPage;
    function ConfirmNI: Boolean;
  end;

implementation

{$R *.DFM}

{ TfmTaxOfficer2 }

procedure TfmTaxOfficer2.btnInterruptFullReportClick(Sender: TObject);
begin
  if not ConfirmNI then Exit;

  EnableButtons(False);
  try
    Driver.InterruptFullReport;
  finally
    EnableButtons(True);
  end;
end;

function TfmTaxOfficer2.ConfirmNI: Boolean;
var
  S: WideString;
begin
  if Driver.EnteredTaxPassword = Driver.Password then
  begin
    Result := True;
    Exit;
  end;
  S := Format(STaxPasswordConfirmation, [Driver.Password]);
  Result := MessageBoxW(Handle, PWideChar(S), PWideChar(WideString(SAttention)),
    MB_ICONEXCLAMATION or MB_YESNO) = ID_YES;
end;

procedure TfmTaxOfficer2.ClearPage;
begin
  edtECRDate.Clear;
  edtSessionNumber.Clear;
  edtSumm1.Clear;
  edtSumm2.Clear;
  edtSumm3.Clear;
  edtSumm4.Clear;
  edtEKLZNumber.Clear;
end;

procedure TfmTaxOfficer2.btnGetShortReportInSessionRangeClick(Sender: TObject);
begin
  if not ConfirmNI then Exit;
  EnableButtons(False);
  try
    Driver.FirstSessionNumber := seFirstSessionNumber.Value;
    Driver.LastSessionNumber := seLastSessionNumber.Value;
    if Driver.GetShortReportInSessionRange <> 0 then
      ClearPage
    else
    begin
      seFirstSessionNumber.Value := Driver.FirstSessionNumber;
      seLastSessionNumber.Value := Driver.LastSessionNumber;
      dtpFirstSessionDate.Date := Driver.FirstSessionDate;
      dtpLastSessionDate.Date := Driver.LastSessionDate;
      edtSumm1.Text := Driver.AmountToStr(Driver.Summ1);
      edtSumm2.Text := Driver.AmountToStr(Driver.Summ2);
      edtSumm3.Text := Driver.AmountToStr(Driver.Summ3);
      edtSumm4.Text := Driver.AmountToStr(Driver.Summ4);
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmTaxOfficer2.btnGetShortReportInDatesRangeClick(Sender: TObject);
begin
  if not ConfirmNI then Exit;
  EnableButtons(False);
  try
    Driver.FirstSessionDate := dtpFirstSessionDate.Date;
    Driver.LastSessionDate := dtpLastSessionDate.Date;
    if Driver.GetShortReportInDatesRange <> 0 then
      ClearPage
    else
    begin
      seFirstSessionNumber.Value := Driver.FirstSessionNumber;
      seLastSessionNumber.Value := Driver.LastSessionNumber;
      dtpFirstSessionDate.Date := Driver.FirstSessionDate;
      dtpLastSessionDate.Date := Driver.LastSessionDate;
      edtSumm1.Text := Driver.AmountToStr(Driver.Summ1);
      edtSumm2.Text := Driver.AmountToStr(Driver.Summ2);
      edtSumm3.Text := Driver.AmountToStr(Driver.Summ3);
      edtSumm4.Text := Driver.AmountToStr(Driver.Summ4);
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmTaxOfficer2.btnReadEKLZActivizationParamsClick(Sender: TObject);
begin
  if not ConfirmNI then Exit;
  EnableButtons(False);
  try
    Driver.RegistrationNumber := seRegistrationNumber.Value;
    if Driver.ReadEKLZActivizationParams <> 0 then
      ClearPage
    else
    begin
      edtECRDate.Text := DateToStr(Driver.Date);
      edtSessionNumber.Text := IntToStr(Driver.SessionNumber);
      edtEKLZNumber.Text := Driver.EKLZNumber;
    end;
  finally
    EnableButtons(True);
  end;
end;

end.
