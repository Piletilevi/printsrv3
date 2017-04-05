unit fmuPrintBuffer;

interface

uses
  // VCL
  Windows, Forms, ComCtrls, StdCtrls, Controls, Classes, SysUtils, Messages,
  Buttons, ExtCtrls,
  // This
  untPages, untUtil, untDriver, Spin;

type
  { TfmPrintBuffer }

  TfmPrintBuffer = class(TPage)
    Memo: TMemo;
    btnReadPrintBufferLineNumber: TButton;
    btnClearPrintBuffer: TButton;
    btnReadPrintBuffer: TButton;
    btnReadPrintBufferLine: TButton;
    lblLineNumber: TLabel;
    lblPrintBufferFormat: TLabel;
    cbPrintBufferFormat: TComboBox;
    btnClear: TButton;
    btnStop: TButton;
    seLineNumber: TSpinEdit;
    procedure btnReadPrintBufferLineNumberClick(Sender: TObject);
    procedure btnClearPrintBufferClick(Sender: TObject);
    procedure btnReadPrintBufferClick(Sender: TObject);
    procedure btnReadPrintBufferLineClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    FStopFlag: Boolean;
  end;

implementation

{$R *.DFM}

resourcestring
  SPrintBufferLineNumber = 'Количество строк в буфере печати';
  SLineNumber = 'Количество напечатаных строк';

{ TfmPrintBuffer }

procedure TfmPrintBuffer.btnClearPrintBufferClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Check(Driver.ClearPrintBuffer);
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmPrintBuffer.btnReadPrintBufferLineNumberClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Check(Driver.ReadPrintBufferLineNumber);

    Memo.Lines.Add(Format('%s : %d', [SPrintBufferLineNumber,
      Driver.PrintBufferLineNumber]));
    Memo.Lines.Add(Format('%s : %d', [SLineNumber, Driver.LineNumber]));
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmPrintBuffer.btnReadPrintBufferLineClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Driver.LineNumber := seLineNumber.Value;
    Driver.PrintBufferFormat := cbPrintBufferFormat.ItemIndex;
    Check(Driver.ReadPrintBufferLine);
    Memo.Lines.Add(Driver.StringForPrinting);
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmPrintBuffer.btnReadPrintBufferClick(Sender: TObject);
var
  i: Integer;
begin
  EnableButtons(False);
  FStopFlag := False;
  btnStop.Enabled := True;
  try
    Memo.Clear;
    Driver.PrintBufferFormat := cbPrintBufferFormat.ItemIndex;
    Check(Driver.ReadPrintBufferLineNumber);
    for i := 0 to Driver.PrintBufferLineNumber-1 do
    begin
      if FStopFlag then Break;
      Driver.LineNumber := i;
      Check(Driver.ReadPrintBufferLine);
      Memo.Lines.Add(Format('%.3d: %s', [i, Driver.StringForPrinting]));
      Application.ProcessMessages;
    end;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmPrintBuffer.FormCreate(Sender: TObject);
begin
  cbPrintBufferFormat.ItemIndex := 2;
end;

procedure TfmPrintBuffer.btnStopClick(Sender: TObject);
begin
  FStopFlag := True;
end;

procedure TfmPrintBuffer.btnClearClick(Sender: TObject);
begin
  Memo.Clear;
end;

end.
