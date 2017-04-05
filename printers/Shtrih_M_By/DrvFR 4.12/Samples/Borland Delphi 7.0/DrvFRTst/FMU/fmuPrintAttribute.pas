unit fmuPrintAttribute;

interface

uses
  // VCL
  Windows, StdCtrls, Controls, Classes, SysUtils, ExtCtrls, Graphics, Dialogs,
  Spin,
  // This
  untPages, untUtil, untDriver;

type
  { TfmPrintAttribute }

  TfmPrintAttribute = class(TPage)
    btnPrintAttribute: TButton;
    lblAttrinuteNumber: TLabel;
    lblAttributeValue: TLabel;
    btnPrintAttributes: TButton;
    seAttributeNumber: TSpinEdit;
    memAttribute: TMemo;
    procedure btnPrintAttributeClick(Sender: TObject);
    procedure btnPrintAttributesClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmPrintAttribute }

procedure TfmPrintAttribute.btnPrintAttributeClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.AttributeNumber := seAttributeNumber.Value;
    Driver.AttributeValue := memAttribute.Text;
    Driver.PrintAttribute;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintAttribute.btnPrintAttributesClick(Sender: TObject);
var
  i: Integer;
begin
  EnableButtons(False);
  try
    for i := 0 to 255 do
    begin
      Driver.AttributeNumber := i;
      Driver.AttributeValue := ' ';
      Driver.PrintAttribute;
    end;
  finally
    EnableButtons(True);
  end;
end;

end.
