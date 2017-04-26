# coding: utf-8

from os import path, chdir
from sys import argv, path as sysPath
from json import load as loadJSON, dumps as dumpsJSON
from yaml import load as loadYAML
# from re import match

import print_ticket
BASEDIR = path.dirname(path.abspath(__file__))
chdir(BASEDIR)
sysPath.append("printers/PosXML")
import posxml
sysPath.append("printers/Shtrih_M_By")
import shtrihm as cm


# Set plp_filename environment variable from passed argument
PLP_FILENAME = argv[1]

with open(path.join(BASEDIR, 'printsrv', 'jsonschema', 'plp.json'), 'rU') as schema_file:
    schema = loadJSON(schema_file)
with open(PLP_FILENAME, 'rU') as plp_data_file:
    PLP_JSON_DATA = loadJSON(plp_data_file, 'utf-8')

# import jsonschema
# try:
#     print('Validating against {0}: {1}').format(path.join(BASEDIR, 'printsrv', 'jsonschema', 'plp.json'), PLP_FILENAME)
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

    cm.init({'feedbackURL': 'https://api.piletilevi.ee/bo/feedback'})
    cm.connect()
    cm.setMode2()

    print('operation {0}'.format(operation))
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
