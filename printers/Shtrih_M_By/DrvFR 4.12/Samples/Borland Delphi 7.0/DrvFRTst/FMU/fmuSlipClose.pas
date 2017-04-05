unit fmuSlipClose;

interface

uses
  // VCL
  Windows, StdCtrls, Controls, Classes, SysUtils, ExtCtrls, Buttons, ComCtrls,
  Spin, Grids, ValEdit,
  // This
  untPages, untDriver, untUtil, untTypes, untTestParams, PrinterTypes,
  VleUtils;

type
  { TfmSlipClose }

  TfmSlipClose = class(TPage)
    lblCount: TLabel;
    btnStandardCloseCheckOnSlipDocument: TBitBtn;
    btnCloseCheckOnSlipDocument: TBitBtn;
    vleParams: TValueListEditor;
    btnLoadFromTables: TButton;
    btnDefaultValues: TButton;
    btnSaveToTables: TButton;
    seCount: TSpinEdit;
    procedure btnCloseCheckOnSlipDocumentClick(Sender: TObject);
    procedure btnStandardCloseCheckOnSlipDocumentClick(Sender: TObject);
    procedure vleParamsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnLoadFromTablesClick(Sender: TObject);
    procedure btnDefaultValuesClick(Sender: TObject);
    procedure btnSaveToTablesClick(Sender: TObject);
    procedure vleParamsSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure FormResize(Sender: TObject);
  private
    function GetFloatItem(const AName: string): Double;
    function GetCurrItem(const AName: string): Currency;
    function LoadFromTables: Integer;
    function SaveToTables: Integer;
  public
    destructor Destroy; override;
    procedure UpdatePage; override;
    procedure UpdateObject; override;
    procedure Initialize; override;
  end;

implementation

uses Forms;

{$R *.DFM}

const
  CloseSlipParams: array[0..4] of TIntParam = (
    (Name: SSumm1; Value: 100),
    (Name: SSumm2; Value: 0),
    (Name: SSumm3; Value: 0),
    (Name: SSumm4; Value: 0),
    (Name: SDiscount; Value: 0)
  );

  CloseSlipExParams: array[0..109] of Integer = (
  17,
  2,
  1,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  1,
  2,
  2,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  1,
  1,
  10,
  2,
  20,
  2,
  20,
  2,
  20,
  2,
  20,
  1,
  20,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  20,
  1,
  20);


{ TfmSlipClose }

destructor TfmSlipClose.Destroy;
begin
  // workaround,  TValueListEditor does not destroy items
  vleParams.Strings.Clear;
  inherited Destroy;
end;

procedure TfmSlipClose.UpdateObject;

  function GetVal(Row: Integer): Integer;
  begin
    Result := StrToInt(Trim(vleParams.Cells[1, Row + 13]));
  end;

