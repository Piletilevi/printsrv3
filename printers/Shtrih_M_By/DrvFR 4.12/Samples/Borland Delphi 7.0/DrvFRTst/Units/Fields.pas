unit Fields;

interface

uses
  // VCL
  Classes, SysUtils;

type
  TField = class;

  TFields = class(TComponent)
  private
    function GetCount: Integer;
    function GetField(Index: Integer): TField;
  public
    procedure Clear;
    procedure SetDefaults;
    function Add: TField;
    procedure SaveToStream(Dst: TStream);
    procedure LoadFromStream(Src: TStream);
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TField read GetField; default;
  end;

  TField = class(TComponent)
  private
    FValue: string;
    FCaption: string;
    FMinValue: Integer;
    FMaxValue: Integer;
    FRowNumber: Integer;
    FFieldNumber: Integer;
    FTableNumber: Integer;
    FPropertyName: string;
    FDefaultValue: string;
    function GetAsString: string;
    procedure SetAsString(const Value: string);
  public
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
  published
    property Caption: string read FCaption write FCaption;
    property AsString: string read GetAsString write SetAsString;
    property PropertyName: string read FPropertyName write FPropertyName;
    property DefaultValue: string read FDefaultValue write FDefaultValue;
    property MinValue: Integer read FMinValue write FMinValue;
    property MaxValue: Integer read FMaxValue write FMaxValue;
    property TableNumber: Integer read FTableNumber write FTableNumber;
    property RowNumber: Integer read FRowNumber write FRowNumber;
    property FieldNumber: Integer read FFieldNumber write FFieldNumber;
  end;

implementation

resourcestring
  SValidValues = 'Допустимые значения';
  SInvalidFieldValue = 'Неверное значение поля';

{ TFields }

function TFields.Add: TField;
begin
  Result := TField.Create(Self);
end;

procedure TFields.Clear;
begin
  DestroyComponents;
end;

function TFields.GetCount: Integer;
begin
  Result := ComponentCount;
end;

function TFields.GetField(Index: Integer): TField;
begin
  Result := Components[Index] as TField;
end;

procedure TFields.LoadFromStream(Src: TStream);
var
  i: Integer;
begin
  for i := 0 to Count-1 do
  begin
    if Src.Position < Src.Size then
      Items[i].LoadFromStream(Src);
  end;
end;

procedure TFields.SaveToStream(Dst: TStream);
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Items[i].SaveToStream(Dst);
end;

procedure TFields.SetDefaults;
var
  i: Integer;
begin
  for i := 0 to Count-1 do
    Items[i].AsString := Items[i].DefaultValue;
end;

{ TField }

function TField.GetAsString: string;
begin
  Result := FValue;
end;

procedure TField.LoadFromStream(Stream: TStream);
begin
  Stream.ReadComponent(Self);
end;

procedure TField.SaveToStream(Stream: TStream);
begin
  Stream.WriteComponent(Self);
end;

procedure TField.SetAsString(const Value: string);
begin
  if (StrToInt(Value) < MinValue)or(StrToInt(Value) > MaxValue) then
  begin
    raise Exception.CreateFmt('%s "%s" (%s).'#13#10'%s: %d..%d.', [
      SInvalidFieldValue, Caption, Value, SValidValues, MinValue, MaxValue]);
  end;
  FValue := Value;
end;


end.
