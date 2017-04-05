unit fmuFullStatus;

interface

uses
  // VCL
  Windows, Forms, ComCtrls, StdCtrls, Controls, Classes, SysUtils, Messages,
  Buttons, Dialogs,
  // This
  untPages, untUtil, untDriver, untTypes, GlobalConst, PrinterTypes,
  DrvFRLib_TLB;

type
  { TfmFullStatus }

  TfmFullStatus = class(TPage)
    Memo: TMemo;
    btnFullEcrStatus: TButton;
    btnSaveToFile: TBitBtn;
    dlgSave: TSaveDialog;
    btnInterrupt: TButton;
    procedure btnFullEcrStatusClick(Sender: TObject);
    procedure btnSaveToFileClick(Sender: TObject);
    procedure btnInterruptClick(Sender: TObject);
  private
    FStopFlag: Boolean;
    procedure AddTables;
    procedure AddSeparator;
    procedure AddDeviceFlags;
    procedure AddFullStatus;
    procedure AddShortStatus;
    procedure AddDeviceMetrics;
    procedure AddCashTotalizers;
    procedure AddOperationRegisters;
    procedure AddLine(V1, V2: Variant);
    procedure Check2(AResultCode: Integer);
    procedure AddMemoLine(const S: WideString);
    procedure AddBool(const ValueName: WideString; Value: Boolean);
    procedure AddLineWidth(V1, V2: Variant; TextWidth: Integer);
  end;

implementation

{$R *.DFM}

{ TfmFullStatus }

const
  DescriptionWidth = 33;

procedure TfmFullStatus.AddMemoLine(const S: WideString);
begin
  Memo.Lines.Add(' ' + S);
end;

procedure TfmFullStatus.AddLineWidth(V1, V2: Variant; TextWidth: Integer);
begin
  AddMemoLine(Format('%-*s: %s', [TextWidth, String(V1), String(V2)]));
end;

procedure TfmFullStatus.AddLine(V1, V2: Variant);
begin
  AddLineWidth(V1, V2, 24);
end;

procedure TfmFullStatus.AddBool(const ValueName: WideString; Value: Boolean);
begin
  AddLineWidth(ValueName, BoolToStr[Value], DescriptionWidth);
end;

procedure TfmFullStatus.AddSeparator;
begin
  AddMemoLine(StringOfChar('-', 52));
end;

procedure TfmFullStatus.AddDeviceFlags;
begin
  AddSeparator;
  AddLine(SFlags, Format('%.4xh, %d', [Driver.ECRFlags, Driver.ECRFlags]));
  AddSeparator;
  AddBool(SQuantityPointPosition, Driver.QuantityPointPosition);
  AddBool(SPresenterOut, Driver.PresenterOut);
  AddBool(SPresenterIn, Driver.PresenterIn);
  AddBool(SIsEKLZOverflow, Driver.IsEKLZOverflow);
  AddBool(SIsDrawerOpen, Driver.IsDrawerOpen);
  AddBool(SLidPositionSensor, Driver.LidPositionSensor);
  AddBool(SReceiptRibbonLever, Driver.ReceiptRibbonLever);
  AddBool(SJournalRibbonLever, Driver.JournalRibbonLever);
  AddBool(SReceiptRibbonOpticalSensor, Driver.ReceiptRibbonOpticalSensor);
  AddBool(SJournalRibbonOpticalSensor, Driver.JournalRibbonOpticalSensor);
  AddBool(SEKLZIsPresent, Driver.EKLZIsPresent);
  AddBool(SPointPosition, Driver.PointPosition);
  AddBool(SSlipDocumentIsPresent, Driver.SlipDocumentIsPresent);
  AddBool(SSlipDocumentIsMoving, Driver.SlipDocumentIsMoving);
  AddBool(SReceiptRibbonIsPresent, Driver.ReceiptRibbonIsPresent);
  AddBool(SJournalRibbonIsPresent, Driver.JournalRibbonIsPresent);
end;

procedure TfmFullStatus.AddFullStatus;
var
  IsCashCore: Boolean;
