import requests

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

OPTIONS['headers'] = {
    'content-type': "application/xml"
}

def init(options):
    global OPTIONS
    for key, val in options.iteritems():
        OPTIONS[key] = val

def post(payload = OPTIONS['payload']):
    response = requests.request('POST', OPTIONS['url'], data=payload, headers=OPTIONS['headers'])
    print(response.text)

post()