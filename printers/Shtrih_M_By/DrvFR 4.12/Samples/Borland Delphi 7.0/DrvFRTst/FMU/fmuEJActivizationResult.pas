unit fmuEJActivizationResult;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,
  // This
  untPages, untDriver, untTypes;

type
  { TfmEJActivizationResult }

  TfmEJActivizationResult = class(TPage)
    btnGetEKLZActivizationResult: TBitBtn;
    Memo: TMemo;
    btnStop: TBitBtn;
    procedure btnGetEKLZActivizationResultClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    FStopFlag: Boolean;
    procedure GetEKLZData;
    procedure Check2(ResultCode: Integer);
  end;

implementation

{$R *.DFM}

{ TfmEJActivizationResult }

procedure TfmEJActivizationResult.btnGetEKLZActivizationResultClick(
  Sender: TObject);
begin
  FStopFlag := False;
  EnableButtons(False);
  btnStop.Enabled := True;
  try
    Memo.Clear;
    Check(Driver.GetEKLZActivizationResult);
    GetEKLZData;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

///////////////////////////////////////////////////////////////////////////////
// Некоторый эксперт написал что неправильно выдавать ошибку
// Хорошо, ошибка будет просто очищаться в драйвере

procedure TfmEJActivizationResult.Check2(ResultCode: Integer);
begin
  if ResultCode <> 0 then
  begin
    if ResultCode = $A9 then
      Driver.ClearResult;

    Abort;
  end;
end;

procedure TfmEJActivizationResult.GetEKLZData;
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

procedure TfmEJActivizationResult.btnStopClick(Sender: TObject);
begin
  FStopFlag := True;
end;

end.

