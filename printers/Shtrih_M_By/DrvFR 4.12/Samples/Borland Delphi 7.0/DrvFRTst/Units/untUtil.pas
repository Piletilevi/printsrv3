unit untUtil;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Controls, Registry, StdCtrls, ExtCtrls, ComCtrls,
  Classes, Graphics, ValEdit, Grids, Spin,
  // This
  untTypes;

const
  /////////////////////////////////////////////////////////////////////////////
  // Tag to prevent automatic save

  TAG_DONTSAVECONTROL = 1000;

function StrToHex(const S: string): string;
function GetINN(const S: string): string;
function GetRNM(const S: string): string;
function GetLicense(const S: string): string;
function GetSerialNumber(const S: string): string;
procedure CenterClientSite(AChildWnd, AParentWnd: HWND);
procedure CheckIntStr(const AStr: string; const Msg: string);
function FMFlagsToStr(NBits: Integer; Driver: OleVariant): string;
function ECRFlagsToStr(NBits: Integer; Driver: OleVariant): string;
procedure LoadControlParams(const Path: string; Control: TWinControl; Reg: TRegistry);
procedure SaveControlParams(const Path: string; Control: TWinControl; Reg: TRegistry);

function Str1251To866(const S: string): string;
function Str866To1251(const S: string): string;

function DecodeTCPPort(ACode: Byte): Integer;
function EncodeTCPPort(ATCPPort: Word): Byte;

function ParsePrintStr(const S: WideString): WideString;

resourcestring
  SNotDefined = 'не задан';
  SSerialNotEntered = 'не введен';
  SLicenceEntered = 'введена';
  SLicenceNotEntered = 'не введена';
  SBit0 = 'нет';
  SBit1 = 'есть';
  SDecimalPoint0Digits = '0 знаков';
  SDecimalPoint2Digits = '2 знака';
  SLeverUp = 'поднят';
  SLeverDown = 'опущен';
  SCoverClosed = 'опущена';
  SCoverOpened = 'поднята';
  SDrawerClosed = 'закрыт';
  SDrawerOpened = 'открыт';
  SYes = 'да';
  SQuantity6Digits = '6 знаков';
  SQuantity3Digits = '3 знака';
  SInvalidBitNumber = 'Неправильный номер бита';
  SFMLastRecordCorrect = 'корректна';
  SFMLastRecordCorrupted = 'повреждена';
  SFMDayClosed = 'закрыта';
  SFMDayOpened = 'открыта';
  SFM24HoursNotOver = 'не кончились';
  SFM24HoursOver = 'кончились';
  SInvalidValue = 'Некорректное значение в поле';

implementation

