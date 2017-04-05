unit fmuMasterPayText;

interface

uses
  // VCL
  Windows, Forms, ComCtrls, StdCtrls, Controls, Classes, SysUtils, Messages,
  Buttons, Dialogs,
  // This
  untPages, untUtil, untDriver;

type
  { TfmMasterPayK }

  TfmMasterPayText = class(TPage)
    Memo: TMemo;
    btnCreateMac: TButton;
    lblText: TLabel;
    btnOpen: TBitBtn;
    OpenDialog: TOpenDialog;
    btnClearMemo: TBitBtn;
    lblMacValue: TLabel;
    edtMacValue: TEdit;
    lblDataLength_: TLabel;
    lblDataLength: TLabel;
    procedure btnCreateMacClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnClearMemoClick(Sender: TObject);
    procedure MemoChange(Sender: TObject);
  public
    procedure UpdatePage; override;
  end;

implementation

{$R *.DFM}

{ TfmMasterPayK }

procedure TfmMasterPayText.UpdatePage;
begin
  inherited UpdatePage;
  lblDataLength.Caption := IntToStr(Length(Memo.Lines.Text));
end;

procedure TfmMasterPayText.btnOpenClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    Memo.Lines.LoadFromFile(OpenDialog.FileName);
  end;
end;

procedure TfmMasterPayText.btnClearMemoClick(Sender: TObject);
begin
  Memo.Clear;
  UpdatePage;
end;

procedure TfmMasterPayText.btnCreateMacClick(Sender: TObject);
const
  BlockSize = 245;
var
  i: Integer;
  Data: WideString;
  BlockCount: Integer;
begin
  EnableButtons(False);
  try
    edtMacValue.Clear;
    Data := Memo.Text;
    Check(Driver.MasterPayClearBuffer);
    BlockCount := (Length(Data) + BlockSize -1) div BlockSize;
    for i := 0 to BlockCount-1 do
    begin
      Driver.TextBlockNumber := i;
      Driver.TextBlock := Copy(Data, BlockSize*i + 1, BlockSize);
      Check(Driver.MasterPayAddTextBlock);
    end;
    Driver.TextBlockNumber := BlockCount;
    Check(Driver.MasterPayCreateMac);
    edtMacValue.Text := IntToStr(Driver.KPKNumber);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMasterPayText.MemoChange(Sender: TObject);
begin
  UpdatePage;
end;

end.
