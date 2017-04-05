unit fmuIBMPrinter;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,
  // This
  untPages, untDriver, untTypes;

type
  { TfmIBMPrinter }

  TfmIBMPrinter = class(TPage)
    btnGetShortIBMStatus: TButton;
    Memo: TMemo;
    btnGetIBMStatus: TButton;
    btnClear: TBitBtn;
    procedure btnGetShortIBMStatusClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnGetIBMStatusClick(Sender: TObject);
  private
    procedure AddSeparator;
    procedure AddStatusBits;
    procedure AddStatusBytes;
    procedure AddLine(const S1, S2: string);
    procedure AddBitText2(Value, BitNumber: Integer; const BitName: string);
    procedure AddBitText(Value, ByteNumber, BitNumber: Integer; const BitName: string);
  end;

implementation

{$R *.DFM}

function TestBit(Value, Bit: Integer): Boolean;
begin
  Result := (Value and (1 shl Bit)) <> 0;
end;

function GetStatusByteText(StatusByteNumber, Value: Integer): string;
begin
  Result := Format('%s %d: %d = 0x%xh',
    [SStatusByte, StatusByteNumber, Value, Value]);
end;

{ TfmIBMPrinter }

procedure TfmIBMPrinter.AddBitText(Value, ByteNumber, BitNumber: Integer;
  const BitName: string);
var
  S: WideString;
  IsBitSet: Boolean;
const
  BitText: array [Boolean] of Char = (' ', 'x');
begin
  IsBitSet := TestBit(Value, BitNumber);
  S := Format('%d.%d [%s] %s', [ByteNumber, BitNumber, BitText[IsBitSet], BitName]);
  Memo.Lines.Add(S);
end;

procedure TfmIBMPrinter.AddBitText2(Value, BitNumber: Integer;
  const BitName: string);
var
  S: WideString;
  IsBitSet: Boolean;
const
  BitText: array [Boolean] of Char = (' ', 'x');
begin
  IsBitSet := TestBit(Value, BitNumber);
  S := Format('[%s] %s', [BitText[IsBitSet], BitName]);
  Memo.Lines.Add(S);
end;

procedure TfmIBMPrinter.AddSeparator;
begin
  Memo.Lines.Add('-------------------------------------');
end;

{ Добавляем значения байтов состояния }

procedure TfmIBMPrinter.AddStatusBytes;
begin
  AddSeparator;
  Memo.Lines.Add(GetStatusByteText(1, Driver.IBMStatusByte1));
  Memo.Lines.Add(GetStatusByteText(2, Driver.IBMStatusByte2));
  Memo.Lines.Add(GetStatusByteText(3, Driver.IBMStatusByte3));
  Memo.Lines.Add(GetStatusByteText(4, Driver.IBMStatusByte4));
  Memo.Lines.Add(GetStatusByteText(5, Driver.IBMStatusByte5));
  Memo.Lines.Add(GetStatusByteText(6, Driver.IBMStatusByte6));
  Memo.Lines.Add(GetStatusByteText(7, Driver.IBMStatusByte7));
  Memo.Lines.Add(GetStatusByteText(8, Driver.IBMStatusByte8));
  AddSeparator;
end;

{ Добавляем значения байтов состояния с расшифровкой битов }

procedure TfmIBMPrinter.AddStatusBits;
var
  Value: Integer;
