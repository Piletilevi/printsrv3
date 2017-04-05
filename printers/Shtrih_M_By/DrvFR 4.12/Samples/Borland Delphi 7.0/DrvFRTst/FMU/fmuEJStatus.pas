unit fmuEJStatus;

interface

uses
  // VCL
  Windows, StdCtrls, Controls, Classes, Forms, Sysutils, ExtCtrls, Graphics,
  // This
  untPages, untUtil, untDriver, untTypes;

type
  { TfmEJStatus }

  TfmEJStatus = class(TPage)
    Memo: TMemo;
    btnGetEJCode1Status: TButton;
    btnGetEJCode2Status: TButton;
    btnEJVersion: TButton;
    btnGetEJSerialNumber: TButton;
    btnGetAll: TButton;
    btnGetEJCode3Status: TButton;
    procedure btnGetEJSerialNumberClick(Sender: TObject);
    procedure btnGetEJCode1StatusClick(Sender: TObject);
    procedure btnGetEJCode2StatusClick(Sender: TObject);
    procedure btnEJVersionClick(Sender: TObject);
    procedure btnGetAllClick(Sender: TObject);
    procedure btnGetEJCode3StatusClick(Sender: TObject);
  private
    procedure AddSeparator;
    procedure GetEKLZVersion;
    procedure GetEKLZCode1Status;
    procedure GetEKLZCode2Status;
    procedure GetEKLZCode3Status;
    procedure GetEKLZSerialNumber;
    procedure EKLZFlagsToMemo;
  end;

implementation

{$R *.DFM}

const
  SDocTypeSale    = 'продажа';
  SDocTypeBuy     = 'покупка';
  SDocTypeRetSale = 'возврат продажи';
  SDocTypeRetBuy  = 'возврат покупки';

  SEJFlagDoscType         = '  <T> Тип документа         : ';
  SEJFlagArchiveOpened    = '  <I> Открыт архив          : ';
  SEJFlagActivated        = '  <F> Выполнена активизация : ';
  SEJFlagReportMode       = '  <W> Режим отчета          : ';
  SEJFlagDocOpened        = '  <D> Открыт документ       : ';
  SEJFlagDayOpened        = '  <S> Открыта смена         : ';
  SEJFlagError            = '  <A> Ошибка устройства     : ';

  SLastKPKDate            = ' Дата                 : ';
  SLastKPKTime            = ' Время                : ';
  SLastKPKDocumentResult  = ' Итог                 : ';
  SLastKPKNumber          = ' Номер КПК            : ';
  SEKLZNumber             = ' Регистр. номер ЭКЛЗ  : ';
  SSessionNumber          = ' Номер смены     : ';
  SSaleAmount             = ' Продажа         : ';
  SBuyAmount              = ' Покупка         : ';
  SRetSaleAmount          = ' Возврат продаж  : ';
  SRetBuyAmount           = ' Возврат покупок : ';
  SEKLZNumberShort        = ' Регистр. номер  : ';
  SEKLZVersion            = ' Версия          : ';

{ TfmEJStatus }

procedure TfmEJStatus.btnGetEJSerialNumberClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Memo.Lines.Add('');
    GetEKLZSerialNumber;
    AddSeparator;    
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJStatus.btnGetEJCode1StatusClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Memo.Lines.Add('');
    GetEKLZCode1Status;
    AddSeparator;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJStatus.btnGetEJCode2StatusClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Memo.Lines.Add('');
    GetEKLZCode2Status;
    AddSeparator;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJStatus.btnEJVersionClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Memo.Lines.Add('');
    GetEKLZVersion;
    AddSeparator;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJStatus.EKLZFlagsToMemo;
const
  DocType: array [0..3] of WideString = (
    SDocTypeSale,
    SDocTypeBuy,
    SDocTypeRetSale,
    SDocTypeRetBuy);
var
  Flags: Integer;
begin
  Flags := Driver.EKLZFlags;
  Memo.Lines.Add(SEJFlagDoscType + DocType[Flags and $3]);
  Memo.Lines.Add(SEJFlagArchiveOpened + BoolToStr[Flags and $4=$4]);
  Memo.Lines.Add(SEJFlagActivated + BoolToStr[Flags and $8=$8]);
  Memo.Lines.Add(SEJFlagReportMode + BoolToStr[Flags and $10=$10]);
  Memo.Lines.Add(SEJFlagDocOpened + BoolToStr[Flags and $20=$20]);
  Memo.Lines.Add(SEJFlagDayOpened + BoolToStr[Flags and $40=$40]);
  Memo.Lines.Add(SEJFlagError + BoolToStr[Flags and $80=$80]);
