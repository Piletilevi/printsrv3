# coding: utf-8

import os, sys
from os   import path, chdir
from sys  import exit as sysexit, argv, path as sysPath
from json import load as loadJSON, dumps as dumpsJSON
from yaml import load as loadYAML
# from re import match
import win32com.client

# import print_ticket
import posxml
from pyexpat import * # needed for py2exe ??

if hasattr(sys, "frozen"):
    BASEDIR = path.dirname(unicode(sys.executable, sys.getfilesystemencoding( )))
else:
    BASEDIR = path.dirname(unicode(__file__, sys.getfilesystemencoding( )))
chdir(BASEDIR)

class ShtrihM:
    def __init__(self, plp_json_data):
        self.PLP_JSON_DATA = plp_json_data
        self.USER_SADM     = 30000
        self.USER_ADM      = 29000
        self.USER_KASSIR   = 1000
        self.RETRY_SEC     = 0.1
        self.TIMEOUT_SEC   = 2
        self.v             = win32com.client.Dispatch('Addin.DrvFR')

        self.connect()
        self.setMode2()

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        del self.v

    # v = win32com.client.Dispatch('Addin.DrvFR')
    # print('bye {0}'.format(v))
    # pythoncom.CoUninitialize()
    # print('Bye')
    # raise SystemExit

    def ecr_mode_string(self, k):
        return str(k) + ":" + ECRMODE_TABLE[k]['name']

    def prc(self):
        if self.v.ResultCode:
            print str(self.v.ResultCode) + ':' + self.v.ResultCodeDescription
            print "ENTER to exit(1)"
            stdin.readline()
            exit(1)

    def feedback(self, feedback):
        print ('Sending "{0}" to "{1}"'.format(feedback, self.PLP_JSON_DATA['feedbackURL']))

    def insist(self, method, password):

        self.v.Password = password
        method()
        if self.v.ResultCode:
            feedback(str(self.v.ResultCode) + ':' + self.v.ResultCodeDescription)

            while self.v.ResultCode:
                print str(self.v.ResultCode) + ':' + self.v.ResultCodeDescription
                print('Method: {0}'.format(method))
                print "ENTER to retry"
                stdin.readline()
                method()
        self.v.Password = 0


    def connect(self):
        setattr(self.v, 'ComNumber', 7)
        setattr(self.v, 'BaudRate', 6)
        # setattr(self.v, 'Timeout ', 100)
        self.insist(self.v.WaitConnection, self.USER_KASSIR)
        self.insist(self.v.Connect, self.USER_KASSIR)
        self.prc()


    def closeShift(self):
        # print "performing PrintReportWithCleaning() (Press ENTER)"
        # stdin.readline()
        self.insist(self.v.PrintReportWithCleaning, USER_ADM)
        self.prc()


    def xReport(self):
        # print "performing PrintReportWithoutCleaning() (Press ENTER)"
        self.insist(self.v.PrintReportWithoutCleaning, USER_ADM)
        self.prc()


    def openShift(self):
        self.insist(self.v.OpenSession, USER_ADM)
        self.prc()
        # Shift will be actually opened with first recipe


    def sysAdminCancelCheck(self):
        self.v.Password = USER_SADM
        self.v.SysAdminCancelCheck()


    def setMode2(self):
        timecount = 0

        # print "Initial ECRMode " + self.ecr_mode_string(v.ECRMode)

        if self.v.ECRMode == 8:
            self.insist(self.v.Beep, self.USER_KASSIR)
            print "Waiting for mode change"
            print "self.v.ECRMode8Status " + str(self.v.ECRMode8Status)
            while self.v.ECRMode == 8:
                self.insist(self.v.GetShortECRStatus, self.USER_KASSIR)
                sleep(RETRY_SEC)
                timecount = timecount + RETRY_SEC
                if timecount > TIMEOUT_SEC:
                    timecount = 0
                    print "sysAdminCancelCheck"
                    sysAdminCancelCheck()
            print "ECRMode " + self.ecr_mode_string(self.v.ECRMode)

        self.insist(self.v.ResetECR, self.USER_KASSIR)
        self.prc()

        if self.v.ECRMode == 0:
            self.insist(self.v.Beep, self.USER_KASSIR)
            print "Waiting for mode change"
            while self.v.ECRMode == 0:
                self.insist(self.v.GetShortECRStatus, self.USER_KASSIR)
                sleep(RETRY_SEC)

        if self.v.ECRMode not in [2,3,4]:
            print "Can't go on with ECRMode: " + self.ecr_mode_string(self.v.ECRMode)
            print "Exiting (Press ENTER)"
            stdin.readline()
            exit(1)

        if self.v.ECRMode == 3:
            print self.ecr_mode_string(self.v.ECRMode)
            closeShift()

        if self.v.ECRMode == 4:
            print self.ecr_mode_string(self.v.ECRMode)
            openShift()


    def sale(self, sales_options, payment_options, password):
        if not password:
            password = self.USER_KASSIR
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
                # print 'Setting {0} = {1}'.format(attr, value)
                setattr(v, attr, value)
            self.insist(v.Sale, password)

        for item in payment_options:
            # print 'Setting from {0}'.format(item)
            attr = 'Summ{0}'.format(item['type'])
            setattr(self.v, attr, item['cost'])

        setattr(self.v, 'DiscountOnCheck', 0)

        # for x in xrange(1,4):
        #    print 'Summ{0} = {1} + {2}'.format( x,
        #                                        getattr(self.v, 'Summ{0}'.format(x)),
        #                                        getattr(self.v, 'Tax{0}'.format(x)) )
        # print self.v.DiscountOnCheck
        # print self.v.StringForPrinting

        setattr(self.v, 'StringForPrinting', '')
        # setattr(self.v, 'StringForPrinting', '- - - - - - - - - - - - - - - - - - - -')
        self.insist(self.v.CloseCheck, password)


    def returnSale(self, sales_options, payment_options, password):
        if not password:
            password = self.USER_KASSIR
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
                'StringForPrinting': item['name'].decode(encoding='UTF-8')
            }.iteritems():
                # print 'Setting {0} = {1}'.format(attr, value)
                setattr(self.v, attr, value)
            self.insist(self.v.ReturnSale, password)

        for item in payment_options:
            # print 'Setting from {0}'.format(item)
            attr = 'Summ{0}'.format(item['type'])
            setattr(self.v, attr, item['cost'])

        setattr(self.v, 'DiscountOnCheck', 0)
        setattr(self.v, 'StringForPrinting', '')
        # setattr(self.v, 'StringForPrinting', '- - - - - - - - - - - - - - - - - - - -')
        self.insist(self.v.CloseCheck, password)


    def printLine(self, string = ' '):
        if len(string) > 36:
            self.printLine(string[:36])
            self.printLine(string[36:])
        else:
            setattr(self.v, 'UseReceiptRibbon', True)
            setattr(self.v, 'UseJournalRibbon', False)
            setattr(self.v, 'StringForPrinting', string.decode(encoding='UTF-8'))
            print ('Printing on receipt: "{0}"'.format(string.decode(encoding='UTF-8')))
            self.insist(self.v.PrintString, self.USER_KASSIR)


    def feed(self, feedLineCount = 4):
        for x in xrange(0, feedLineCount):
            self.printLine()


    def cut(self, feedAfterCutCount = 0, partialCut = True):
        self.feed()
        if (feedAfterCutCount == 0):
            setattr(self.v, 'FeedAfterCut', False)
        else:
            setattr(self.v, 'FeedAfterCut', True)
            setattr(self.v, 'FeedLineCount', feedAfterCutCount)
        setattr(self.v, 'CutType', partialCut)
        self.insist(self.v.CutCheck, self.USER_KASSIR)


    def insertCash(self, amount, password):
        if not password:
            password = self.USER_KASSIR
        setattr(self.v, 'Summ1', amount)
        self.insist(self.v.CashIncome, password)


    def withdrawCash(self, amount, password):
        if not password:
            password = self.USER_KASSIR
        setattr(self.v, 'Summ1', amount)
        self.insist(self.v.CashOutcome, password)


    def openCashRegister(self, drawer, password):
        if not drawer:
            drawer = 0
        if not password:
            password = self.USER_KASSIR
        setattr(self.v, 'DrawerNumber', drawer)
        self.insist(self.v.OpenDrawer, password)


