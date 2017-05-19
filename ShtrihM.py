# This Python file uses the following encoding: utf-8

# ShtrihM module
import                                    win32com.client
from PosXML       import                  PosXML
import                                    sys
from os           import                  chdir
from os           import path          as path
from yaml         import load          as loadYAML
from json         import load          as loadJSON
from json         import dumps         as dumpsJSON

class ShtrihM:
    def __init__(self, feedback, bye, plp_json_data, password=None):
        self.feedback      = feedback
        self.bye           = bye
        self.PLP_JSON_DATA = plp_json_data
        self.USER_SADM     = plp_json_data['fiscalData']['printerData']['sysAdminPw'] or 0
        self.USER_ADM      = plp_json_data['fiscalData']['printerData']['adminPw']    or 0
        self.USER_KASSIR   = plp_json_data['fiscalData']['printerData']['cashierPw']  or 0
        self.password      = password if password else self.USER_KASSIR
        self.RETRY_SEC     = 0.1
        self.TIMEOUT_SEC   = 2
        self.password      = self.USER_KASSIR
        self.v             = win32com.client.Dispatch('Addin.DrvFR')
        self.BASEDIR       = path.dirname(sys.executable) if hasattr(sys, "frozen") else path.dirname(__file__)
        # chdir(self.BASEDIR)

        ecrmode_fn = path.join(self.BASEDIR, 'config', 'ECRModes.yaml')
        with open(ecrmode_fn, 'r', encoding='utf-8') as ecrmode_table_file:
            self.ECRMODE_TABLE = loadYAML(ecrmode_table_file)['ECRMode']

        self.connect()
        setattr(self.v, 'CodePage', 1) # Russian
        self.setMode2()


    def __enter__(self):
        print('Enter ShtrihM')
        return self


    def __exit__(self, exc_type, exc_value, traceback):
        print('Exit ShtrihM')
        # del self.v


    def ecr_mode_string(self, k):
        return str(k) + ":" + self.ECRMODE_TABLE[k]['name']


    def prc(self):
        # print('self.v.ResultCodeDescription: {0}'.format(self.v.ResultCodeDescription))
        if self.v.ResultCode:
            print(str(self.v.ResultCode) + ':' + self.v.ResultCodeDescription)
            self.feedback({'code': str(self.v.ResultCode), 'message': self.v.ResultCodeDescription}, False)
            # input("Press Enter to continue...")
            self.bye()


    def _insist(self, method, password=None):
        self.v.Password = password if password else self.password
        print('Method: {0}'.format(method))
        method()
        self.prc()
        # if self.v.ResultCode:
        #     self.feedback({'code': str(self.v.ResultCode), 'message': self.v.ResultCodeDescription}, False)
        #
        #     while self.v.ResultCode:
        #         print(str(self.v.ResultCode) + ':' + self.v.ResultCodeDescription)
        #         print('Method: {0}'.format(method))
        #         print("ENTER to retry")
        #         input("Press Enter to continue...")
        #         method()
        self.v.Password = 0


    def connect(self):
        _baud_rate = self.PLP_JSON_DATA['fiscalData']['printerData']['comPortBaudRate']
        if _baud_rate > 6:
            _baud_rates = {2400: 0, 4800: 1, 9600: 2, 19200: 3, 38400: 4, 57600: 5, 115200: 6}
            _baud_rate = _baud_rates[_baud_rate] if _baud_rate in _baud_rates else -1
        if _baud_rate < 0:
            raise ValueError('Unsupported baud rate for fiscal register. {0} not in {1}.'.format(self.PLP_JSON_DATA['fiscalData']['printerData']['comPortBaudRate'], _baud_rates))
        setattr(self.v, 'ComNumber', self.PLP_JSON_DATA['fiscalData']['printerData']['comPortNumber'])
        setattr(self.v, 'BaudRate', _baud_rate)
        # setattr(self.v, 'Timeout ', 100)
        self._insist(self.v.WaitConnection, 0)
        self._insist(self.v.Connect, 0)


    def closeShift(self):
        self._insist(self.v.PrintReportWithCleaning, self.USER_ADM)


    def xReport(self):
        self._insist(self.v.PrintReportWithoutCleaning, self.USER_ADM)


    def openShift(self):
        # Shift will be actually opened with first recipe
        self._insist(self.v.OpenSession, self.USER_ADM)
        self._insist(self.v.Beep)


    def sysAdminCancelCheck(self):
        self._insist(self.v.SysAdminCancelCheck, self.USER_SADM)


    def setMode2(self):
        timecount = 0

        if self.v.ECRMode == 8:
            self._insist(self.v.Beep)
            print("Waiting for mode change")
            print("self.v.ECRMode8Status " + str(self.v.ECRMode8Status))
            while self.v.ECRMode == 8:
                self._insist(self.v.GetShortECRStatus)
                sleep(self.RETRY_SEC)
                timecount = timecount + self.RETRY_SEC
                if timecount > self.TIMEOUT_SEC:
                    timecount = 0
                    print("sysAdminCancelCheck")
                    self.sysAdminCancelCheck()
            print("ECRMode " + self.ecr_mode_string(self.v.ECRMode))

        self._insist(self.v.ResetECR)

        if self.v.ECRMode == 0:
            self._insist(self.v.Beep)
            print("Waiting for mode change")
            while self.v.ECRMode == 0:
                self._insist(self.v.GetShortECRStatus)
                sleep(self.RETRY_SEC)

        if self.v.ECRMode not in [2,3,4]:
            self.feedback({'code': 1, 'message': "Can't go on with ECRMode: " + self.ecr_mode_string(self.v.ECRMode)})
            self.bye()

        if self.v.ECRMode == 3:
            self.closeShift()

        if self.v.ECRMode == 4:
            self.openShift()


    def sale(self, sales_options, payment_options):
        self.v.Password = self.USER_KASSIR
        for item in sales_options:
            # print('unpacking {0}'.format(item))
            for attr, value in {
                'Quantity': item['amount'],
                'Price': item['cost'],
                # 'Department': 1,
                'Tax1': item['vatGroup'],
                'Tax2': 0,
                'Tax3': 0,
                'Tax4': 0,
                'StringForPrinting': item['name']
            }.items():
                # print('Setting {0} = {1}'.format(attr, value))
                setattr(self.v, attr, value)
            if self.PLP_JSON_DATA['fiscalData']['operation'] == 'sale':
                self._insist(self.v.Sale)
            elif self.PLP_JSON_DATA['fiscalData']['operation'] == 'refund':
                self._insist(self.v.ReturnSale)

        for item in payment_options:
            # print('Setting from {0}'.format(item))
            attr = 'Summ{0}'.format(item['type'])
            setattr(self.v, attr, item['cost'])

        setattr(self.v, 'DiscountOnCheck', 0)
        setattr(self.v, 'StringForPrinting', '')
        # setattr(self.v, 'StringForPrinting', '- - - - - - - - - - - - - - - - - - - -')
        self._insist(self.v.CloseCheck)


    def printLine(self, string = ' '):
        if len(string) > 36:
            self.printLine(string[:36])
            self.printLine(string[36:])
        else:
            setattr(self.v, 'UseReceiptRibbon', True)
            setattr(self.v, 'UseJournalRibbon', False)
            # setattr(self.v, 'StringForPrinting', 'Сервисный сбор')
            setattr(self.v, 'StringForPrinting', string)
            print('Printing on receipt: "{0}"'.format(string))
            self._insist(self.v.PrintString)


    def feed(self, feedLineCount = 4):
        for x in range(0, feedLineCount):
            self.printLine()


    def cut(self, feedAfterCutCount = 0, partialCut = True):
        self.feed()
        if (feedAfterCutCount == 0):
            setattr(self.v, 'FeedAfterCut', False)
        else:
            setattr(self.v, 'FeedAfterCut', True)
            setattr(self.v, 'FeedLineCount', feedAfterCutCount)
        setattr(self.v, 'CutType', partialCut)
        self._insist(self.v.CutCheck)


    def insertCash(self):
        print('insertCash')
        setattr(self.v, 'Summ1', self.PLP_JSON_DATA['fiscalData']['cashAmount'])
        self._insist(self.v.CashIncome)
        return self.PLP_JSON_DATA['fiscalData']['cashAmount']


    def withdrawCash(self):
        setattr(self.v, 'Summ1', self.PLP_JSON_DATA['fiscalData']['cashAmount'])
        self._insist(self.v.CashOutcome)
        return self.PLP_JSON_DATA['fiscalData']['cashAmount']


    def openCashRegister(self, drawer=0):
        setattr(self.v, 'DrawerNumber', drawer)
        self._insist(self.v.OpenDrawer)


    def reverseSale(self):
        if self.PLP_JSON_DATA['fiscalData']['operation'] == 'sale':
            self.PLP_JSON_DATA['fiscalData']['operation'] = 'refund'
        elif self.PLP_JSON_DATA['fiscalData']['operation'] == 'refund':
            self.PLP_JSON_DATA['fiscalData']['operation'] = 'sale'

        self.cmsale()


    def prepareSale(self):
        payment_method_total = {'sum': 0}
        payment_method_total_validate = {'sum': 0}
        payment_sum_failed = False

        sales_options = []
        payment_options = []

        for payment in self.PLP_JSON_DATA['fiscalData']['payments']:
            if payment['type'] not in payment_method_total:
                payment_method_total[payment['type']] = 0
                payment_method_total_validate[payment['type']] = 0
            payment_method_total[payment['type']] += payment['cost']
            payment_method_total['sum']           += payment['cost']

            payment_options.append({'cost': payment['cost'], 'type': payment['type']})

            for component in payment['components']:
                if not 'kkm' in component:
                    continue
                if not component['kkm']:
                    continue
                if not 'amount' in component:
                    component['amount'] = 1
                if 'ticketId' in component:
                    component['name'] = '{0} {1}'.format(component['name'], component['ticketId'])
                payment_method_total_validate[payment['type']] += component['cost'] * component['amount']
                payment_method_total_validate['sum']           += component['cost'] * component['amount']
                sales_options.append(component)

        for ix in payment_method_total:
            if round(payment_method_total[ix], 2) != round(payment_method_total_validate[ix], 2):
                print('------------------------------------')
                print('     !!! FISCAL DATA ERROR !!!')
                print('        In payment type {0}'.format(ix))
                print('Sum of component costs | {0}'.format(payment_method_total_validate[ix]))
                print('doesnot match          | !=')
                print('sum of payment costs   | {0}'.format(payment_method_total[ix]))
                print('------------------------------------')
                self.printLine('------------------------------------')
                self.printLine('     !!! FISCAL DATA ERROR !!!')
                self.printLine('         In payment type {0}'.format(ix))
                self.printLine('Sum of component costs | {0}'.format(payment_method_total_validate[ix]))
                self.printLine('doesnot match          | !=')
                self.printLine('sum of payment costs   | {0}'.format(payment_method_total[ix]))
                self.printLine('------------------------------------')
                for i in range(0, 3):
                    self.printLine()

                self.feedback({'code': '1', 'message': 'Fiscal data error: Sum of component costs ({0}) doesnot match sum of payment costs ({1})'.format(payment_method_total_validate[ix], payment_method_total[ix])}, False)
                self.bye()

        return (sales_options, payment_options, payment_method_total_validate['sum'])


    def cmsale(self):
        card_payment_amount = 0
        for payment in self.PLP_JSON_DATA['fiscalData']['payments']:
            if payment['type'] == '4':
                card_payment_amount += payment['cost']

        if card_payment_amount > 0:
            posxmlIP = self.PLP_JSON_DATA['fiscalData']['cardPaymentUnitSettings']['cardPaymentUnitIp']
            posxmlPort = self.PLP_JSON_DATA['fiscalData']['cardPaymentUnitSettings']['cardPaymentUnitPort']
            with PosXML(self.feedback, self.bye, {'url': 'http://{0}:{1}'.format(posxmlIP,posxmlPort)}) as posxml:
                posxml.post('CancelAllOperationsRequest', '')
                response = posxml.post(
                    'TransactionRequest' if (self.PLP_JSON_DATA['fiscalData']['operation'] == 'sale') else 'RefundTransactionRequest',
                    {
                        'TransactionID': self.PLP_JSON_DATA['fiscalData']['businessTransactionId'],
                        'Amount'       : card_payment_amount * 100,
                        'CurrencyName' : 'EUR',
                        'PrintReceipt' : 2,
                        'Timeout'      : 100,
                    }
                )
                print(response)
                if response['ReturnCode'] != '0':
                    self.feedback({'code': response['ReturnCode'], 'message': 'Card payment failed: {0}'.format(response['Reason'])}, False)
                    self.bye()

        (sales_options, payment_options, sum_of_payments) = self.prepareSale()
        self.sale(sales_options, payment_options)
        return sum_of_payments