begin
  // Status Byte 1
  AddSeparator;
  Value := Driver.IBMStatusByte1;
  Memo.Lines.Add(GetStatusByteText(1, Value));
  AddBitText(Value, 1, 0, 'Command complete');
  AddBitText(Value, 1, 1, 'Cash receipt right home position');
  AddBitText(Value, 1, 2, 'Left home position');
  AddBitText(Value, 1, 3, 'Document right home position');
  AddBitText(Value, 1, 4, 'Reserved. Always 0');
  AddBitText(Value, 1, 5, 'Ribbon cover open');
  AddBitText(Value, 1, 6, 'Cash receipt print error');
  AddBitText(Value, 1, 7, 'Command reject');
  // Status Byte 2
  AddSeparator;
  Value := Driver.IBMStatusByte2;
  Memo.Lines.Add(GetStatusByteText(2, Value));
  AddBitText(Value, 2, 0, 'Document ready');
  AddBitText(Value, 2, 1, 'Document present under the front sensor');
  AddBitText(Value, 2, 2, 'Document present under the top sensor');
  AddBitText(Value, 2, 3, 'Reserved. Always equals 1');
  AddBitText(Value, 2, 4, 'Print buffer held');
  AddBitText(Value, 2, 5, 'Open throat position');
  AddBitText(Value, 2, 6, 'Buffer empty');
  AddBitText(Value, 2, 7, 'Buffer Full');
  // Status Byte 3
  AddSeparator;
  Value := Driver.IBMStatusByte3;
  Memo.Lines.Add(GetStatusByteText(3, Value));
  AddBitText(Value, 3, 0, 'Memory sector is full');
  AddBitText(Value, 3, 1, 'Home error');
  AddBitText(Value, 3, 2, 'Document error');
  AddBitText(Value, 3, 3, 'Flash EPROM load error or MCT load error');
  AddBitText(Value, 3, 4, 'Reserved. Always equals 0');
  AddBitText(Value, 3, 5, 'User flash storage sector is full');
  AddBitText(Value, 3, 6, 'Firmware error');
  AddBitText(Value, 3, 7, 'Command complete');
  // Status Byte 4
  AddSeparator;
  Value := Driver.IBMStatusByte4;
  Memo.Lines.Add(GetStatusByteText(4, Value));
  // Status Byte 5
  AddSeparator;
  Value := Driver.IBMStatusByte5;
  Memo.Lines.Add(GetStatusByteText(5, Value));
  AddBitText(Value, 5, 0, 'Printer ID Request Address command');
  AddBitText(Value, 5, 1, 'EC Level');
  AddBitText(Value, 5, 2, 'MICR Read');
  AddBitText(Value, 5, 3, 'MCT Read');
  AddBitText(Value, 5, 4, 'User flash read');
  AddBitText(Value, 5, 5, 'Reserved. Defaults to 1');
  AddBitText(Value, 5, 6, 'Reserved');
  AddBitText(Value, 5, 7, 'Reserved');
  // Status Byte 6
  AddSeparator;
  Value := Driver.IBMStatusByte6;
  Memo.Lines.Add(GetStatusByteText(6, Value));
  Memo.Lines.Add('    Contains the current line count');
  // Status Byte 7
  AddSeparator;
  Value := Driver.IBMStatusByte7;
  Memo.Lines.Add(GetStatusByteText(7, Value));
  AddBitText(Value, 7, 0, 'Station selection low order bit');
  AddBitText(Value, 7, 1, 'Reserved');
  AddBitText(Value, 7, 2, 'Reserved');
  AddBitText(Value, 7, 3, 'Cash drawer status');
  AddBitText(Value, 7, 4, 'Print key pressed');
  AddBitText(Value, 7, 5, 'Reserved. Defaults to 1');
  AddBitText(Value, 7, 6, 'Station Selection high order bit');
  AddBitText(Value, 7, 7, 'Document feed error');
  // Status Byte 8
  AddSeparator;
  Value := Driver.IBMStatusByte8;
  Memo.Lines.Add(GetStatusByteText(8, Value));
  AddBitText(Value, 8, 0, 'Fiscal offline mode');
  AddBitText(Value, 8, 1, 'Fiscal offline mode');
  AddBitText(Value, 8, 2, 'Fiscal offline mode');
  AddBitText(Value, 8, 3, 'Reserved');
  AddBitText(Value, 8, 4, 'Reserved');
  AddBitText(Value, 8, 5, 'Reserved');
  AddBitText(Value, 8, 6, 'Reserved');
  AddBitText(Value, 8, 7, 'Reserved');
  AddSeparator;
