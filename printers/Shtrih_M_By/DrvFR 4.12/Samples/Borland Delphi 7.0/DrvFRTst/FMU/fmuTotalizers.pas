unit fmuTotalizers;

interface

uses
    // VCL
  Windows, ComCtrls, StdCtrls, Controls, Classes, SysUtils, Forms, ExtCtrls,
  Graphics, Grids, Spin, 
  // This
  untPages, untUtil, untDriver;

type
  { TfmTotalizers }

  TfmTotalizers = class(TPage)
    lblRegisterNumber: TLabel;
    lblNameOperationReg: TLabel;
    edtRegName: TEdit;
    lblContents: TLabel;
    edtRegContent: TEdit;
    btnGetOperationReg: TButton;
    btnGetCashReg: TButton;
    seRegisterNumber: TSpinEdit;
    btnGetCashRegEx: TButton;
    procedure btnGetOperationRegClick(Sender: TObject);
    procedure btnGetCashRegClick(Sender: TObject);
    procedure btnGetCashRegExClick(Sender: TObject);
  end;

implementation

{$R *.DFM}

{ TfmTotalizers }

procedure TfmTotalizers.btnGetOperationRegClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.RegisterNumber := seRegisterNumber.Value;
    if Driver.GetOperationReg = 0 then
    begin
      edtRegName.Text := Driver.NameOperationReg;
      edtRegContent.Text := Driver.AmountToStr(Driver.ContentsOfOperationRegister);
    end else
    begin
      edtRegName.Clear;
      edtRegContent.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmTotalizers.btnGetCashRegClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.RegisterNumber := seRegisterNumber.Value;
    if Driver.GetCashReg = 0 then
    begin
      edtRegName.Text := Driver.NameCashReg;
      edtRegContent.Text := Driver.AmountToStr(Driver.ContentsOfCashRegister);
    end else
    begin
      edtRegName.Clear;
      edtRegContent.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmTotalizers.btnGetCashRegExClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.RegisterNumber := seRegisterNumber.Value;
    if Driver.GetCashRegEx = 0 then
    begin
      edtRegName.Text := Driver.NameCashReg;
      edtRegContent.Text := Driver.AmountToStr(Driver.ContentsOfCashRegister);
    end else
    begin
      edtRegName.Clear;
      edtRegContent.Clear;
    end;
  finally
    EnableButtons(True);
  end;
end;

end.
