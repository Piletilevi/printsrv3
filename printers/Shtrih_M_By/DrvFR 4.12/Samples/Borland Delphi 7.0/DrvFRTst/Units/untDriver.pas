unit untDriver;

interface

uses
  // VCL
  Classes, SysUtils, Forms, ActiveX, ComObj,
  // This
  DrvFRLib_TLB, DriverError;

type
  { TDriver }

  TDriver = class(TDrvFR)
  private
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetCapEJournal: Boolean;
    function CapJrnSensor: Boolean;
		function CapJrnOpticalSensor: Boolean;
		function CapJrnLeverSensor: Boolean;
    function CapRecSensor: Boolean;
    function CapRecOpticalSensor: Boolean;
    function CapRecLeverSensor: Boolean;
    function CapSlpDocumentHiSensor: Boolean;
    function CapSlpDocumentLoSensor: Boolean;
    function CapCoverSensor: Boolean;
    function CapEKLZOverflowSensor: Boolean;
    function CapCashDrawerAsPresenter: Boolean;
    function CapTaxCalc: Boolean;
    function CapCashDrawerSensor: Boolean;
  	function CapPrsPaperInSensor: Boolean;
	  function CapPrsPaperOutSensor: Boolean;
  	function CapPresenter: Boolean;
  	function CapPresenterCommands: Boolean;
  	function CapBillAcceptor: Boolean;
  	function CapSlip: Boolean;
  	function CapNonfiscalDocument: Boolean;
    function CapJournal: Boolean;
    function CapTaxKeyboard: Boolean;
    function CapCashCore: Boolean;
    function CapEJournal: Boolean;
    function CapCutterPresent: Boolean;
    function SwapLineBytes: Boolean;
    function TaxCalcField: Integer;
    function Font1Width: Integer;
    function Font2Width: Integer;
    function FirstDrawLine: Integer;
    function InnDigitCount: Integer;
    function RnmDigitCount: Integer;
    function LongRnmDigitCount: Integer;
    function LongSerialDigitCount: Integer;
    function DefaultTaxPassword: Integer;
    function DefaultSysPassword: Integer;
    function CapTaxPasswordLock: Boolean;

    function ReadIntParam(ParamID: Integer): Integer;
    function ReadBoolParam(ParamID: Integer): Boolean;

    procedure Check(ResultCode: Integer);
    function ReadTableDef(ATableNumber, ARowNumber, AFieldNumber,
      ADefValue: Integer): Integer;
    function AmountToStr(Value: Currency): string;
  end;

procedure FreeDriver;
function Driver: TDriver;
function DriverExists: Boolean;
procedure Check(AResultCode: Integer);

implementation

uses
  Windows, fmuMain;

function GetParamsFileName: string;
begin
  Result := ChangeFileExt(Application.ExeName, '.dat');
end;

var
  FDriver: TDriver = nil;

procedure FreeDriver;
begin
  FDriver.Free;
  FDriver := nil;
end;

function DriverExists: Boolean;
begin
  Result := FDriver <> nil;
end;

function Driver: TDriver;
resourcestring
  SDriverCreateFailed = 'Ошибка создания объекта драйвера: ';
begin
  if FDriver = nil then
  try
    FDriver := TDriver.Create(nil);
  except
    on E: Exception do
    begin
      E.Message := SDriverCreateFailed + E.Message;
      raise;
    end;
  end;
  Result := FDriver;
end;

function DriverIsNil: Boolean;
begin
  Result := FDriver = nil;
end;

{ TDriver }

constructor TDriver.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TDriver.Destroy;
begin
  inherited Destroy;
end;

function TDriver.ReadTableDef(ATableNumber, ARowNumber, AFieldNumber,
  ADefValue: Integer): Integer;
begin
  RowNumber := ARowNumber;
  TableNumber := ATableNumber;
  FieldNumber := AFieldNumber;
  if ReadTable = 0 then
    Result := ValueOfFieldInteger
  else
    Result := ADefValue;
end;

procedure TDriver.Check(ResultCode: Integer);
begin
  if ResultCode <> 0 then Abort;
end;

function TDriver.ReadIntParam(ParamID: Integer): Integer;
begin
  Driver.ModelParamNumber := ParamID;
  Check(Driver.ReadModelParamValue);
  Result := StrToInt(Driver.ModelParamValue);
end;

function TDriver.ReadBoolParam(ParamID: Integer): Boolean;
begin
  Driver.ModelParamNumber := ParamID;
  Check(Driver.ReadModelParamValue);
  Result := Driver.ModelParamValue <> '0';
end;

function TDriver.GetCapEJournal: Boolean;
begin
  Result := ReadBoolParam(mpCapEJournal);
end;

function TDriver.AmountToStr(Value: Currency): string;
begin
  if PointPosition then
    Result := Format('%.2f', [Value])
  else
    Result := IntToStr(Trunc(Value));
end;

function TDriver.CapBillAcceptor: Boolean;
begin
  Result := ReadBoolParam(mpCapBillAcceptor);
end;

function TDriver.CapCashCore: Boolean;
begin
  Result := ReadBoolParam(mpCapCashCore);
end;

function TDriver.CapCashDrawerAsPresenter: Boolean;
begin
  Result := ReadBoolParam(mpCapCashDrawerAsPresenter);
end;

function TDriver.CapCashDrawerSensor: Boolean;
begin
  Result := ReadBoolParam(mpCapCashDrawerSensor);