end;

procedure TfmEJStatus.GetEKLZCode1Status;
begin
  Check(Driver.GetEKLZCode1Report);
  AddSeparator;
  Memo.Lines.Add(SLastKPKDate + DateToStr(Driver.LastKPKDate));
  Memo.Lines.Add(SLastKPKTime + TimeToStr(Driver.LastKPKTime));
  Memo.Lines.Add(SLastKPKDocumentResult + Driver.AmountToStr(Driver.LastKPKDocumentResult));
  Memo.Lines.Add(SLastKPKNumber + IntToStr(Driver.LastKPKNumber));
  Memo.Lines.Add(SEKLZNumber + Driver.EKLZNumber);
  AddSeparator;
  Memo.Lines.Add(Format(' %s (%d)', [SFlags, Driver.EKLZFlags]));
  EKLZFlagsToMemo;
  // Scroll memo to beginning
  Memo.SelStart := 0;
  Memo.SelLength := 0;
end;

procedure TfmEJStatus.GetEKLZCode2Status;
begin
  Check(Driver.GetEKLZCode2Report);
  AddSeparator;
  Memo.Lines.Add(SSessionNumber + IntToStr(Driver.SessionNumber));
  Memo.Lines.Add(SSaleAmount + Driver.AmountToStr(Driver.Summ1));
  Memo.Lines.Add(SBuyAmount + Driver.AmountToStr(Driver.Summ2));
  Memo.Lines.Add(SRetSaleAmount + Driver.AmountToStr(Driver.Summ3));
  Memo.Lines.Add(SRetBuyAmount  + Driver.AmountToStr(Driver.Summ4));
end;

procedure TfmEJStatus.GetEKLZCode3Status;
const
  STransmitStatus         = 'Код состояния передачи данных  : ';
  STransmitQueueSize      = 'Документов в очереди отправки  : ';
  STransmitSessionNumber  = 'Номер отправленной смены       : ';
  STransmitDocumentNumber = 'Номер отправленного документа  : ';
begin
  if Driver.GetEKLZCode3Report = 0 then
  begin
    AddSeparator;
    Memo.Lines.Add(STransmitStatus + IntToStr(Driver.TransmitStatus));
    Memo.Lines.Add(STransmitQueueSize + IntToStr(Driver.TransmitQueueSize));
    Memo.Lines.Add(STransmitSessionNumber + IntToStr(Driver.TransmitSessionNumber));
    Memo.Lines.Add(STransmitDocumentNumber + IntToStr(Driver.TransmitDocumentNumber));
  end;
end;

procedure TfmEJStatus.GetEKLZSerialNumber;
begin
  Check(Driver.GetEKLZSerialNumber);
  AddSeparator;
  Memo.Lines.Add(SEKLZNumberShort + Driver.EKLZNumber);
end;

procedure TfmEJStatus.GetEKLZVersion;
begin
  Check(Driver.GetEKLZVersion);
  AddSeparator;
  Memo.Lines.Add(SEKLZVersion + Driver.EKLZVersion);
end;

procedure TfmEJStatus.btnGetAllClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Memo.Lines.Add('');
    GetEKLZCode1Status;
    GetEKLZCode2Status;
    GetEKLZCode3Status;
    GetEKLZVersion;
    GetEKLZSerialNumber;
    AddSeparator;
    // Прокручиваем Memo на начало
    Memo.SelStart := 0;
    Memo.SelLength := 0;
  finally
    EnableButtons(True);
  end;
end;

procedure TfmEJStatus.AddSeparator;
begin
  Memo.Lines.Add(' ' + StringOfChar('-', 36));
end;

procedure TfmEJStatus.btnGetEJCode3StatusClick(Sender: TObject);
begin
  EnableButtons(False);
  try
    Memo.Clear;
    Memo.Lines.Add('');
    GetEKLZCode3Status;
    AddSeparator;
  finally
    EnableButtons(True);
  end;
end;

end.
