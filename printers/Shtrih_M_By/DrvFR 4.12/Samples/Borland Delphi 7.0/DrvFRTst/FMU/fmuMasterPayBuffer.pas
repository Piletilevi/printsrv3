unit fmuMasterPayBuffer;

interface

uses
  // VCL
  Windows, Forms, ComCtrls, StdCtrls, Controls, Classes, SysUtils, Messages,
  Buttons, Dialogs, ExtCtrls,
  // This
  untPages, untUtil, untDriver, Spin;

type
  { TfmMasterPayBuffer }

  TfmMasterPayBuffer = class(TPage)
    btnMasterPayClearBuffer: TButton;
    lblText: TLabel;
    lblDataLength_: TLabel;
    lblDataLength: TLabel;
    Memo: TMemo;
    btnOpen: TBitBtn;
    btnClearMemo: TBitBtn;
    btnMasterPayCreateMac: TButton;
    Bevel1: TBevel;
    btnMasterPayAddText: TButton;
    lblBlockNumber: TLabel;
    lblMacValue: TLabel;
    edtMacValue: TEdit;
    lblOperatorNumber: TLabel;
    edtOperatorNumber: TEdit;
    lblBlockCount: TLabel;
    Bevel2: TBevel;
    OpenDialog: TOpenDialog;
    seBlockNumber: TSpinEdit;
    seBlockCount: TSpinEdit;
    procedure btnOpenClick(Sender: TObject);
    procedure btnClearMemoClick(Sender: TObject);
    procedure btnMasterPayAddTextClick(Sender: TObject);
    procedure btnMasterPayClearBufferClick(Sender: TObject);
    procedure btnMasterPayCreateMacClick(Sender: TObject);
  public
    procedure UpdatePage; override;
  end;

implementation

{$R *.DFM}

{ TfmMasterPayBuffer }

procedure TfmMasterPayBuffer.UpdatePage;
begin
  inherited UpdatePage;
  lblDataLength.Caption := IntToStr(Length(Memo.Lines.Text));
end;

procedure TfmMasterPayBuffer.btnOpenClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    Memo.Lines.LoadFromFile(OpenDialog.FileName);
    UpdatePage;
  end;
end;

procedure TfmMasterPayBuffer.btnClearMemoClick(Sender: TObject);
begin
  Memo.Clear;
  UpdatePage;
end;

procedure TfmMasterPayBuffer.btnMasterPayAddTextClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.TextBlock := Memo.Text;
    Driver.TextBlockNumber := seBlockNumber.Value;
    Check(Driver.MasterPayAddTextBlock);
    edtOperatorNumber.Text := IntToStr(Driver.OperatorNumber);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMasterPayBuffer.btnMasterPayClearBufferClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Check(Driver.MasterPayClearBuffer);
    edtOperatorNumber.Text := IntToStr(Driver.OperatorNumber);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmMasterPayBuffer.btnMasterPayCreateMacClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.TextBlockNumber := seBlockCount.Value;
    Check(Driver.MasterPayCreateMac);
    edtOperatorNumber.Text := IntToStr(Driver.OperatorNumber);
  finally
    EnableButtons(True);
  end;
end;

end.
