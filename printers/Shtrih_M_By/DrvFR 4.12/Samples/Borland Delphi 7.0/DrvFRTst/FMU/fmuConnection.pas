unit fmuConnection;

interface

uses
  // VCL
  Windows, StdCtrls, ComCtrls, Controls, ExtCtrls, Graphics, Classes, SysUtils,
  Buttons, Spin,
  // This
  CompName, untPages, untUtil, untDriver;

type
  { TfmConnect }

  TfmConnection = class(TPage)
    btnConnect: TBitBtn;
    btnDisconnect: TBitBtn;
    btnGetExchangeParam: TBitBtn;
    btnSetExchangeParam: TBitBtn;
    gbParams: TGroupBox;
    lblCOMNumber: TLabel;
    lblBaudRate: TLabel;
    lblTimeout: TLabel;
    lblPortNumber: TLabel;
    cbCOMNumber: TComboBox;
    cbBaudRate: TComboBox;
    seTimeout: TSpinEdit;
    chkConnected: TCheckBox;
    btnWaitConnection: TButton;
    lblConnectionTimeout: TLabel;
    seConnectionTimeout: TSpinEdit;
    btnWaitForPrinting: TButton;
    btnWaitForCheckClose: TButton;
    cbPortNumber: TComboBox;
    lblTCPPort: TLabel;
    edtTCPPortReal: TEdit;
    lblTcpPortReal: TLabel;
    seTCPPortCode: TSpinEdit;
    procedure btnGetExchangeParamClick(Sender: TObject);
    procedure btnSetExchangeParamClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure btnAdminUnlockPortClick(Sender: TObject);
    procedure btnAdminUnlockPortsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkConnectedClick(Sender: TObject);
    procedure btnWaitConnectionClick(Sender: TObject);
    procedure btnWaitForPrintingClick(Sender: TObject);
    procedure btnWaitForCheckCloseClick(Sender: TObject);
    procedure edtTCPPortCodeChange(Sender: TObject);
    procedure cbPortNumberChange(Sender: TObject);
  private
    procedure FillComNumbers;
    procedure FillPortNumbers;    
  public
    procedure UpdatePage; override;
    procedure Initialize; override;
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

{ TfmConnect }

procedure TfmConnection.btnGetExchangeParamClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.PortNumber :=  Integer(cbPortNumber.Items.Objects[cbPortNumber.ItemIndex]);
    if Driver.GetExchangeParam = 0 then
    begin
      seTimeout.Value := Driver.Timeout;
      cbBaudRate.ItemIndex := Driver.BaudRate;
      seTCPPortCode.Value := EncodeTCPPort(Driver.TCPPort);
    end;
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.btnSetExchangeParamClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.Timeout := seTimeout.Value;
    Driver.BaudRate := cbBaudRate.ItemIndex;
    Driver.TCPPort := DecodeTCPPort(seTCPPortCode.Value);
    Driver.PortNumber := Integer(cbPortNumber.Items.Objects[cbPortNumber.ItemIndex]);
    Driver.SetExchangeParam;
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.btnConnectClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ComNumber := cbCOMNumber.ItemIndex + 1;
    Driver.BaudRate := cbBaudRate.ItemIndex;
    Driver.Timeout := seTimeout.Value;
    Driver.TCPPort := DecodeTCPPort(seTCPPortCode.Value);
    Driver.Connect;
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.btnDisconnectClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.Disconnect;
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.btnAdminUnlockPortClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.AdminUnlockPort;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.btnAdminUnlockPortsClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.AdminUnlockPorts;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.FormShow(Sender: TObject);
begin
  if DriverExists then
  begin
    seTimeout.Value := Driver.Timeout;
    cbBaudRate.ItemIndex := Driver.BaudRate;
    cbCOMNumber.ItemIndex := Driver.ComNumber-1;
    edtTCPPortReal.Text := IntToStr(Driver.TCPPort);
    seTCPPortCode.Value := EncodeTCPPort(Driver.TCPPort);
    seConnectionTimeout.Value := Driver.ConnectionTimeout;
  end;
end;

procedure TfmConnection.chkConnectedClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.Connected := chkConnected.Checked;
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.UpdatePage;
begin
  if DriverExists then
  begin
    chkConnected.Checked := Driver.Connected;
  end;
end;

procedure TfmConnection.btnWaitConnectionClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ConnectionTimeout := seConnectionTimeout.Value;
    Driver.WaitConnection;
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.btnWaitForPrintingClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ConnectionTimeout := seConnectionTimeout.Value;
    Driver.WaitForPrinting;
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.btnWaitForCheckCloseClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.ConnectionTimeout := seConnectionTimeout.Value;
    Driver.WaitForCheckClose;
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmConnection.FillComNumbers;
var
  i: Integer;
begin
  cbCOMNumber.Clear;
  for i := 1 to 256 do
    cbCOMNumber.AddItem('COM' + IntToStr(i), TObject(i));
end;

procedure TfmConnection.Initialize;
begin
  FillComNumbers;
  FillPortNumbers;
end;

procedure TfmConnection.FillPortNumbers;
resourcestring
  SRS232 = 'RS-232';
  SUSB = 'USB';
  SBluetooth = 'Bluetooth';
  SWiFi = 'WiFi';
  STCPSocket = 'TCP socket';
begin
  cbPortNumber.Clear;
  cbPortNumber.AddItem(SRS232, TObject(0));
  cbPortNumber.AddItem(SBluetooth, TObject(1));
  cbPortNumber.AddItem(SUSB, TObject(2));
  cbPortNumber.AddItem(SWiFi, TObject(3));
  cbPortNumber.AddItem(STCPSocket, TObject(128));
  cbPortNumber.ItemIndex := 0;
  cbPortNumberChange(Self);
end;

procedure TfmConnection.edtTCPPortCodeChange(Sender: TObject);
begin
  edtTCPPortReal.Text := IntToStr(DecodeTCPPort(seTCPPortCode.Value));
end;

procedure TfmConnection.cbPortNumberChange(Sender: TObject);
var
  Enabled: Boolean;
begin
  Enabled := Integer(cbPortNumber.Items.Objects[cbPortNumber.ItemIndex]) = 128;
  seTCPPortCode.Enabled := Enabled;
  edtTCPPortReal.Enabled := Enabled;
  lblTCPPort.Enabled := Enabled;
  lblTcpPortReal.Enabled := Enabled;
end;

end.
