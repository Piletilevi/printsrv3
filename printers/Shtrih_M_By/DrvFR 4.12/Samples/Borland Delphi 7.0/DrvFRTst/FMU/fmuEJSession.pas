unit fmuEJSession;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Spin,
  // This
  untPages, untDriver, untTypes;

type
  TfmEJSession = class(TPage)
    Memo: TMemo;
    btnEJReadJournal: TBitBtn;
    btnStop: TBitBtn;
    lblSessionNumber: TLabel;
    btnEJReadDayTotal: TBitBtn;
    btnEJPrintDayTotal: TBitBtn;
    btnEJPrintJournal: TBitBtn;
    seSessionNumber: TSpinEdit;
    btnFont: TButton;
    FontDialog: TFontDialog;
    procedure btnEJReadJournalClick(Sender: TObject);
    procedure btnEJReadDayTotalClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnEJPrintDayTotalClick(Sender: TObject);
    procedure btnEJPrintJournalClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
  private
    FStopFlag: Boolean;
    procedure GetEKLZData;
    procedure Check2(ResultCode: Integer);
  end;

implementation

{$R *.DFM}

procedure TfmEJSession.Check2(ResultCode: Integer);
begin
  if ResultCode <> 0 then
  begin
    if ResultCode = $A9 then
      Driver.ClearResult;

    Abort;
  end;
end;

procedure TfmEJSession.GetEKLZData;
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

procedure TfmEJSession.btnEJReadJournalClick(Sender: TObject);
begin
  FStopFlag := False;
  EnableButtons(False);
  btnStop.Enabled := True;
  try
    Memo.Clear;
    Driver.SessionNumber := seSessionNumber.Value;
    Check(Driver.GetEKLZJournal);
    GetEKLZData;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmEJSession.btnEJReadDayTotalClick(Sender: TObject);
begin
  FStopFlag := False;
  EnableButtons(False);
  btnStop.Enabled := True;
  try
    Memo.Clear;
    Driver.SessionNumber := seSessionNumber.Value;
    Check(Driver.GetEKLZSessionTotal);
    GetEKLZData;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmEJSession.btnStopClick(Sender: TObject);
begin
  FStopFlag := True;
end;

procedure TfmEJSession.btnEJPrintDayTotalClick(
  Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.SessionNumber := seSessionNumber.Value;
    Driver.ReadEKLZSessionTotal;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJSession.btnEJPrintJournalClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.SessionNumber := seSessionNumber.Value;
    Driver.EKLZJournalOnSessionNumber;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJSession.btnFontClick(Sender: TObject);
begin
  FontDialog.Font := Memo.Font;
  if FontDialog.Execute then
    Memo.Font := FontDialog.Font;
end;

end.
