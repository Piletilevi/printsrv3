unit fmuBillAcceptor;

interface

uses
  // VCL
  Windows, Forms, ComCtrls, StdCtrls, Controls, Classes, SysUtils, Messages,
  Buttons, Dialogs,
  // This
  untPages, untUtil, untDriver;

type
  { TfmBillAcceptor }

  TfmBillAcceptor = class(TPage)
    Memo: TMemo;
    btnGetCashBillStatus: TButton;
    btnGetBillAcceptorRegisters: TButton;
    btnBillAcceptorReport: TButton;
    cbRegisterNumber: TComboBox;
    lblRegisterNumber: TLabel;
    procedure btnGetCashBillStatusClick(Sender: TObject);
    procedure btnGetBillAcceptorRegistersClick(Sender: TObject);
    procedure btnBillAcceptorReportClick(Sender: TObject);
  private
    procedure AddSeparator;
    procedure AddLineWidth(V1, V2: Variant; TextWidth: Integer);
    procedure AddMemoLine(const S: string);
  end;

implementation

{$R *.DFM}

{ TfmECRStatus }

const
  DescriptionWidth = 33;

resourcestring
  SPollingEnabled = 'ведется';
  SPollingDisabled = 'не ведется';
  SPollingMode = 'Режим опроса купюроприемника';
  SPollingDecsription = ' Описание: ';
  SBillAcceptorStatus = ' Запрос состояния купюроприемника:';
  SBillCount = 'Количество купюр типа %.2d';
  SRegisterSetQuery = ' Запрос регистров купюроприемника:';
  SRegisterSetNumber = 'Номер набора регистров';

procedure TfmBillAcceptor.AddMemoLine(const S: string);
begin
  Memo.Lines.Add(' ' + S);
end;

procedure TfmBillAcceptor.AddLineWidth(V1, V2: Variant; TextWidth: Integer);
begin
  AddMemoLine(Format('%-*s: %s', [TextWidth, String(V1), String(V2)]));
end;

procedure TfmBillAcceptor.AddSeparator;
begin
  AddMemoLine(StringOfChar('-', 40));
end;

function CAModeToStr(ACAMode: Integer): string;
begin
  case ACAMode of
    0: Result := SPollingDisabled;
    1: Result := SPollingEnabled;
  else
    Result := IntToStr(ACAMode);
  end;
end;

procedure TfmBillAcceptor.btnGetCashBillStatusClick(Sender: TObject);
begin
  EnableButtons(False);
  Memo.Lines.BeginUpdate;
  try
    Memo.Clear;
    if Driver.GetCashAcceptorStatus <> 0 then Exit;
    Memo.Lines.Add('');
    AddSeparator;
    Memo.Lines.Add(SBillAcceptorStatus);
    AddSeparator;

    AddLineWidth(SPollingMode, CAModeTostr(Driver.CashAcceptorPollingMode), 29);
    AddLineWidth('Poll1', Driver.Poll1, 29);
    AddLineWidth('Poll2', Driver.poll2, 29);
    Memo.Lines.Add(SPollingDecsription + Driver.PollDescription);

    AddSeparator;
    // Scroll memo
    Memo.SelStart := 0;
    Memo.SelLength := 0;
  finally
    Memo.Lines.EndUpdate;
    EnableButtons(True);
  end;
end;

procedure TfmBillAcceptor.btnGetBillAcceptorRegistersClick(Sender: TObject);
var
  i: Integer;
begin
  EnableButtons(False);
  Memo.Lines.BeginUpdate;
  try
    Memo.Clear;
    Driver.RegisterNumber := cbRegisterNumber.ItemIndex;
    if Driver.GetCashAcceptorRegisters <> 0 then Exit;
    Memo.Lines.Add('');
    AddSeparator;
    Memo.Lines.Add(SRegisterSetQuery);
    AddSeparator;

    AddLineWidth(SRegisterSetNumber, IntToStr(Driver.RegisterNumber), 23);
    for i := 0 to 23 do
    begin
      Driver.BanknoteType := i;
      if Driver.ReadBanknoteCount <> 0 then
        Exit;
      AddLineWidth(Format(SBillCount, [i]), Driver.BanknoteCount, 23);
    end;
    AddSeparator;
    // Scroll memo
    Memo.SelStart := 0;
    Memo.SelLength := 0;
  finally
    Memo.Lines.EndUpdate;
    EnableButtons(True);
  end;
end;

procedure TfmBillAcceptor.btnBillAcceptorReportClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.CashAcceptorReport;
  finally
    EnableButtons(True);
  end;
end;

end.
