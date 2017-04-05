unit fmuConnectionTest;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, ExtCtrls, ComCtrls, Buttons,
  // This
  untPages, untUtil, untDriver, untTypes;

type
  { TfmConnectionTest }

  TfmConnectionTest = class(TPage)
    grpCheckConnection: TGroupBox;
    lblRepCount2: TLabel;
    lblRepCount: TLabel;
    lblErrCount2: TLabel;
    lblErrCount: TLabel;
    lblSpeed: TLabel;
    lblTxSpeed: TLabel;
    Label1: TLabel;
    lblErrRate: TLabel;
    lblTimeLeft2: TLabel;
    lblTimeLeft: TLabel;
    Label2: TLabel;
    lblCommandTime: TLabel;
    btnStart: TButton;
    btnStop: TButton;
    chbStopOnError: TCheckBox;
    grpConnectionTest: TGroupBox;
    lblTime: TLabel;
    lblTest: TLabel;
    btnTestConnect: TBitBtn;
    edtTime: TEdit;
    chkCheckFM: TCheckBox;
    chkCheckEJ: TCheckBox;
    lblCheck: TLabel;
    procedure btnStopClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTestConnectClick(Sender: TObject);
  private
    StopFlag: Boolean;
  end;

implementation

{$R *.DFM}

{ TfmTest }

procedure TfmConnectionTest.btnStartClick(Sender: TObject);
var
  Speed: Integer;
  ErrRate: Double;
  TimeLeft: DWORD;
  TickCount: DWORD;
  RepCount: Integer;
  ErrCount: Integer;
  ResultCode: Integer;
begin
  RepCount := 0;
  ErrCount := 0;
  StopFlag := False;
  btnStop.Enabled := True;
  btnStart.Enabled := False;
  chkCheckFM.Enabled := False;
  chkCheckEJ.Enabled := False;
  chbStopOnError.Enabled := False;
  Driver.CheckFMConnection := chkCheckFM.Checked;
  Driver.CheckEJConnection := chkCheckEJ.Checked;
  TickCount := GetTickCount;
  try
    repeat
      Inc(RepCount);

      ResultCode := Driver.CheckConnection;
      if ResultCode <> 0 then Inc(ErrCount);

      TimeLeft := GetTickCount - TickCount;
      if TimeLeft = 0 then Continue;

      Speed := Trunc(RepCount*1000/TimeLeft);
      ErrRate := ErrCount*100/RepCount;

      lblRepCount.Caption := IntToStr(RepCount);
      lblErrCount.Caption := IntToStr(ErrCount);
      lblTxSpeed.Caption := IntToStr(Speed);
      lblErrRate.Caption := Format('%.2f', [ErrRate]);
      lblTimeLeft.Caption := IntToStr(Trunc(TimeLeft/1000));
      lblCommandTime.Caption := IntToStr(Trunc(TimeLeft/RepCount));
      Application.ProcessMessages;
      if (ResultCode <> 0)and(chbStopOnError.Checked) then Exit;
    until StopFlag;
  finally
    Driver.Disconnect;
    btnStop.Enabled := False;
    btnStart.Enabled := True;
    chkCheckFM.Enabled := True;
    chkCheckEJ.Enabled := True;
    chbStopOnError.Enabled := True;
  end;
end;

procedure TfmConnectionTest.btnStopClick(Sender: TObject);
begin
  StopFlag := True;
end;

procedure TfmConnectionTest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  StopFlag := True;
end;

procedure TfmConnectionTest.btnTestConnectClick(Sender: TObject);
var
  T: DWORD;
  i: Integer;
begin
  EnableButtons(False);
  try
    Driver.StringForPrinting := SStringForPrinting;
    T := GetTickCount;
    for i := 1 to 100 do
      if Driver.PrintString <> 0 then Break;
    Driver.CutType := True;
    Driver.CutCheck;
    edtTime.Text := IntToStr(GetTickCount - T);
  finally
    EnableButtons(True);
  end;
end;

end.