begin
  Check2(Driver.GetDeviceMetrics);
  Check2(Driver.GetECRStatus);
  Driver.ModelParamNumber := mpCapCashCore;
  Check2(Driver.ReadModelParamValue);
  IsCashCore := Driver.ModelParamValue;

  Memo.Lines.Add('');
  AddSeparator;
  Memo.Lines.Add(SStatusQuery);
  AddSeparator;
  Memo.Lines.Add(SPrinterMode);
  Memo.Lines.Add(' ' + Format('%d, %s', [Driver.ECRMode, Driver.ECRModeDescription]));
  // Printer software
  AddSeparator;
  AddLine(SPrinterSoftwareVersion, Driver.ECRSoftVersion);
  AddLine(SPrinterSoftwareBuild, Driver.ECRBuild);
  AddLine(SPrinterSoftwareDate, Driver.ECRSoftDate);
  // Fiscal memory software
  AddSeparator;
  AddLine(SFMSoftwareVersion, Driver.FMSoftVersion);
  AddLine(SFMSoftwareBuild, Driver.FMBuild);
  AddLine(SFMSoftwareDate, Driver.FMSoftDate);
  // Mode
  AddSeparator;
  AddLine(SPrinterSubMode, Format('%d, %s', [Driver.ECRAdvancedMode, Driver.ECRAdvancedModeDescription]));
  AddLine(SPrinterModeStatus, Driver.ECRModeStatus);
  AddLine(SLogicalNumber, Driver.LogicalNumber);
  AddLine(SDocumentNumber, Driver.OpendocumentNumber);
  AddLine(SPortNumber, Driver.PortNumber);
  AddLine(SRegistrationNumber, Driver.RegistrationNumber);
  AddLine(SFreeRegistration, Driver.FreeRegistration);
  AddLine(SSessionNumber, Driver.SessionNumber);
  AddLine(SFreeRecordInFM, Driver.FreeRecordInFM);
  AddLine(SDate, Driver.Date);
  AddLine(SPrinterTime, Driver.Time);
  AddLine(SSerialNumber, GetSerialNumber(Driver.SerialNumber));
  AddLine(SINN, GetINN(Driver.INN));
  // Flags
  AddDeviceFlags;
  // Fiscal memory flags
  AddSeparator;
  AddLine(SFMFlags, Format('%.2xh, %d', [Driver.FMFlags, Driver.FMFlags]));
  if IsCashCore then
    AddLine(SFMFlagsEx, Format('%.2xh, %d', [Driver.FMFlagsEx, Driver.FMFlagsEx]));
  AddSeparator;
  AddBool(SIsFM24HoursOver, Driver.IsFM24HoursOver);
  AddBool(SIsFMSessionOpen, Driver.IsFMSessionOpen);
  AddBool(SIsLastFMRecordCorrupted, Driver.IsLastFMRecordCorrupted);
  AddBool(SIsBatteryLow, Driver.IsBatteryLow);
  AddBool(SFMOverflow, Driver.FMOverflow);
  AddBool(SLicenseIsPresent, Driver.LicenseIsPresent);
  AddBool(SFM2IsPresent, Driver.FM2IsPresent);
  AddBool(SFM1IsPresent, Driver.FM1IsPresent);
  if IsCashCore then
  begin
    AddBool(SASPDMode, Driver.IsASPDMode);
    AddBool(SIsCorruptedFMRecords, Driver.IsCorruptedFMRecords);
    AddBool(SIsCorruptedFiscalizationInfo, Driver.IsCorruptedFiscalizationInfo);
  end;
  AddSeparator;
  // Scroll memo to beginning
  Memo.SelStart := 0;
  Memo.SelLength := 0;
end;

procedure TfmFullStatus.AddShortStatus;
begin
  Check2(Driver.GetDeviceMetrics);
  Check2(Driver.GetShortECRStatus);

  Memo.Lines.Add('');
  AddSeparator;
  Memo.Lines.Add(SShortStatusQuery);
  AddSeparator;
  Memo.Lines.Add(SPrinterMode);
  Memo.Lines.Add(Format(' %d, %s', [Driver.ECRMode, Driver.ECRModeDescription]));
  AddSeparator;
  AddLine(SPrinterSubMode, Format('%d, %s', [Driver.ECRAdvancedMode, Driver.ECRAdvancedModeDescription]));
  AddLine(SPrinterModeStatus, Driver.ECRModeStatus);
  AddLine(SQuantityOfOperations, Driver.QuantityOfOperations);
  AddLine(SBatteryVoltage, Driver.BatteryVoltage);
  AddLine(SPowerSourceVoltage, Driver.PowerSourceVoltage);
  AddLine(SFMResultCode, Driver.FMResultCode);
  AddLine(SEKLZResultCode, Driver.EKLZResultCode);
  // Flags
  AddDeviceFlags;
  AddSeparator;
  // Scroll memo to beginning
  Memo.SelStart := 0;
  Memo.SelLength := 0;
end;

procedure TfmFullStatus.AddDeviceMetrics;
begin
  Check2(Driver.GetDeviceMetrics);

  Memo.Lines.Add('');
  AddSeparator;
  Memo.Lines.Add(SPrinterParameters);
  AddSeparator;
  Memo.Lines.Add(SUCodePage + IntToStr(Driver.UCodePage));
  Memo.Lines.Add(SUDescription + Driver.UDescription);
  Memo.Lines.Add(SUMajorProtocolVersion + IntToStr(Driver.UMajorProtocolVersion));
  Memo.Lines.Add(SUMinorProtocolVersion + IntToStr(Driver.UMinorProtocolVersion));
  Memo.Lines.Add(SUMajorType + IntToStr(Driver.UMajorType));
  Memo.Lines.Add(SUMinorType + IntToStr(Driver.UMinorType));
  Memo.Lines.Add(SUModel + IntToStr(Driver.UModel));
