unit fmuReports;

interface

uses
  // VCL
  Classes, Controls, StdCtrls, ExtCtrls,
  // This
  untPages, untDriver;

type
  { TfmReports }

  TfmReports = class(TPage)
    btnPrintDepartmentReport: TButton;
    btnPrintReportWithCleaning: TButton;
    btnPrintTaxReport: TButton;
    btnPrintOperationReg: TButton;
    btnPrintReportWithoutCleaning: TButton;
    btnOpenSession: TButton;
    btnPrintZReportInBuffer: TButton;
    btnPrintZReportFromBuffer: TButton;
    btnPrintCashierReport: TButton;
    btnPrintHourlyReport: TButton;
    btnPrintWareReport: TButton;
    procedure btnPrintDepartmentReportClick(Sender: TObject);
    procedure btnPrintReportWithCleaningClick(Sender: TObject);
    procedure btnPrintTaxReportClick(Sender: TObject);
    procedure btnPrintOperationRegClick(Sender: TObject);
    procedure btnPrintReportWithoutCleaningClick(Sender: TObject);
    procedure btnOpenSessionClick(Sender: TObject);
    procedure btnPrintZReportInBufferClick(Sender: TObject);
    procedure btnPrintZReportFromBufferClick(Sender: TObject);
    procedure btnPrintCashierReportClick(Sender: TObject);
    procedure btnPrintHourlyReportClick(Sender: TObject);
    procedure btnPrintWareReportClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmReports }

procedure TfmReports.btnPrintDepartmentReportClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PrintDepartmentReport;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReports.btnPrintReportWithCleaningClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PrintReportWithCleaning;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReports.btnPrintTaxReportClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PrintTaxReport;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReports.btnPrintOperationRegClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PrintOperationReg;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReports.btnPrintReportWithoutCleaningClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PrintReportWithoutCleaning;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReports.btnOpenSessionClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.OpenSession;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReports.btnPrintZReportInBufferClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PrintZReportInBuffer;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReports.btnPrintZReportFromBufferClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PrintZReportFromBuffer;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReports.btnPrintCashierReportClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PrintCashierReport;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReports.btnPrintHourlyReportClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PrintHourlyReport;
  finally
    EnableButtons(True);
  end;

end;

procedure TfmReports.btnPrintWareReportClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PrintWareReport;
  finally
    EnableButtons(True);
  end;
end;

end.
