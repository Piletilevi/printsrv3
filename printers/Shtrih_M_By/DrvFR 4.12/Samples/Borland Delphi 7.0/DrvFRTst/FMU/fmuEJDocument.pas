unit fmuEJDocument;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Spin,
  // This
  untPages, untDriver, untTypes;

type
  { TfmEJDocument }

  TfmEJDocument = class(TPage)
    lblKPKNumber: TLabel;
    Memo: TMemo;
    btnGetEKLZDocument: TBitBtn;
    btnStop: TBitBtn;
    btnReadEKLZDocument: TButton;
    seKPKNumber: TSpinEdit;
    procedure btnGetEKLZDocumentClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnReadEKLZDocumentClick(Sender: TObject);
  private
    FStopFlag: Boolean;
    procedure GetEKLZData;
    procedure Check2(ResultCode: Integer);
  end;

implementation

{$R *.DFM}

{ TfmEJDocument }

procedure TfmEJDocument.Check2(ResultCode: Integer);
begin
  if ResultCode <> 0 then
  begin
    if ResultCode = $A9 then
      Driver.ClearResult;

    Abort;
  end;
end;

procedure TfmEJDocument.btnGetEKLZDocumentClick(Sender: TObject);
begin
  FStopFlag := False;
  EnableButtons(False);
  btnStop.Enabled := True;
  try
    Memo.Clear;
    Driver.KPKNumber := seKPKNumber.Value;
    Check(Driver.GetEKLZDocument);
    GetEKLZData;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmEJDocument.GetEKLZData;
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

procedure TfmEJDocument.btnStopClick(Sender: TObject);
begin
  FStopFlag := True;
end;

procedure TfmEJDocument.btnReadEKLZDocumentClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.KPKNumber := seKPKNumber.Value;
    Driver.ReadEKLZDocumentOnKPK;
  finally
    EnableButtons(True);
  end;
end;

end.
