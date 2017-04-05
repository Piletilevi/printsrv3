unit fmuWorkTotalizer;

interface

uses
    // VCL
  Windows, ComCtrls, StdCtrls, Controls, Classes, SysUtils, Forms, ExtCtrls,
  Buttons,
  // This
  untPages, untUtil, untDriver, untTypes, PrinterTypes;

type
  { TfmWorkTotalizer }

  TfmWorkTotalizer = class(TPage)
    Memo: TMemo;
    btnStop: TButton;
    btnReadAll: TButton;
    procedure btnStopClick(Sender: TObject);
    procedure btnReadAllClick(Sender: TObject);
  private
    FStopFlag: Boolean;
    procedure AddAllRegisters;
    procedure AddCaption(S: string);
  end;

implementation


{$R *.DFM}

{ TfmWorkTotalizer }

procedure TfmWorkTotalizer.AddCaption(S: string);
begin
  Memo.Lines.Add('');
  Memo.Lines.Add(S);
  Memo.Lines.Add(' ' + StringOfChar('-', 54));
end;

procedure TfmWorkTotalizer.AddAllRegisters;
var
  i: Integer;
begin
  for i := 0 to 255 do
  begin
    if FStopFlag then
      raise EAbort.Create(SUserAbort);
    Driver.RegisterNumber := i;
    if Driver.GetOperationReg <> 0 then
    begin
      raise EAbort.CreateFmt(SErrorAbort, [
        Driver.ResultCode, Driver.ResultCodeDescription]);
    end;
    Application.ProcessMessages;

    Memo.Lines.Add(Format(' %3d.%-50s : %s',
      [i, Driver.NameOperationReg,
      Driver.AmountToStr(Driver.ContentsOfOperationRegister)]));
  end;
end;

procedure TfmWorkTotalizer.btnStopClick(Sender: TObject);
begin
  FStopFlag := True;
end;

procedure TfmWorkTotalizer.btnReadAllClick(Sender: TObject);
begin
  EnableButtons(False);
  btnStop.Enabled := True;
  try
    try
      FStopFlag := False;
      Memo.Clear;
      AddCaption(SOperationRegisters);
      AddAllRegisters;
      // Scroll memo
      Memo.SelStart := 0;
      Memo.SelLength := 0;
    except
      on E: EAbort do
        Memo.Lines.Add(E.Message);
    end;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

end.
