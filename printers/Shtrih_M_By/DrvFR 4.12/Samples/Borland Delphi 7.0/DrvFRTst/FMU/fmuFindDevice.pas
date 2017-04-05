unit fmuFindDevice;

interface

uses
  // VCL
  Windows, Forms, ComCtrls, StdCtrls, Controls, Classes, SysUtils, Messages,
  Buttons,
  // This
  untPages, untUtil, untDriver;

type
  { TfmFindDevice }

  TfmFindDevice = class(TPage)
    Memo: TMemo;
    btnRead: TBitBtn;
    procedure btnReadClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

resourcestring
  SDeviceFound = 'Устройство найдено.';
  SDeviceParams = 'Порт: COM%d, Скорость: %d';
  SDeviceNotFound = 'Устройство не найдено.';

function IntToBaudRate(Value: Integer): Integer;
begin
  case Value of
    0: Result := CBR_2400;
    1: Result := CBR_4800;
    2: Result := CBR_9600;
    3: Result := CBR_19200;
    4: Result := CBR_38400;
    5: Result := CBR_57600;
    6: Result := CBR_115200;
  else
    Result := CBR_4800;
  end;
end;

{ TfmFindDevice }

procedure TfmFindDevice.btnReadClick(Sender: TObject);
begin
  EnableButtons(False);
  Memo.Lines.BeginUpdate;
  try
    Memo.Clear;
    if Driver.FindDevice = 0 then
    begin
      Memo.Lines.Add(SDeviceFound);
      Memo.Lines.Add(Format(SDeviceParams, [Driver.ComNumber,
        IntToBaudRate(Driver.BaudRate)]))
    end else
      Memo.Lines.Add(SDeviceNotFound);
  finally
    Memo.Lines.EndUpdate;
    EnableButtons(True);
  end;
end;

end.