begin
  if DriverExists then
  begin
    // Основные параметры
    Driver.OperationBlockFirstString := seCount.Value;
    Driver.Summ1 := GetCurrItem(SSumm1);
    Driver.Summ2 := GetCurrItem(SSumm2);
    Driver.Summ3 := GetCurrItem(SSumm3);
    Driver.Summ4 := GetCurrItem(SSumm4);
    Driver.DiscountOnCheck := GetFloatItem(SDiscount);
    Driver.StringForPrinting := VLE_GetPropertyValue(vleParams, SStringForPrinting);
    Driver.Tax1 := VLE_GetPickPropertyValue(vleParams, STax1);
    Driver.Tax2 := VLE_GetPickPropertyValue(vleParams, STax2);
    Driver.Tax3 := VLE_GetPickPropertyValue(vleParams, STax3);
    Driver.Tax4 := VLE_GetPickPropertyValue(vleParams, STax4);
    // Дополнительные параметры
    Driver.StringQuantityinOperation := GetVal(0);
    Driver.TotalStringNumber := GetVal(1);
    Driver.TextStringNumber := GetVal(2);
    Driver.Summ1StringNumber := GetVal(3);
    Driver.Summ2StringNumber := GetVal(4);
    Driver.Summ3StringNumber := GetVal(5);
    Driver.Summ4StringNumber := GetVal(6);
    Driver.ChangeStringNumber := GetVal(7);
    Driver.Tax1TurnOverStringNumber := GetVal(8);
    Driver.Tax2TurnOverStringNumber := GetVal(9);
    Driver.Tax3TurnOverStringNumber := GetVal(10);
    Driver.Tax4TurnOverStringNumber := GetVal(11);
    Driver.Tax1SumStringNumber := GetVal(12);
    Driver.Tax2SumStringNumber := GetVal(13);
    Driver.Tax3SumStringNumber := GetVal(14);
    Driver.Tax4SumStringNumber := GetVal(15);
    Driver.SubTotalStringNumber := GetVal(16);
    Driver.DiscountOnCheckStringNumber := GetVal(17);
    Driver.TextFont := GetVal(18);
    Driver.TotalFont := GetVal(19);
    Driver.TotalSumFont := GetVal(20);
    Driver.Summ1NameFont := GetVal(21);
    Driver.Summ1Font := GetVal(22);
    Driver.Summ2NameFont := GetVal(23);
    Driver.Summ2Font := GetVal(24);
    Driver.Summ3NameFont := GetVal(25);
    Driver.Summ3Font := GetVal(26);
    Driver.Summ4NameFont := GetVal(27);
    Driver.Summ4Font := GetVal(28);
    Driver.ChangeFont := GetVal(29);
    Driver.ChangeSumFont := GetVal(30);
    Driver.Tax1NameFont := GetVal(31);
    Driver.Tax1TurnOverFont := GetVal(32);
    Driver.Tax1RateFont := GetVal(33);
    Driver.Tax1SumFont := GetVal(34);
    Driver.Tax2NameFont := GetVal(35);
    Driver.Tax2TurnOverFont := GetVal(36);
    Driver.Tax2RateFont := GetVal(37);
    Driver.Tax2SumFont := GetVal(38);
    Driver.Tax3NameFont := GetVal(39);
    Driver.Tax3TurnOverFont := GetVal(40);
    Driver.Tax3RateFont := GetVal(41);
    Driver.Tax3SumFont := GetVal(42);
    Driver.Tax4NameFont := GetVal(43);
    Driver.Tax4TurnOverFont := GetVal(44);
    Driver.Tax4RateFont := GetVal(45);
    Driver.Tax4SumFont := GetVal(46);
    Driver.SubTotalFont := GetVal(47);
    Driver.SubTotalSumFont := GetVal(48);
    Driver.DiscountOnCheckFont := GetVal(49);
    Driver.DiscountOnCheckSumFont := GetVal(50);
    Driver.TextSymbolNumber := GetVal(51);
    Driver.TotalSymbolNumber := GetVal(52);
    Driver.Summ1SymbolNumber := GetVal(53);
    Driver.Summ2SymbolNumber := GetVal(54);
    Driver.Summ3SymbolNumber := GetVal(55);
    Driver.Summ4SymbolNumber := GetVal(56);
    Driver.ChangeSymbolNumber := GetVal(57);
    Driver.Tax1NameSymbolNumber := GetVal(58);
    Driver.Tax1TurnOverSymbolNumber := GetVal(59);
    Driver.Tax1RateSymbolNumber := GetVal(60);
    Driver.Tax1SumSymbolNumber := GetVal(61);
    Driver.Tax2NameSymbolNumber := GetVal(62);
    Driver.Tax2TurnOverSymbolNumber := GetVal(63);
    Driver.Tax2RateSymbolNumber := GetVal(64);
    Driver.Tax2SumSymbolNumber := GetVal(65);
    Driver.Tax3NameSymbolNumber := GetVal(66);
    Driver.Tax3TurnOverSymbolNumber := GetVal(67);
    Driver.Tax3RateSymbolNumber := GetVal(68);
    Driver.Tax3SumSymbolNumber := GetVal(69);
    Driver.Tax4NameSymbolNumber := GetVal(70);
    Driver.Tax4TurnOverSymbolNumber := GetVal(71);
    Driver.Tax4RateSymbolNumber := GetVal(72);
    Driver.Tax4SumSymbolNumber := GetVal(73);
    Driver.SubTotalSymbolNumber := GetVal(74);
    Driver.DiscountOnCheckSymbolNumber := GetVal(75);
    Driver.DiscountOnCheckSumSymbolNumber := GetVal(76);
    Driver.TextOffset := GetVal(77);
    Driver.TotalOffset := GetVal(78);
    Driver.TotalSumOffset := GetVal(79);
    Driver.Summ1NameOffset := GetVal(80);
    Driver.Summ1Offset := GetVal(81);
    Driver.Summ2NameOffset := GetVal(82);
    Driver.Summ2Offset := GetVal(83);
    Driver.Summ3NameOffset := GetVal(84);
    Driver.Summ3Offset := GetVal(85);
    Driver.Summ4NameOffset := GetVal(86);
    Driver.Summ4Offset := GetVal(87);
    Driver.ChangeOffset := GetVal(88);
    Driver.ChangeSumOffset := GetVal(89);
    Driver.Tax1NameOffset := GetVal(90);
    Driver.Tax1TurnOverOffset := GetVal(91);
    Driver.Tax1RateOffset := GetVal(92);
    Driver.Tax1SumOffset := GetVal(93);
    Driver.Tax2NameOffset := GetVal(94);
    Driver.Tax2TurnOverOffset := GetVal(95);
    Driver.Tax2RateOffset := GetVal(96);
    Driver.Tax2SumOffset := GetVal(97);
    Driver.Tax3NameOffset := GetVal(98);
    Driver.Tax3TurnOverOffset := GetVal(99);
    Driver.Tax3RateOffset := GetVal(100);
    Driver.Tax3SumOffset := GetVal(101);
    Driver.Tax4NameOffset := GetVal(102);
    Driver.Tax4TurnOverOffset := GetVal(103);
    Driver.Tax4RateOffset := GetVal(104);
    Driver.Tax4SumOffset := GetVal(105);
    Driver.SubTotalOffset := GetVal(106);
    Driver.SubTotalSumOffset := GetVal(107);
    Driver.DiscountOnCheckOffset := GetVal(108);
    Driver.DiscountOnCheckSumOffset := GetVal(109);
  end;
