unit fmuDateTime;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Buttons,
  StdCtrls, ComCtrls, ExtCtrls, 
  // This
  untPages, untDriver;
type
  { TfmDateTime }

  TfmDateTime = class(untPages.TPage)
    gbDate: TGroupBox;
    dtpDate: TDateTimePicker;
    btnCurrentDate: TButton;
    btnConfirmDate: TButton;
    btnSetDate: TBitBtn;
    gbTime: TGroupBox;
    dtpTime: TDateTimePicker;
    btnCurrentTime: TButton;
    btnSetTime: TBitBtn;
    Timer: TTimer;
    grpCurrentDateTime: TGroupBox;
    lblDateTime: TLabel;
    btnSetCurrentDateTime: TButton;
    procedure btnCurrentDateClick(Sender: TObject);
    procedure btnCurrentTimeClick(Sender: TObject);
    procedure btnSetTimeClick(Sender: TObject);
    procedure btnSetDateClick(Sender: TObject);
    procedure btnConfirmDateClick(Sender: TObject);
    procedure btnSetCurrentDateTimeClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmDateTime }

procedure TfmDateTime.btnCurrentDateClick(Sender: TObject);
begin
  dtpDate.Date := Date;
end;

procedure TfmDateTime.btnCurrentTimeClick(Sender: TObject);
begin
  dtpTime.Time := Time;
end;

procedure TfmDateTime.btnSetTimeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.Time := dtpTime.Time;
    Driver.SetTime;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmDateTime.btnSetDateClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.Date := dtpDate.Date;
    Driver.SetDate;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmDateTime.btnConfirmDateClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.Date := dtpDate.Date;
    Driver.ConfirmDate;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmDateTime.btnSetCurrentDateTimeClick(Sender: TObject);
var
  Dat: TDateTime;
begin
  EnableButtons(False);
  try
    Dat := Date;
    Driver.Date := Dat;
    Check(Driver.SetDate);
    Driver.Date := Dat;
    Check(Driver.ConfirmDate);
    Driver.Time := Time;
    Check(Driver.SetTime);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmDateTime.TimerTimer(Sender: TObject);
begin
  lblDateTime.Caption := DateToStr(Date) + '  ' + TimeToStr(Time);
end;

end.
