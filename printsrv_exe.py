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
    def __init__(self, plp_json_data, password=None):
        self.PLP_JSON_DATA = plp_json_data
        self.USER_SADM     = 30000
        self.USER_ADM      = 29000
        self.USER_KASSIR   = 1000
        self.password      = password if password else self.USER_KASSIR
        self.RETRY_SEC     = 0.1
        self.TIMEOUT_SEC   = 2
        self.v             = win32com.client.Dispatch('Addin.DrvFR')

        self.connect()
        self.setMode2()


    def __enter__(self):
        return self


    def __exit__(self, exc_type, exc_value, traceback):
        del self.v


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


    def insist(self, method, password=None):
        self.v.Password = password if password else self.password
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
        self.insist(self.v.WaitConnection)
        self.insist(self.v.Connect)
        self.prc()


    def closeShift(self):
        # print "performing PrintReportWithCleaning() (Press ENTER)"
        # stdin.readline()
        self.insist(self.v.PrintReportWithCleaning, self.USER_ADM)
        self.prc()


    def xReport(self):
        # print "performing PrintReportWithoutCleaning() (Press ENTER)"
        self.insist(self.v.PrintReportWithoutCleaning, self.USER_ADM)
        self.prc()


    def openShift(self):
        self.insist(self.v.OpenSession, self.USER_ADM)
        self.prc()
        # Shift will be actually opened with first recipe


    def sysAdminCancelCheck(self):
        self.v.Password = self.USER_SADM
        self.v.SysAdminCancelCheck()
        self.v.Password = 0


    def setMode2(self):
        timecount = 0

        # print "Initial ECRMode " + self.ecr_mode_string(v.ECRMode)

        if self.v.ECRMode == 8:
            self.insist(self.v.Beep)
            print "Waiting for mode change"
            print "self.v.ECRMode8Status " + str(self.v.ECRMode8Status)
            while self.v.ECRMode == 8:
                self.insist(self.v.GetShortECRStatus)
                sleep(RETRY_SEC)
                timecount = timecount + RETRY_SEC
                if timecount > TIMEOUT_SEC:
                    timecount = 0
                    print "sysAdminCancelCheck"
                    sysAdminCancelCheck()
            print "ECRMode " + self.ecr_mode_string(self.v.ECRMode)

        self.insist(self.v.ResetECR)
        self.prc()

        if self.v.ECRMode == 0:
            self.insist(self.v.Beep)
            print "Waiting for mode change"
            while self.v.ECRMode == 0:
                self.insist(self.v.GetShortECRStatus)
                sleep(RETRY_SEC)

        if self.v.ECRMode not in [2,3,4]:
            print "Can't go on with ECRMode: " + self.ecr_mode_string(self.v.ECRMode)
            print "Exiting (Press ENTER)"
            stdin.readline()
            exit(1)

        if self.v.ECRMode == 3:
            print self.ecr_mode_string(self.v.ECRMode)
            self.closeShift()

        if self.v.ECRMode == 4:
            print self.ecr_mode_string(self.v.ECRMode)
            self.openShift()


    def sale(self, sales_options, payment_options):
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
                setattr(self.v, attr, value)
            self.insist(self.v.Sale)

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
                'StringForPrinting': item['name'].decode(encoding='UTF-8')
            }.iteritems():
                # print 'Setting {0} = {1}'.format(attr, value)
                setattr(self.v, attr, value)
            self.insist(self.v.ReturnSale)

        for item in payment_options:
            # print 'Setting from {0}'.format(item)
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
            setattr(self.v, 'StringForPrinting', string.decode(encoding='UTF-8'))
            print ('Printing on receipt: "{0}"'.format(string.decode(encoding='UTF-8')))
            self.insist(self.v.PrintString)


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
        self.insist(self.v.CutCheck)


    def insertCash(self):
        setattr(self.v, 'Summ1', self.PLP_JSON_DATA['fiscalData']['cashAmount'])
        self.insist(self.v.CashIncome)


    def withdrawCash(self):
        setattr(self.v, 'Summ1', self.PLP_JSON_DATA['fiscalData']['cashAmount'])
        self.insist(self.v.CashOutcome)


    def openCashRegister(self, drawer):
        if not drawer:
            drawer = 0
        setattr(self.v, 'DrawerNumber', drawer)
        self.insist(self.v.OpenDrawer)


    def cmsale(self):
        card_payment_amount = 0
        for payment in self.PLP_JSON_DATA['fiscalData']['payments']:
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


if PLP_JSON_DATA['fiscalData']:
    with ShtrihM(PLP_JSON_DATA) as cm:

        operation = PLP_JSON_DATA['fiscalData']['operation']
        print('{0} operation from:\n{1}'.format(operation, PLP_FILENAME))

        operations_a = {
            'cut': cm.cut,
            'endshift': cm.closeShift,
            'feed': cm.feed,
            'insertcash': cm.insertCash,
            'open_cashreg': cm.openCashRegister,
            'refund': cm.cmsale,
            'sale': cm.cmsale,
            'startshift': cm.openShift,
            'withdrawcash': cm.withdrawCash,
            'xreport': cm.xReport
        }
        VALID_OPERATIONS = operations_a.keys()
        if operation not in VALID_OPERATIONS:
            raise ValueError('"operation" must be one of {0} in plp file. Got {1} instead.'.format(VALID_OPERATIONS, operation))
        print('operation {0} in {1}'.format(operation, VALID_OPERATIONS))
        print('operation {0}'.format(operations_a[operation]))

        operations_a[operation]()

        print('raise')
        exit(0)


    print('{0} operation from:\n{1} succeeded.'.format(operation, PLP_FILENAME))


if PLP_JSON_DATA['ticketData']:
    print('Invoke ticket printing')
    print_ticket.doPrint(PLP_JSON_DATA)


# C:\github\printsrv\printsrv_exe.py "C:\github\printsrv\printers\Shtrih_M_By\PLP prototypes\sale_cash.plp"
# C:\github\printsrv\printsrv_exe.py "C:\github\printsrv\printers\Shtrih_M_By\PLP prototypes\sale_gt_card.plp"
