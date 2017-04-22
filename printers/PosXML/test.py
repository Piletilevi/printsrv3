# coding: utf-8

import json
import posxml
# from sys import stdin

posxml.init({'url': 'http://192.168.2.45:4445'})


print('CancelAllOperationsRequest')
response = posxml.post('CancelAllOperationsRequest', '')
print(json.dumps(response, indent=4))
print(response['ReturnCode'])

posxml.waitForRemoveCardFromTerminal()

print('TransactionRequest')
response = posxml.post('TransactionRequest', {
    'TransactionID': 42,
    'Amount'       : 101,
    'CurrencyName' : 'EUR',
    'PrintReceipt' : 2,
    'Timeout'      : 100,
    'Language'     : 'en',
})
print(json.dumps(response, indent=4))
print(response['ReturnCode'])
if response['ReturnCode'] != '0':
    print(json.dumps(response, indent=4))
    print(response['Reason'].encode('utf-8'))

posxml.waitForRemoveCardFromTerminal()

print('ReverseTransactionRequest')
response = posxml.post('ReverseTransactionRequest', {
    'UTFTesting'   : 'õüäöšžč'.decode('utf-8'),
    'TransactionID': 42,
    'PrintReceipt' : 2,
    'CurrencyName' : 'EUR'
})
print(json.dumps(response, indent=4))
print(response['ReturnCode'])
if response['ReturnCode'] != '0':
    print(response['Reason'].encode('utf-8'))