# BASEDIR = path.dirname(path.abspath(__file__))
# sysPath.append("printers\PosXML")
# sysPath.append("printers\Shtrih_M_By")
# import shtrihm as cm
# cm.init( {'feedbackURL': 'https://api.piletilevi.ee/bo/feedback'} )
# cm.uninit()
# del cm
# raise SystemExit

# Set plp_filename environment variable from passed argument
PLP_FILENAME = argv[1]
SCHEMA_FILENAME = path.join(BASEDIR, 'printsrv', 'jsonschema', 'plp.json')
with open(SCHEMA_FILENAME, 'rU') as schema_file:
    schema = loadJSON(schema_file)
with open(PLP_FILENAME, 'rU') as plp_data_file:
    PLP_JSON_DATA = loadJSON(plp_data_file, 'utf-8')
with open('ECRModes.yaml', 'r') as ecrmode_table_file:
    ECRMODE_TABLE = loadYAML(ecrmode_table_file)['ECRMode']


# import jsonschema
print('Validating against {0}: {1}').format(SCHEMA_FILENAME, PLP_FILENAME)
# try:
#     print('S: {0}'.format(schema))
#     print('D: {0}'.format(PLP_JSON_DATA))
#     jsonschema.validate(PLP_JSON_DATA, schema)
# except jsonschema.exceptions.ValidationError as ve:
#     print("JSON validation ERROR\n")
#     print( "{0}\n".format(ve))
#     raise ve

