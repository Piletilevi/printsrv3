unit fmuCashDrawer;

interface

uses
  // VCL
  StdCtrls, Controls, Classes, SysUtils, ExtCtrls, Buttons, Graphics,
  // This
  untPages, CompName, untUtil, untDriver, Spin;

type
  { TfmCashDrawer }

  TfmCashDrawer = class(TPage)
    lblDrawer: TLabel;
    btnOpenDrawer: TButton;
    seDrawer: TSpinEdit;
    procedure btnOpenDrawerClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmCashDrawer }

procedure TfmCashDrawer.btnOpenDrawerClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.DrawerNumber := seDrawer.Value;
    Driver.OpenDrawer;
  finally
    EnableButtons(True);
  end;
end;

end.
