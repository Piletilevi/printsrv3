unit fmuPrintLine;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Spin,
  // This
  untPages, untUtil, untDriver;

type
  { TfmPrintLine }

  TfmPrintLine = class(TPage)
    gbPrintLine: TGroupBox;
    lblLineData: TLabel;
    lblLineNumber: TLabel;
    chbLineSwapBytes: TCheckBox;
    edtLineData: TEdit;
    btnPrintLine: TButton;
    gbBlackLine: TGroupBox;
    lblLineCount: TLabel;
    lblByteCount: TLabel;
    btnBlackLine: TButton;
    seLineNumber: TSpinEdit;
    seLineCount: TSpinEdit;
    seByteCount: TSpinEdit;
    procedure btnPrintLineClick(Sender: TObject);
    procedure btnBlackLineClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

resourcestring
  SInvalidLineLength = 'Неверная длина линии';

{ TfmPrintLine }

procedure TfmPrintLine.btnPrintLineClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.LineDataHex := edtLineData.Text;
    Driver.LineNumber := seLineNumber.Value;
    Driver.LineSwapBytes := chbLineSwapBytes.Checked;
    Driver.PrintLine;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintLine.btnBlackLineClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.FontType := 1;
    if Driver.GetFontMetrics <> 0 then
      Exit;
    if Driver.PrintWidth div 8 < seByteCount.Value then
      raise Exception.Create(SInvalidLineLength);

    Driver.LineData := StringOfChar(#$FF, seByteCount.Value);
    Driver.LineNumber := seLineCount.Value;
    Driver.PrintLine;
  finally
    EnableButtons(True);
  end;
end;

end.

