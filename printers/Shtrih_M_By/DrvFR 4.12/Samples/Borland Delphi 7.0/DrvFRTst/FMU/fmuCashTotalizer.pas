unit fmuCashTotalizer;

interface

uses
    // VCL
  Windows, ComCtrls, StdCtrls, Controls, Classes, SysUtils, Forms, ExtCtrls,
  Buttons,
  // This
  untPages, untUtil, untDriver, untTypes, PrinterTypes;

type
  { TfmCashTotalizer }

  TfmCashTotalizer = class(TPage)
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

{ TfmCashTotalizer }

procedure TfmCashTotalizer.AddCaption(S: string);
begin
  Memo.Lines.Add('');
  Memo.Lines.Add(S);
  Memo.Lines.Add(' ' + StringOfChar('-', 54));
end;

procedure TfmCashTotalizer.AddAllRegisters;
var
  i: Integer;
begin
  Memo.Clear;
  AddCaption(SCashRegisters);
  for i := 0 to 255 do
  begin
    if FStopFlag then
      raise EAbort.Create(SUserAbort);

    Driver.RegisterNumber := i;
    if Driver.GetCashReg <> 0 then
    begin
      raise EAbort.CreateFmt(SErrorAbort, [
        Driver.ResultCode, Driver.ResultCodeDescription]);
    end;
    Memo.Lines.Add(Format(' %3d.%-56s : %s',
      [i, Driver.NameCashReg, Driver.AmountToStr(Driver.ContentsOfCashRegister)]));
    Application.ProcessMessages;
  end;
  // Scroll memo down
  Memo.SelStart := 0;
  Memo.SelLength := 0;
end;

procedure TfmCashTotalizer.btnStopClick(Sender: TObject);
begin
  FStopFlag := True;
end;

procedure TfmCashTotalizer.btnReadAllClick(Sender: TObject);
begin
  EnableButtons(False);
  btnStop.Enabled := True;
  try
    try
      FStopFlag := False;
      AddAllRegisters;
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
