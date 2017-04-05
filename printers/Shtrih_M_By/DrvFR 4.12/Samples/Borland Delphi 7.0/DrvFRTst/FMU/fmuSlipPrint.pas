unit fmuSlipPrint;

interface

uses
  // VCL
  Classes, Controls, StdCtrls, ExtCtrls, Buttons,
  // This
  untPages, untDriver;

type
  { TfmSlipPrint }

  TfmSlipPrintEject = class(TPage)
    btnPrintSlipDocument: TBitBtn;
    chkIsClearUnfiscalInfo: TCheckBox;
    ComboBox1: TComboBox;
    lblInfoType: TLabel;
    btnEject: TButton;
    grpPrint: TGroupBox;
    grpEject: TGroupBox;
    cbEjectDirection: TComboBox;
    lblEjectDirection: TLabel;
    procedure btnPrintSlipDocumentClick(Sender: TObject);
    procedure btnEjectClick(Sender: TObject);
  public
    procedure UpdateObject; override;
  end;

implementation

{$R *.DFM}

{ TfmSlipPrint }

procedure TfmSlipPrintEject.UpdateObject;
begin
  Driver.InfoType := cbInfoType.ItemIndex;
  Driver.IsClearUnfiscalInfo := chkIsClearUnfiscalInfo.Checked;
end;

procedure TfmSlipPrintEject.btnPrintSlipDocumentClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    UpdateObject;
    Check(Driver.PrintSlipDocument);
    Driver.OperationBlockFirstString := 0;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipPrintEject.btnEjectClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    UpdateObject;
    Check(Driver.EjectSlipDocument);
  finally
    EnableButtons(True);
  end;
end;

end.