function StrToHex(const S: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(S) do
    Result := Result + IntToHex(Ord(S[i]), 2) + ' ';
end;

function GetINN(const S: string): string;
begin
  Result := S;
  if Result = '' then Result := SNotDefined;
end;

function GetRNM(const S: string): string;
begin
  Result := S;
  if Result = '' then Result := SNotDefined;
end;

function GetLicense(const S: string): string;
begin
  Result := S;
  if Result = '' then Result := SLicenceNotEntered;
end;

function GetSerialNumber(const S: string): string;
begin
  Result := S;
  if Result = '' then Result := SSerialNotEntered;
end;

function ECRFlagsToStr(NBits: Integer; Driver: OleVariant): string;
const
  BitStr: array[0..15,False..True] of string = (
  (SBit0, SBit1),
  (SBit0, SBit1),
  (SBit0, SBit1),
  (SBit0, SBit1),
  (SDecimalPoint0Digits, SDecimalPoint2Digits),
  (SBit0, SBit1),
  (SBit0, SBit1),
  (SBit0, SBit1),
  (SLeverUp, SLeverDown),
  (SLeverUp, SLeverDown),
  (SCoverClosed, SCoverOpened),
  (SDrawerClosed, SDrawerOpened),
  (SBit0, SBit1),
  (SBit0, SBit1),
  (SBit0, SYes),
  (SQuantity6Digits, SQuantity3Digits));

begin
  case NBits of
    0: Result := BitStr[0,Boolean(Driver.JournalRibbonIsPresent)];
    1: Result := BitStr[1,Boolean(Driver.ReceiptRibbonIsPresent)];
    2: Result := BitStr[3,Boolean(Driver.SlipDocumentIsMoving)];
    3: Result := BitStr[2,Boolean(Driver.SlipDocumentIsPresent)];
    4: Result := BitStr[4,Boolean(Driver.PointPosition)];
    5: Result := BitStr[5,Boolean(Driver.EKLZIsPresent)];
    6: Result := BitStr[6,Boolean(Driver.JournalRibbonOpticalSensor)];
    7: Result := BitStr[7,Boolean(Driver.ReceiptRibbonOpticalSensor)];
    8: Result := BitStr[8,Boolean(Driver.JournalRibbonLever)];
    9: Result := BitStr[9,Boolean(Driver.ReceiptRibbonLever)];
    10: Result := BitStr[10,Boolean(Driver.LidPositionSensor)];
    11: Result := BitStr[11,Boolean(Driver.isDrawerOpen)];
    12: Result := BitStr[12,Boolean(Driver.isPrinterRightSensorFailure)];
    13: Result := BitStr[13,Boolean(Driver.isPrinterLeftSensorFailure)];
    14: Result := BitStr[14,Boolean(Driver.IsEKLZOverflow)];
    15: Result := BitStr[15,Boolean(Driver.QuantityPointPosition)];
  else
    Result := SInvalidBitNumber;
    Exit;
  end;
  Result := '<' + Result + '>';
end;

function FMFlagsToStr(NBits: Integer; Driver: OleVariant): string;

const
  BitStr:array[0..7,False..True]of string=(
  (SNo, SYes),
  (SNo, SYes),
  (SLicenceNotEntered, SLicenceEntered),
  (SNo,SYes),
  (' <80% ',' >80% '),
  (SFMLastRecordCorrect, SFMLastRecordCorrupted),
  (SFMDayClosed, SFMDayOpened),
  (SFM24HoursNotOver, SFM24HoursOver)
  );
begin
  Case NBits of
    0: Result := BitStr[0,Boolean(Driver.FM1IsPresent)];
    1: Result := BitStr[1,Boolean(Driver.FM2IsPresent)];
    2: Result := BitStr[2,Boolean(Driver.LicenseIsPresent)];
    3: Result := BitStr[3,Boolean(Driver.FMOverflow)];
    4: Result := BitStr[4,Boolean(Driver.IsBatteryLow)];
    5: Result := BitStr[5,Boolean(Driver.IsLastFMRecordCorrupted)];
    6: Result := BitStr[6,Boolean(Driver.IsFMSessionOpen)];
    7: Result := BitStr[7,Boolean(Driver.IsFM24HoursOver)];
  else
    Result := SInvalidBitNumber;
    Exit;
  end;
  Result := '<' + Result + '>';
end;

procedure LoadControlParams(const Path: string; Control: TWinControl; Reg: TRegistry);
var
  i: Integer;
  Item: TControl;
  ValueName: string;
begin
  for i := 0 to Control.ControlCount-1 do
  begin
    Item := Control.Controls[i];
    if Item is TWinControl then
    begin
      if Item.Tag = TAG_DONTSAVECONTROL then
        Continue;
      ValueName := Path + '.' + Item.Name;
      LoadControlParams(ValueName, Item as TWinControl, Reg);
      if Reg.ValueExists(ValueName) then
      begin
        if Item is TUpDown then
          TUpDown(Item).Position := Reg.ReadInteger(ValueName);
        if Item is TSpinEdit then
          TSpinEdit(Item).Value := Reg.ReadInteger(ValueName);
        if Item is TRadioGroup then
          TRadioGroup(Item).ItemIndex := Reg.ReadInteger(ValueName);
      end;
    end;
  end;
end;

procedure SaveControlParams(const Path: string; Control: TWinControl; Reg: TRegistry);
var
  i: Integer;
  Item: TComponent;
  ValueName: string;
begin
  for i := 0 to Control.ControlCount-1 do
  begin
    Item := Control.Controls[i];
    if Item is TWinControl then
    begin
      if TWinControl(Item).Tag = TAG_DONTSAVECONTROL then
        Continue;
      ValueName := Path + '.' + Item.Name;
      SaveControlParams(ValueName, Item as TWinControl, Reg);

      if Item is TUpDown then
        Reg.WriteInteger(ValueName, TUpDown(Item).Position);

      if Item is TSpinEdit then
        Reg.WriteInteger(ValueName, TSpinEdit(Item).Value);

      if Item is TRadioGroup then
        Reg.WriteInteger(ValueName, TRadioGroup(Item).ItemIndex);

    end;
  end;
end;

procedure CenterClientSite(AChildWnd, AParentWnd: HWND);
var
  ChildRect: TRect;
  ParentRect: TRect;
  ChildWidth, ChildHeight: Integer;
  ParentWidth, ParentHeight: Integer;
begin
  if IsWindow(AParentWnd) then
  begin
    GetWindowRect(AChildWnd, ChildRect);
    GetWindowRect(AParentWnd, ParentRect);
    ChildWidth := ChildRect.Right - ChildRect.Left;
    ChildHeight := ChildRect.Bottom - ChildRect.Top;
    ParentWidth := ParentRect.Right - ParentRect.Left;
    ParentHeight := ParentRect.Bottom - ParentRect.Top;

    MoveWindow(AChildWnd, ParentRect.Left + (ParentWidth - ChildWidth) div 2,
      ParentRect.Top + (ParentHeight - ChildHeight) div 2, ChildWidth,
      ChildHeight, TRUE);
  end;
end;

procedure CheckIntStr(const AStr: string; const Msg: string);
begin
  if Length(AStr) > 1024 then
    raise Exception.CreateFmt('%s "%s"', [SInvalidValue, Msg]);
end;

const
  Table866To1251: array [0..255] of Byte = (
  {00} $00,$01,$02,$03,$04,$05,$06,$07, $08,$09,$0A,$0B,$0C,$0D,$0E,$0F,
  {10} $10,$11,$12,$13,$14,$15,$16,$17, $18,$19,$1A,$1B,$1C,$1D,$1E,$1F,
  {20} $20,$21,$22,$23,$24,$25,$26,$27, $28,$29,$2A,$2B,$2C,$2D,$2E,$2F,
  {30} $30,$31,$32,$33,$34,$35,$36,$37, $38,$39,$3A,$3B,$3C,$3D,$3E,$3F,
  {40} $40,$41,$42,$43,$44,$45,$46,$47, $48,$49,$4A,$4B,$4C,$4D,$4E,$4F,
  {50} $50,$51,$52,$53,$54,$55,$56,$57, $58,$59,$5A,$5B,$5C,$5D,$5E,$5F,
  {60} $60,$61,$62,$63,$64,$65,$66,$67, $68,$69,$6A,$6B,$6C,$6D,$6E,$6F,
  {70} $70,$71,$72,$73,$74,$75,$76,$77, $78,$79,$7A,$7B,$7C,$7D,$7E,$7F,
  {80} $C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7, $C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,
  {90} $D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7, $D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF,
  {A0} $E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7, $E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF,
  {B0} $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F, $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,
  {C0} $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F, $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,
  {D0} $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F, $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,
  {E0} $F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7, $F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF,
  {F0} $A8,$B8,$AA,$BA,$AF,$BF,$A1,$A2, $B0,$3F,$B7,$3F,$B9,$A4,$3F,$A0
  );

function Char866To1251(C: Char): Char;
begin
  Result := Chr(Table866To1251[Ord(C)]);
end;

function Str866To1251(const S: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(S) do
    Result := Result + Char866To1251(S[i]);
end;

const
  Table1251To866: array [0..255] of Byte = (
  {00} $00,$01,$02,$03,$04,$05,$06,$07, $08,$09,$0A,$0B,$0C,$0D,$0E,$0F,
  {10} $10,$11,$12,$13,$14,$15,$16,$17, $18,$19,$1A,$1B,$1C,$1D,$1E,$1F,
  {20} $20,$21,$22,$23,$24,$25,$26,$27, $28,$29,$2A,$2B,$2C,$2D,$2E,$2F,
  {30} $30,$31,$32,$33,$34,$35,$36,$37, $38,$39,$3A,$3B,$3C,$3D,$3E,$3F,
  {40} $40,$41,$42,$43,$44,$45,$46,$47, $48,$49,$4A,$4B,$4C,$4D,$4E,$4F,
  {50} $50,$51,$52,$53,$54,$55,$56,$57, $58,$59,$5A,$5B,$5C,$5D,$5E,$5F,
  {60} $60,$61,$62,$63,$64,$65,$66,$67, $68,$69,$6A,$6B,$6C,$6D,$6E,$6F,
  {70} $70,$71,$72,$73,$74,$75,$76,$77, $78,$79,$7A,$7B,$7C,$7D,$7E,$7F,

  {80} $3F,$3F,$2C,$3F,$3F,$3F,$3F,$3F, $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,
  {90} $3F,$3F,$2C,$3F,$3F,$3F,$3F,$3F, $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F,
  {A0} $FF,$F6,$F7,$3F,$FD,$3F,$3F,$3F, $F0,$3F,$F2,$3F,$3F,$3F,$3F,$F4,
  {B0} $F8,$3F,$3F,$3F,$3F,$3F,$3F,$FA, $F1,$FC,$F3,$3F,$3F,$6A,$73,$F5,
  {C0} $80,$81,$82,$83,$84,$85,$86,$87, $88,$89,$8A,$8B,$8C,$8D,$8E,$8F,
  {D0} $90,$91,$92,$93,$94,$95,$96,$97, $98,$99,$9A,$9B,$9C,$9D,$9E,$9F,
  {E0} $A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7, $A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,
  {F0} $E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7, $E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF
  );

function Char1251To866(C: Char): Char;
begin
  Result := Chr(Table1251To866[Ord(C)]);
end;

function Str1251To866(const S: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(S) do
    Result := Result + Char1251To866(S[i]);
end;

function DecodeTCPPort(ACode: Byte): Integer;
var
  LoValue: Byte;
  HiValue: Byte;
begin
  LoValue := (ACode and $0F) or $30;
  HiValue := (ACode and $F0);
  Result := MakeWord(LoValue, HiValue);
end;

function EncodeTCPPort(ATCPPort: Word): Byte;
begin
  Result := ((ATCPPort and $F000) shr 12) shl 4 or (ATCPPort and $000F);
end;

function ParsePrintStr(const S: WideString): WideString;
var
  Esc: Boolean;
  k: Integer;
begin
  Result := '';
  Esc := False;
  k := 1;
  while True do
  begin
    if k > Length(S) then Exit;
    if (S[k] = '\') and not Esc then
    begin
      if k = Length(S) then Result := Result + '\';
      Esc := True;
      Inc(k);
      Continue;
    end;
    if not Esc then
    begin
      Result := Result + S[k];
      Inc(k);
      Continue;
    end;
    case S[k] of
      'n': Result := Result + #10;
    else
      Result := Result + S[k];
    end;
    Esc := False;
    Inc(k);
  end;
end;


end.


