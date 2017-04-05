unit fmuCashCore;

interface

uses
  // VCL
  StdCtrls, Controls, Classes, SysUtils, ExtCtrls, Buttons, Graphics,
  // This
  untPages, CompName, untUtil, untDriver, Spin;

type
  { TfmCashDrawer }

  TfmCashCore = class(TPage)
    lblDrawer: TLabel;
    btnOpenDrawer: TButton;
    edtErrorCode: TSpinEdit;
    edtErrorDescription: TEdit;
    lblErrorDescription: TLabel;
    procedure btnOpenDrawerClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmCashDrawer }

procedure TfmCashCore.btnOpenDrawerClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ErrorCode := edtErrorCode.Value;
    if Driver.ReadErrorDescription <> 0 then Exit;
    edtErrorDescription.Text := Driver.ErrorDescription;
  finally
    EnableButtons(True);
  end;
end;

end.
