unit fmuSlipRegistration;

interface

uses
  // VCL
  Windows, ComCtrls, StdCtrls, Controls, Classes, SysUtils, ExtCtrls, Buttons,
  Dialogs, Spin, Graphics, Grids, ValEdit,
  // This
  untPages, untDriver, untUtil, untTypes, untTestParams,
  PrinterTypes, VleUtils;

type
  { TfmSlipRegistration }

  TfmSlipRegistration = class(TPage)
    btnStdRegistration: TBitBtn;
    btnRegistration: TBitBtn;
    vleParams: TValueListEditor;
    btnLoadFromTables: TButton;
    lblCount: TLabel;
    btnDefaultValues: TButton;
    btnSaveToTables: TButton;
    seCount: TSpinEdit;
    procedure btnRegistrationClick(Sender: TObject);
    procedure btnStdRegistrationClick(Sender: TObject);
    procedure vleParamsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnLoadFromTablesClick(Sender: TObject);
    procedure btnDefaultValuesClick(Sender: TObject);
    procedure btnSaveToTablesClick(Sender: TObject);
    procedure vleParamsSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure FormResize(Sender: TObject);
  private
    function GetItem(const AName: string): Integer;
    function GetFloatItem(const AName: string): Double;
    function GetCurrItem(const AName: string): Currency;
    function LoadFromTables: Integer;
    function SaveToTables: Integer;
  public
    destructor Destroy; override;
    procedure Initialize; override;
    procedure UpdatePage; override;
    procedure UpdateObject; override;
  end;

implementation

{$R *.DFM}

const
  RegSlipParams: array[0..2] of TIntParam = (
    (Name: SQuantity; Value: 1),
    (Name: SPrice; Value: 100),
    (Name: SDepartment; Value: 0)
  );

const
  RegSlipExParams: array[0..20] of Integer = (
  1, 3, 1, 2, 3, 2, 1, 1, 1, 1,
  1, 1, 40, 14, 14, 14, 40, 1, 20, 1,
  1);


{ TfmSlipRegistration }

destructor TfmSlipRegistration.Destroy;
begin
  // workaround,  TValueListEditor does not destroy items
  vleParams.Strings.Clear;
  inherited Destroy;
end;

procedure TfmSlipRegistration.UpdateObject;

  function GetVal(Row: Integer): Integer;
  begin
    Result := StrToInt(Trim(vleParams.Cells[1, Row + 11]));
  end;

begin
  if DriverExists then
  begin
    // General
    Driver.OperationBlockFirstString := seCount.Value;
    Driver.Quantity := GetFloatItem(SQuantity);
    Driver.Price := GetCurrItem(SPrice);
    Driver.Department := GetItem(SDepartment);
    Driver.StringForPrinting := VLE_GetPropertyValue(vleParams, SStringForPrinting);
    Driver.Tax1 := VLE_GetPickPropertyValue(vleParams, STax1);
    Driver.Tax2 := VLE_GetPickPropertyValue(vleParams, STax2);
    Driver.Tax3 := VLE_GetPickPropertyValue(vleParams, STax3);
    Driver.Tax4 := VLE_GetPickPropertyValue(vleParams, STax4);
    // Extended
    Driver.Quantityformat := GetVal(0);
    Driver.StringQuantityinOperation := GetVal(1);
    Driver.TextStringNumber := GetVal(2);
    Driver.QuantityStringNumber := GetVal(3);
    Driver.SummStringNumber := GetVal(4);
    Driver.DepartmentStringNumber := GetVal(5);
    Driver.TextFont := GetVal(6);
    Driver.QuantityFont := GetVal(7);
    Driver.MultiplicationFont := GetVal(8);
    Driver.PriceFont := GetVal(9);
    Driver.SummFont := GetVal(10);
    Driver.DepartmentFont := GetVal(11);
    Driver.TextSymbolNumber := GetVal(12);
    Driver.QuantitySymbolNumber := GetVal(13);
    Driver.PriceSymbolNumber := GetVal(14);
    Driver.SummSymbolNumber := GetVal(15);
    Driver.DepartmentSymbolNumber := GetVal(16);
    Driver.TextOffset := GetVal(17);
    Driver.QuantityOffset := GetVal(18);
    Driver.SummOffset := GetVal(19);
    Driver.DepartmentOffset := GetVal(20);
  end;
end;

procedure TfmSlipRegistration.btnRegistrationClick(Sender: TObject);
var
  Count: Integer;
begin
  EnableButtons(False);
  try
    UpdateObject;
    Check(Driver.RegistrationOnSlipDocument);
    Count := Driver.OperationBlockFirstString;
    Count := Count + Driver.StringQuantityinOperation;
    Driver.OperationBlockFirstString := Count;
    UpdatePage;                                                                                                      
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipRegistration.UpdatePage;
begin
  if DriverExists then
  begin
    seCount.Value := Driver.OperationBlockFirstString;
  end;
