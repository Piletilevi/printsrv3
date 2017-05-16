# -*- coding: utf-8 -*-

from time import time
start_time = time()

from os import kill
from os import getpid
import signal
def bye():
    kill(getpid(), signal.SIGTERM)

import                    fileinput
import                    requests
import                    sys
from os   import          path
from os   import          chdir
from sys  import          argv
from time import          sleep
from json import dumps as dumpsJSON
from json import load  as loadJSON
from json import loads as loadsJSON
from sys  import path  as sysPath
from yaml import load  as loadYAML
from yaml import dump  as dumpYAML

from ShtrihM import ShtrihM
from PSPrint import PSPrint


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

fbtmpl_fn = path.join(BASEDIR, 'config', 'feedbackTemplate.json')
with open(fbtmpl_fn, 'rU', encoding='utf-8') as feedback_template_file:
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
        print('BO response: {0}'.format(dumpsJSON(response_json, indent=4)))
    except Exception as e:
        print(e)
        input("Press Enter to continue...")
        print('BO response: {0}'.format(r.text))
        if reverse:
            reverse()
        bye()



def noop():
    pass

def doFiscal():
    _amount = 0
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

        _amount = operations_a[operation]['operation']() or 0

    fiscal_reply_fn = path.join(BASEDIR, 'config', 'fiscal_reply.yaml')
    fiscal_reply_ofn = path.join(BASEDIR, 'tmp.txt')
    with open(fiscal_reply_fn, 'r', encoding='utf-8') as fiscal_reply_file:
        FISCAL_REPLY = loadYAML(fiscal_reply_file)

    if _amount == 0:
        reply_message = FISCAL_REPLY[operation]['reply']
    else:
        reply_message = FISCAL_REPLY[operation]['exactReply'].format(_amount)

    # print('reply_message: {0}'.format(reply_message).encode(sys.stdout.encoding, errors='replace'))
    feedback({'code': '0', 'message': reply_message}, success=True, reverse=operations_a[operation].get('reverse', None))


if 'fiscalData' in PLP_JSON_DATA:
    doFiscal()


if 'ticketData' in PLP_JSON_DATA:
    with PSPrint(feedback, bye, PLP_JSON_DATA) as ps:
        ps.printTickets()

bye()
