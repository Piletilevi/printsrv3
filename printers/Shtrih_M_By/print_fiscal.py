# coding: utf-8

from json import load as loadJSON
from os import environ, path, chdir
from subprocess import call
from sys import argv, exit, path as sysPath

import shtrihm as cm
sysPath.append("../PosXML")
import posxml

posxml.init({'url': 'http://192.168.2.45:4445'})
print('CancelAllOperationsRequest')
response = posxml.post('CancelAllOperationsRequest', '')
print(json.dumps(response, indent=4))
print(response['ReturnCode'])


if 'plp_filename' in environ:
    plp_filename = environ['plp_filename']
else:
    print 'PLP filename not in environment.'
    if len(argv) > 1:
        plp_filename = argv[1]
    else:
        print 'PLP filename not in arguments, neither. Bye.'
        exit(0)

with open(plp_filename, 'rU') as plp_data_file:
    plp_json_data = loadJSON(plp_data_file, 'WIN1251')


VALID_OPERATIONS = ('cut', 'endshift', 'feed', 'insertcash', 'open_cachreg', 'refund', 'sale', 'startshift', 'withdrawcash', 'xreport')


def sale():
    global plp_json_data
    global cm

    payment_method_total = {}
    payment_method_total_validate = {}
    payment_sum_failed = False

    sales_options = []
    payment_options = []

    for payment in plp_json_data['fiscalData']['payments']:
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
    elif plp_json_data['fiscalData']['operation'] == 'sale':
        cm.sale(sales_options, payment_options)
    elif plp_json_data['fiscalData']['operation'] == 'refund':
        cm.returnSale(sales_options, payment_options)
    else:
        raise ValueError('operation={0} - must be sale/refund.'.format(plp_json_data['fiscalData']['operation']))



operation = plp_json_data['fiscalData']['operation']
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
    cm.insertCash(plp_json_data['fiscalData']['cashAmount'])
elif operation == 'open_cashreg':
    cm.openCashRegister()
elif operation == 'refund':
    sale()
elif operation == 'sale':
    sale()
elif operation == 'startshift':
    cm.openShift()
elif operation == 'withdrawcash':
    cm.withdrawCash(plp_json_data['fiscalData']['cashAmount'])
elif operation == 'xreport':
    cm.xReport()
else:
    raise ValueError('"operation" must be one of {0} in plp file.'.format(VALID_OPERATIONS))


print('{0} operation from:\n{1} succeeded.'.format(operation, plp_filename))
if plp_json_data['ticketData']:
    BASEDIR = path.realpath(path.dirname(argv[0]))
    PRINTSRV_DIRNAME = path.join(BASEDIR, '..', '..')
    print(PRINTSRV_DIRNAME)
    PRINTSRV_FILENAME = 'print_ticket.py'
    chdir(PRINTSRV_DIRNAME)
    print('Invoke: {0}'.format(PRINTSRV_FILENAME))
    call(['python', PRINTSRV_FILENAME])
