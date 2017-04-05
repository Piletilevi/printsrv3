unit untTypes;

interface

type
  { TIntParam }

  TIntParam = record
    Name: string;
    Value: Integer;
  end;

resourcestring
  SBooleanTrue = '[да]';
  SBooleanFalse = '[нет]';
  SFlags = 'Флаги';
  SFMFlags = 'Флаги ФП';
  SFMFlagsEx = 'Доп. Флаги ФП';
  SFMMode = 'Режим ФП';
  SASPDMode = 'Режим АСПД';
  SIsCorruptedFMRecords = 'Повреждены 3 или более записей';
  SIsCorruptedFiscalizationInfo = 'Повреждена запись фискализации';
  SQuantityPointPosition = 'Увеличенная точность количества';
  SPresenterOut = 'Бумага на выходе из накопителя';
  SPresenterIn = 'Бумага на входе в накопитель';
  SIsEKLZOverflow = 'ЭКЛЗ почти заполнена';
  SIsDrawerOpen = 'Денежный ящик открыт';
  SLidPositionSensor = 'Крышка корпуса поднята';
  SReceiptRibbonLever = 'Рычаг термоголовки чека опущен';
  SJournalRibbonLever = 'Рычаг термоголовки журнала опущен';
  SReceiptRibbonOpticalSensor = 'Оптический датчик чека';
  SJournalRibbonOpticalSensor = 'Оптический датчик журнала';
  SEKLZIsPresent = 'ЭКЛЗ есть';
  SPointPosition = '2 знака после запятой в цене';
  SSlipDocumentIsPresent = 'Нижний датчик ПД';
  SSlipDocumentIsMoving = 'Верхний датчик ПД';
  SReceiptRibbonIsPresent = 'Рулон чековой ленты';
  SJournalRibbonIsPresent = 'Рулон контрольной ленты';
  SStatusQuery = ' Запрос состояния:';
  SPrinterMode = ' Режим: ';
  SPrinterSoftwareVersion = 'Версия ПО';
  SPrinterSoftwareBuild = 'Сборка ПО';
  SPrinterSoftwareDate = 'Дата ПО';
  SFMSoftwareVersion = 'Версия ПО ФП';
  SFMSoftwareBuild = 'Сборка ПО ФП';
  SFMSoftwareDate = 'Дата ПО ФП';
  SPrinterSubMode = 'Подрежим';
  SPrinterModeStatus = 'Статус режима';
  SLogicalNumber = 'Номер ККМ в зале';
  SDocumentNumber = 'Номер документа';
  SPortNumber = 'Номер порта';
  SRegistrationNumber = 'Количество фискализаций';
  SFreeRegistration = 'Осталось фискализаций';
  SSessionNumber = 'Последняя закрытая смена';
  SFreeRecordInFM = 'Свободных записей в ФП';
  SDate = 'Дата';
  SPrinterTime = 'Время';
  SSerialNumber = 'Заводской номер';
  SINN = 'ИНН';
  SIsFM24HoursOver = '24 часа в ФП кончились';
  SIsFMSessionOpen = 'Смена в ФП открыта';
  SIsLastFMRecordCorrupted = 'Последняя запись в ФП повреждена';
  SIsBatteryLow = 'Батарея ФП заряжена более 80 %';
  SFMOverflow = 'Переполнение ФП';
  SLicenseIsPresent = 'Лицензия введена';
  SFM2IsPresent = 'ФП2 есть';
  SFM1IsPresent = 'ФП1 есть';
  SShortStatusQuery = ' Краткий запрос состояния:';
  SQuantityOfOperations = 'Количество операций в чеке';
  SBatteryVoltage = 'Напряжение батареи, В';
  SPowerSourceVoltage = 'Напряжение источника, В';
  SFMResultCode = 'Ошибка ФП';
  SEKLZResultCode = 'Ошибка ЭКЛЗ';
  SPrinterParameters = ' Параметры принтера:';
  SUCodePage = ' Кодовая страница    : ';
  SUDescription = ' Описание устройства : ';
  SUMajorProtocolVersion = ' Версия протокола    : ';
  SUMinorProtocolVersion = ' Подверсия протокола : ';
  SUMajorType = ' Тип устройства      : ';
  SUMinorType = ' Подтип устройства   : ';
  SUModel = ' Модель устройства   : ';
  SPrinterLockedAfterInvalidTaxPassword =
    'Принтер заблокирован из-за ввода неправильного ' +
    'пароля налогового инспектора';
  SPrinterInTechnologicalMode =
    'Принтер находится в режиме технологического обнуления';
  SModelParameters = ' Параметры Модели:';
  SDriverVersionCaption = ' Версия драйвера:';
  SDriverMajorVersion = 'Версия';
  SDriverMinorVersion = 'Подверсия';
  SDriverRelease = 'Релиз';
  SDriverBuild = 'Сборка';
  SDriverVersion = 'Полная версия';
  SFullStatus = ' Полное состояние';

  SUserAbort = '<Прервано пользователем>';
  SErrorAbort = '<Прервано в результате ошибки: %d %s>';

  SCashRegisters      = ' ДЕНЕЖНЫЕ РЕГИСТРЫ:';
  SOperationRegisters = ' ОПЕРАЦИОННЫЕ РЕГИСТРЫ:';
  STableInfo = ' ТАБЛИЦА %d. %s. Рядов:%d Полей:%d';
  STableHeader = ' Ряд.Поле. Наименование:Значение';
  STables = ' ТАБЛИЦЫ:';
  SOperatorNumber = 'Номер оператора';
  SCurrentDate = 'Текущая дата';
  SCurrentTime = 'Текущее время';
  SSaleReceiptNumber = 'Количество чеков продаж';
  SBuyReceiptNumber = 'Количество чеков покупок';
  SRetSaleReceiptNumber = 'Количество чеков возврата продаж';
  SRetBuyReceiptNumber = 'Количество чеков возврата покупок';
  SDayOpenDate = 'Дата начала открытой смены';
  SDayOpenTime = 'Время начала открытой смены';
  SCashTotal = 'Наличные в кассе';
  SFlagSerialized = 'Сериализована';
  SFlagFiscalized = 'Фискализирована';
  SFlagActivated = 'Активизирована';
  SFlagDayOpened = 'Смена открыта';
  SFlagDayExausted = '24 часа кончились';
  SPrintBufferEmpty = 'Буфер печати пуст';
  SStatusByte = 'Байт состояния';
  STimeout = 'Таймаут';
  SEnterComputerName = 'Укажите имя компьютера';
  SData = 'Данные';
  SMacNumber = 'Номер КПК';
  SContinueAfterError = 'Ошибка %d: %s'#10#13'Продолжить?';
  SBlockNumber = 'Получено блоков: %d';
  SPump = 'ТРК';
  STicket = 'СЧЕТ';
  SPrice = 'Цена';
  SSumm1 = 'Сумма 1';
  SSumm2 = 'Сумма 2';
  SSumm3 = 'Сумма 3';
  SSumm4 = 'Сумма 4';
  SNumber = 'Номер';
  SQuantity = 'Количество';
  SDiscount = 'Скидка на чек';
  SString = 'Строка';
  STax1 = 'Налог 1';
  STax2 = 'Налог 2';
  STax3 = 'Налог 3';
  STax4 = 'Налог 4';
  SGeneral = 'Основные';
  SNo = 'Нет';
  SGroup1 = '1 группа';
  SGroup2 = '2 группа';
  SGroup3 = '3 группа';
  SGroup4 = '4 группа';
  SStringForPrinting = 'Строка для печати';
  SExtended = 'Дополнительные';
  SSlipDocumentWidth = 'Ширина';
  SSlipDocumentLength = 'Длина';
  SPrintingAlignment = 'Ориентация';
  SSlipLineSpacing = 'Межстрочный интервал между строками: %d и %d';
  SExciseCode = 'Код акциза';

  SSlipCopyType = 'Дублирование печати';
  SSlipReceiptType = 'Тип чека';
  SSlipCopyOffset1 = 'Смещение 1';
  SSlipCopyOffset2 = 'Смещение 2';
  SSlipCopyOffset3 = 'Смещение 3';
  SSlipCopyOffset4 = 'Смещение 4';
  SSlipCopyOffset5 = 'Смещение 5';
  SSlipNumberOfCopies = 'Количество копий';
  SLine1 = 'Строка 1';
  SLine2 = 'Строка 2';
  SDepartment = 'Отдел';
  STableName = 'Название таблицы';
  SRowCount = 'Количество рядов: ';
  SFieldCount = 'Количество полей';
  SFieldName = 'Название поля';
  SFieldTypeString = 'Тип поля: строка';
  SFieldTypeNumber = 'Тип поля: число';
  SFieldSize = 'Размер поля';
  SMinValue = 'Мин. значение';
  SMaxValue = 'Макс. значение';
  STableStructure = 'Структура поля';
  SNewTaxPassword = 'Новый пароль НИ';
  SFiscalizationNumber = 'Номер фискализации';
  SStartDay = 'Начальная смена';
  SEndDay = 'Конечная смена';
  STaxPasswordConfirmation = 'Будет введен пароль налогового инспектора (%d)'#13#10 +
    'В случае ошибки принтер будет заблокирован до ввода правильного пароля.'#13#10 +
    'Продолжить?';

  SSale = 'Продажа';
  SBuy = 'Покупка';
  SRetSale = 'Возврат продажи';
  SRetBuy = 'Возврат покупки';
  SSaleStorno = 'Сторно продажи';
  SBuyStorno = 'Сторно покупки';
  SRetSaleStorno = 'Сторно возврата продажи';
  SRetBuyStorno = 'Сторно возврата покупки';

  SReceipt = 'Чек';
  SLine = 'строка';

  SAlignmentText = 'По центру'#13#10'Влево'#13#10'Вправо';
  SPrintWidth576 = 'Полная ширина печати. 576 точек';
  SLeftBound = 'Левая граница. Точка 1 печатается';
  SRightBound = 'Правая граница. Точка 576 печатается';
  SPrintWidth560 = 'Вывод - ширина печати 560 точек, а не 576';
  SPrinterType = 'Тип ККМ';
  SAttention = 'Внимание!';
  SConfirmFiscalization = 'Фискализацию аппарата нельзя отменить.'#13#10+
    'Вы хотите продолжить?';

const
  BoolToStr: array [Boolean] of string = (SBooleanFalse, SBooleanTrue);

implementation

end.
