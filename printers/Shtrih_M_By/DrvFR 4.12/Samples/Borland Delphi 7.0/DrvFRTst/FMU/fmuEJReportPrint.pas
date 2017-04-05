unit fmuEJReportPrint;

interface

uses
  // VCL
  Controls, StdCtrls, ExtCtrls, ComCtrls, Classes, SysUtils, Graphics,
  // This
  untPages, untUtil, untDriver, Spin;

type
  { TfmEKLZReportInRange }

  TfmEJReportPrint = class(TPage)
    lblDepartment: TLabel;
    lblStartDate: TLabel;
    dtpStartDate: TDateTimePicker;
    lblEndDate: TLabel;
    dtpEndDate: TDateTimePicker;
    btnEKLZDepartmentReportInDatesRange: TButton;
    btnEKLZSessionReportInDatesRange: TButton;
    lblFirstSessionNumber: TLabel;
    lblLastSessionNumber: TLabel;
    btnEKLZDepartmentReportInSessionsRange: TButton;
    btnEKLZSessionReportInSessionsRange: TButton;
    cbReportType: TComboBox;
    lblReportType: TLabel;
    btnInterruptPrint: TButton;
    seDepartment: TSpinEdit;
    seFirstSessionNumber: TSpinEdit;
    seLastSessionNumber: TSpinEdit;
    procedure btnEKLZDepartmentReportInDatesRangeClick(Sender: TObject);
    procedure btnEKLZDepartmentReportInSessionsRangeClick(Sender: TObject);
    procedure btnEKLZSessionReportInDatesRangeClick(Sender: TObject);
    procedure btnEKLZSessionReportInSessionsRangeClick(Sender: TObject);
    procedure btnInterruptPrintClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmEKLZReportInRange }

procedure TfmEJReportPrint.btnEKLZDepartmentReportInDatesRangeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ReportType := cbReportType.ItemIndex > 0;
    Driver.Department := seDepartment.Value;
    Driver.FirstSessionDate := dtpStartDate.Date;
    Driver.LastSessionDate := dtpEndDate.Date;
    Driver.EKLZDepartmentReportInDatesRange;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJReportPrint.btnEKLZDepartmentReportInSessionsRangeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ReportType := cbReportType.ItemIndex > 0;
    Driver.Department := seDepartment.Value;
    Driver.FirstSessionNumber := seFirstSessionNumber.Value;
    Driver.LastSessionNumber := seLastSessionNumber.Value;
    Driver.EKLZDepartmentReportInSessionsRange;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJReportPrint.btnEKLZSessionReportInDatesRangeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ReportType := cbReportType.ItemIndex > 0;
    Driver.FirstSessionDate := dtpStartDate.Date;
    Driver.LastSessionDate := dtpEndDate.Date;
    Driver.EKLZSessionReportInDatesRange;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJReportPrint.btnEKLZSessionReportInSessionsRangeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ReportType := cbReportType.ItemIndex > 0;
    Driver.FirstSessionNumber := seFirstSessionNumber.Value;
    Driver.LastSessionNumber := seLastSessionNumber.Value;
    Driver.EKLZSessionReportInSessionsRange;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJReportPrint.btnInterruptPrintClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.StopEKLZDocumentPrinting;
  finally
    EnableButtons(True);
  end;
end;

end.
