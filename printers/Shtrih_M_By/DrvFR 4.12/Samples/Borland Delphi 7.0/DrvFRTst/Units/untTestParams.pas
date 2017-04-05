unit untTestParams;

interface
uses
  // VCL
  Sysutils, Classes, Forms, Dialogs;

type
  TTestParams = class(TComponent)
  private
    FParamsLoaded: Boolean;
    FSlipDiscountCharge: TStringList;
    FSlipClose: TStringList;
    FSlipConfigure: TStringList;
    FSlipOpen: TStringList;
    FSlipRegistration: TStringList;
    procedure SaveToFile(FileName: string);
    procedure LoadFromFile(FileName: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadState;
    procedure SaveState;
    property ParamsLoaded: Boolean read FParamsLoaded;
  published
    property SlipClose: TStringList read FSlipClose write FSlipClose;
    property SlipOpen: TStringList read FSlipOpen write FSlipOpen;
    property SlipDiscountCharge: TStringList read FSlipDiscountCharge write FSlipDiscountCharge;
    property SlipConfigure: TStringList read FSlipConfigure write FSlipConfigure;
    property SlipRegistration: TStringList read FSlipRegistration write FSlipRegistration;
  end;

function TestParams:TTestParams;
procedure FreeTestParams;

var
  FTestParams: TTestParams;

implementation

function TestParams:TTestParams;
begin
  if FTestParams = nil then
    FTestParams := TTestParams.Create(nil);
  Result := FTestParams;
end;
procedure FreeTestParams;
begin
  FTestParams.Free;
end;

function GetParamsFileName: string;
begin
  Result := ChangeFileExt(Application.ExeName, '.dat');
end;

{ TTestParams }

constructor TTestParams.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSlipOpen := TStringList.Create;
  FSlipClose := TStringList.Create;
  FSlipConfigure := TStringList.Create;
  FSlipDiscountCharge := TStringList.Create;
  FSlipRegistration := TStringList.Create;
  FParamsLoaded := False;
  LoadState;
end;

destructor TTestParams.Destroy;
begin
  SaveState;
  FSlipOpen.Free;
  FSlipClose.Free;
  FSlipConfigure.Free;
  FSlipDiscountCharge.Free;
  FSlipRegistration.Free;
  inherited Destroy;
end;

procedure TTestParams.LoadFromFile(FileName: string);
begin
  if FileName = '' then Exit;
  if not FileExists(FileName) then Exit;
  FParamsLoaded := True;
  try
    ReadComponentResFile(FileName, Self)
  except
    FParamsLoaded := False;
  end;
  if (FSlipOpen.Text = '') or (FSlipClose.Text = '') or
     (FSlipConfigure.Text = '') or (FSlipDiscountCharge.Text = '') or
     (FSlipDiscountCharge.Text = '') or (FSlipRegistration.Text = '') then
    FParamsLoaded := False;
end;

procedure TTestParams.LoadState;
begin
  try
    LoadFromFile(GetParamsFileName);
  except
  end;
end;

procedure TTestParams.SaveState;
begin
  try
    SaveToFile(GetParamsFileName);
  except
  end;  
end;

procedure TTestParams.SaveToFile(FileName: string);
begin
  if FileName = '' then Exit;
  if FileExists(FileName) then DeleteFile(PChar(FileName));
  try
    WriteComponentResFile(FileName, Self);
  except
  end;
end;

end.