end;

procedure TfmSlipClose.btnCloseCheckOnSlipDocumentClick(Sender: TObject);
var
  Count: Integer;
begin
  EnableButtons(False);
  try
    UpdateObject;
    Check(Driver.CloseCheckOnSlipDocument);
    Count := Driver.OperationBlockFirstString;
    Count := Count + Driver.StringQuantityinOperation;
    Driver.OperationBlockFirstString := Count;
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipClose.UpdatePage;
begin
  if DriverExists then
  begin
    seCount.Value := Driver.OperationBlockFirstString;
  end;
end;

procedure TfmSlipClose.btnStandardCloseCheckOnSlipDocumentClick(Sender: TObject);
var
  Count: Integer;
begin
  EnableButtons(False);
  try
    UpdateObject;
    Check(Driver.StandardCloseCheckOnSlipDocument);
    Count := Driver.OperationBlockFirstString;
    Count := Count + Driver.ReadTableDef(14,1,1,17);
    Driver.OperationBlockFirstString := Count;
    UpdatePage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipClose.Initialize;
var
  i: Integer;
begin
  VLE_AddSeparator(vleParams, SGeneral);
  for i := Low(CloseSlipParams) to High(CloseSlipParams) do
    VLE_AddProperty(vleParams, CloseSlipParams[i].Name, IntToStr(CloseSlipParams[i].Value));

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
  for i := Low(CloseSlipExParams) to High(CloseSlipExParams) do
    VLE_AddProperty(vleParams,
      GetCloseSlipExParamName(i),
      IntToStr(CloseSlipExParams[i]));
  // Если были загружены настройки, записываем их в контрол
  if TestParams.ParamsLoaded then
    StringToVLEParams(vleParams, TestParams.SlipClose.Text)
  else
    TestParams.SlipClose.Text := VLEParamsToString(vleParams);
end;

function TfmSlipClose.LoadFromTables: Integer;
var
  i: Integer;
begin
  EnableButtons(False);
  try
    Driver.TableNumber := 14;
    Result := Driver.GetTableStruct;
    if Result <> 0 then Exit;
    Driver.RowNumber := 1;
    for i := 1 to Driver.FieldNumber do
    begin
      Driver.FieldNumber := i;
      Result := Driver.ReadTable;
      if Result = 0 then
        vleParams.Cells[1, i + 12] := IntToSTr(Driver.ValueOfFieldInteger);
    end;
    Updatepage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipClose.vleParamsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  VLE_DrawCell(Sender, ACol, ARow, Rect, State);
end;

procedure TfmSlipClose.btnLoadFromTablesClick(Sender: TObject);
begin
  Check(LoadFromTables);
end;

procedure TfmSlipClose.btnDefaultValuesClick(Sender: TObject);
begin
  vleParams.Strings.Text := '';
  Initialize;
end;

procedure TfmSlipClose.btnSaveToTablesClick(Sender: TObject);
begin
  Check(SaveToTables);
end;

function TfmSlipClose.SaveToTables: Integer;
var
  i: Integer;
begin
  EnableButtons(False);
  try
    Driver.TableNumber := 14;
    Result := Driver.GetTableStruct;
    if Result <> 0 then Exit;
    Driver.RowNumber := 1;
    for i := 1 to Driver.FieldNumber do
    begin
      Driver.FieldNumber := i;
      Driver.ValueOfFieldInteger := StrToInt(vleParams.Cells[1, i + 12]);
      Result := Driver.WriteTable;
      if Result <> 0 then Exit;
    end;
    Updatepage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipClose.vleParamsSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  TestParams.SlipClose.Text := VLEParamsToString(vleParams);
end;

procedure TfmSlipClose.FormResize(Sender: TObject);
begin
  if vleParams.Width > 392 then
    vleParams.DisplayOptions := vleParams.DisplayOptions + [doAutoColResize]
  else
    vleParams.DisplayOptions := vleParams.DisplayOptions - [doAutoColResize];
end;

function TfmSlipClose.GetFloatItem(const AName: string): Double;
begin
  Result := StrToFloat(VLE_GetPropertyValue(vleParams, AName));
end;

function TfmSlipClose.GetCurrItem(const AName: string): Currency;
begin
  Result := StrToCurr(VLE_GetPropertyValue(vleParams, AName));
end;

end.