end;

procedure TfmSlipRegistration.btnStdRegistrationClick(Sender: TObject);
var
  Count: Integer;
begin
  EnableButtons(False);
  try
    UpdateObject;
    Check(Driver.StandardRegistrationOnSlipDocument);
    Count := Driver.OperationBlockFirstString;
    Count := Count + Driver.ReadTableDef(13,1,2,3);
    Driver.OperationBlockFirstString := Count;
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipRegistration.Initialize;
var
  i: Integer;
begin
  VLE_AddSeparator(vleParams, SGeneral);
  for i := Low(RegSlipParams) to High(RegSlipParams) do
    VLE_AddProperty(vleParams, RegSlipParams[i].Name, IntToStr(RegSlipParams[i].Value));

  VLE_AddPickProperty(vleParams, STax1, SNo, [SNo, SGroup1, SGroup2, SGroup3,
    SGroup4], [0, 1, 2, 3, 4]);

  VLE_AddPickProperty(vleParams, STax2, SNo, [SNo, SGroup1, SGroup2, SGroup3,
    SGroup4], [0, 1, 2, 3, 4]);

  VLE_AddPickProperty(vleParams, STax3, SNo, [SNo, SGroup1, SGroup2, SGroup3,
    SGroup4], [0, 1, 2, 3, 4]);

  VLE_AddPickProperty(vleParams, STax4, SNo, [SNo, SGroup1, SGroup2, SGroup3,
    SGroup4], [0, 1, 2, 3, 4]);

  VLE_AddProperty(vleParams, SStringForPrinting, SStringForPrinting);
  VLE_AddSeparator(vleParams, SExtended);
  for i := Low(RegSlipExParams) to High(RegSlipExParams) do
    VLE_AddProperty(vleParams, GetSlipRegExParamName(i),
    IntToStr(RegSlipExParams[i]));

  if TestParams.ParamsLoaded then
    StringToVLEParams(vleParams, TestParams.SlipRegistration.Text)
  else
    TestParams.SlipRegistration.Text := VLEParamsToString(vleParams);
end;

function TfmSlipRegistration.LoadFromTables: Integer;
var
  i: Integer;
begin
  EnableButtons(False);
  try
    Driver.TableNumber := 13;
    Result := Driver.GetTableStruct;
    if Result <> 0 then Exit;
    Driver.RowNumber := 1;
    for i := 1 to Driver.FieldNumber do
    begin
      Driver.FieldNumber := i;
      Result := Driver.ReadTable;
      if Result = 0 then
        vleParams.Cells[1, i + 10] := IntToSTr(Driver.ValueOfFieldInteger);
    end;
    Updatepage;
  finally
    EnableButtons(True);
  end;
end;

function TfmSlipRegistration.GetItem(const AName: string): Integer;
begin
  Result := StrToInt(VLE_GetPropertyValue(vleParams, AName));
end;

function TfmSlipRegistration.GetFloatItem(const AName: string): Double;
begin
  Result := StrToFloat(VLE_GetPropertyValue(vleParams, AName));
end;

function TfmSlipRegistration.GetCurrItem(const AName: string): Currency;
begin
  Result := StrToCurr(VLE_GetPropertyValue(vleParams, AName));
end;

procedure TfmSlipRegistration.vleParamsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  VLE_DrawCell(Sender, ACol, ARow, Rect, State);
end;

procedure TfmSlipRegistration.btnLoadFromTablesClick(Sender: TObject);
begin
  Check(LoadFromTables);
end;

procedure TfmSlipRegistration.btnDefaultValuesClick(Sender: TObject);
begin
  vleParams.Strings.Text := '';
  Initialize;
end;

procedure TfmSlipRegistration.btnSaveToTablesClick(Sender: TObject);
begin
  Check(SaveToTables);
end;

function TfmSlipRegistration.SaveToTables: Integer;
var
  i: Integer;
begin
  EnableButtons(False);
  try
    Driver.TableNumber := 13;
    Result := Driver.GetTableStruct;
    if Result <> 0 then Exit;
    Driver.RowNumber := 1;
    for i := 1 to Driver.FieldNumber do
    begin
      Driver.FieldNumber := i;
      Driver.ValueOfFieldInteger := StrToInt(vleParams.Cells[1, i + 10]);
      Result := Driver.WriteTable;
      if Result <> 0 then Exit;
    end;
    Updatepage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipRegistration.vleParamsSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  TestParams.SlipRegistration.Text := VLEParamsToString(vleParams);
end;

procedure TfmSlipRegistration.FormResize(Sender: TObject);
begin
  if vleParams.Width > 392 then
    vleParams.DisplayOptions := vleParams.DisplayOptions + [doAutoColResize]
  else
    vleParams.DisplayOptions := vleParams.DisplayOptions - [doAutoColResize];
end;

end.
