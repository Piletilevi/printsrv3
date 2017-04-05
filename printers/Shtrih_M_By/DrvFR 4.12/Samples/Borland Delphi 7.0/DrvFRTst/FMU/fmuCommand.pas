unit fmuCommand;

interface

uses
  // VCL
  Windows, Classes, SysUtils, StdCtrls, ComCtrls, Controls, ExtCtrls, Graphics,
  Buttons,
  // This
  untPages, untDriver, DrvFRLib_TLB;

type
  { TfmConnect }

  TfmCommand = class(TPage)
    btnSend: TBitBtn;
    lblTxData: TLabel;
    edtTxData: TEdit;
    lblRxData: TLabel;
    edtRxData: TEdit;
    procedure btnSendClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

procedure TfmCommand.btnSendClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.BinaryConversion := BINARY_CONVERSION_HEX;
    Driver.TransferBytes := edtTxData.Text;
    Driver.ExchangeBytes;
    edtRxData.Text := Driver.TransferBytes;
  finally
    EnableButtons(True);
  end;
end;

end.
