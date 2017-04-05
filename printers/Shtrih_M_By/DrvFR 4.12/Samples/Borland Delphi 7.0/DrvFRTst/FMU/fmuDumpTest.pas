unit fmuDumpTest;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  // This
  untPages, untDriver, untUtil;

type
  TfmDumpTest = class(TPage)
    btnReadDump: TButton;
    Memo: TMemo;
    procedure btnReadDumpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDumpTest: TfmDumpTest;

implementation

{$R *.dfm}

procedure TfmDumpTest.btnReadDumpClick(Sender: TObject);
var
  DataBlock: string;
  DataBlockLength: Integer;
begin
  Memo.Clear;
  EnableButtons(False);
  try
    Driver.DeviceCode := 1;
    Check(Driver.DampRequest);
    Check(Driver.GetData);
    DataBlock := Driver.DataBlock;
    DataBlockLength := Length(DataBlock);
    Driver.InterruptDataStream;

    Memo.Lines.Add('DataBlockLength: ' + IntToStr(DataBlockLength));
    Memo.Lines.Add('DataBlockHex: ' + StrToHex(DataBlock));
  finally
    EnableButtons(True);
  end;
end;

end.
