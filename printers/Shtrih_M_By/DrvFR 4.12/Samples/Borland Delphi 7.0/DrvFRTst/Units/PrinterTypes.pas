unit PrinterTypes;

interface

const
  CashRegisterMin = $00;
  CashRegisterMax = $FF;

  OperationRegisterMin = $00;
  OperationRegisterMax = $FF;

  CloseSlipExParamMin = 0;
  CloseSlipExParamMax = $6D;

function GetCloseSlipExParamName(Number: Integer): string;
function GetSlipDiscountExParamName(Number: Integer): string;
function GetSlipOpenExParamName(Number: Integer): string;
function GetSlipRegExParamName(Number: Integer): string;

implementation

resourcestring
  SNoDescrpiption = 'Описание недоступно';

  SCloseSlipExParam00 = 'Количество строк в операции';
  SCloseSlipExParam01 = 'Строка итога';
  SCloseSlipExParam02 = 'Строка текста';
  SCloseSlipExParam03 = 'Строка наличных';
  SCloseSlipExParam04 = 'Строка оплаты 2';
  SCloseSlipExParam05 = 'Строка оплаты 3';
  SCloseSlipExParam06 = 'Строка оплаты 4';
  SCloseSlipExParam07 = 'Строка сдачи';
  SCloseSlipExParam08 = 'Строка оборота по налогу А';
  SCloseSlipExParam09 = 'Строка оборота по налогу Б';
  SCloseSlipExParam0A = 'Строка оборота по налогу В';
  SCloseSlipExParam0B = 'Строка оборота по налогу Г';
  SCloseSlipExParam0C = 'Строка суммы по налогу А';
  SCloseSlipExParam0D = 'Строка суммы по налогу Б';
  SCloseSlipExParam0E = 'Строка суммы по налогу В';
  SCloseSlipExParam0F = 'Строка суммы по налогу Г';
  SCloseSlipExParam10 = 'Строка суммы до начисления скидки';
  SCloseSlipExParam11 = 'Строка суммы скидки';
  SCloseSlipExParam12 = 'Шрифт текста';
  SCloseSlipExParam13 = 'Шрифт "ИТОГ"';
  SCloseSlipExParam14 = 'Шрифт суммы итога';
  SCloseSlipExParam15 = 'Шрифт "НАЛИЧНЫМИ"';
  SCloseSlipExParam16 = 'Шрифт суммы наличных';
  SCloseSlipExParam17 = 'Шрифт названия типа оплаты 2';
  SCloseSlipExParam18 = 'Шрифт суммы типа оплаты 2';
  SCloseSlipExParam19 = 'Шрифт названия типа оплаты 3';
  SCloseSlipExParam1A = 'Шрифт суммы типа оплаты 3';
  SCloseSlipExParam1B = 'Шрифт названия типа оплаты 4';
  SCloseSlipExParam1C = 'Шрифт суммы типа оплаты 4';
  SCloseSlipExParam1D = 'Шрифт "СДАЧА"';
  SCloseSlipExParam1E = 'Шрифт суммы сдачи';
  SCloseSlipExParam1F = 'Шрифт названия налога А';
  SCloseSlipExParam20 = 'Шрифт оборота налога А';
  SCloseSlipExParam21 = 'Шрифт ставки налога А';
  SCloseSlipExParam22 = 'Шрифт суммы налога А';
  SCloseSlipExParam23 = 'Шрифт названия налога Б';
  SCloseSlipExParam24 = 'Шрифт оборота налога Б';
  SCloseSlipExParam25 = 'Шрифт ставки налога Б';
  SCloseSlipExParam26 = 'Шрифт суммы налога Б';
  SCloseSlipExParam27 = 'Шрифт названия налога В';
  SCloseSlipExParam28 = 'Шрифт оборота налога В';
  SCloseSlipExParam29 = 'Шрифт ставки налога В';
  SCloseSlipExParam2A = 'Шрифт суммы налога В';
  SCloseSlipExParam2B = 'Шрифт названия налога Г';
  SCloseSlipExParam2C = 'Шрифт оборота налога Г';
  SCloseSlipExParam2D = 'Шрифт ставки налога Г';
  SCloseSlipExParam2E = 'Шрифт суммы налога Г';
  SCloseSlipExParam2F = 'Шрифт "ВСЕГО"';
  SCloseSlipExParam30 = 'Шрифт суммы до начисления скидки';
  SCloseSlipExParam31 = 'Шрифт скидки в %';
  SCloseSlipExParam32 = 'Шрифт суммы скидки';
  SCloseSlipExParam33 = 'Количество символов текста';
  SCloseSlipExParam34 = 'Количество символов суммы итога';
  SCloseSlipExParam35 = 'Количество символов суммы наличных';
  SCloseSlipExParam36 = 'Количество символов суммы типа оплаты 2';
  SCloseSlipExParam37 = 'Количество символов суммы типа оплаты 3';
  SCloseSlipExParam38 = 'Количество символов суммы типа оплаты 4';
  SCloseSlipExParam39 = 'Количество символов суммы сдачи';
  SCloseSlipExParam3A = 'Количество символов названия налога А';
  SCloseSlipExParam3B = 'Количество символов оборота налога А';
  SCloseSlipExParam3C = 'Количество символов ставки налога А';
  SCloseSlipExParam3D = 'Количество символов суммы налога А';
  SCloseSlipExParam3E = 'Количество символов названия налога Б';
  SCloseSlipExParam3F = 'Количество символов оборота налога Б';
  SCloseSlipExParam40 = 'Количество символов ставки налога Б';
  SCloseSlipExParam41 = 'Количество символов суммы налога Б';
  SCloseSlipExParam42 = 'Количество символов названия налога В';
  SCloseSlipExParam43 = 'Количество символов оборота налога В';
  SCloseSlipExParam44 = 'Количество символов ставки налога В';
  SCloseSlipExParam45 = 'Количество символов суммы налога В';
  SCloseSlipExParam46 = 'Количество символов названия налога Г';
  SCloseSlipExParam47 = 'Количество символов оборота налога Г';
  SCloseSlipExParam48 = 'Количество символов ставки налога Г';
  SCloseSlipExParam49 = 'Количество символов суммы налога Г';
  SCloseSlipExParam4A = 'Количество символов суммы до начисления скидки';
  SCloseSlipExParam4B = 'Количество символов скидки в %';
  SCloseSlipExParam4C = 'Количество символов суммы скидки';
  SCloseSlipExParam4D = 'Смещение текста';
  SCloseSlipExParam4E = 'Смещение "ИТОГ"';
  SCloseSlipExParam4F = 'Смещение суммы итога';
  SCloseSlipExParam50 = 'Смещение "НАЛИЧНЫМИ"';
  SCloseSlipExParam51 = 'Смещение суммы наличных';
  SCloseSlipExParam52 = 'Смещение названия типа оплаты 2';
  SCloseSlipExParam53 = 'Смещение суммы типа оплаты 2';
  SCloseSlipExParam54 = 'Смещение названия типа оплаты 3';
  SCloseSlipExParam55 = 'Смещение суммы типа оплаты 3';
  SCloseSlipExParam56 = 'Смещение названия типа оплаты 4';
  SCloseSlipExParam57 = 'Смещение суммы типа оплаты 4';
  SCloseSlipExParam58 = 'Смещение "СДАЧА"';
  SCloseSlipExParam59 = 'Смещение суммы сдачи';
  SCloseSlipExParam5A = 'Смещение названия налога А';
  SCloseSlipExParam5B = 'Смещение оборота налога А';
  SCloseSlipExParam5C = 'Смещение ставки налога А';
  SCloseSlipExParam5D = 'Смещение суммы налога А';
  SCloseSlipExParam5E = 'Смещение названия налога Б';
  SCloseSlipExParam5F = 'Смещение оборота налога Б';
  SCloseSlipExParam60 = 'Смещение ставки налога Б';
  SCloseSlipExParam61 = 'Смещение суммы налога Б';
  SCloseSlipExParam62 = 'Смещение названия налога В';
  SCloseSlipExParam63 = 'Смещение оборота налога В';
  SCloseSlipExParam64 = 'Смещение ставки налога В';
  SCloseSlipExParam65 = 'Смещение суммы налога В';
  SCloseSlipExParam66 = 'Смещение названия налога Г';
  SCloseSlipExParam67 = 'Смещение оборота налога Г';
  SCloseSlipExParam68 = 'Смещение ставки налога Г';
  SCloseSlipExParam69 = 'Смещение суммы налога Г';
  SCloseSlipExParam6A = 'Смещение "ВСЕГО"';
  SCloseSlipExParam6B = 'Смещение суммы до начисления скидки';
  SCloseSlipExParam6C = 'Смещение скидки в %';
  SCloseSlipExParam6D = 'Смещение суммы скидки';


  SSlipDiscountExParam00 = 'Кол-во строк в операции';
  SSlipDiscountExParam01 = 'Строка текста';
  SSlipDiscountExParam02 = 'Строка названия операции';
  SSlipDiscountExParam03 = 'Строка суммы';
  SSlipDiscountExParam04 = 'Шрифт текста';
  SSlipDiscountExParam05 = 'Шрифт названия операции';
  SSlipDiscountExParam06 = 'Шрифт суммы';
  SSlipDiscountExParam07 = 'Кол-во символов текста';
  SSlipDiscountExParam08 = 'Кол-во символов суммы';
  SSlipDiscountExParam09 = 'Смещение текста';
  SSlipDiscountExParam0A = 'Смещение названия суммы';
  SSlipDiscountExParam0B = 'Смещение суммы';

  SSlipOpenExParam00 = 'Шрифт клише';
  SSlipOpenExParam01 = 'Шрифт заголовка документа';
  SSlipOpenExParam02 = 'Шрифт номера ЭКЛЗ';
  SSlipOpenExParam03 = 'Шрифт КПК и номера КПК';
  SSlipOpenExParam04 = 'Строка клише';
  SSlipOpenExParam05 = 'Строка заголовка документа';
  SSlipOpenExParam06 = 'Строка номера ЭКЛЗ';
  SSlipOpenExParam07 = 'Строка признака повтора документа';
  SSlipOpenExParam08 = 'Смещение клише';
  SSlipOpenExParam09 = 'Смещение заголовка документа';
  SSlipOpenExParam0A = 'Смещение номера ЭКЛЗ';
  SSlipOpenExParam0B = 'Смещение КПК и номера КПК';
  SSlipOpenExParam0C = 'Смещение признака повтора документа';

  SSlipRegExParam00 = 'Формат целого кол-ва';
  SSlipRegExParam01 = 'Количество строк в операции';
  SSlipRegExParam02 = 'Строка текста';
  SSlipRegExParam03 = 'Строка произведения кол-ва на цену';
  SSlipRegExParam04 = 'Строка суммы';
  SSlipRegExParam05 = 'Строка отдела';
  SSlipRegExParam06 = 'Шрифт текста';
  SSlipRegExParam07 = 'Шрифт кол-ва';
  SSlipRegExParam08 = 'Шрифт знака умножения';
  SSlipRegExParam09 = 'Шрифт цены';
  SSlipRegExParam0A = 'Шрифт суммы';
  SSlipRegExParam0B = 'Шрифт отдела';
  SSlipRegExParam0C = 'Кол-во символов текста';
  SSlipRegExParam0D = 'Кол-во символов кол-ва';
  SSlipRegExParam0E = 'Кол-во символов цены';
  SSlipRegExParam0F = 'Кол-во символов суммы';
  SSlipRegExParam10 = 'Кол-во символов отдела';
  SSlipRegExParam11 = 'Смещение текста';
  SSlipRegExParam12 = 'Смещение произведения кол-ва на цену';
  SSlipRegExParam13 = 'Смещение суммы';
  SSlipRegExParam14 = 'Смещение отдела';

  