end;

function TDriver.CapCoverSensor: Boolean;
begin
  Result := ReadBoolParam(mpCapCoverSensor);
end;

function TDriver.CapCutterPresent: Boolean;
begin
  Result := ReadBoolParam(mpCapCutterPresent);
end;

function TDriver.CapEJournal: Boolean;
begin
  Result := ReadBoolParam(mpCapEJournal);
end;

function TDriver.CapEKLZOverflowSensor: Boolean;
begin
  Result := ReadBoolParam(mpCapEKLZOverflowSensor);
end;

function TDriver.CapJournal: Boolean;
begin
  Result := ReadBoolParam(mpCapJournal);
end;

function TDriver.CapJrnLeverSensor: Boolean;
begin
  Result := ReadBoolParam(mpCapJrnLeverSensor);
end;

function TDriver.CapJrnOpticalSensor: Boolean;
begin
  Result := ReadBoolParam(mpCapJrnOpticalSensor);
end;

function TDriver.CapJrnSensor: Boolean;
begin
  Result := ReadBoolParam(mpCapJrnSensor);
end;

function TDriver.CapNonfiscalDocument: Boolean;
begin
  Result := ReadBoolParam(mpCapNonfiscalDocument);
end;

function TDriver.CapPresenter: Boolean;
begin
  Result := ReadBoolParam(mpCapPresenter);
end;

function TDriver.CapPresenterCommands: Boolean;
begin
  Result := ReadBoolParam(mpCapPresenterCommands);
end;

function TDriver.CapPrsPaperInSensor: Boolean;
begin
  Result := ReadBoolParam(mpCapPrsPaperInSensor);
end;

function TDriver.CapPrsPaperOutSensor: Boolean;
begin
  Result := ReadBoolParam(mpCapPrsPaperOutSensor);
end;

function TDriver.CapRecLeverSensor: Boolean;
begin
  Result := ReadBoolParam(mpCapRecLeverSensor);
end;

function TDriver.CapRecOpticalSensor: Boolean;
begin
  Result := ReadBoolParam(mpCapRecOpticalSensor);
end;

function TDriver.CapRecSensor: Boolean;
begin
  Result := ReadBoolParam(mpCapRecSensor);
end;

function TDriver.CapSlip: Boolean;
begin
  Result := ReadBoolParam(mpCapSlip);
end;

function TDriver.CapSlpDocumentHiSensor: Boolean;
begin
  Result := ReadBoolParam(mpCapSlpDocumentHiSensor);
end;

function TDriver.CapSlpDocumentLoSensor: Boolean;
begin
  Result := ReadBoolParam(mpCapSlpDocumentLoSensor);
end;

function TDriver.CapTaxCalc: Boolean;
begin
  Result := ReadBoolParam(mpCapTaxCalc);
end;

function TDriver.CapTaxKeyboard: Boolean;
begin
  Result := ReadBoolParam(mpCapTaxKeyboard);
end;

function TDriver.CapTaxPasswordLock: Boolean;
begin
  Result := ReadBoolParam(mpCapTaxPasswordLock);
end;

function TDriver.DefaultSysPassword: Integer;
begin
  Result := ReadIntParam(mpDefaultSysPassword);
end;

function TDriver.DefaultTaxPassword: Integer;
begin
  Result := ReadIntParam(mpDefaultTaxPassword);
end;

function TDriver.FirstDrawLine: Integer;
begin
  Result := ReadIntParam(mpFirstDrawLine);
end;

function TDriver.Font1Width: Integer;
begin
  Result := ReadIntParam(mpFont1Width);
end;

function TDriver.Font2Width: Integer;
begin
  Result := ReadIntParam(mpFont2Width);
end;

function TDriver.InnDigitCount: Integer;
begin
  Result := ReadIntParam(mpInnDigitCount);
end;

function TDriver.LongRnmDigitCount: Integer;
begin
  Result := ReadIntParam(mpLongRnmDigitCount);
end;

function TDriver.LongSerialDigitCount: Integer;
begin
  Result := ReadIntParam(mpLongSerialDigitCount);
end;

function TDriver.RnmDigitCount: Integer;
begin
  Result := ReadIntParam(mpRnmDigitCount);
end;

function TDriver.SwapLineBytes: Boolean;
begin
  Result := ReadBoolParam(mpSwapLineBytes);
end;

function TDriver.TaxCalcField: Integer;
begin
  Result := ReadIntParam(mpTaxCalcField);
end;

procedure Check(AResultCode: Integer);
var
  Text: string;
resourcestring
  SCommandNotSupportedInMode = 'Команда не поддерживается в данном режиме';
  SCommandNotSupportedInSubMode = 'Команда не поддерживается в данном подрежиме';
begin
  if AResultCode = 0 then
    Exit;

  case AResultCode of
    $72:
    begin
      Text := SCommandNotSupportedInSubMode;
      if Driver.GetECRStatus = 0 then
        Text := Text + Format(' (%s)', [Driver.ECRAdvancedModeDescription]);
      raise EDriverError.Create2($72, Text);
    end;

    $73:
    begin
      Text := SCommandNotSupportedInMode;
      if Driver.GetECRStatus = 0 then
        Text := Text + Format(' (%s)', [Driver.ECRModeDescription]);
      raise EDriverError.Create2($73, Text);
    end;
  else
    raise EDriverError.Create2(AResultCode, Driver.ResultCodeDescription);
  end
end;


end.
