import win32com.client
import posxml
from yaml import load as loadYAML
from json import load as loadJSON, dumps as dumpsJSON

with open('ECRModes.yaml', 'r', encoding='utf-8') as ecrmode_table_file:
    ECRMODE_TABLE = loadYAML(ecrmode_table_file)['ECRMode']


class ShtrihM:
    def __init__(self, plp_json_data, password=None):
        self.PLP_JSON_DATA = plp_json_data
        self.USER_SADM     = plp_json_data['fiscalData']['printerData']['sysAdminPw']
        self.USER_ADM      = plp_json_data['fiscalData']['printerData']['adminPw']
        self.USER_KASSIR   = plp_json_data['fiscalData']['printerData']['cashierPw']
        self.password      = password if password else self.USER_KASSIR
        self.RETRY_SEC     = 0.1
        self.TIMEOUT_SEC   = 2
        self.v             = win32com.client.Dispatch('Addin.DrvFR')

        self.connect()
        setattr(self.v, 'CodePage', 1) # Russian
        self.setMode2()


    def __enter__(self):
        return self


    def __exit__(self, exc_type, exc_value, traceback):
        del self.v


    def ecr_mode_string(self, k):
        return str(k) + ":" + ECRMODE_TABLE[k]['name']


    def prc(self):
        if self.v.ResultCode:
            print(str(self.v.ResultCode) + ':' + self.v.ResultCodeDescription)
            print("ENTER to exit(1)")
            input("Press Enter to continue...")
            exit(1)


    def feedback(self, feedback):
        print('Sending "{0}" to "{1}"'.format(feedback, self.PLP_JSON_DATA['feedbackUrl']))


    def insist(self, method, password=None):
        self.v.Password = password if password else self.password
        method()
        if self.v.ResultCode:
            self.feedback(str(self.v.ResultCode) + ':' + self.v.ResultCodeDescription)

            while self.v.ResultCode:
                print(str(self.v.ResultCode) + ':' + self.v.ResultCodeDescription)
                print('Method: {0}'.format(method))
                print("ENTER to retry")
                input("Press Enter to continue...")
                method()
        self.v.Password = 0


    def connect(self):
        setattr(self.v, 'ComNumber', self.PLP_JSON_DATA['fiscalData']['printerData']['comPortNumber'])
        setattr(self.v, 'BaudRate', self.PLP_JSON_DATA['fiscalData']['printerData']['comPortBaudRate'])
        # setattr(self.v, 'Timeout ', 100)
        self.insist(self.v.WaitConnection)
        self.insist(self.v.Connect)
        self.prc()


    def closeShift(self):
        self.insist(self.v.PrintReportWithCleaning, self.USER_ADM)
        self.prc()
        return True


    def xReport(self):
        self.insist(self.v.PrintReportWithoutCleaning, self.USER_ADM)
        self.prc()
        return True


    def openShift(self):
        # Shift will be actually opened with first recipe
        self.insist(self.v.OpenSession, self.USER_ADM)
        self.prc()
        return True


    def sysAdminCancelCheck(self):
        self.v.Password = self.USER_SADM
        self.v.SysAdminCancelCheck()
        self.v.Password = 0


    def setMode2(self):
        timecount = 0

        if self.v.ECRMode == 8:
            self.insist(self.v.Beep)
            print("Waiting for mode change")
            print("self.v.ECRMode8Status " + str(self.v.ECRMode8Status))
            while self.v.ECRMode == 8:
                self.insist(self.v.GetShortECRStatus)
                sleep(self.RETRY_SEC)
                timecount = timecount + self.RETRY_SEC
                if timecount > self.TIMEOUT_SEC:
                    timecount = 0
                    print("sysAdminCancelCheck")
                    self.sysAdminCancelCheck()
            print("ECRMode " + self.ecr_mode_string(self.v.ECRMode))

        self.insist(self.v.ResetECR)
        self.prc()

        if self.v.ECRMode == 0:
            self.insist(self.v.Beep)
            print("Waiting for mode change")
            while self.v.ECRMode == 0:
                self.insist(self.v.GetShortECRStatus)
                sleep(self.RETRY_SEC)

        if self.v.ECRMode not in [2,3,4]:
            print("Can't go on with ECRMode: " + self.ecr_mode_string(self.v.ECRMode))
            print("Exiting (Press ENTER)")
            input("Press Enter to continue...")
            exit(1)

        if self.v.ECRMode == 3:
            print(self.ecr_mode_string(self.v.ECRMode))
            self.closeShift()

        if self.v.ECRMode == 4:
            print(self.ecr_mode_string(self.v.ECRMode))
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
                print('Setting {0} = {1}'.format(attr, value))
                setattr(self.v, attr, value)
            self.insist(self.v.Sale)

        for item in payment_options:
            # print('Setting from {0}'.format(item))
            attr = 'Summ{0}'.format(item['type'])
            setattr(self.v, attr, item['cost'])

        setattr(self.v, 'DiscountOnCheck', 0)

        setattr(self.v, 'StringForPrinting', '')
        # setattr(self.v, 'StringForPrinting', '- - - - - - - - - - - - - - - - - - - -')
        self.insist(self.v.CloseCheck)


    def returnSale(self, sales_options, payment_options):

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
            }.iteritems():
                # print('Setting {0} = {1}'.format(attr, value))
                setattr(self.v, attr, value)
            self.insist(self.v.ReturnSale)

        for item in payment_options:
            # print('Setting from {0}'.format(item))
            attr = 'Summ{0}'.format(item['type'])
            setattr(self.v, attr, item['cost'])

        setattr(self.v, 'DiscountOnCheck', 0)
        setattr(self.v, 'StringForPrinting', '')
        # setattr(self.v, 'StringForPrinting', '- - - - - - - - - - - - - - - - - - - -')
        self.insist(self.v.CloseCheck)


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
            self.insist(self.v.PrintString)


    def feed(self, feedLineCount = 4):
        for x in range(0, feedLineCount):
            self.printLine()
        return True


    def cut(self, feedAfterCutCount = 0, partialCut = True):
        self.feed()
        if (feedAfterCutCount == 0):
            setattr(self.v, 'FeedAfterCut', False)
        else:
            setattr(self.v, 'FeedAfterCut', True)
            setattr(self.v, 'FeedLineCount', feedAfterCutCount)
        setattr(self.v, 'CutType', partialCut)
        self.insist(self.v.CutCheck)
        return True


    def insertCash(self):
        setattr(self.v, 'Summ1', self.PLP_JSON_DATA['fiscalData']['cashAmount'])
        self.insist(self.v.CashIncome)
        return True


    def withdrawCash(self):
        setattr(self.v, 'Summ1', self.PLP_JSON_DATA['fiscalData']['cashAmount'])
        self.insist(self.v.CashOutcome)
        return True


    def openCashRegister(self, drawer):
        if not drawer:
            drawer = 0
        setattr(self.v, 'DrawerNumber', drawer)
        self.insist(self.v.OpenDrawer)
        return True


    def cmsale(self):
        card_payment_amount = 0
        card_payment_failed = False

        for payment in self.PLP_JSON_DATA['fiscalData']['payments']:
            if payment['type'] == '4':
                card_payment_amount += payment['cost']
            print(payment['type'], card_payment_amount)


        if card_payment_amount > 0:
            posxmlIP = self.PLP_JSON_DATA['fiscalData']['cardPaymentUnitSettings']['cardPaymentSetting2']
            posxmlPort = self.PLP_JSON_DATA['fiscalData']['cardPaymentUnitSettings']['cardPaymentSetting3']
            posxml.init({'url': 'http://{0}:{1}'.format(posxmlIP,posxmlPort)})
            posxml.post('CancelAllOperationsRequest', '')
            response = posxml.post('TransactionRequest', {
                'TransactionID': self.PLP_JSON_DATA['fiscalData']['businessTransactionId'],
                'Amount'       : card_payment_amount * 100,
                'CurrencyName' : 'EUR',
                'PrintReceipt' : 2,
                'Timeout'      : 100,
                # 'Language'     : 'en',
            })
            if response['ReturnCode'] != '0':
                print(dumpsJSON(response, indent=4))
                print(response['Reason'])
                card_payment_failed = True
                self.printLine('------------------------------------')
                self.printLine('Card payment failed !!!')
                self.printLine('Code: {0}'.format(response['ReturnCode']))
                self.printLine('Reason: {0}'.format(response['Reason']))
                self.printLine('------------------------------------')
                self.cut()
                return False

            # posxml.waitForRemoveCardFromTerminal()


        payment_method_total = {}
        payment_method_total_validate = {}
        payment_sum_failed = False

        sales_options = []
        payment_options = []

        for payment in self.PLP_JSON_DATA['fiscalData']['payments']:
            if payment['type'] not in payment_method_total:
                payment_method_total[payment['type']] = 0
                payment_method_total_validate[payment['type']] = 0
            payment_method_total[payment['type']] += payment['cost']

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
                payment_sum_failed = True

        if payment_sum_failed:
            self.cut()
        elif self.PLP_JSON_DATA['fiscalData']['operation'] == 'sale':
            self.sale(sales_options, payment_options)
        elif self.PLP_JSON_DATA['fiscalData']['operation'] == 'refund':
            self.returnSale(sales_options, payment_options)
        else:
            raise ValueError('operation={0} - must be sale/refund.'.format(self.PLP_JSON_DATA['fiscalData']['operation']))

        return True
