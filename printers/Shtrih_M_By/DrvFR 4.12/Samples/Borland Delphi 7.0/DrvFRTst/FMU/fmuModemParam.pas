unit fmuModemParam;

interface

uses
  // VCL
  StdCtrls, Controls, Classes, SysUtils, ExtCtrls, Buttons, Graphics, Spin,
  // This
  untPages, untDriver;

type
  { TfmModemParam }

  TfmModemParam = class(TPage)
    lblParameterValue: TLabel;
    btnReadModemParameter: TBitBtn;
    btnWriteModemParameter: TBitBtn;
    lblParameterNumber: TLabel;
    seParameterNumber: TSpinEdit;
    memParameterValue: TMemo;
    lblCharCount: TLabel;
    procedure btnReadModemParameterClick(Sender: TObject);
    procedure btnWriteModemParameterClick(Sender: TObject);
    procedure memParameterValueChange(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmModemParam }

procedure TfmModemParam.btnReadModemParameterClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    memParameterValue.Clear;
    Driver.ParameterNumber := seParameterNumber.Value;
    Driver.ReadModemParameter;
    memParameterValue.Text := Driver.ParameterValue;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmModemParam.btnWriteModemParameterClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ParameterNumber := seParameterNumber.Value;
    Driver.ParameterValue := memParameterValue.Text;
    Driver.WriteModemParameter;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmModemParam.memParameterValueChange(Sender: TObject);
begin
  lblCharCount.Caption := 'Количество символов: ' +
    IntToStr(Length(memParameterValue.Text));
end;

end.
