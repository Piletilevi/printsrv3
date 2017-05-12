# This Python file uses the following encoding: utf-8

from time import time
start_time = time()


import os
import signal
def bye():
    os.kill(os.getpid(), signal.SIGTERM)


# PosXML module
import                    requests
import                    xmltodict
from json import dumps as dumpsJSON
from sys  import          stdin
from yaml import load  as loadYAML
from time import          sleep

class PosXML:
    def __init__(self, feedback, bye, options):
        self.feedback = feedback
        self.bye      = bye
        self.OPTIONS  = { 'headers': { 'content-type': "application/xml" } }
        for key, val in options.items():
            self.OPTIONS[key] = val
        with open('posxml_responses.yaml', 'r') as posxml_responses_file:
            self.PXRESPONSES = loadYAML(posxml_responses_file)


    def __enter__(self):
        print('Enter PosXML')
        return self


    def __exit__(self, exc_type, exc_value, traceback):
        print('Exit PosXML')
        pass


    def post(self, func, data):
        dict = { 'PosXML': { '@version':'7.2.0', } }
        dict['PosXML'][func] = data
        payload_xml = xmltodict.unparse(dict, pretty=True).encode('utf-8')

        try:
            http_response = requests.post(self.OPTIONS['url'], data=payload_xml, headers=self.OPTIONS['headers'])
        except requests.exceptions.RequestException as e:
            self.feedback({'code': '', 'message': e.__str__()}, False)
            self.bye()

        response = xmltodict.parse(http_response.content)['PosXML']
        try:
            # find if any key in response matches one of expected response keys
            responseKey = [key for key in self.PXRESPONSES[func] if key in response][0]
        except Exception as e:
            self.feedback({'code': '', 'message': 'Expected responses: "{0}" not present in returned response keys: "{1}".'.format(';'.join(self.PXRESPONSES[func]), ';'.join(response.keys()))}, False)
            self.bye()

        if response[responseKey]['ReturnCode'] != '0':
            self.feedback({
                'code': response[responseKey]['ReturnCode'],
                'message': response[responseKey]['Reason'] or response[responseKey]['ReturnCode']}, False)
            self.bye()


    def beep(self):
        self.post('DoBeepRequest', {'Frequency1':2000, 'Duration1':40})

    def message(self, destination, message):
        self.post('DisplayMessageRequest', {
            'Action':1,
            'BackLight':1,
            'Destination':destination,
            'Line2': message.encode('utf-8')
        })
    def resetMessages(self):
        self.post('DisplayMessageRequest', {
            'Action':0
        })

    def waitForRemoveCardFromTerminal(self):
        response = self.post('GetTerminalStatusRequest', '')
        CardStatus = response['CardStatus']
        if CardStatus != '0':
            print('Remove card from terminal')
            # message(2,'Remove card from terminal')
        while CardStatus != '0':
            self.beep()
            sleep(0.3)
            CardStatus = self.post('GetTerminalStatusRequest', '')['CardStatus']
        self.resetMessages()


# ShtrihM module
import                    win32com.client
# import                    posxml
from yaml import load  as loadYAML
from json import load  as loadJSON
from json import dumps as dumpsJSON

