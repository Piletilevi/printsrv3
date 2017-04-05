unit fmuReadDump;

interface

uses
  // VCL
  Windows, ComCtrls, StdCtrls, Controls, Classes, SysUtils, Forms, ExtCtrls,
  Buttons, Graphics, Dialogs,
  // This
  untPages, untUtil, fmuDump, untDriver, untTypes;

type
  { TfmReadDump }

  TfmReadDump = class(TPage)
    lblDeviceCode: TLabel;
    cbDeviceCode: TComboBox;
    grpBlockRequest: TGroupBox;
    lblData: TLabel;
    lblBlockNumber: TLabel;
    lblBlockCount: TLabel;
    btnDampRequest: TButton;
    Memo: TMemo;
    edtBlockCount: TEdit;
    edtBlockNumber: TEdit;
    btnGetData: TBitBtn;
    btnInterruptDataStream: TBitBtn;
    grpAllBlocks: TGroupBox;
    btnStart: TBitBtn;
    btnStop: TBitBtn;
    btnViewData: TBitBtn;
    ProgressBar: TProgressBar;
    lblCount: TLabel;
    dlgSave: TSaveDialog;
    btnSaveDump: TBitBtn;
    procedure btnDampRequestClick(Sender: TObject);
    procedure btnGetDataClick(Sender: TObject);
    procedure btnInterruptDataStreamClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnViewDataClick(Sender: TObject);
    procedure btnSaveDumpClick(Sender: TObject);
  private
    FDump: string;
    FCount: Integer;
    FStopFlag: Boolean;
    procedure ReadData;
  public  
    procedure Initialize; override;
  end;

implementation

uses fmuMain;

{$R *.DFM}

{ TfmReadDump }

procedure TfmReadDump.ReadData;
var
  S: WideString;
  i: Integer;
  ResultCode: Integer;
  ResultCodeDescription: WideString;
begin
  try
    FDump := '';
    ResultCode := 0;
    FStopFlag := False;
    btnStop.Enabled := True;
    ProgressBar.Max := FCount;
    ProgressBar.Position := 0;
    ProgressBar.Visible := True;
    lblCount.Visible := True;

    for i := 1 to FCount do
    begin
      if FStopFlag then Break;
      ResultCode := Driver.GetData;
      if ResultCode = 0 then
      begin
        FDump := FDump + Driver.DataBlock;
        ProgressBar.Position := i;
        lblCount.Caption := Format(SBlockNumber, [i]);
      end else
      begin
        ResultCode := Driver.ResultCode;
        ResultCodeDescription := Driver.ResultCodeDescription;
        S := Format(SContinueAfterError, [ResultCode, ResultCodeDescription]);
        if MessageBoxW(Handle, PWideChar(S), PWideChar(WideString(Application.Title)),
          MB_ICONEXCLAMATION or MB_OKCANCEL) = ID_CANCEL then Break;
      end;
      Application.ProcessMessages;
    end;
    if ResultCode = 0 then Driver.InterruptDataStream;
    btnStart.Enabled := True;
    btnStop.Enabled := False;
    ProgressBar.Visible := False;
    lblCount.Visible := False;
  except
    on E: Exception do Application.ShowException(E);
  end;
end;

procedure TfmReadDump.btnDampRequestClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.DeviceCode := Integer(cbDeviceCode.Items.Objects[cbDeviceCode.ItemIndex]);
    if Driver.DampRequest = 0 then
      edtBlockCount.Text := IntToStr(Driver.DataBlockNumber)
    else
      edtBlockCount.Clear;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmReadDump.btnGetDataClick(Sender: TObject);
var
  Index: Integer;
begin
  Memo.Clear;
  EnableButtons(False);
  try
    if Driver.GetData = 0 then
    begin
      edtBlockNumber.Text := IntToStr(Driver.DataBlockNumber);
      Index := 1;
      repeat
        Memo.Lines.Add(StrToHex(Copy(Driver.DataBlock, Index, 16)));
        Index := Index +16;
      until Index > Length(Driver.DataBlock);
    end else
    begin
      edtBlockNumber.Clear;
    end;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmReadDump.btnInterruptDataStreamClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.InterruptDataStream;
  finally
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmReadDump.btnStartClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Driver.DeviceCode := Integer(cbDeviceCode.Items.Objects[cbDeviceCode.ItemIndex]);
    if Driver.DampRequest = 0 then
    begin
      FCount := Driver.DataBlockNumber;
      FStopFlag := False;
      ReadData;
    end;
  finally
    TfmMain(Owner).SetPage(Self); { !!! }
    EnableButtons(True);
    btnStop.Enabled := False;
  end;
end;

procedure TfmReadDump.btnStopClick(Sender: TObject);
begin
  FStopFlag := True;
  EnableButtons(True);
  btnStop.Enabled := False;
  ProgressBar.Visible := False;
end;

procedure TfmReadDump.btnViewDataClick(Sender: TObject);
var
  DeviceRec: TDeviceRec;
begin
  DeviceRec.Code := Driver.DeviceCode;
  DeviceRec.Description := Driver.DeviceCodeDescription;
  ShowDumpDlg(Self, FDump, DeviceRec);
end;

procedure TfmReadDump.btnSaveDumpClick(Sender: TObject);
var
  Stream: TFileStream;
begin
  if not dlgSave.Execute then Exit;
  Stream := TFileStream.Create(dlgSave.FileName, fmCreate);
  try
    Stream.Write(FDump[1], Length(FDump));
  finally
    Stream.Free;
  end;
end;


procedure TfmReadDump.Initialize;
resourcestring
  SCheckFM = '00h Стационарная проверка ФП';
  SFM1 = '01h Накопитель ФП1';
  SFM2 = '02h Накопитель ФП2';
  SClock = '03h Часы';
  SEEPROM = '04h Энергонезависимая память';
  SFMCPU = '05h Процессор ФП / Память программ ФП';
  SPrgMemory = '06h Память программ';
  SRAM = '07h Оперативная память';
  SFSImage = '08h Образ файловой системы';
  SuLinuxImage = '09h Образ uLinux';
  SEXEFile = '0Ah Исполняемый файл ПО';
  SCashCorePrgMemory = '86h Память программ КЯ';

begin
  cbDeviceCode.Clear;
  cbDeviceCode.AddItem(SCheckFM, TObject(0));
  cbDeviceCode.AddItem(SFM1, TObject(1));
  cbDeviceCode.AddItem(SFM2, TObject(2));
  cbDeviceCode.AddItem(SClock, TObject(3));
  cbDeviceCode.AddItem(SEEPROM, TObject(4));
  cbDeviceCode.AddItem(SFMCPU, TObject(5));
  cbDeviceCode.AddItem(SPrgMemory, TObject(6));
  cbDeviceCode.AddItem(SRAM, TObject(7));
  cbDeviceCode.AddItem(SFSImage, TObject(8));
  cbDeviceCode.AddItem(SuLinuxImage, TObject(9));
  cbDeviceCode.AddItem(SEXEFile, TObject(10));
  cbDeviceCode.AddItem(SCashCorePrgMemory, TObject($86));
  cbDeviceCode.ItemIndex := 0;
end;

end.
