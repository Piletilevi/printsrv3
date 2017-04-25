# coding: utf-8

from os import path, chdir, execl, makedirs, remove, chmod
from stat import S_IWRITE
from io import open as ioOpen
from sys import argv, exit, path as sysPath
from subprocess import call
from json import load as loadJSON, dumps as dumpsJSON
import jsonschema
from re import match
from urllib2 import urlopen, URLError, HTTPError
from zipfile import ZipFile
from distutils.version import LooseVersion
from helpers import cd

BASEDIR = path.dirname(path.abspath(__file__))
sysPath.append("printers/PosXML")
import posxml
sysPath.append("printers/Shtrih_M_By")
import shtrihm as cm


# Set plp_filename environment variable from passed argument
PLP_FILENAME = argv[1]

with open(path.join(BASEDIR, 'printsrv', 'jsonschema', 'plp.json'), 'rU') as schema_file:
    schema = loadJSON(schema_file)
with open(PLP_FILENAME, 'rU') as plp_data_file:
    PLP_JSON_DATA = loadJSON(plp_data_file)
try:
    print('Validating against {0}: {1}').format(path.join(BASEDIR, 'printsrv', 'jsonschema', 'plp.json'), PLP_FILENAME)
    jsonschema.validate(PLP_JSON_DATA, schema)
except jsonschema.exceptions.ValidationError as ve:
    print("JSON validation ERROR\n")
    # print( "{0}\n".format(ve))
    raise ve

with open(path.join(BASEDIR, 'printsrv', 'package.json'), 'rU') as package_json_file:
    PACKAGE_JSON_DATA = loadJSON(package_json_file)


def cmsale():
    global PLP_JSON_DATA
    global cm

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
                component['name'] = '{0} {1}'.format(component['name'], component['ticketId'])
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
    print('{0} operation from:\n{1}'.format(operation, plp_filename))

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
        sale()
    elif operation == 'startshift':
        cm.openShift()
    elif operation == 'withdrawcash':
        cm.withdrawCash(PLP_JSON_DATA['fiscalData']['cashAmount'])
    elif operation == 'xreport':
        cm.xReport()
    else:
        raise ValueError('"operation" must be one of {0} in plp file.'.format(VALID_OPERATIONS))

    print('{0} operation from:\n{1} succeeded.'.format(operation, plp_filename))


if PLP_JSON_DATA['ticketData']:
    PRINTSRV_DIRNAME = path.join(BASEDIR, 'printers', 'ticket')
    PRINTSRV_FILENAME = 'print_ticket.py'
    chdir(PRINTSRV_DIRNAME)
    print('Invoke: {0}'.format(PRINTSRV_FILENAME))
    call(['python', PRINTSRV_FILENAME])