function GetCloseSlipExParamName(Number: Integer): string;
begin
  case Number of
    $00: Result := SCloseSlipExParam00;
    $01: Result := SCloseSlipExParam01;
    $02: Result := SCloseSlipExParam02;
    $03: Result := SCloseSlipExParam03;
    $04: Result := SCloseSlipExParam04;
    $05: Result := SCloseSlipExParam05;
    $06: Result := SCloseSlipExParam06;
    $07: Result := SCloseSlipExParam07;
    $08: Result := SCloseSlipExParam08;
    $09: Result := SCloseSlipExParam09;
    $0A: Result := SCloseSlipExParam0A;
    $0B: Result := SCloseSlipExParam0B;
    $0C: Result := SCloseSlipExParam0C;
    $0D: Result := SCloseSlipExParam0D;
    $0E: Result := SCloseSlipExParam0E;
    $0F: Result := SCloseSlipExParam0F;

    $10: Result := SCloseSlipExParam10;
    $11: Result := SCloseSlipExParam11;
    $12: Result := SCloseSlipExParam12;
    $13: Result := SCloseSlipExParam13;
    $14: Result := SCloseSlipExParam14;
    $15: Result := SCloseSlipExParam15;
    $16: Result := SCloseSlipExParam16;
    $17: Result := SCloseSlipExParam17;
    $18: Result := SCloseSlipExParam18;
    $19: Result := SCloseSlipExParam19;
    $1A: Result := SCloseSlipExParam1A;
    $1B: Result := SCloseSlipExParam1B;
    $1C: Result := SCloseSlipExParam1C;
    $1D: Result := SCloseSlipExParam1D;
    $1E: Result := SCloseSlipExParam1E;
    $1F: Result := SCloseSlipExParam1F;

    $20: Result := SCloseSlipExParam20;
    $21: Result := SCloseSlipExParam21;
    $22: Result := SCloseSlipExParam22;
    $23: Result := SCloseSlipExParam23;
    $24: Result := SCloseSlipExParam24;
    $25: Result := SCloseSlipExParam25;
    $26: Result := SCloseSlipExParam26;
    $27: Result := SCloseSlipExParam27;
    $28: Result := SCloseSlipExParam28;
    $29: Result := SCloseSlipExParam29;
    $2A: Result := SCloseSlipExParam2A;
    $2B: Result := SCloseSlipExParam2B;
    $2C: Result := SCloseSlipExParam2C;
    $2D: Result := SCloseSlipExParam2D;
    $2E: Result := SCloseSlipExParam2E;
    $2F: Result := SCloseSlipExParam2F;

    $30: Result := SCloseSlipExParam30;
    $31: Result := SCloseSlipExParam31;
    $32: Result := SCloseSlipExParam32;
    $33: Result := SCloseSlipExParam33;
    $34: Result := SCloseSlipExParam34;
    $35: Result := SCloseSlipExParam35;
    $36: Result := SCloseSlipExParam36;
    $37: Result := SCloseSlipExParam37;
    $38: Result := SCloseSlipExParam38;
    $39: Result := SCloseSlipExParam39;
    $3A: Result := SCloseSlipExParam3A;
    $3B: Result := SCloseSlipExParam3B;
    $3C: Result := SCloseSlipExParam3C;
    $3D: Result := SCloseSlipExParam3D;
    $3E: Result := SCloseSlipExParam3E;
    $3F: Result := SCloseSlipExParam3F;

    $40: Result := SCloseSlipExParam40;
    $41: Result := SCloseSlipExParam41;
    $42: Result := SCloseSlipExParam42;
    $43: Result := SCloseSlipExParam43;
    $44: Result := SCloseSlipExParam44;
    $45: Result := SCloseSlipExParam45;
    $46: Result := SCloseSlipExParam46;
    $47: Result := SCloseSlipExParam47;
    $48: Result := SCloseSlipExParam48;
    $49: Result := SCloseSlipExParam49;
    $4A: Result := SCloseSlipExParam4A;
    $4B: Result := SCloseSlipExParam4B;
    $4C: Result := SCloseSlipExParam4C;
    $4D: Result := SCloseSlipExParam4D;
    $4E: Result := SCloseSlipExParam4E;
    $4F: Result := SCloseSlipExParam4F;

    $50: Result := SCloseSlipExParam50;
    $51: Result := SCloseSlipExParam51;
    $52: Result := SCloseSlipExParam52;
    $53: Result := SCloseSlipExParam53;
    $54: Result := SCloseSlipExParam54;
    $55: Result := SCloseSlipExParam55;
    $56: Result := SCloseSlipExParam56;
    $57: Result := SCloseSlipExParam57;
    $58: Result := SCloseSlipExParam58;
    $59: Result := SCloseSlipExParam59;
    $5A: Result := SCloseSlipExParam5A;
    $5B: Result := SCloseSlipExParam5B;
    $5C: Result := SCloseSlipExParam5C;
    $5D: Result := SCloseSlipExParam5D;
    $5E: Result := SCloseSlipExParam5E;
    $5F: Result := SCloseSlipExParam5F;

    $60: Result := SCloseSlipExParam60;
    $61: Result := SCloseSlipExParam61;
    $62: Result := SCloseSlipExParam62;
    $63: Result := SCloseSlipExParam63;
    $64: Result := SCloseSlipExParam64;
    $65: Result := SCloseSlipExParam65;
    $66: Result := SCloseSlipExParam66;
    $67: Result := SCloseSlipExParam67;
    $68: Result := SCloseSlipExParam68;
    $69: Result := SCloseSlipExParam69;
    $6A: Result := SCloseSlipExParam6A;
    $6B: Result := SCloseSlipExParam6B;
    $6C: Result := SCloseSlipExParam6C;
    $6D: Result := SCloseSlipExParam6D;
  else
    Result := SNoDescrpiption;
  end;
