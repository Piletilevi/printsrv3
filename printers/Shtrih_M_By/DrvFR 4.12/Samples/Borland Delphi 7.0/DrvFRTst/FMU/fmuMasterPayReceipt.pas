unit fmuMasterPayReceipt;

interface

uses
  // VCL
  Windows, Forms, ComCtrls, StdCtrls, Controls, Classes, SysUtils, Messages,
  Buttons, Dialogs,
  // This
  untPages, untUtil, untDriver, untTypes;

type
  { TfmMasterPayK }

  TfmMasterPayReceipt = class(TPage)
    Memo: TMemo;
    btnReadLastReceipt: TButton;
    btnReadLastReceiptLine: TButton;
    btnReadLastReceiptMac: TButton;
    btnReadReceipt: TButton;
    btnSave: TBitBtn;
    SaveDialog: TSaveDialog;
    chbSaveReceipt: TCheckBox;
    Label1: TLabel;
    procedure btnReadLastReceiptClick(Sender: TObject);
    procedure btnReadLastReceiptLineClick(Sender: TObject);
    procedure btnReadLastReceiptMacClick(Sender: TObject);
    procedure btnReadReceiptClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    function GetReceiptFileName: string;
    procedure SaveReceipt(const Text: string);
  end;

implementation

{$R *.DFM}

{ TfmMasterPayK }

procedure TfmMasterPayReceipt.btnReadLastReceiptClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    if Driver.ReadLastReceipt = 0 then
    begin
      Memo.Lines.Add(Format(' %s: %d', [SOperatorNumber, Driver.OperatorNumber]));
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMasterPayReceipt.btnReadLastReceiptLineClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    if Driver.ReadLastReceiptLine = 0 then
    begin
      Memo.Lines.Add(Format(' %s: %d', [SOperatorNumber, Driver.OperatorNumber]));
      Memo.Lines.Add(Format(' %s: %s', [SData, Driver.LineData]));
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMasterPayReceipt.btnReadLastReceiptMacClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    if Driver.ReadLastReceiptMac = 0 then
    begin
      Memo.Lines.Add(Format(' %s: %d', [SOperatorNumber, Driver.OperatorNumber]));
      Memo.Lines.Add(Format(' %s: %d', [SMacNumber, Driver.KPKNumber]));
    end;
  finally
    EnableButtons(True);
  end;
end;

function TfmMasterPayReceipt.GetReceiptFileName: string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) +
    'Receipt.txt';
end;

procedure TfmMasterPayReceipt.SaveReceipt(const Text: string);
var
  Mode: Integer;
  Stream: TFileStream;
begin
  if Length(Text) = 0 then Exit;

  Mode := fmCreate;
  if FileExists(GetReceiptFileName) then Mode := fmOpenReadWrite;
  Mode := Mode + fmShareDenyWrite;
  Stream := TFileStream.Create(GetReceiptFileName, Mode);
  try
    Stream.Seek(0, soFromEnd);
    Stream.Write(Text[1], Length(Text));
  finally
    Stream.Free;
  end;
end;

procedure TfmMasterPayReceipt.btnReadReceiptClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    if Driver.ReadLastReceipt = 0 then
    begin
      while True do
      begin
        if Driver.ReadLastReceiptLine <> 0 then Break;
        Memo.Lines.Add(Driver.LineData);
      end;
    end;
    if chbSaveReceipt.Checked then
      SaveReceipt(Memo.Lines.Text);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMasterPayReceipt.btnSaveClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    Memo.Lines.SaveToFile(SaveDialog.FileName);
end;

end.
