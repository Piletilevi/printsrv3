# -*- coding: utf-8 -*-
import win32com.client
import pythoncom
import time
import ConfigParser

#TODO
# - implement LOOP. Z buffer printing when 24h shift is over
# - implement refund sale

class ECR_Object:
    def __init__(self):
        print "pythoncom._GetInterfaceCount():", pythoncom._GetInterfaceCount()
        pythoncom.CoInitialize()
        print "pythoncom._GetInterfaceCount() after CoInitialize():", pythoncom._GetInterfaceCount()
        self.Password = 30
        self.m_Device = win32com.client.Dispatch("AddIn.Drvfr")



        #self.m_Device = win32com.client.dynamic.Dispatch("AddIn.Drvfr")
        #self.m_Device = win32com.client.gencache.EnsureDispatch("AddIn.Drvfr")
    ##################################################################
    def Connect(self, cfg):
    ##################################################################
        self.PrintStatus(verbose=True)
        print "System defaults:"
        print " ECRSoftVersion:%s"%self.m_Device.ECRSoftVersion
        print " ComNumber:%s"%self.m_Device.ComNumber
        print " BaudRate:%s"%self.m_Device.BaudRate
        print " Timeout:%s"%self.m_Device.Timeout
        print " ComputerName:%s"%self.m_Device.ComputerName
        try:
            print " Connected:%s"%self.m_Device.Connected
        except:
            print "exception while printing self.m_Device.Connected. Probably version 4.9?"

        print "Setting Connected=True"
        try:
            self.m_Device.Connected = True
        except:
            print "exception while setting self.m_Device.Connected = True. Probably version 4.9?"

        print "Calling Connect() ..."
        #try:
        self.m_Device.Password = self.Password

        # Driver version 4.9 does not set com port and baudrate correctly. We need to specify it in ini file
        if cfg.has_option('DEFAULT', 'kkm_port_no'):
            # COM1 = 1, COM2 = 2, etc. Documentation is wrong. It says COM1=0, COM2=1, etc
            self.m_Device.ComNumber = int(cfg.get('DEFAULT', 'kkm_port_no'))# 2 # com2

        if cfg.has_option('DEFAULT', 'kkm_port_baudrate'):
            # 2400=0, 4800=1, 9600=2, 19200=3, 38400=4, 57600=5, 115200=6
            self.m_Device.BaudRate = int(cfg.get('DEFAULT', 'kkm_port_baudrate')) #6 # 115200

        #self.m_Device.Timeout = 1000
        #self.m_Device.ComputerName = "Local"
        try:
            ret = self.m_Device.Connect()
        except:
            print "exception while doing self.m_Device.Connect(). Probably version 4.9?"

        try:
            print "Connect():%s,%s"%(ret, self.m_Device.Connected)
        except:
            print "exception while printing self.m_Device.Connected. Probably version 4.9?"
    ##################################################################
    def StartShift(self):
    ##################################################################
        # check if there is paper
        if(self.DeviceIsReadyForPrinting()):
            self.m_Device.Password = self.Password
            ret = self.m_Device.PrintReportWithoutCleaning()
            print "PrintReportWithoutCleaning(): %s,%s"%(ret, self.m_Device.ResultCodeDescription)
            return ret == 0
        return False

    ##################################################################
    def EndShift(self):
    ##################################################################

        #if(self.DeviceIsReadyForPrinting()): # PrintZReportInBuffer fails with Attribute error
        if(True):
            self.m_Device.Password = self.Password
            ret = self.m_Device.PrintReportWithCleaning()
            print "PrintReportWithCleaning(): %s,%s"%(ret , self.m_Device.ResultCodeDescription)
            return ret == 0
        return False

    ##################################################################
    def PrintStatus(self, verbose=True):
    ##################################################################
        self.m_Device.Password = self.Password
        ret = self.m_Device.GetShortECRStatus()
        if(verbose):
            print "     status GetShortECRStatus():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
            #self.m_Device.Password = self.Password
            print "            ECRMode = %s,%s"%(self.m_Device.ECRMode, self.m_Device.ECRModeDescription)
            #self.m_Device.Password = self.Password
            print "            ECRAdvancedMode = %s,%s"%(self.m_Device.ECRAdvancedMode, self.m_Device.ECRAdvancedModeDescription)
        return ret == 0

    ##################################################################
    def WaitWhilePrinting(self):
    ##################################################################
        self.m_Device.Password = self.Password
        print "     printing1 ... GetShortECRStatus():%s,%s"%(self.m_Device.GetShortECRStatus(), self.m_Device.ResultCodeDescription)
        print "            ECRAdvancedMode:%s"%self.m_Device.ECRAdvancedMode,
        print "            ECRMode:%s"%self.m_Device.ECRMode
        while(self.m_Device.ECRAdvancedMode == 5):
            time.sleep(0.2)
            self.m_Device.Password = self.Password
            print "     printing2 ... GetShortECRStatus():%s,%s"%(self.m_Device.GetShortECRStatus(), self.m_Device.ResultCodeDescription)

    ##################################################################
    def PrintZReportInBuffer(self):
    ##################################################################
        # печать сменного отчета с гашением в буфер
        #self.m_Device.Password = self.Password
        #ret = self.m_Device.PrintZReportInBuffer() #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        #print "PrintZReportInBuffer():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
        #return ret == 0
        print "WARNING PrintZReportInBuffer not supported"
        return True

    ##################################################################
    def Poll(self):
    ##################################################################
        self.PrintStatus(verbose=False) # just update status variables

        #смотрим, если подрежим 3 (не было бумаги), надо попробовать вызвать продолжение печати
        if (self.m_Device.ECRAdvancedMode == 3):

            #logger.Info("Устройство в режиме \"После активного отсутствия бумаги\"");
            #logger.Info("Запрашиваем продолжение печати");

            # запрос возобновления печати
            self.m_Device.Password = self.Password
            ret = self.m_Device.ContinuePrint()
            print "ContinuePrint():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
            if(ret!=0):
                return False

            #logger.Info("Продолжение печати выполнено успешно");
            self.PrintStatus(verbose=False) # just update status variables

        #открытая смена, 24 часа кончились
        if (self.m_Device.ECRMode == 3):
            #logger.Info("Обнаружено окончание 24 часов при открытой смене");

            # снимаем z-отчет в буфер
            if (self.PrintZReportInBuffer()):
                # запрашиваем снова состояние
                self.PrintStatus(verbose=False) # just update status variables

        # проверяем проблемные состояния
        if self.m_Device.ECRMode == 3:
            print "ERROR: Shift open, 24h ended. Need to make ZReport"
            return False
        elif self.m_Device.ECRMode == 5:
            print "ERROR: Blocked because of wrong password of tax inspector"
            return False
        elif self.m_Device.ECRMode == 6:
            print "ERROR: Waiting for Date confirmation"
            self.ResetPrinter()
            return False
        elif self.m_Device.ECRMode == 7:
            print "ERROR: Confirmation to change decimal point?"
            self.ResetPrinter()
            return False
        elif self.m_Device.ECRMode == 9:
            print "ERROR: State to allow technological reset"
            self.ResetSettings()
            return False

        # дополнительные проблемные состояния
        if self.m_Device.ECRAdvancedMode == 1:
            print "ERROR: no paper. passive"
            return False
        elif self.m_Device.ECRAdvancedMode == 2:
            print "ERROR: no paper. active"
            return False
        elif self.m_Device.ECRAdvancedMode == 3:
            print "ERROR: paper available again. waiting to continue printing"
            return False

        return True
    ##################################################################
    def DeviceIsReadyForPrinting(self):
    ##################################################################
        if not self.Poll():
            print "DeviceIsReadyForPrinting() = False, because Poll() = False"
            return False

        # ожидаем завершения печати
        #ExecCommand(YarusKKTCommand.WaitForPrinting);
        self.WaitWhilePrinting()
        self.PrintStatus(verbose=False) # just update status variables

        # допустимое состояние для печати
        if self.m_Device.ECRAdvancedMode == 0:
            print "DeviceIsReadyForPrinting() = True"
            return True
        print "DeviceIsReadyForPrinting() = False"
        return False

    ##################################################################
    def DeviceIsReadyForSale(self):
    ##################################################################
        if not self.DeviceIsReadyForPrinting():
            return False

        # допустимые состояния
        if self.m_Device.ECRMode == 2 :# Открытая смена, 24 часа не кончились
            print "DeviceIsReadyForSale() = True, because ECRMode = 2"
            return True
        elif self.m_Device.ECRMode == 4 :# Закрытая смена
            print "DeviceIsReadyForSale() = True, because ECRMode = 4"
            return True
        elif self.m_Device.ECRMode == 8 :# Открытый документ
            print "Open document. CancelCheck"
            self.m_Device.Password = self.Password
            print "CancelCheck():%s,%s"%(self.m_Device.CancelCheck(), self.m_Device.ResultCodeDescription)
            # запрашиваем состояние
            self.PrintStatus()
            self.WaitWhilePrinting()
            self.PrintStatus()
            #self.m_Device.Password = self.Password
            #if (self.m_Device.GetShortECRStatus()!=0):
            #    #ResultToErrorState();
            #    return False;

        # если вышли в правильный режим - всё хорошо
        if ((self.m_Device.ECRMode == 2 or self.m_Device.ECRMode == 4) and self.m_Device.ECRAdvancedMode == 0):
            print "DeviceIsReadyForSale() = True, because ECRMode = 2||4 and ECRAdvancedMode = 0"
            return True#!m_FatalError && m_ErrorStateCode == 0
        print "DeviceIsReadyForSale() = False"
        return False
    ##################################################################
    def ResetPrinter(self):
    ##################################################################
        self.PrintStatus()
        self.m_Device.Password = self.Password
        ret = self.m_Device.ResetECR()
        print "ResetECR():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
        self.PrintStatus()
    ##################################################################
    def InitFM(self):
    ##################################################################
        self.PrintStatus()
        self.m_Device.Password = self.Password
        ret = self.m_Device.InitFM()
        print "InitFM():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
        self.PrintStatus()

    ##################################################################
    def ResetSettings(self):
    ##################################################################
        self.PrintStatus()
        self.m_Device.Password = self.Password
        ret = self.m_Device.ResetSettings()
        print "ResetSettings():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
        self.PrintStatus()

    ##################################################################
    # CheckType 0 = sale, 1 = buy, 2 = return sale, 3 = return buy
    def Sale(self, cfg, CheckType = 0, Price = 0, StringForPrinting = ''):
    ##################################################################

        if not self.DeviceIsReadyForSale():
            print "NOT READY FOR SALE"
            return False

        print "DEBUG: Sale(Price:%s,StringForPrinting%s)"%(Price,StringForPrinting)

        self.m_Device.SlipDocumentWidth = 0
        self.m_Device.SlipDocumentLength = 0
        self.m_Device.PrintingAlignment = 0
        #self.m_Device.SlipStringIntervals: ???
        self.m_Device.CheckType = CheckType # 0 = sale, 1 = buy, 2 = return sale, 3 = return buy

        self.m_Device.Password = self.Password
        ret = self.m_Device.OpenCheck()
        print "OpenCheck():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
        if ret == 78: #Смена превысила 24 часа
            print "ERROR: shift exceeded 24h. Do End Shift."
            self.m_Device.Password = self.Password
            ret = self.m_Device.CancelCheck()
            print "       CancelCheck():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
            return False
            #print "WARNING: shift exceeded 24h. will try to fix with PrintZReportInBuffer()"
            # снимаем z-отчет в буфер
            #if (self.PrintZReportInBuffer()):
            #    # запрашиваем снова состояние
            #    self.PrintStatus(verbose=False) # just update status variables
            #    # let's try to OpenCheck() again
            #    self.m_Device.Password = self.Password
            #    ret = self.m_Device.OpenCheck()
            #    print "OpenCheck():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
            #    if ret!=0:
            #        print "ERROR: repeted OpenCheck() failed after PrintZReportInBuffer()"
            #        return False
            #else:
            #    print "ERROR: PrintZReportInBuffer() failed."
            #    return False

        ########
        self.WaitWhilePrinting()
        ########
        self.m_Device.Quantity = 1
        self.m_Device.Price = float(Price) #cfg.get('DEFAULT', 'tickets_cost') #tickets_cost
        self.m_Device.Department = 1
        self.m_Device.Tax1 = 0
        self.m_Device.Tax2 = 0
        self.m_Device.Tax3 = 0
        self.m_Device.Tax4 = 0

        if(cfg.get('DEFAULT', 'kkm_encoding_type') == 'utf-8'):
            self.m_Device.StringForPrinting = StringForPrinting
        elif(cfg.get('DEFAULT', 'kkm_encoding_type') == 'unicode'):
            self.m_Device.StringForPrinting = StringForPrinting.decode('utf-8')
        elif(cfg.get('DEFAULT', 'kkm_encoding_type') == 'cp1251'):
            self.m_Device.StringForPrinting = StringForPrinting.decode('utf-8').encode('cp1251')
        else:
            # default
            print "WARNING: wrong encoding. using default"
            self.m_Device.StringForPrinting = StringForPrinting.decode('utf-8').encode('cp1251')

        self.m_Device.Password = self.Password
        ret = self.m_Device.Sale()
        print "Sale():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
        if(ret == 163):
            # this is bad. "Некорректное состояние ЭКЛЗ" . do reset
            print "ERROR: Sale() returned wrong EKL state. This is bad. will try to do full reset and init!"
            self.m_Device.Password = self.Password
            ret = self.m_Device.CancelCheck()
            print "       CancelCheck():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
            #self.ResetPrinter() # wrongs params error ??
            self.ResetSettings()
            #self.InitFM()
            return False
        ########
        self.WaitWhilePrinting()
        ########


        self.m_Device.StringForPrinting = ""
        self.m_Device.Password = self.Password
        ret = self.m_Device.CheckSubTotal()
        print "CheckSubTotal():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
        if ret == 115:
            print "ERROR: CheckSubTotal() command is not supported in this state"
            return False

        ########
        self.WaitWhilePrinting()
        ########
        self.m_Device.Summ1 = 0
        self.m_Device.Summ2 = 0
        self.m_Device.Summ3 = 0
        self.m_Device.Summ4 = 0

        # this makes it possible to select different payment methods
        if cfg.has_option('DEFAULT', 'payment_1'):
            print "DEBUG: setting payment_1"
            self.m_Device.Summ1 = float(Price)
        if cfg.has_option('DEFAULT', 'payment_2'):
            print "DEBUG: setting payment_2"
            self.m_Device.Summ2 = float(Price)
        if cfg.has_option('DEFAULT', 'payment_3'):
            print "DEBUG: setting payment_3"
            self.m_Device.Summ3 = float(Price)
        if cfg.has_option('DEFAULT', 'payment_4'):
            print "DEBUG: setting payment_4"
            self.m_Device.Summ4 = float(Price)

        self.m_Device.Password = self.Password
        ret = self.m_Device.CloseCheck()
        print "CloseCheck():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
        if(ret == -1):
            self.PrintStatus(verbose=False)
            if(self.m_Device.ECRMode == 8):
                self.m_Device.Password = self.Password
                ret = self.m_Device.CancelCheck()
                print "       CancelCheck():%s,%s"%(ret, self.m_Device.ResultCodeDescription)

        ########
        self.WaitWhilePrinting()
        ########
        self.m_Device.CutType = True
        self.m_Device.Password = self.Password
        ret = self.m_Device.CutCheck()
        print "CutCheck():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
        if ret == 74:
            # operation not possible. Check is still open
            # cancel and retry cutting
            self.m_Device.Password = self.Password
            ret = self.m_Device.CancelCheck()
            print "       CancelCheck():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
            self.m_Device.CutType = True
            self.m_Device.Password = self.Password
            ret = self.m_Device.CutCheck()
            print "retry CutCheck():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
        elif ret == -1:
            self.PrintStatus(verbose=False)
            if(self.m_Device.ECRMode == 8):
                self.m_Device.Password = self.Password
                ret = self.m_Device.CancelCheck()
                print "       CancelCheck():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
                self.m_Device.CutType = True
                self.m_Device.Password = self.Password
                ret = self.m_Device.CutCheck()
                print "retry CutCheck():%s,%s"%(ret, self.m_Device.ResultCodeDescription)


    ##################################################################
    def Refund(self, cfg, CheckType = 2, Price = 0.0, StringForPrinting = ''):
    ##################################################################
        # TODO !!!!!!!!!!!!!!!
        if not self.DeviceIsReadyForSale():
            print "NOT READY FOR REFUND"
            return False


        self.m_Device.SlipDocumentWidth = 0
        self.m_Device.SlipDocumentLength = 0
        self.m_Device.PrintingAlignment = 0
        #self.m_Device.SlipStringIntervals: ???
        self.m_Device.CheckType = CheckType # 0 = sale, 1 = buy, 2 = return sale, 3 = return buy

        self.m_Device.Password = self.Password
        ret = self.m_Device.OpenCheck()
        print "OpenCheck():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
        if ret == 78: #Смена превысила 24 часа
            print "ERROR: shift exceeded 24h. Do End SHift"


        ########
        self.WaitWhilePrinting()
        ########
        self.m_Device.Quantity = 1
        self.m_Device.Price = float(Price) #tickets_cost
        self.m_Device.Department = 1
        self.m_Device.Tax1 = 0
        self.m_Device.Tax2 = 0
        self.m_Device.Tax3 = 0
        self.m_Device.Tax4 = 0

        #self.m_Device.StringForPrinting = cfg.get('DEFAULT', 'tickets_name').decode('utf-8')#.encode('koi8-r')
        if(cfg.get('DEFAULT', 'kkm_encoding_type') == 'utf-8'):
            self.m_Device.StringForPrinting = StringForPrinting
        elif(cfg.get('DEFAULT', 'kkm_encoding_type') == 'unicode'):
            self.m_Device.StringForPrinting = StringForPrinting.decode('utf-8')
        elif(cfg.get('DEFAULT', 'kkm_encoding_type') == 'cp1251'):
            self.m_Device.StringForPrinting = StringForPrinting.decode('utf-8').encode('cp1251')
        else:
            # default
            print "WARNING: wrong encoding. using default"
            self.m_Device.StringForPrinting = StringForPrinting.decode('utf-8').encode('cp1251')
        self.m_Device.Password = self.Password
        ret = self.m_Device.ReturnSale()
        print "ReturnSale():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
        #return self.Sale(cfg, CheckType = 2)

        ########
        self.WaitWhilePrinting()
        ########
        self.m_Device.StringForPrinting = ""
        self.m_Device.Password = self.Password
        ret = self.m_Device.CheckSubTotal()
        print "CheckSubTotal():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
        if ret == 115:
            print "ERROR: CheckSubTotal() command is not supported in this state"
            return False

        ########
        self.WaitWhilePrinting()
        ########
        self.m_Device.Summ1 = 0
        self.m_Device.Summ2 = 0
        self.m_Device.Summ3 = 0
        self.m_Device.Summ4 = 0

        # this makes it possible to select different payment methods
        if cfg.has_option('DEFAULT', 'payment_1'):
            print "DEBUG: setting payment_1"
            self.m_Device.Summ1 = float(Price)
        if cfg.has_option('DEFAULT', 'payment_2'):
            print "DEBUG: setting payment_2"
            self.m_Device.Summ2 = float(Price)
        if cfg.has_option('DEFAULT', 'payment_3'):
            print "DEBUG: setting payment_3"
            self.m_Device.Summ3 = float(Price)
        if cfg.has_option('DEFAULT', 'payment_4'):
            print "DEBUG: setting payment_4"
            self.m_Device.Summ4 = float(Price)


        self.m_Device.Password = self.Password
        ret = self.m_Device.CloseCheck()
        print "CloseCheck():%s,%s"%(ret, self.m_Device.ResultCodeDescription)

        ########
        self.WaitWhilePrinting()
        ########
        self.m_Device.CutType = True
        self.m_Device.Password = self.Password
        ret = self.m_Device.CutCheck()
        print "CutCheck():%s,%s"%(ret, self.m_Device.ResultCodeDescription)
        return True #?

    ##################################################################
    def WaitForECRMode(self, mode): #not tested ...
    ##################################################################
        #logger.Info("Ожидание перехода в режим {0}", mode);
        self.m_Device.Password = self.Password
        # максимум 5 секунд
        retryCount = 5000 / 200
        # обнаружена ошибка
        badECRMode = False;
        while (self.m_Device.GetShortECRStatus()==0 and self.m_Device.ECRMode != mode and retryCount > 0 and not badECRMode):
            #logger.Debug("  ECRMode: {0}, {1}", m_Device.ECRMode, m_Device.ECRModeDescription);

            # смотрим, может режим полной ошибки
            if (self.m_Device.ECRMode in [5,6,7,9]):
                #case 5: #// Блокировка по неправильному паролю налогового инспектора
                #case 6: #// Ожидание подтверждения ввода даты
                #case 7: #// Разрешение изменения положения десятичной точки
                #case 9: #// Режим разрешения технологического обнуления
                    badECRMode = True
            else:
                    #// ждем 200ms
                    time.sleep(200)

            retryCount-= 1

        #logger.Info("Ожидание перехода в режим {0} завершилось {1}", mode, m_Device.ECRMode == mode ? "успехом" : "неудачей");
        #logger.Debug("  ECRMode: {0}, {1}", m_Device.ECRMode, m_Device.ECRModeDescription);

        return self.m_Device.ECRMode == mode
    ##################################################################
    def PrintEKLZVersion(self):
    ##################################################################
        self.m_Device.Password = self.Password
        ret = self.m_Device.GetEKLZVersion()
        print "GetEKLZVersion(): %s, %s"%(ret, self.m_Device.EKLZVersion)

    ##################################################################
    def PrintCheckString(self):
    ##################################################################
        #global m_Device

        self.m_Device.Password = self.Password
        self.m_Device.UseReceiptRibbon = 1
        self.m_Device.UseJournalRibbon = 1
        self.m_Device.StringForPrinting = "test2"
        self.m_Device.FontType = 4
        #m_Device.PrintStringWithFont()
        print "PrintStringWithFont():", self.m_Device.PrintStringWithFont()
        self.m_Device.Password = self.Password
        print "ResultCodeDescription:", self.m_Device.ResultCodeDescription

    ##################################################################
    def ParsePLP(self, cfg):
    ##################################################################
        print "ECR module, ParsePLP"
        self.PrintEKLZVersion()
        if (not cfg.has_option('DEFAULT', 'operation')):
            print "ERROR: no operation parameter in plp file. exiting"
            return False
        print "ParsePLP: operation:",cfg.get('DEFAULT', 'operation')

        if(cfg.get('DEFAULT', 'operation')=="startshift"):
            self.PrintStatus()
            self.StartShift()
            self.WaitWhilePrinting()
            self.PrintStatus()
        elif(cfg.get('DEFAULT', 'operation')=="endshift"):
            self.PrintStatus()
            self.EndShift()
            self.WaitWhilePrinting()
            self.PrintStatus()
        elif(cfg.get('DEFAULT', 'operation')=="sale"):
            self.PrintStatus()
            # do SALE
            ###########################################################
            for pref in ['', '_2', '_3', '_4', '_5']: # print each fee as separate ticket
                print "Using prefix:[%s]"%pref
                if cfg.has_option('DEFAULT', 'tr_service_fee_kkm'+pref):
                    print "Option found. checking if it is set to [Yes]..."
                    if cfg.get('DEFAULT', 'tr_service_fee_kkm'+pref)=="Yes":
                        print "OK, proceed to Sale:"
                        self.Sale(cfg, Price=cfg.get('DEFAULT', 'tr_service_fee_cost'+pref), \
                            StringForPrinting=cfg.get('DEFAULT', 'tr_service_fee_name'+pref))
                        self.WaitWhilePrinting()


            if cfg.has_option('DEFAULT', 'tickets_cost_kkm'): # just for safety. maybe there will be only a fee sale
                if cfg.get('DEFAULT', 'tickets_cost_kkm')=="Yes":
                    self.Sale(cfg, Price=cfg.get('DEFAULT', 'tickets_cost'), \
                        StringForPrinting=cfg.get('DEFAULT', 'tickets_name'))
                    self.WaitWhilePrinting()
                self.PrintStatus()

            # do REFUND
            ###########################################################
        elif(cfg.get('DEFAULT', 'operation')=="refund"):
            self.PrintStatus()
            for pref in ['', '_2', '_3', '_4', '_5']: # print each refund as separte ticket
                if cfg.has_option('DEFAULT', 'tr_service_fee_kkm'+pref):
                    if cfg.get('DEFAULT', 'tr_service_fee_kkm'+pref)=="Yes":
                        self.Refund(cfg, Price=cfg.get('DEFAULT', 'tr_service_fee_cost'+pref), \
                            StringForPrinting=cfg.get('DEFAULT', 'tr_service_fee_name'+pref))
                        self.WaitWhilePrinting()

            if cfg.has_option('DEFAULT', 'tickets_cost_kkm'): # just for safety. maybe there will be only a fee refund
                if cfg.get('DEFAULT', 'tickets_cost_kkm')=="Yes":
                    self.Refund(cfg, Price=cfg.get('DEFAULT', 'tickets_cost'), \
                        StringForPrinting=cfg.get('DEFAULT', 'tickets_name'))
                    self.WaitWhilePrinting()
                self.PrintStatus()
        else:
            print "ERROR: unknown operation type:",cfg.get('DEFAULT', 'operation')
            return False
    ##################################################################
    def Close(self):
    ##################################################################
        print "pythoncom._GetInterfaceCount():", pythoncom._GetInterfaceCount()
        self.m_Device = None
        #print pythoncom._GetInterfaceCount()
        #del self.m_Device
        print "pythoncom._GetInterfaceCount() after m_Device=None:", pythoncom._GetInterfaceCount()
        pythoncom.CoUninitialize()
#cfg = ConfigParser.ConfigParser()
#cfg.set('DEFAULT','operation','sale')
#d = ECR_Object()
#d.ParsePLP(cfg)
