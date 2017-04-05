unit fmuCashControl;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, WinSock, ExtCtrls, Buttons,
  // This
  untPages, WSockets, untUtil;

type
  { TfmCashControl }

  TfmCashControl = class(TPage)
    Memo: TMemo;
    lblProtocol: TLabel;
    rbTCP: TRadioButton;
    rbUDP: TRadioButton;
    lblPort: TLabel;
    edtPort: TEdit;
    btnOpenPort: TBitBtn;
    btnClosePort: TBitBtn;
    btnClear: TBitBtn;
    btnSaveData: TBitBtn;
    SaveDialog: TSaveDialog;
    chbShowData: TCheckBox;
    lblLineCount_: TLabel;
    lblLineCount: TLabel;
    chbCP866: TCheckBox;
    procedure btnOpenPortClick(Sender: TObject);
    procedure btnClosePortClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnSaveDataClick(Sender: TObject);
  private
    FLineCount: Integer;
    FUDPServer: TUDPServer;
    FTCPServer: TTCPServer;

    procedure ServerData(Sender: TObject; Socket: TSocket);
    property UDPServer: TUDPServer read FUDPServer;
    property TCPServer: TTCPServer read FTCPServer;
    function GetLineData(const Data: string): string;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  fmCashControl: TfmCashControl;

implementation

{$R *.DFM}

{ TfmCashControl }

constructor TfmCashControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FUDPServer := TUDPServer.Create(Self);
  FTCPServer := TTCPServer.Create(Self);
  FUDPServer.OnData := ServerData;
  FTCPServer.OnData := ServerData;
end;

function TfmCashControl.GetLineData(const Data: string): string;
begin
  Result := Data;
  if chbCP866.Checked then
    Result := Str866To1251(Data);
end;

procedure TfmCashControl.ServerData(Sender: TObject; Socket: TSocket);
var
  Data: string;
  Lines: TStrings;
  SockAddrIn: TSockAddrIn;
begin
  if Sender is TTCPServer then
  begin
    Data := (Sender as TTCPServer).Read(Socket);
  end else
  begin
    Data := (Sender as TUDPServer).Read(Socket, SockAddrIn);
  end;
  if chbShowData.Checked then
  begin
    Memo.Lines.Text := Memo.Lines.Text + GetLineData(Data);
  end;
  Lines := TStringList.Create;
  try
    Lines.Text := GetLineData(Data);
    FLineCount := FLineCount + Lines.Count;
    lblLineCount.Caption := IntToStr(FLineCount);
  finally
    Lines.Free;
  end;
end;

procedure TfmCashControl.btnOpenPortClick(Sender: TObject);
begin
  FLineCount := 0;
  if rbTCP.Checked then
  begin
    TCPServer.Close;
    TCPServer.Port := edtPort.Text;
    TCPServer.Open;
  end else
  begin
    UDPServer.Close;
    UDPServer.Port := edtPort.Text;
    UDPServer.Open;
  end;

  btnOpenPort.Enabled := False;
  btnClosePort.Enabled := True;
  btnClosePort.SetFocus;
end;

procedure TfmCashControl.btnClosePortClick(Sender: TObject);
begin
  UDPServer.Close;
  TCPServer.Close;

  btnClosePort.Enabled := False;
  btnOpenPort.Enabled := True;
  btnOpenPort.SetFocus;
end;

procedure TfmCashControl.btnClearClick(Sender: TObject);
begin
  Memo.Lines.Clear;
end;

procedure TfmCashControl.btnSaveDataClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    Memo.Lines.SaveToFile(SaveDialog.FileName);
end;

end.