class ShtrihM:
    def __init__(self, feedback, bye, plp_json_data, password=None):
        self.feedback      = feedback
        self.bye           = bye
        self.PLP_JSON_DATA = plp_json_data
        self.USER_SADM     = plp_json_data['fiscalData']['printerData']['sysAdminPw']
        self.USER_ADM      = plp_json_data['fiscalData']['printerData']['adminPw']
        self.USER_KASSIR   = plp_json_data['fiscalData']['printerData']['cashierPw']
        self.password      = password if password else self.USER_KASSIR
        self.RETRY_SEC     = 0.1
        self.TIMEOUT_SEC   = 2
        self.v             = win32com.client.Dispatch('Addin.DrvFR')

        with open('ECRModes.yaml', 'r', encoding='utf-8') as ecrmode_table_file:
            self.ECRMODE_TABLE = loadYAML(ecrmode_table_file)['ECRMode']

        self.connect()
        setattr(self.v, 'CodePage', 1) # Russian
        self.setMode2()


    def __enter__(self):
        print('Enter ShtrihM')
        return self


    def __exit__(self, exc_type, exc_value, traceback):
        print('Exit ShtrihM')
        del self.v


    def ecr_mode_string(self, k):
        return str(k) + ":" + self.ECRMODE_TABLE[k]['name']


    def prc(self):
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
        setattr(self.v, 'ComNumber', self.PLP_JSON_DATA['fiscalData']['printerData']['comPortNumber'])
        setattr(self.v, 'BaudRate', self.PLP_JSON_DATA['fiscalData']['printerData']['comPortBaudRate'])
        # setattr(self.v, 'Timeout ', 100)
        self._insist(self.v.WaitConnection)
        self._insist(self.v.Connect)


    def closeShift(self):
        self._insist(self.v.PrintReportWithCleaning, self.USER_ADM)


    def xReport(self):
        self._insist(self.v.PrintReportWithoutCleaning, self.USER_ADM)


    def openShift(self):
        # Shift will be actually opened with first recipe
        self._insist(self.v.OpenSession, self.USER_ADM)


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
            self._insist(self.v.Sale)

        for item in payment_options:
            # print('Setting from {0}'.format(item))
            attr = 'Summ{0}'.format(item['type'])
            setattr(self.v, attr, item['cost'])

        setattr(self.v, 'DiscountOnCheck', 0)

        setattr(self.v, 'StringForPrinting', '')
        # setattr(self.v, 'StringForPrinting', '- - - - - - - - - - - - - - - - - - - -')
        self._insist(self.v.CloseCheck)


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
            }.items():
                # print('Setting {0} = {1}'.format(attr, value))
                setattr(self.v, attr, value)
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


    def withdrawCash(self):
        setattr(self.v, 'Summ1', self.PLP_JSON_DATA['fiscalData']['cashAmount'])
        self._insist(self.v.CashOutcome)


    def openCashRegister(self, drawer=0):
        setattr(self.v, 'DrawerNumber', drawer)
        self._insist(self.v.OpenDrawer)


    def reverseSale(self):
        card_payment_amount = 0
        for payment in self.PLP_JSON_DATA['fiscalData']['payments']:
            if payment['type'] == '4':
                card_payment_amount += payment['cost']

        if card_payment_amount > 0:
            posxmlIP = self.PLP_JSON_DATA['fiscalData']['cardPaymentUnitSettings']['cardPaymentUnitIp']
            posxmlPort = self.PLP_JSON_DATA['fiscalData']['cardPaymentUnitSettings']['cardPaymentUnitPort']
            with PosXML(self.feedback, self.bye, {'url': 'http://{0}:{1}'.format(posxmlIP,posxmlPort)}) as posxml:
                posxml.post('CancelAllOperationsRequest', '')
                response = posxml.post('ReverseTransactionRequest', {
                'TransactionID': self.PLP_JSON_DATA['fiscalData']['businessTransactionId'],
                'Amount'       : card_payment_amount * 100,
                'CurrencyName' : 'EUR',
                'PrintReceipt' : 1,
                'Timeout'      : 100,
                'ForcedAction' : 1,
                })
                if response['ReturnCode'] != '0':
                    self.feedback({'code': response['ReturnCode'], 'message': 'Reverse sale failed: {0}'.format(response['Reason'])}, False)
                    self.bye()

        (sales_options, payment_options) = self.prepareSale()

        if self.PLP_JSON_DATA['fiscalData']['operation'] == 'sale':
            self.returnSale(sales_options, payment_options)
        else:
            self.feedback({'code': '1', 'message': 'operation={0} - must be sale.'.format(self.PLP_JSON_DATA['fiscalData']['operation'])}, False)
            self.bye()


    def prepareSale(self):
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

                self.feedback({'code': '1', 'message': 'Fiscal data error: Sum of component costs ({0}) doesnot match sum of payment costs ({1})'.format(payment_method_total_validate[ix], payment_method_total[ix])}, False)
                self.bye()

        return (sales_options, payment_options)


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
                    ('TransactionRequest' if (self.PLP_JSON_DATA['fiscalData']['operation'] == 'sale') else 'RefundTransactionRequest'),
                    {
                        'TransactionID': self.PLP_JSON_DATA['fiscalData']['businessTransactionId'],
                        'Amount'       : card_payment_amount * 100,
                        'CurrencyName' : 'EUR',
                        'PrintReceipt' : 2,
                        'Timeout'      : 100,
                    }
                )
                if response['ReturnCode'] != '0':
                    self.feedback({'code': response['ReturnCode'], 'message': 'Card payment failed: {0}'.format(response['Reason'])}, False)
                    self.bye()

        (sales_options, payment_options) = self.prepareSale()

        if self.PLP_JSON_DATA['fiscalData']['operation'] == 'sale':
            self.sale(sales_options, payment_options)
        elif self.PLP_JSON_DATA['fiscalData']['operation'] == 'refund':
            self.returnSale(sales_options, payment_options)
        else:
            self.feedback({'code': '1', 'message': 'operation={0} - must be sale/refund.'.format(self.PLP_JSON_DATA['fiscalData']['operation'])}, False)
            self.bye()


