unit untPages;

interface

Uses
  // VCL
  Windows, Classes, SysUtils, Forms, Grids, Controls, ComObj, StdCtrls,
  // This
  BaseForm;

type
  TPage = class;
  TPageClass = class of TPage;
  TChangeType = (ctStart, ctStop);

  { TPages }

  TPages = class
  private
    FList: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TPage;
    function GetItemIndex(AItem: TPage): Integer;
    procedure InsertItem(AItem: TPage);
    procedure RemoveItem(AItem: TPage);
  public
    Password: Integer;
    destructor Destroy; override;
    function ValidIndex(Value: Integer): Boolean;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TPage read GetItem; default;
  end;

  { TPage }

  TPage = class(TBaseForm)
  private
    FOwner: TPages;
    FButton: TButton;
    function GetIndex: Integer;
  public
    destructor Destroy; override;

    procedure Initialize; virtual;
    procedure UpdatePage; virtual;
    procedure UpdateObject; virtual;
    procedure SetOwner(AOwner: TPages);
    procedure Check(ResultCode: Integer);
    function LoadDefaults: Integer; virtual;
    procedure EnableButtons(Value: Boolean); override;
    property Index: Integer read GetIndex;
  end;


  TPageNotifyEvent = procedure(Sender: TObject; ChangeType: TChangeType) of object;

  { TPageNotifier }

  TPageNotifier = class
  private
    FOnChange: TPageNotifyEvent;
    procedure DoChange(ChangeType: TChangeType);
  public
    property OnChange: TPageNotifyEvent read FOnChange write FOnChange;
  end;

function PageNotifier: TPageNotifier;

implementation

var
  FPageNotifier: TPageNotifier;

function PageNotifier: TPageNotifier;
begin
  if FPageNotifier = nil then
    FPageNotifier := TPageNotifier.Create;
  Result := FPageNotifier;
end;

procedure EnableControlButtons(WinControl: TWinControl; Value: Boolean;
  var AButton: TButton);
var
  i: Integer;
  Button: TButton;
  Control: TControl;
begin
  for i := 0 to WinControl.ControlCount-1 do
  begin
    Control := WinControl.Controls[i];
    if Control is TWinControl then
      EnableControlButtons(Control as TWinControl, Value, AButton);
  end;

  if (WinControl is TButton) then
  begin
    Button := WinControl as TButton;
    if Value then
    begin
      Button.Enabled := True;
      if Button = AButton then Button.SetFocus;
    end else
    begin
      if Button.Focused then AButton := Button;
      Button.Enabled := False;
    end;
  end;
end;

{ TPages }

destructor TPages.Destroy;
begin
  while Count > 0 do
    Items[0].Free;
  inherited Destroy;
end;

function TPages.GetCount: Integer;
begin
  if FList = nil then Result := 0
  else Result := FList.Count;
end;

function TPages.GetItem(Index: Integer): TPage;
begin
  Result := FList[Index];
end;

function TPages.GetItemIndex(AItem: TPage): Integer;
begin
  Result := FList.IndexOf(AItem);
end;

procedure TPages.InsertItem(AItem: TPage);
begin
  if FList = nil then FList := TList.Create;
  FList.Add(AItem);
  AItem.FOwner := Self;
end;

procedure TPages.RemoveItem(AItem: TPage);
begin
  AItem.FOwner := nil;
  FList.Remove(AItem);
  if FList.Count = 0 then
  begin
    FList.Free;
    FList := nil;
  end;
end;

function TPages.ValidIndex(Value: Integer): Boolean;
begin
  Result := (Value >= 0)and(Value < Count);
end;

{ TPage }

destructor TPage.Destroy;
begin
  SetOwner(nil);
  inherited Destroy;
end;

procedure TPage.SetOwner(AOwner: TPages);
begin
  if FOwner <> nil then FOwner.RemoveItem(Self);
  if AOwner <> nil then AOwner.InsertItem(Self);
end;

function TPage.GetIndex: Integer;
begin
  Result := FOwner.GetItemIndex(Self);
end;

procedure TPage.Initialize;
begin

end;

procedure TPage.UpdatePage;
begin

end;

procedure TPage.UpdateObject;
begin

end;

function TPage.LoadDefaults: Integer;
begin
  Result := 0;
end;

procedure TPage.EnableButtons(Value: Boolean);
begin
  if Value then
  begin
    PageNotifier.DoChange(ctStop);
  end else
  begin
    PageNotifier.DoChange(ctStart);
  end;
  EnableControlButtons(Self, Value, FButton);
end;

procedure TPage.Check(ResultCode: Integer);
begin
  if ResultCode <> 0 then Abort;
end;

{ TPageNotifier }

procedure TPageNotifier.DoChange(ChangeType: TChangeType);
begin
  if Assigned(FOnChange) then FOnChange(Self, ChangeType);
end;

initialization
finalization
  FPageNotifier.Free;
  FPageNotifier := nil;
end.
