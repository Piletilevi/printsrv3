unit fmuEJReports;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Spin,
  // This
  untPages, untDriver, untTypes;

type
  { TfmEJReports }

  TfmEJReports = class(TPage)
    Memo: TMemo;
    btnGetEKLZDepartmentReportInSessionsRange: TBitBtn;
    btnStop: TBitBtn;
    btnGetEKLZSessionReportInSessionsRange: TBitBtn;
    btnGetEKLZDepartmentReportInDatesRange: TBitBtn;
    btnGetEKLZSessionReportInDatesRange: TBitBtn;
    lblReportType: TLabel;
    lblDepartment: TLabel;
    lblFirstSessionNumber: TLabel;
    lblLastSessionNumber: TLabel;
    lblStartDate: TLabel;
    dtpFirstSessionDate: TDateTimePicker;
    lblEndDate: TLabel;
    dtpLastSessionDate: TDateTimePicker;
    cbReportType: TComboBox;
    seDepartment: TSpinEdit;
    seFirstSessionNumber: TSpinEdit;
    seLastSessionNumber: TSpinEdit;
    procedure btnGetEKLZDepartmentReportInSessionsRangeClick(Sender: TObject);
    procedure btnGetEKLZSessionReportInSessionsRangeClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnGetEKLZDepartmentReportInDatesRangeClick(Sender: TObject);
    procedure btnGetEKLZSessionReportInDatesRangeClick(Sender: TObject);
  private
    FStopFlag: Boolean;
    procedure GetEKLZData;
    procedure Check2(ResultCode: Integer);
  end;

implementation

{$R *.DFM}

{ TfmEJReports }

procedure TfmEJReports.btnGetEKLZDepartmentReportInSessionsRangeClick(Sender: TObject);
begin
  FStopFlag := False;
  EnableButtons(False);
  btnStop.Enabled := True;
  try
    Memo.Clear;
    Driver.ReportType := cbReportType.ItemIndex > 0;
    Driver.Department := seDepartment.Value;
    Driver.FirstSessionNumber := seFirstSessionNumber.Value;
    Driver.LastSessionNumber := seLastSessionNumber.Value;
    Check(Driver.GetEKLZDepartmentReportInSessionsRange);
    GetEKLZData;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmEJReports.btnGetEKLZSessionReportInSessionsRangeClick(
  Sender: TObject);
begin
  FStopFlag := False;
  EnableButtons(False);
  btnStop.Enabled := True;
  try
    Memo.Clear;
    Driver.ReportType := cbReportType.ItemIndex > 0;
    Driver.FirstSessionNumber := seFirstSessionNumber.Value;
    Driver.LastSessionNumber := seLastSessionNumber.Value;
    Check(Driver.GetEKLZSessionReportInSessionsRange);
    GetEKLZData;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

///////////////////////////////////////////////////////////////////////////////
// Некоторый эксперт написал что неправильно выдавать ошибку
// Хорошо, ошибка будет просто очищаться в драйвере

procedure TfmEJReports.Check2(ResultCode: Integer);
begin
  if ResultCode <> 0 then
  begin
    if ResultCode = $A9 then
      Driver.ClearResult;

    Abort;
  end;
end;

procedure TfmEJReports.GetEKLZData;
begin
  Memo.Lines.Add('');
  Memo.Lines.Add(Format(' %s: %s', [SPrinterType, Driver.UDescription]));
  Memo.Lines.Add('');
  repeat
    Check2(Driver.GetEKLZData);
    Memo.Lines.Add(' ' + Driver.EKLZData);
    Application.ProcessMessages;
  until FStopFlag;
  Driver.EKLZInterrupt;
end;

procedure TfmEJReports.btnGetEKLZDepartmentReportInDatesRangeClick(
  Sender: TObject);
begin
  FStopFlag := False;
  EnableButtons(False);
  btnStop.Enabled := True;
  try
    Memo.Clear;
    Driver.ReportType := cbReportType.ItemIndex > 0;
    Driver.Department := seDepartment.Value;
    Driver.FirstSessionDate := dtpFirstSessionDate.Date;
    Driver.LastSessionDate := dtpLastSessionDate.Date;
    Check(Driver.GetEKLZDepartmentReportInDatesRange);
    GetEKLZData;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmEJReports.btnGetEKLZSessionReportInDatesRangeClick(
  Sender: TObject);
begin
  FStopFlag := False;
  EnableButtons(False);
  btnStop.Enabled := True;
  try
    Memo.Clear;
    Driver.ReportType := cbReportType.ItemIndex > 0;
    Driver.FirstSessionDate := dtpFirstSessionDate.Date;
    Driver.LastSessionDate := dtpLastSessionDate.Date;
    Check(Driver.GetEKLZSessionReportInDatesRange);
    GetEKLZData;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmEJReports.btnStopClick(Sender: TObject);
begin
  FStopFlag := True;
end;

end.