# PSPrint module
import                                    win32ui
import                                    win32gui
import                                    win32print
from ctypes       import                  windll
from yaml         import load          as loadYAML
from code128image import code128_image as _c128image
from PIL          import                  ImageWin
from PIL          import                  Image

class PSPrint:
    def __init__(self, feedback, bye, plp_json_data):
        self.feedback      = feedback
        self.bye           = bye
        self.PLP_JSON_DATA = plp_json_data

        printer = self.PLP_JSON_DATA['ticketData']['printerData']['printerName']
        try:
            hprinter = win32print.OpenPrinter(printer)
        except Exception as e:
            self.feedback({'code': '', 'message': e.__str__()}, False)
            self.bye()

        try:
            devmode = win32print.GetPrinter(hprinter, 2)['pDevMode']
        except Exception as e:
            self.feedback({'code': '', 'message': e.__str__()}, False)
            self.bye()

        try:
            devmode.Orientation = 2
        except Exception as e:
            self.feedback({'code': '', 'message': e.__str__()}, False)
            self.bye()

        printjobs = win32print.EnumJobs(hprinter, 0, 999)
        while len(printjobs) != 0:
            ret = windll.user32.MessageBoxW(0, 'Printer has old jobs in queue'.decode(), 'Check printer!'.decode(), 0x40 | 0x0) #OK only
            printjobs = win32print.EnumJobs(hprinter, 0, 999)

        try:
            self.DEVICE_CONTEXT_HANDLE = win32gui.CreateDC('WINSPOOL', printer, devmode)
        except Exception as e:
            self.feedback({'code': '', 'message': e.__str__()}, False)
            self.bye()

        try:
            self.DEVICE_CONTEXT = win32ui.CreateDCFromHandle(self.DEVICE_CONTEXT_HANDLE)
        except Exception as e:
            self.feedback({'code': '', 'message': e.__str__()}, False)
            self.bye()

        with open('layout.yaml', 'r', encoding='utf-8') as layout_file:
            self.PS_LAYOUT = loadYAML(layout_file)


    def __enter__(self):
        print('Enter PSPrint')
        return self


    def __exit__(self, exc_type, exc_value, traceback):
        print('Exit PSPrint')
        pass


    def _setFont(self, font_name, w=None, h=None, weight=None, orientation=0):
        if font_name is not None:
            _log_font = [font_name]
            def callback(font, tm, fonttype, _font):
                if font.lfFaceName == _font[0]:
                    _font[0]=font
                return True
            win32gui.EnumFontFamilies(self.DEVICE_CONTEXT_HANDLE, None, callback, _log_font)
            self.log_font = _log_font[0]

        self.log_font.lfWidth = int(w)
        self.log_font.lfHeight = int(h)
        self.log_font.lfWeight = int(weight)
        self.log_font.lfOrientation = int(orientation) * 10
        self.log_font.lfEscapement = int(orientation) * 10
        font_handle = win32gui.CreateFontIndirect(self.log_font)
        win32gui.SelectObject(self.DEVICE_CONTEXT_HANDLE, font_handle)


    def _placeText(self, x, y, text):
        windll.gdi32.TextOutW(self.DEVICE_CONTEXT_HANDLE, x, y, text, len(text))


    def _placeImage(self, x, y, url):
        windll.gdi32.TextOutW(self.DEVICE_CONTEXT_HANDLE, x, y, url, len(url))


    def _placeC128(self, text, x, y, width, height, thickness, rotate, quietzone):
        print('Placing {0}, x:{1}, y:{2}, w:{3}, h:{4}'.format(text, x, y, width, height))
        file1 = 'tmp1.jpeg'
        file2 = 'tmp2.jpeg'
        bmp = _c128image(text, int(width), int(height), quietzone)
        print('dimensions of {0}: {1}'.format(file1, bmp.size))
        bmp.save(file1, 'JPEG')
        bmp = Image.open(file1)
        print('dimensions of {0}: {1}'.format(file1, bmp.size))
        bmp = bmp.rotate(rotate, expand=True)
        print('dimensions of {0}: {1}'.format(file2, bmp.size))
        bmp.save(file2, 'JPEG')
        bmp = Image.open(file2)
        print('dimensions of {0}: {1}'.format(file2, bmp.size))
        dib = ImageWin.Dib(bmp)
        x = int(x)
        y = int(y)
        dib.draw(self.DEVICE_CONTEXT_HANDLE, (x, y, x + bmp.size[0], y + bmp.size[1]))
        print('dimensions: {0}'.format(bmp))


    def _startDocument(self):
        # print("DEVICE_CONTEXT.SetMapMode")
        self.DEVICE_CONTEXT.SetMapMode(1)
        # print("DEVICE_CONTEXT.StartDoc")
        self.DEVICE_CONTEXT.StartDoc("ticket.txt")
        # print("DEVICE_CONTEXT.StartPage")
        self.DEVICE_CONTEXT.StartPage()
        # print("win32ui.CreateFont");
        font = win32ui.CreateFont({"name": "Arial", "height": 16})
        # print("DEVICE_CONTEXT.SelectObject")
        self.DEVICE_CONTEXT.SelectObject(font)
        # print("DEVICE_CONTEXT.SelectObject DONE")


    def _printDocument(self):
        self.DEVICE_CONTEXT.EndPage()
        self.DEVICE_CONTEXT.EndDoc()


    def printTickets(self):
        for ticket in self.PLP_JSON_DATA['ticketData']['tickets']:
            self._startDocument()
            self.printTicket(ticket)
            self._printDocument()


    def _getInstanceProperty(self, key, instance, field, mandatory=False):
        if key in instance:
            return instance.get(key)
        if key in field.get('common', []):
            return field.get('common').get(key)
        if mandatory:
            print('Text without {0} - {1}'.format(key, field))
        return None


    def printTicket(self, ticket):
        # print('ticket : {0}'.format(ticket.keys()))
        for layout_key in self.PS_LAYOUT.keys():
            # print('layout_key : {0}'.format(layout_key))
            # print('{0} : {1}'.format(key,field))
            field = self.PS_LAYOUT[layout_key]
            value = ticket.get(layout_key, self.PLP_JSON_DATA.get(layout_key, ''))
            if value == '':
                print('skip {0}'.format(layout_key))
                continue

            if field['type'] == 'text':
                for instance in field['instances']:
                    font_name   = self._getInstanceProperty('font_name', instance, field)
                    font_height = self._getInstanceProperty('font_height', instance, field)
                    font_width  = self._getInstanceProperty('font_width', instance, field)
                    font_weight = self._getInstanceProperty('font_weight', instance, field)
                    x           = self._getInstanceProperty('x', instance, field)
                    y           = self._getInstanceProperty('y', instance, field)
                    if not (font_height and font_width and font_weight and x and y):
                        continue
                    orientation = self._getInstanceProperty('orientation', instance, field) or 0
                    prefix      = self._getInstanceProperty('prefix', instance, field) or ''
                    suffix      = self._getInstanceProperty('suffix', instance, field) or ''
                    self._setFont(font_name, font_width, font_height, font_weight, orientation)
                    # print('Placing {0}, {1}, {2}{3}{4}'.format(x, y, prefix, value, suffix))
                    self._placeText(x, y, '{0}{1}{2}'.format(prefix, value, suffix))
                continue

            elif field['type'] == 'image':
                for instance in field['instances']:
                    self._placeImage(x, y, value, orientation)
                continue

            elif field['type'] == 'code128':
                for instance in field['instances']:
                    thickness   = self._getInstanceProperty('thickness', instance, field)       or 10
                    width       = self._getInstanceProperty('width', instance, field)           or 560
                    height      = self._getInstanceProperty('height', instance, field)          or 100
                    x           = instance.get('x', field.get('common', {'x': False}).get('x', False))
                    y           = instance.get('y', field.get('common', {'y': False}).get('y', False))
                    # orientation = instance.get('orientation', field.get('common', {'orientation': 0}).get('orientation', 0))
                    orientation = self._getInstanceProperty('orientation', instance, field)     or 0
                    quietzone   = self._getInstanceProperty('quietzone', instance, field)       or False
                    if not (x and y):
                        continue
                    print('Placing {0}, x:{1}, y:{2}, w:{3}, h:{4}'.format(value, x, y, width, height))
                    self._placeC128(value, x, y, width, height, thickness, orientation, quietzone)
                continue


    def helloWorld(self):
        self._startDocument()
        text = u'Hello, WORLD!'
        self._setFont(font_name='Arial', w=12, h=30, weight=500, orientation=0)
        self._placeText(250, 250, text)
        self._setFont(font_name='Arial', w=24, h=50, weight=1000, orientation=0)
        self._placeText(150, 150, text)
        # self._placeC128('650', '6', '3', '100', '1234567890123456', 90)
        self._printDocument()