with open(path.join(BASEDIR, 'package.json'), 'rU') as package_json_file:
    PACKAGE_JSON_DATA = loadJSON(package_json_file)


def cmsale():
    global PLP_JSON_DATA

    card_payment_amount = 0
    for payment in PLP_JSON_DATA['fiscalData']['payments']:
        if payment['type'] == '4':
            card_payment_amount += payment['cost']
        print(payment['type'], card_payment_amount)

    if card_payment_amount > 0:
        global cm
        posxml.init({'url': 'http://192.168.2.45:4445'})
        posxml.post('CancelAllOperationsRequest', '')
        response = posxml.post('TransactionRequest', {
            'TransactionID': PLP_JSON_DATA['busnId'],
            'Amount'       : card_payment_amount*100,
            'CurrencyName' : 'EUR',
            'PrintReceipt' : 2,
            'Timeout'      : 100,
            'Language'     : 'en',
        })
        print(dumpsJSON(response, indent=4))
        print(response['ReturnCode'])
        if response['ReturnCode'] != '0':
            print(dumpsJSON(response, indent=4))
            print(response['Reason'].encode('utf-8'))

            posxml.waitForRemoveCardFromTerminal()


    payment_method_total = {}
    payment_method_total_validate = {}
    payment_sum_failed = False

    sales_options = []
    payment_options = []

    for payment in PLP_JSON_DATA['fiscalData']['payments']:
        if payment['type'] not in payment_method_total:
            payment_method_total[payment['type']] = 0
            payment_method_total_validate[payment['type']] = 0
        payment_method_total[payment['type']] += payment['cost']
        # cm.printLine('{0} = {1}'.format(payment['name'], '%.2f' % payment['cost']))

        payment_options.append({'cost': payment['cost'], 'type': payment['type']})

        for component in payment['components']:
            if not 'kkm' in component:
                continue
            if not component['kkm']:
                continue
            if not 'amount' in component:
                component['amount'] = 1
            if 'ticketId' in component:
                component['name'] = '{0} {1}'.format(component['name'].encode('utf-8'), component['ticketId'])
            payment_method_total_validate[payment['type']] += component['cost'] * component['amount']
            sales_options.append(component)


    for ix in payment_method_total:
        if round(payment_method_total[ix], 2) != round(payment_method_total_validate[ix], 2):
            # for i in range(0, 10):
                # cm.printLine()
            print('------------------------------------')
            print('     !!! FISCAL DATA ERROR !!!')
            print('        In payment type {0}'.format(ix))
            print('Sum of component costs | {0}'.format(payment_method_total_validate[ix]))
            print('doesnot match          | !=')
            print('sum of payment costs   | {0}'.format(payment_method_total[ix]))
            print('------------------------------------')
            cm.printLine('------------------------------------')
            cm.printLine('     !!! FISCAL DATA ERROR !!!')
            cm.printLine('         In payment type {0}'.format(ix))
            cm.printLine('Sum of component costs | {0}'.format(payment_method_total_validate[ix]))
            cm.printLine('doesnot match          | !=')
            cm.printLine('sum of payment costs   | {0}'.format(payment_method_total[ix]))
            cm.printLine('------------------------------------')
            for i in range(0, 3):
                cm.printLine()
            payment_sum_failed = True

    if payment_sum_failed:
        cm.cut()
    elif PLP_JSON_DATA['fiscalData']['operation'] == 'sale':
        cm.sale(sales_options, payment_options)
    elif PLP_JSON_DATA['fiscalData']['operation'] == 'refund':
        cm.returnSale(sales_options, payment_options)
    else:
        raise ValueError('operation={0} - must be sale/refund.'.format(PLP_JSON_DATA['fiscalData']['operation']))


