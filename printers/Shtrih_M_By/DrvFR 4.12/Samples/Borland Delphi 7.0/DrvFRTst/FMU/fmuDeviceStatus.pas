unit fmuDeviceStatus;

interface

uses
  // VCL
  Windows, Forms, ComCtrls, StdCtrls, Controls, Classes, SysUtils, Messages,
  Buttons, Dialogs, Variants,
  // This
  untPages, untUtil, untDriver, DrvFRLib_TLB, GlobalConst, untTypes;

type
  { TfmDeviceStatus }

  TfmDeviceStatus = class(TPage)
    Memo: TMemo;
    btnEcrStatus: TButton;
    btnShortEcrStatus: TButton;
    btnDeviceMetrics: TButton;
    btnResetPrinter: TButton;
    btnGetModelParams: TButton;
    btnDriverVersion: TButton;
    procedure btnEcrStatusClick(Sender: TObject);
    procedure btnShortEcrStatusClick(Sender: TObject);
    procedure btnDeviceMetricsClick(Sender: TObject);
    procedure btnResetPrinterClick(Sender: TObject);
    procedure btnGetModelParamsClick(Sender: TObject);
    procedure btnDriverVersionClick(Sender: TObject);
  private
    procedure AddDeviceFlags;
    procedure AddSeparator;
    procedure AddLine(V1, V2: Variant);
    procedure AddMemoLine(const S: string);
    procedure AddBool(const ValueName: string; Value: Boolean);
    procedure AddLineWidth(V1, V2: Variant; TextWidth: Integer);
  end;

implementation

{$R *.DFM}

{ TfmDeviceStatus }

const
  DescriptionWidth = 33;


procedure TfmDeviceStatus.AddMemoLine(const S: string);
begin
  Memo.Lines.Add(' ' + S);
end;

procedure TfmDeviceStatus.AddLineWidth(V1, V2: Variant; TextWidth: Integer);
begin
  AddMemoLine(Format('%-*s: %s', [TextWidth, String(V1), String(V2)]));
end;

procedure TfmDeviceStatus.AddLine(V1, V2: Variant);
begin
  AddLineWidth(V1, V2, 24);
end;

procedure TfmDeviceStatus.AddBool(const ValueName: string; Value: Boolean);
begin
  AddLineWidth(ValueName, BoolToStr[Value], DescriptionWidth);
end;

procedure TfmDeviceStatus.AddSeparator;
begin
  AddMemoLine(StringOfChar('-', 40));
end;

procedure TfmDeviceStatus.AddDeviceFlags;
begin
  AddSeparator;
  AddLine(SFlags + DeviceName, Format('%.4xh, %d', [Driver.ECRFlags, Driver.ECRFlags]));
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

procedure TfmDeviceStatus.btnEcrStatusClick(Sender: TObject);
var
  IsCashCore: Boolean;
begin
  EnableButtons(False);
  Memo.Lines.BeginUpdate;
  try
    Memo.Clear;
    if Driver.GetECRStatus <> 0 then Exit;
    Driver.ModelParamNumber := mpCapCashCore;
    if Driver.ReadModelParamValue <> 0 then Exit;
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
    AddBool(SIsBatteryLow, not Driver.IsBatteryLow);
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
  finally
    Memo.Lines.EndUpdate;
    EnableButtons(True);
  end;
end;

procedure TfmDeviceStatus.btnShortEcrStatusClick(Sender: TObject);
begin
  EnableButtons(False);
  Memo.Lines.BeginUpdate;
  try
    Memo.Clear;
    if Driver.GetShortECRStatus <> 0 then Exit;

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
  finally
    Memo.Lines.EndUpdate;
    EnableButtons(True);
  end;
end;