# Main

from time import          sleep
import                    sys
from os   import          path
from os   import          chdir
from sys  import          argv
from sys  import path  as sysPath
from json import load  as loadJSON
from json import loads as loadsJSON
from json import dumps as dumpsJSON
from yaml import load  as loadYAML
import                    fileinput
import                    requests


# from PSPrint import PSPrint
# from ShtrihM import ShtrihM
# bye("--- {0} seconds ---".format(time() - start_time))

# from pyexpat import * # needed for py2exe ??

if hasattr(sys, "frozen"):
    BASEDIR = path.dirname(sys.executable)
else:
    BASEDIR = path.dirname(__file__)
chdir(BASEDIR)


# Set plp_filename environment variable from passed argument
PLP_FILENAME = argv[1]

with open(PLP_FILENAME, 'rU', encoding='utf-8') as plp_data_file:
    PLP_JSON_DATA = loadJSON(plp_data_file)
    # print(PLP_JSON_DATA['salesPointCountry'])


# with open(path.join(BASEDIR, 'package.json'), 'rU') as package_json_file:
#     PACKAGE_JSON_DATA = loadJSON(package_json_file)

with open('feedbackTemplate.json', 'rU', encoding='utf-8') as feedback_template_file:
    FEEDBACK_TEMPLATE = loadJSON(feedback_template_file)
    FEEDBACK_TEMPLATE['feedbackToken'] = PLP_JSON_DATA.get('feedbackToken')
    FEEDBACK_TEMPLATE['operationToken'] = PLP_JSON_DATA.get('operationToken')
    FEEDBACK_TEMPLATE['businessTransactionId'] = PLP_JSON_DATA.get('fiscalData', {'businessTransactionId':''}).get('businessTransactionId', '')
    FEEDBACK_TEMPLATE['operation'] = PLP_JSON_DATA.get('fiscalData').get('operation')