if PLP_JSON_DATA['fiscalData']:
    VALID_OPERATIONS = ('cut', 'endshift', 'feed', 'insertcash', 'open_cachreg', 'refund', 'sale', 'startshift', 'withdrawcash', 'xreport')

    operation = PLP_JSON_DATA['fiscalData']['operation']
    print('{0} operation from:\n{1}'.format(operation, PLP_FILENAME))

    with ShtrihM(PLP_JSON_DATA) as cm:
        cm.cut()
        print('foo: {0}'.format(cm))
    print('raise')
    raise SystemExit


    operations_a = {
        'cut': cm.cut,
        'endshift': cm.closeShift,
        'feed': cm.feed,
        'insertcash': cm.insertCash,
        'open_cashreg': cm.openCashRegister,
        'refund': cmsale,
        'sale': cmsale,
        'startshift': cm.openShift,
        'withdrawcash': cm.withdrawCash,
        'xreport': cm.xReport
    }
    print('operation {0}'.format(operation))
    print('operation {0}'.format(operations_a[operation]))
    exit(0)

    if operation == 'cut':
        cm.cut()
    elif operation == 'endshift':
        cm.closeShift()
    elif operation == 'feed':
        cm.feed()
    elif operation == 'insertcash':
        cm.insertCash(PLP_JSON_DATA['fiscalData']['cashAmount'])
    elif operation == 'open_cashreg':
        cm.openCashRegister()
    elif operation == 'refund':
        cmsale()
    elif operation == 'sale':
        cmsale()
    elif operation == 'startshift':
        cm.openShift()
    elif operation == 'withdrawcash':
        cm.withdrawCash(PLP_JSON_DATA['fiscalData']['cashAmount'])
    elif operation == 'xreport':
        cm.xReport()
    else:
        raise ValueError('"operation" must be one of {0} in plp file.'.format(VALID_OPERATIONS))

    print('{0} operation from:\n{1} succeeded.'.format(operation, PLP_FILENAME))


if PLP_JSON_DATA['ticketData']:
    print('Invoke ticket printing')
    print_ticket.doPrint(PLP_JSON_DATA)


# C:\github\printsrv\printsrv_exe.py "C:\github\printsrv\printers\Shtrih_M_By\PLP prototypes\sale_cash.plp"
# C:\github\printsrv\printsrv_exe.py "C:\github\printsrv\printers\Shtrih_M_By\PLP prototypes\sale_gt_card.plp"
