unit fmuLogicDevice;

interface

uses
  // VCL
  StdCtrls, Controls, Classes, SysUtils, ExtCtrls, Buttons, Graphics, Spin,
  // This
  untPages, CompName, untUtil, untDriver, untTypes;

type
  { TfmLogicDevice }

  TfmLogicDevice = class(TPage)
    lblLDIndex: TLabel;
    lblLDCount: TLabel;
    lblBaudRate: TLabel;
    lblComNumber: TLabel;
    lblLDNumber: TLabel;
    lblLDName: TLabel;
    edtLDName: TEdit;
    cbComNumber: TComboBox;
    cbBaudRate: TComboBox;
    edtLDCount: TEdit;
    lblTimeout: TLabel;
    lblComputer: TLabel;
    edtComputerName: TEdit;
    btnComputerName: TButton;
    btnAddLD: TBitBtn;
    btnDeleteLD: TBitBtn;
    btnSetParamLD: TBitBtn;
    btnGetParamLD: TBitBtn;
    btnSetActiveLD: TBitBtn;
    btnGetActiveLD: TBitBtn;
    btnGetCountLD: TBitBtn;
    btnEnumLD: TBitBtn;
    seLDIndex: TSpinEdit;
    seLDNumber: TSpinEdit;
    seTimeout: TSpinEdit;
    procedure btnAddLDClick(Sender: TObject);
    procedure btnDeleteLDClick(Sender: TObject);
    procedure btnGetCountLDClick(Sender: TObject);
    procedure btnEnumLDClick(Sender: TObject);
    procedure btnSetParamLDClick(Sender: TObject);
    procedure btnGetParamLDClick(Sender: TObject);
    procedure btnSetActiveLDClick(Sender: TObject);
    procedure btnGetActiveLDClick(Sender: TObject);
    procedure btnComputerNameClick(Sender: TObject);
  private
    procedure SetLDParams;
    procedure GetLDParams;
    procedure FillComNumbers;
  public
    procedure Initialize; override;
  end;

implementation

{$R *.DFM}

{ TfmLogicDevice }

procedure TfmLogicDevice.SetLDParams;
begin
  Driver.LDName := edtLDName.Text;
  Driver.LDBaudrate := cbBaudRate.ItemIndex;
  Driver.LDComNumber := cbComNumber.ItemIndex+1;
  Driver.LDComputerName := edtComputerName.Text;
  Driver.LDTimeout := seTimeout.Value;
end;

procedure TfmLogicDevice.GetLDParams;
begin
  edtLDName.Text := Driver.LDName;
  seLDNumber.Value := Driver.LDNumber;
  cbComNumber.ItemIndex := Driver.LDComNumber-1;
  cbBaudRate.ItemIndex := Driver.LDBaudrate;
  edtLDCount.Text := IntToStr(Driver.LDCount);
  seLDIndex.Value := Driver.LDIndex;
  edtComputerName.Text := Driver.LDComputerName;
  seTimeout.Value := Driver.LDTimeout;
end;

procedure TfmLogicDevice.btnAddLDClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    SetLDParams;
    Driver.AddLD;
    GetLDParams;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmLogicDevice.btnDeleteLDClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.LDNumber := seLDNumber.Value;
    Driver.DeleteLD;
    GetLDParams;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmLogicDevice.btnGetCountLDClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.GetCountLD;
    GetLDParams;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmLogicDevice.btnEnumLDClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.LDIndex := seLDIndex.Value;
    Driver.EnumLD;
    GetLDParams;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmLogicDevice.btnSetParamLDClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.LDNumber := seLDNumber.Value;
    SetLDParams;
    Driver.SetParamLD;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmLogicDevice.btnGetParamLDClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.LDNumber := seLDNumber.Value;
    Driver.GetParamLD;
    GetLDParams;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmLogicDevice.btnSetActiveLDClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.LDNumber := seLDNumber.Value;
    Driver.SetActiveLD;
    GetLDParams;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmLogicDevice.btnGetActiveLDClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.GetActiveLD;
    GetLDParams;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmLogicDevice.btnComputerNameClick(Sender: TObject);
var
  ComputerName: string;
begin
  if BrowseComputer(Handle, ComputerName, SEnterComputerName, -1) then
    edtComputerName.Text := ComputerName;
end;

procedure TfmLogicDevice.FillComNumbers;
var
  i: Integer;
begin
  cbCOMNumber.Clear;
  for i := 1 to 256 do
    cbCOMNumber.AddItem('COM' + IntToStr(i), TObject(i));
end;

procedure TfmLogicDevice.Initialize;
begin
  FillComNumbers;
end;

end.
