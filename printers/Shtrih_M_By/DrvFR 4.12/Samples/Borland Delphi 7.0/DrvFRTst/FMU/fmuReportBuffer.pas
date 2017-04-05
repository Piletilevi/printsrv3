unit fmuReportBuffer;

interface

uses
  // VCL
  SysUtils, Classes, Controls, StdCtrls, ExtCtrls, Forms, Buttons,
  Spin, Dialogs,
  // This
  untPages, untDriver,  untUtil;

type
  { TfmReportBuffer }

  TfmReportBuffer = class(TPage)
    lblLineNumber: TLabel;
    lblPrintBufferFormat: TLabel;
    Memo: TMemo;
    btnGetAllReports: TButton;
    btnGetReportStringFromBuffer: TButton;
    cbPrintBufferFormat: TComboBox;
    btnClear: TButton;
    btnStop: TButton;
    lbl1: TLabel;
    btnSave: TBitBtn;
    btnGetReport: TButton;
    dlgSave: TSaveDialog;
    seLineNumber: TSpinEdit;
    seDocumentNumber: TSpinEdit;
    procedure btnGetReportStringFromBufferClick(Sender: TObject);
    procedure btnGetReportClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnGetAllReportsClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    FStopFlag: Boolean;  
  end;

implementation

{$R *.DFM}

resourcestring
  SUserCancelled = '<Прервано пользователем>';
  SReport = '<Отчет №%d>';

{ TfmReportBuffer }

procedure TfmReportBuffer.btnGetReportStringFromBufferClick(
  Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Driver.DocumentNumber := seDocumentNumber.Value;
    Driver.LineNumber := seLineNumber.Value;
    Driver.PrintBufferFormat := cbPrintBufferFormat.ItemIndex;
    Driver.ReadReportBufferLine;
    Memo.Lines.Add(Driver.StringForPrinting);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReportBuffer.btnGetReportClick(Sender: TObject);
var
  i: Integer;
begin
  EnableButtons(False);
  try
    FStopFlag := False;
    btnStop.Enabled := True;
    Memo.Clear;
    i := 0;
    while True do
    begin
      if FStopFlag then
      begin
        Memo.Lines.Add(SUserCancelled);
        Exit;
      end;
      Driver.LineNumber := i;
      Driver.PrintBufferFormat := cbPrintBufferFormat.ItemIndex;
      Driver.DocumentNumber := seDocumentNumber.Value;
      if Driver.ReadReportBufferLine <> 0 then Exit;
      if Driver.PrintBufferFormat = 0 then
        Memo.Lines.Add(StrToHex(Driver.StringForPrinting))
      else
        Memo.Lines.Add(Driver.StringForPrinting);
      Inc(i);
      Application.ProcessMessages;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReportBuffer.btnGetAllReportsClick(Sender: TObject);
var
  i: Integer;
  RepNumber: Integer;
  Res: Integer;
begin
  EnableButtons(False);
  try
    FStopFlag := False;
    btnStop.Enabled := True;
    Memo.Clear;
    for RepNumber := 0 to $FF do
    begin
      i := 0;
      while True do
      begin
        if FStopFlag then
        begin
          Memo.Lines.Add(SUserCancelled);
          Exit;
        end;
        Driver.DocumentNumber := RepNumber;
        Driver.LineNumber := i;
        Driver.PrintBufferFormat := cbPrintBufferFormat.ItemIndex;
        Res := Driver.ReadReportBufferLine;
        if (Res <> $00) and (Res <> $D1) then Exit;
        { Нет данных отчета }
        if Res = $D1 then
        begin
          if i = 0 then
            Exit
          else
           Break;
        end;
        if i = 0 then
          Memo.Lines.Add(Format(SReport, [RepNumber]));
        if Driver.PrintBufferFormat = 0 then
          Memo.Lines.Add(StrToHex(Driver.StringForPrinting))
        else
          Memo.Lines.Add(Driver.StringForPrinting);
        Inc(i);
        Application.ProcessMessages;
      end;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmReportBuffer.btnStopClick(Sender: TObject);
begin
  FStopFlag := True;
end;

procedure TfmReportBuffer.btnClearClick(Sender: TObject);
begin
  Memo.Clear;
end;

procedure TfmReportBuffer.btnSaveClick(Sender: TObject);
begin
  if not dlgSave.Execute then Exit;
  Memo.Lines.SaveToFile(dlgSave.FileName);
end;

end.
