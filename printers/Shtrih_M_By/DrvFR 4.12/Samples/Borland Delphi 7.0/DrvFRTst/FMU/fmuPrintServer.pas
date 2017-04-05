unit fmuPrintServer;

interface

uses
  // VCL
  Windows, StdCtrls, ComCtrls, Controls, ExtCtrls, Graphics, Classes, SysUtils,
  Buttons,
  // This
  untPages, untUtil, CompName, untDriver, untTypes;

type
  { TfmPrintServer }

  TfmPrintServer = class(TPage)
    lblComputerName: TLabel;
    edtComputerName: TEdit;
    lblCOMNumber: TLabel;
    cbCOMNumber: TComboBox;
    btnServerConnect: TBitBtn;
    btnServerDisconnect: TBitBtn;
    btnLockPort: TBitBtn;
    btnAdminUnlockPort: TBitBtn;
    btnUnlockPort: TBitBtn;
    btnAdminUnlockPorts: TBitBtn;
    btnDeleteDriver: TBitBtn;
    btnCreateDriver: TBitBtn;
    btnComputerName: TBitBtn;
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure btnComputerNameClick(Sender: TObject);
    procedure btnServerConnectClick(Sender: TObject);
    procedure btnServerDisconnectClick(Sender: TObject);
    procedure btnLockPortClick(Sender: TObject);
    procedure btnUnlockPortClick(Sender: TObject);
    procedure btnAdminUnlockPortClick(Sender: TObject);
    procedure btnAdminUnlockPortsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCreateDriverClick(Sender: TObject);
    procedure btnDeleteDriverClick(Sender: TObject);
  private
    procedure FillComNumbers;
  public
    procedure Initialize;override;
  end;

implementation

{$R *.DFM}

function GetCompName: string;
var
  Size: DWORD;
  LocalMachine: array [0..MAX_COMPUTERNAME_LENGTH] of char;
begin
  Size := Sizeof(LocalMachine);
  if GetComputerName(LocalMachine, Size) then
    Result := LocalMachine else Result := '';
end;

{ TfmPrintServer }

procedure TfmPrintServer.btnConnectClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ComNumber := cbComNumber.ItemIndex + 1;
    Driver.Connect;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintServer.btnDisconnectClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.Disconnect;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintServer.btnComputerNameClick(Sender: TObject);
var
  ComputerName: string;
begin
  if BrowseComputer(Handle, ComputerName, SEnterComputerName, -1) then
    edtComputerName.Text := ComputerName;
end;

procedure TfmPrintServer.btnServerConnectClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ComputerName := edtComputerName.Text;
    Driver.ServerConnect;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintServer.btnServerDisconnectClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ServerDisconnect;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintServer.btnLockPortClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ComNumber := cbComNumber.ItemIndex + 1;
    Driver.LockPort;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintServer.btnUnlockPortClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.UnlockPort;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintServer.btnAdminUnlockPortClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.AdminUnlockPort;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintServer.btnAdminUnlockPortsClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.AdminUnlockPorts;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmPrintServer.FormShow(Sender: TObject);
begin
  if DriverExists then
  begin
    cbComNumber.ItemIndex := Driver.ComNumber-1;
    edtComputerName.Text := Driver.ComputerName;
  end;
end;

procedure TfmPrintServer.btnCreateDriverClick(Sender: TObject);
begin
  Driver.ControlInterface;
end;

procedure TfmPrintServer.btnDeleteDriverClick(Sender: TObject);
begin
  FreeDriver;
end;

procedure TfmPrintServer.FillComNumbers;
var
  i: Integer;
begin
  cbCOMNumber.Clear;
  for i := 1 to 256 do
    cbCOMNumber.AddItem('COM' + IntToStr(i), TObject(i));
end;

procedure TfmPrintServer.Initialize;
begin
  FillComNumbers;
end;

end.