def feedback(feedback, success=True, reverse=None):
    FEEDBACK_TEMPLATE['status'] = success
    FEEDBACK_TEMPLATE['feedBackMessage'] = feedback.get('message')

    _fburl = PLP_JSON_DATA.get('feedbackUrl', PLP_JSON_DATA.get('feedBackurl'))
    print('Sending "{0}" to "{1}"'.format(dumpsJSON(FEEDBACK_TEMPLATE, indent=4), _fburl))
    headers = {'Content-type': 'application/json'}
    r = requests.post(_fburl, allow_redirects=True, timeout=30, json=FEEDBACK_TEMPLATE)

    if r.status_code != requests.codes.ok:
        print('{0}; status_code={1}'.format(r.headers['content-type'], r.status_code))
        if reverse:
            reverse()
        bye()

    try:
        response_json = r.json()
    except Exception as e:
        print(e)
        input("Press Enter to continue...")
        print('BO response: {0}'.format(r.text))
        if reverse:
            reverse()
        bye()

        print('BO response: {0}'.format(dumpsJSON(response_json, indent=4)))


def noop():
    pass

def doFiscal():
    with ShtrihM(feedback, bye, PLP_JSON_DATA) as cm:
        operations_a = {
        'cut':          {'operation': cm.cut,              },
        'endshift':     {'operation': cm.closeShift,       },
        'feed':         {'operation': cm.feed,             },
        'insertcash':   {'operation': cm.insertCash,       'reverse': cm.withdrawCash},
        'opencashreg':  {'operation': cm.openCashRegister, },
        'refund':       {'operation': cm.cmsale,           },
        'sale':         {'operation': cm.cmsale,           },
        'startshift':   {'operation': noop                 },
        'withdrawcash': {'operation': cm.withdrawCash,     'reverse': cm.insertCash},
        'xreport':      {'operation': cm.xReport,          },
        }
        VALID_OPERATIONS = operations_a.keys()
        operation = PLP_JSON_DATA['fiscalData']['operation']
        if operation not in VALID_OPERATIONS:
            raise ValueError('"operation" must be one of {0} in plp file. Got {1} instead.'.format(VALID_OPERATIONS, operation))

        operations_a[operation]['operation']()

    feedback({'code': '0', 'message': 'Fiscal succeeded'}, success=True, reverse=operations_a[operation].get('reverse', None))


if 'fiscalData' in PLP_JSON_DATA:
    doFiscal()


if 'ticketData' in PLP_JSON_DATA:
    with PSPrint(feedback, bye, PLP_JSON_DATA) as ps:
        ps.printTickets()

bye()
