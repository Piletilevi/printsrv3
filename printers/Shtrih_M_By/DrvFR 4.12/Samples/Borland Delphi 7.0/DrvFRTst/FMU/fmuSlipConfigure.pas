unit fmuSlipConfigure;

interface

uses
  // VCL
  Windows, ExtCtrls, Classes, Controls, StdCtrls, Buttons, SysUtils,
  Grids, ValEdit, Dialogs,
  // This
  untPages, untDriver, untTypes, untUtil, untTestParams, VleUtils;

type
  { TfmSlipConfigure }

  TfmSlipConfigure = class(TPage)
    btnConfigureStandardSlipDocument: TBitBtn;
    btnConfigureSlipDocument: TBitBtn;
    vleParams: TValueListEditor;
    btnLoadFromTables: TButton;
    btnDefaultValues: TButton;
    btnSaveToTables: TButton;
    procedure btnConfigureSlipDocumentClick(Sender: TObject);
    procedure btnConfigureStandardSlipDocumentClick(Sender: TObject);
    procedure btnLoadFromTablesClick(Sender: TObject);

    procedure btnDefaultValuesClick(Sender: TObject);
    procedure btnSaveToTablesClick(Sender: TObject);
    procedure vleParamsSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure FormResize(Sender: TObject);
  private
    function GetItem(const AName: string): Integer;
    function LoadFromTables: Integer;
    function SaveToTables: Integer;
  public
    destructor Destroy; override;
    procedure UpdateObject; override;
    procedure Initialize; override;
  end;

implementation

{$R *.DFM}


const
  ConfigureSlipParams: array[0..2] of TIntParam =(
    (Name: SSlipDocumentWidth; Value: 0),
    (Name: SSlipDocumentLength; Value: 0),
    (Name: SPrintingAlignment; Value: 0)
  );

{ TfmSlipConfigure }

destructor TfmSlipConfigure.Destroy;
begin
  // workaround,  TValueListEditor does not destroy items
  vleParams.Strings.Clear;
  inherited Destroy;
end;

procedure TfmSlipConfigure.btnConfigureSlipDocumentClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    UpdateObject;
    Check(Driver.ConfigureSlipDocument);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipConfigure.btnConfigureStandardSlipDocumentClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Check(Driver.ConfigureStandardSlipDocument);
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipConfigure.Initialize;
var
  i: Integer;
begin
  for i := Low(ConfigureSlipParams) to High(ConfigureSlipParams) - 1 do
    VLE_AddProperty(vleParams, ConfigureSlipParams[i].Name, IntToStr(ConfigureSlipParams[i].Value) );
  VLE_AddPickProperty(vleParams, SPrintingAlignment, '0',
    ['0', '90', '180', '270'], [0, 1, 2, 3]);
  for i := 1 to 199 do
    VLE_AddProperty(vleParams, Format(SSlipLineSpacing, [i, i + 1]), '24');
  // Если были загружены настройки, записываем их в контрол
  if TestParams.ParamsLoaded then
    StringToVLEParams(vleParams, TestParams.SlipConfigure.Text)
  else
    TestParams.SlipConfigure.Text := VLEParamsToString(vleParams);
end;

function TfmSlipConfigure.LoadFromTables: Integer;
var
  i: Integer;
begin
  EnableButtons(False);
  try
    Driver.TableNumber := 10;
    Result := Driver.GetTableStruct;
    if Result <> 0 then Exit;
    Driver.RowNumber := 1;
    for i := 1 to 3 do
    begin
      Driver.FieldNumber := i;
      Result := Driver.ReadTable;
      if Result = 0 then
      begin
        if i = 3 then
          VLE_SETPickPropertyValue(vleParams, SPrintingAlignment,
            Driver.ValueOfFieldInteger)
        else
          vleParams.Cells[1, i] := IntToSTr(Driver.ValueOfFieldInteger);
      end;
    end;

    Driver.TableNumber := 11;
    Result := Driver.GetTableStruct;
    if Result <> 0 then Exit;
    Driver.FieldNumber := 1;
    for i := 1 to Driver.RowNumber do
    begin
      Driver.RowNumber := i;
      Result := Driver.ReadTable;
      if Result = 0 then
        vleParams.Cells[1, i + 3] := IntToSTr(Driver.ValueOfFieldInteger);
    end;
    Updatepage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipConfigure.UpdateObject;
var
  S: WideString;
  i: Integer;
begin
  if DriverExists then
  begin
    Driver.SlipDocumentWidth := GetItem(SSlipDocumentWidth);
    Driver.SlipDocumentLength := GetItem(SSlipDocumentLength);
    Driver.PrintingAlignment := VLE_GetPickPropertyValue(vleParams, SPrintingAlignment);
    S := '';
    for i := 1 to 199 do
      S := S + Chr(StrToInt(Trim(vleParams.Cells[1, i + 3])));
    Driver.SlipStringIntervals := S;
  end;
end;

function TfmSlipConfigure.GetItem(const AName: string): Integer;
begin
  Result := StrToInt(VLE_GetPropertyValue(vleParams, AName));
end;

procedure TfmSlipConfigure.btnLoadFromTablesClick(Sender: TObject);
begin
  Check(LoadFromTables);
end;

procedure TfmSlipConfigure.btnDefaultValuesClick(Sender: TObject);
begin
  vleParams.Strings.Text := '';
  Initialize;
end;

procedure TfmSlipConfigure.btnSaveToTablesClick(Sender: TObject);
begin
  Check(SaveToTables);
end;

function TfmSlipConfigure.SaveToTables: Integer;
var
  i: Integer;
begin
  EnableButtons(False);
  try
    Driver.TableNumber := 10;
    Result := Driver.GetTableStruct;
    if Result <> 0 then Exit;
    Driver.RowNumber := 1;
    for i := 1 to 3 do
    begin
      Driver.FieldNumber := i;
      if i = 3 then
        Driver.ValueOfFieldInteger := VLE_GetPickPropertyValue(vleParams, SPrintingAlignment)
      else
        Driver.ValueOfFieldInteger := StrToInt(vleParams.Cells[1, i]);
      Result := Driver.WriteTable;
      if Result <> 0 then Exit;
    end;

    Driver.TableNumber := 11;
    Result := Driver.GetTableStruct;
    if Result <> 0 then Exit;
    Driver.FieldNumber := 1;
    for i := 1 to Driver.RowNumber do
    begin
      Driver.RowNumber := i;
      Driver.ValueOfFieldInteger := StrToInt(vleParams.Cells[1, i + 3]);
      Result := Driver.WriteTable;
      if Result <> 0 then Exit;
    end;
    Updatepage;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmSlipConfigure.vleParamsSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  TestParams.SlipConfigure.Text := VLEParamsToString(vleParams);
end;

procedure TfmSlipConfigure.FormResize(Sender: TObject);
begin
  if vleParams.Width > 392 then
    vleParams.DisplayOptions := vleParams.DisplayOptions + [doAutoColResize]
  else
    vleParams.DisplayOptions := vleParams.DisplayOptions - [doAutoColResize];
end;

end.
