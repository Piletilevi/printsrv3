unit fmuPrintTest;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Spin,
  // This
  untPages, untDriver;

type
  { TfmLock }

  TfmPrintTest = class(TPage)
    grpPrintLock: TGroupBox;
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
    btnStartPrintWithLock: TButton;
    btnStopPrintWithLock: TButton;
    chbStopOnError: TCheckBox;
    lblSpeedPrinting: TLabel;
    grpSpeedPrintTest: TGroupBox;
    lblStringCount: TLabel;
    btnStartSpeedPrintTest: TButton;
    lblSpeed_: TLabel;
    btnStopSpeedPrintTest: TButton;
    grpTestFonts: TGroupBox;
    btnFonts: TButton;
    sePrintCount: TSpinEdit;
    procedure btnStartPrintWithLockClick(Sender: TObject);
    procedure btnStopPrintWithLockClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFontsClick(Sender: TObject);
    procedure btnStartSpeedPrintTestClick(Sender: TObject);
    procedure btnStopSpeedPrintTestClick(Sender: TObject);
  private
    StopFlag: Boolean;
  end;

implementation

{$R *.DFM}

resourcestring
  SFont = 'Шрифт';
  SLine = 'Строка ';
  SStringForPrinting = '%d: Строка для печати(ID:%d)';

{ TfmLock }

procedure TfmPrintTest.btnStartPrintWithLockClick(Sender: TObject);

  procedure Wait(T2: DWORD);
  var
    T1: DWORD;
  begin
    T1 := GetTickCount;
    repeat
      Application.ProcessMessages;
    until GetTickCount - T1 > T2;
  end;

var
  i: Integer;
  Speed: Integer;
  ErrRate: Double;
  TimeLeft: DWORD;
  TickCount: DWORD;
  ProcessID: DWORD;
  RepCount: Integer;
  ErrCount: Integer;
  ResultCode: Integer;
begin
  RepCount := 0;
  ErrCount := 0;
  ResultCode := 0;
  StopFlag := False;
  btnStopPrintWithLock.Enabled := True;
  btnStartPrintWithLock.Enabled := False;
  TickCount := GetTickCount;
  try
    repeat
      Inc(RepCount);
      try
        ResultCode := Driver.LockPort;
      except
      end;
      if ResultCode <> 0 then

      begin
        ResultCode := 0;
        Wait(100);
      end else
      try
        GetWindowThreadProcessId(Application.Handle, @ProcessID);
        Driver.StringForPrinting := '-------------------------------';
        ResultCode := Driver.PrintString;
        Driver.WaitForPrinting;
        for i := 1 to 10 do
        begin
          Driver.StringForPrinting := Format(SStringForPrinting, [
            i, ProcessID]);
          ResultCode := Driver.PrintString;
          Driver.WaitForPrinting;
          if ResultCode <> 0 then Break;
        end;
        Driver.CutType := True;
        Driver.FeedDocument;
        Driver.CutCheck;
      finally
        Driver.UnlockPort;
        Wait(500); // Чтобы другие тоже могли захватить порт
      end;

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
    btnStopPrintWithLock.Enabled := False;
    btnStartPrintWithLock.Enabled := True;
  end;
end;

procedure TfmPrintTest.btnStopPrintWithLockClick(Sender: TObject);
begin
  StopFlag := True;
end;

procedure TfmPrintTest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  StopFlag := True;
end;

// Тест печати шрифтов
procedure TfmPrintTest.btnFontsClick(Sender: TObject);
var
  i: Integer;
  S: WideString;
  Count: Integer;
  CharCount: Integer;
begin
  EnableButtons(False);
  try
    Driver.UseReceiptRibbon := True;
    Driver.UseJournalRibbon := False;
    S := '01234567890123456789012345678901234567890' +
      '0123456789012345678901234567890123456789012345678901234567890123456789';
    // Шрифт 1 есть всегда
    Driver.FontType := 1;
    if Driver.GetFontMetrics <> 0 then
      Exit;
    Count := Driver.FontCount;
    for i := 1 to Count do
    begin
      Driver.FontType := i;
      if Driver.GetFontMetrics <> 0 then Break;
      CharCount := 40;
      if Driver.CharWidth > 0 then
        CharCount := Trunc(Driver.PrintWidth/Driver.CharWidth);

      Driver.StringForPrinting := Format('%s %d', [SFont, i]);
      if Driver.PrintStringWithFont <> 0 then
        Break;
      Driver.StringForPrinting := Copy(S, 1, CharCount);
      if Driver.PrintStringWithFont <> 0 then
        Break;
    end;
  finally
    EnableButtons(True);
  end;
end;

// Тест скорости печати
procedure TfmPrintTest.btnStartSpeedPrintTestClick(Sender: TObject);
var
  i: Integer;
  Count: Integer;
  PrintSpeed: Double;
  TickCount: Integer;
  StartTickCount: Integer;
begin
  EnableButtons(False);
  btnStopSpeedPrintTest.Enabled := True;
  try
    PrintSpeed := 0;
    StopFlag := False;
    lblSpeedPrinting.Caption := '';
    Application.ProcessMessages;
    Count := sePrintCount.Value;

    StartTickCount := GetTickCount;
    Driver.FontType := 1;
    Driver.UseReceiptRibbon := True;
    Driver.UseJournalRibbon := False;
    for i := 1 to Count do
    begin
      if StopFlag then Break;
      Driver.StringForPrinting := Format('%s %d', [SLine, i]);

      if Driver.PrintString <> 0 then
        Break;

      TickCount := Integer(GetTickCount) - StartTickCount;
      if TickCount > 0 then
        PrintSpeed := (i * 1000)/TickCount;

      lblSpeedPrinting.Caption := Format('%.3f', [PrintSpeed]);
      Application.ProcessMessages;
    end;
  finally
    EnableButtons(True);
    btnStopSpeedPrintTest.Enabled := False;
  end;
end;

procedure TfmPrintTest.btnStopSpeedPrintTestClick(Sender: TObject);
begin
  StopFlag := True;
end;

end.
