# coding: utf-8

import requests
import xmltodict
import json
from os import path
from sys import argv, stdin
from yaml import load as loadYAML
import urllib
from time import sleep

BASEDIR = path.realpath(path.dirname(argv[0]))
with open(path.join(BASEDIR, 'responses.yaml'), 'r') as posxml_responses_file:
    PXRESPONSES = loadYAML(posxml_responses_file)

OPTIONS = { 'headers': { 'content-type': "application/xml" } }

def init(options):
    global OPTIONS
    for key, val in options.iteritems():
        OPTIONS[key] = val

def post(func, data):
    dict = { 'PosXML': { '@version':'7.2.0', } }
    dict['PosXML'][func] = data
    payload_xml = xmltodict.unparse(dict, pretty=True).encode('utf-8')
    http_response = requests.post(OPTIONS['url'], data=payload_xml, headers=OPTIONS['headers'])
    response = xmltodict.parse(http_response.content)['PosXML']
    try:
        # find if any key in response matches one of expected response keys
        responseKey = [key for key in PXRESPONSES[func] if key in response][0]
    except Exception as e:
        print('Expected responses: "' + ';'.join(PXRESPONSES[func]) 
            + '" not present in returned response keys: "' 
            + ';'.join(response.keys()) + '".')
        print(json.dumps(response, indent=4, encoding='utf-8'))
        print('Take a screenshot')
        stdin.readline()
        raise 
    if response[responseKey]['ReturnCode'] != '0' and not response[responseKey]['Reason']:
        response[responseKey]['Reason'] = 'ReturnCode: ' + response[responseKey]['ReturnCode']
    return response[responseKey]

def beep():
    post('DoBeepRequest', {'Frequency1':2000, 'Duration1':40})

def message(destination, message):
    post('DisplayMessageRequest', {
        'Action':1, 
        'BackLight':1, 
        'Destination':destination, 
        'Line2': message.encode('utf-8')
    })
def resetMessages():
    post('DisplayMessageRequest', {
        'Action':0
    })
    
def waitForRemoveCardFromTerminal():
    response = post('GetTerminalStatusRequest', '')
    CardStatus = response['CardStatus']
    if CardStatus != '0':
        print('Remove card from terminal')
        # message(2,'Remove card from terminal')
    while CardStatus != '0':
        beep()
        sleep(0.3)
        CardStatus = post('GetTerminalStatusRequest', '')['CardStatus']
    resetMessages()