end;

procedure TfmIBMPrinter.btnClearClick(Sender: TObject);
begin
  Memo.Lines.Clear;
end;

procedure TfmIBMPrinter.AddLine(const S1, S2: string);
var
  S: WideString;
begin
  S := Format('%-10s %s', [S1, S2]);
  Memo.Lines.Add(S);
end;

procedure TfmIBMPrinter.btnGetIBMStatusClick(Sender: TObject);
var
  S: WideString;
  Value: Integer;
  ResultCode: Integer;
  Hour, Min, Sec: Byte;
  Day, Month, Year: Byte;
begin
  EnableButtons(False);
  try
    Memo.Clear;
    ResultCode := Driver.GetIBMStatus;

    if ResultCode = 0 then
    begin
      with Memo do
      begin
        Lines.BeginUpdate;
        try
          AddLine(IntToStr(Driver.OperatorNumber), SOperatorNumber);
          AddLine(DateToStr(Driver.Date), SCurrentDate);
          AddLine(TimeToStr(Driver.Time), SCurrentTime);
          AddLine(IntToStr(Driver.SessionNumber), SSessionNumber);
          AddLine(IntToStr(Driver.IBMDocumentNumber), SDocumentNumber);
          AddLine(IntToStr(Driver.IBMLastSaleReceiptNumber), SSaleReceiptNumber);
          AddLine(IntToStr(Driver.IBMLastBuyReceiptNumber), SBuyReceiptNumber);
          AddLine(IntToStr(Driver.IBMLastReturnSaleReceiptNumber),
            SRetSaleReceiptNumber);
          AddLine(IntToStr(Driver.IBMLastReturnBuyReceiptNumber),
            SRetBuyReceiptNumber);
          // Day open date
          Day := Driver.IBMSessionDay;
          Month := Driver.IBMSessionMonth;
          Year := Driver.IBMSessionYear;
          S := Format('%.2d.%.2d.%.2d', [Day, Month, Year]);
          AddLine(S, SDayOpenDate);
          // Day open time
          Hour := Driver.IBMSessionHour;
          Min := Driver.IBMSessionMin;
          Sec := Driver.IBMSessionSec;
          S := Format('%.2d:%.2d:%.2d', [Hour, Min, Sec]);
          AddLine(S, SDayOpenTime);
          // Cash total
          AddLine(Driver.AmountToStr(Driver.Summ1), SCashTotal);
          // Status
          AddStatusBytes;
          // Flags
          Value := Driver.IBMFlags;
          Lines.Add(Format('%s: %d', [SFlags, Value]));
          AddBitText2(Value, 0, SFlagSerialized);
          AddBitText2(Value, 1, SFlagFiscalized);
          AddBitText2(Value, 2, SFlagActivated);
          AddBitText2(Value, 3, SFlagDayOpened);
          AddBitText2(Value, 4, SFlagDayExausted);
          // Status bits
          AddStatusBits;
        finally
          Lines.EndUpdate;
        end;
      end;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmIBMPrinter.btnGetShortIBMStatusClick(Sender: TObject);
var
  ResultCode: Integer;
begin
  EnableButtons(False);
  try
    Memo.Clear;
    ResultCode := Driver.GetShortIBMStatus;

    if ResultCode = 0 then
    begin
      with Memo do
      begin
        Lines.BeginUpdate;
        try
          Lines.Add(Format('%s: %d', [SOperatorNumber, Driver.OperatorNumber]));
          AddStatusBytes;
          Lines.Add(Format('%s: %d', [SFlags, Driver.IBMFlags]));
          AddBitText2(Driver.IBMFlags, 0, SPrintBufferEmpty);
          AddStatusBits;
        finally
          Lines.EndUpdate;
        end;
      end;
    end;
  finally
    EnableButtons(True);
  end;
end;

end.