end;

function GetSlipDiscountExParamName(Number: Integer): string;
begin
  case Number of
    $00: Result := SSlipDiscountExParam00;
    $01: Result := SSlipDiscountExParam01;
    $02: Result := SSlipDiscountExParam02;
    $03: Result := SSlipDiscountExParam03;
    $04: Result := SSlipDiscountExParam04;
    $05: Result := SSlipDiscountExParam05;
    $06: Result := SSlipDiscountExParam06;
    $07: Result := SSlipDiscountExParam07;
    $08: Result := SSlipDiscountExParam08;
    $09: Result := SSlipDiscountExParam09;
    $0A: Result := SSlipDiscountExParam0A;
    $0B: Result := SSlipDiscountExParam0B;
  else
    Result := SNoDescrpiption;
  end;
end;

function GetSlipOpenExParamName(Number: Integer): string;
begin
  case Number of
    $00: Result := SSlipOpenExParam00;
    $01: Result := SSlipOpenExParam01;
    $02: Result := SSlipOpenExParam02;
    $03: Result := SSlipOpenExParam03;
    $04: Result := SSlipOpenExParam04;
    $05: Result := SSlipOpenExParam05;
    $06: Result := SSlipOpenExParam06;
    $07: Result := SSlipOpenExParam07;
    $08: Result := SSlipOpenExParam08;
    $09: Result := SSlipOpenExParam09;
    $0A: Result := SSlipOpenExParam0A;
    $0B: Result := SSlipOpenExParam0B;
    $0C: Result := SSlipOpenExParam0C;
  else
    Result := SNoDescrpiption;
  end;
end;

function GetSlipRegExParamName(Number: Integer): string;
begin
  case Number of
    $00: Result := SSlipRegExParam00;
    $01: Result := SSlipRegExParam01;
    $02: Result := SSlipRegExParam02;
    $03: Result := SSlipRegExParam03;
    $04: Result := SSlipRegExParam04;
    $05: Result := SSlipRegExParam05;
    $06: Result := SSlipRegExParam06;
    $07: Result := SSlipRegExParam07;
    $08: Result := SSlipRegExParam08;
    $09: Result := SSlipRegExParam09;
    $0A: Result := SSlipRegExParam0A;
    $0B: Result := SSlipRegExParam0B;
    $0C: Result := SSlipRegExParam0C;
    $0D: Result := SSlipRegExParam0D;
    $0E: Result := SSlipRegExParam0E;
    $0F: Result := SSlipRegExParam0F;
    $10: Result := SSlipRegExParam10;
    $11: Result := SSlipRegExParam11;
    $12: Result := SSlipRegExParam12;
    $13: Result := SSlipRegExParam13;
    $14: Result := SSlipRegExParam14;
  else
    Result := SNoDescrpiption;
  end;
end;

end.