procedure TfmDeviceStatus.btnDeviceMetricsClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    if Driver.GetDeviceMetrics <> 0 then Exit;

    Memo.Lines.Add('');
    AddSeparator;
    Memo.Lines.Add(SPrinterParameters);
    AddSeparator;
    Memo.Lines.Add(SUCodePage + IntToStr(Driver.UCodePage) + ', ' + Driver.UCodePageText);
    Memo.Lines.Add(SUDescription + Driver.UDescription);
    Memo.Lines.Add(SUMajorProtocolVersion + IntToStr(Driver.UMajorProtocolVersion));
    Memo.Lines.Add(SUMinorProtocolVersion + IntToStr(Driver.UMinorProtocolVersion));
    Memo.Lines.Add(SUMajorType + IntToStr(Driver.UMajorType));
    Memo.Lines.Add(SUMinorType + IntToStr(Driver.UMinorType));
    Memo.Lines.Add(SUModel + IntToStr(Driver.UModel));
  finally
    EnableButtons(True);
  end;
end;

procedure TfmDeviceStatus.btnResetPrinterClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    repeat
      if Driver.UModel > 2 then
        Check(Driver.GetShortECRStatus)
      else
        Check(Driver.GetECRStatus);
      case Driver.ECRAdvancedMode of
        0:
          begin
            case Driver.ECRMode of
              1: Check(Driver.InterruptDataStream);
              5: begin
                   ShowMessage(SPrinterLockedAfterInvalidTaxPassword);
                   Exit;
                 end;
              6: Check(Driver.ConfirmDate);
              8: Check(Driver.CancelCheck);
              9: begin
                   ShowMessage(SPrinterInTechnologicalMode);
                   Exit;
                 end;
              10: Check(Driver.InterruptTest);
              11, 12, 14: Sleep(1000);
            else
              Exit;
            end;
          end;
        3: Check(Driver.ContinuePrint);
        4, 5: Sleep(1000);
      else
        Break;
      end;
    until false;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmDeviceStatus.btnGetModelParamsClick(Sender: TObject);
var
  i: Integer;
  V: Variant;
  ParamCount: Integer;
  ParamText: WideString;
  ParamValue: WideString;
begin
  EnableButtons(False);
  Memo.Lines.BeginUpdate;
  try
    Memo.Clear;
    if Driver.GetDeviceMetrics <> 0 then Exit;
    Memo.Lines.Add('');
    AddSeparator;
    Memo.Lines.Add(SModelParameters);
    AddSeparator;

    ParamCount := Driver.ModelParamCount;
    for i := 0 to ParamCount-1 do
    begin
      Driver.ModelParamIndex := i;
      if Driver.ReadModelParam <> 0 then Exit;
      ParamText := Format('%4d. %s', [
        Driver.ModelParamNumber,
        String(Driver.ModelParamDescription)]);

      V := Driver.ModelParamValue;
      if VarType(V) = varBoolean then
        ParamValue := BoolToStr[Boolean(V)]
      else
        ParamValue := V;

      AddLineWidth(ParamText, ParamValue, 44);
    end;

  finally
    EnableButtons(True);
    Memo.Lines.EndUpdate;
  end;
end;

procedure TfmDeviceStatus.btnDriverVersionClick(Sender: TObject);
begin
  EnableButtons(False);
  Memo.Lines.BeginUpdate;
  try
    Memo.Clear;
    Memo.Lines.Add('');
    AddSeparator;
    Memo.Lines.Add(SDriverVersionCaption);
    AddSeparator;
    AddLineWidth(SDriverMajorVersion, Driver.DriverMajorVersion, 14);
    AddLineWidth(SDriverMinorVersion, Driver.DriverMinorVersion, 14);
    AddLineWidth(SDriverRelease, Driver.DriverRelease, 14);
    AddLineWidth(SDriverBuild, Driver.DriverBuild, 14);
    AddLineWidth(SDriverVersion, Driver.DriverVersion, 14);
  finally
    EnableButtons(True);
    Memo.Lines.EndUpdate;
  end;
end;

end.
