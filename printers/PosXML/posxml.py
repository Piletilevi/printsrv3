import requests
from dicttoxml import dicttoxml

OPTIONS = {}

OPTIONS['url'] = "http://192.168.2.45:4445/"

OPTIONS['payload'] = """<?xml version="1.0" encoding="UTF-8" ?>
<PosXML version="7.2.0">
    <DoBeepRequest>
        <Frequency1>2000</Frequency1>
        <Duration1>40</Duration1>
        <Interval1>10</Interval1>
        <Repeat>2</Repeat>
        <RepeatInt>100</RepeatInt>
    </DoBeepRequest>
</PosXML>"""

OPTIONS['postData'] = {
    'DoBeepRequest': {
        'Frequency1': 2000,
        'Duration1':  40,
        'Interval1':  10,
        'Repeat':     2,
        'RepeatInt':  100,
    }
}

OPTIONS['headers'] = {
    'content-type': "application/xml"
}

def init(options):
    global OPTIONS
    for key, val in options.iteritems():
        OPTIONS[key] = val

def post(postData = OPTIONS['postData']):
    xml = """<?xml version="1.0" encoding="UTF-8" ?>
<PosXML version="7.2.0">
""" + dicttoxml(postData, root=False, attr_type=False) + """
</PosXML>"""

    print(xml)
    response = requests.request('POST', OPTIONS['url'], data=xml, headers=OPTIONS['headers'])
    print(response.text)

# Usage:
# ---------
# post({ 
# 'RefundTransactionRequest': {
#     'TransactionID': 1,
#     'RefundAmount' : 100,
#     'CurrencyName' : 'EUR',
#     'PrintReceipt' : 2,
#     'Timeout'      : 100,
# }})