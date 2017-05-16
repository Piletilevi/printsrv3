# This Python file uses the following encoding: utf-8

# PosXML module
import                                    requests
import                                    xmltodict
import                                    sys
from os           import path          as path
from json         import dumps         as dumpsJSON
from sys          import                  stdin
from yaml         import load          as loadYAML
from time         import                  sleep
from os           import                  chdir

class PosXML:
    def __init__(self, feedback, bye, options):
        self.feedback = feedback
        self.bye      = bye
        self.OPTIONS  = { 'headers': { 'content-type': "application/xml" } }
        for key, val in options.items():
            self.OPTIONS[key] = val
        if hasattr(sys, "frozen"):
            self.BASEDIR = path.dirname(sys.executable)
        else:
            self.BASEDIR = path.dirname(__file__)
        chdir(self.BASEDIR)
        posxml_responses_fn = path.join(self.BASEDIR, 'config', 'posxml_responses.yaml')
        with open(posxml_responses_fn, 'r') as posxml_responses_file:
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