end;

procedure TfmFullStatus.btnFullEcrStatusClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    FStopFlag := False;
    btnInterrupt.Enabled := True;
    Memo.Clear;
    Memo.Lines.Add('');
    AddSeparator;
    Memo.Lines.Add(SFullStatus);
    AddSeparator;
    try
      AddFullStatus;
      AddShortStatus;
      AddDeviceMetrics;
      AddTables;
      AddCashTotalizers;
      AddOperationRegisters;
      AddSeparator;
      // Scroll memo to beginning
      Memo.SelStart := 0;
      Memo.SelLength := 0;
    except
      on E: EAbort do
        Memo.Lines.Add(E.Message);
    end;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmFullStatus.btnSaveToFileClick(Sender: TObject);
begin
  if not dlgSave.Execute then Exit;
  Memo.Lines.SaveToFile(dlgSave.FileName);
end;

procedure TfmFullStatus.AddCashTotalizers;
var
  i: Integer;
begin
  Memo.Lines.Add('');
  Memo.Lines.Add(SCashRegisters);
  Memo.Lines.Add(' ' + StringOfChar('-', 54));
  for i := CashRegisterMin to CashRegisterMax do
  begin
    if FStopFlag then
      raise EAbort.Create(SUserAbort);

    Driver.RegisterNumber := i;
    if Driver.GetCashReg <> 0 then
    begin
      raise EAbort.CreateFmt(SErrorAbort, [
        Driver.ResultCode, Driver.ResultCodeDescription]);
    end;
    Memo.Lines.Add(Format(' %3d.%-44s : %s',
      [i, Driver.NameCashReg,
      Driver.AmountToStr(Driver.ContentsOfCashRegister)]));
    Application.ProcessMessages;
  end;
  // Scroll memo to beginning
  Memo.SelStart := 0;
  Memo.SelLength := 0;
end;

procedure TfmFullStatus.AddOperationRegisters;
var
  i: Integer;
begin
  Memo.Lines.Add('');
  AddSeparator;
  Memo.Lines.Add(SOperationRegisters);
  AddSeparator;

  for i := OperationRegisterMin to OperationRegisterMax do
  begin
    Driver.RegisterNumber := i;
    Check2(Driver.GetOperationReg);

    Memo.Lines.Add(Format(' %3d.%-44s : %s', [
      i+1, Driver.NameOperationReg,
      Driver.AmountToStr(Driver.ContentsOfOperationRegister)]))
  end;
end;

procedure TfmFullStatus.AddTables;

  function AddTable(ATableNumber: Integer): Integer;
  var
    Row: Integer;
    Field: Integer;
    RowN: Integer;
    FieldN: Integer;
    FieldName: WideString;
  begin
    Check2(0);
    Driver.TableNumber := ATableNumber;
    Result := Driver.GetTableStruct;
    if Result <> 0 then Exit;
    RowN := Driver.RowNumber;
    FieldN := Driver.FieldNumber;
    Memo.Lines.Add('');
    AddSeparator;
    Memo.Lines.Add(Format(STableInfo,
      [Driver.TableNumber, Driver.TableName, RowN, FieldN]));

    Memo.Lines.Add(STableHeader);
    AddSeparator;
    Driver.TableNumber := ATableNumber;
    Result := Driver.GetTableStruct;
    if (Result <> 0) then Exit;
    RowN := Driver.RowNumber;
    FieldN := Driver.FieldNumber;
    for  Row := 1 to RowN do
    begin
      Driver.RowNumber := Row;
      for Field := 1 to FieldN do
      begin
        Check2(0);
        Driver.FieldNumber := Field;
        Result := Driver.GetFieldStruct;
        if Result <> 0 then Exit;
        FieldName := Driver.FieldName;
        Result := Driver.ReadTable;
        if Result <> 0 then Exit;
        Memo.Lines.Add(Format(' %.2d.%.2d. %s:%s', [Row, Field, FieldName, Driver.ValueOfFieldString]));
        Driver.FieldName;
      end;
      AddSeparator;
    end;
  end;

var
  i: Integer;
  Res: Integer;
begin
  Memo.Lines.Add('');
  AddSeparator;
  Memo.Lines.Add(STables);
  AddSeparator;
  i := 1;
  Res := 0;
  while True do
  begin
    Res := AddTable(i);
    if (Res <> 0) then
      Break;
    Inc(i);
  end;
  if Res = $5D then
    Res := 0;
  Check(Res);
end;

procedure TfmFullStatus.btnInterruptClick(Sender: TObject);
begin
  FStopFlag := True;
end;

procedure TfmFullStatus.Check2(AResultCode: Integer);
begin
  Application.ProcessMessages;
  if FStopFlag then
    raise EAbort.Create(SUserAbort);
  Check(AResultCode);
end;

end.

