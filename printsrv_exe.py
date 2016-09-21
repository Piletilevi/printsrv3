# coding: utf-8
""" Main executable for printing tickets and/or fiscal receipts
    Also used for invoking update procedures
    Makes sure correct script gets invoked based on provided .plp file
    If .plp is NOT JSON, then it gets forvarded to printsrv.py;
    If .plp is JSON;
       and info == 'fiscal',
       and operation in ('sale', 'startshift', 'endshift')
       then RasoASM gets invoked;
    If .plp is JSON;
       and info == 'update',
       and version = 'GitHub tag' is provided
       then update script gets invoked;
    If .plp is JSON;
       and info == 'fiscal',
       and operation 'endshift'
       and version = 'GitHub tag' is provided
       then update script gets invoked after RasoASM returns.
"""
from os import environ, path, chdir, execl
from sys import argv, exit
from subprocess import call
from json import load as loadJSON
from re import match

from plp2json import read_plp_file

BASEDIR = path.realpath(path.dirname(argv[0]))

# Set plp_language environment variable from persistent.ini
PERS_INI_FILE = 'C:\plevi\persistent.ini'
LANGUAGE = None
with open(PERS_INI_FILE, 'rU') as f:
    for l in f:
        if match('my_id', l):
            LANGUAGE = l.split('=')[1].strip().split('_')[0]
if not LANGUAGE:
    raise Exception('Could not detect language from {0}.'.format(PERS_INI_FILE))
print('Setting language to {0}'.format(LANGUAGE))
environ['plp_language'] = LANGUAGE


# Set plp_filename environment variable from passed argument
PLP_FILENAME = argv[1]
environ['plp_filename'] = path.realpath(PLP_FILENAME)


def validate_fiscal_json(plp_json_data):
    """ Make sure plp file has required attributes. """
    if not 'info' in plp_json_data:
        raise IndexError('Missing "info" field in plp file {0}.'.format(PLP_FILENAME))
    if plp_json_data['info'] not in ('fiscal', 'update'):
        raise ValueError('"info" must be either "fiscal" or "update" in {0}.'.format(PLP_FILENAME))
    if plp_json_data['info'] == 'fiscal':
        if not 'operation' in plp_json_data:
            raise IndexError('Missing "operation" field in plp file {0}.'.format(PLP_FILENAME))
        if plp_json_data['operation'] not in ('sale', 'refund', 'startshift', 'endshift'):
            raise ValueError('"operation" must be one of "sale", "refund", "startshift", "endshift" in {0}.'.format(PLP_FILENAME))
    if plp_json_data['info'] == 'update':
        if not 'version' in plp_json_data:
            print('Note: Missing "version" field in plp file {0}.'.format(PLP_FILENAME))


# Detect plp file type.
# If valid JSON, read file type from 'info' field, otherwise assume it's for tickets
try:
    with open(PLP_FILENAME, 'rU') as plp_data_file:
        PLP_JSON_DATA = loadJSON(plp_data_file)
except ValueError:
    PLP_JSON_DATA = read_plp_file(plp_data_file)
    # print dumpsJSON(PLP_JSON_DATA, indent=4, ensure_ascii=False, separators=(',', ': '))
    PLP_FILE_TYPE = 'flat'
else:
    validate_fiscal_json(PLP_JSON_DATA)
    PLP_FILE_TYPE = 'json'

if 'info' not in PLP_JSON_DATA: # Backward compatible
    PLP_JSON_DATA['info'] = 'tickets'

PLP_CONTENT_TYPE = PLP_JSON_DATA['info']

if 'ticketPrinterType' in PLP_JSON_DATA:
    PLP_PRINTER_TYPE = PLP_JSON_DATA['ticketPrinterType']
elif 'fiscalPrinterType' in PLP_JSON_DATA:
    PLP_PRINTER_TYPE = PLP_JSON_DATA['fiscalPrinterType']
else:
    PLP_PRINTER_TYPE = PLP_CONTENT_TYPE


def call_update(plp_update_to_version):
    environ['plp_update_to_version'] = plp_update_to_version
    update_filename = path.join(BASEDIR, 'update.exe')
    chdir(BASEDIR)
    print('Invoke: {0}'.format(update_filename))
    # call(update_filename)
    # exit(0)
    execl(update_filename, update_filename)


if PLP_PRINTER_TYPE == 'tickets':
    PRINTSRV_DIRNAME = path.join(BASEDIR, 'printsrv')
    # PRINTSRV_FILENAME = path.join(PRINTSRV_DIRNAME, 'print_ticket.py')
    PRINTSRV_FILENAME = 'print_ticket.py'
    chdir(PRINTSRV_DIRNAME)
    print('Invoke: {0}'.format(PRINTSRV_FILENAME))
    call(['python', PRINTSRV_FILENAME])

elif PLP_PRINTER_TYPE == 'fiscal':
    RASO_DIRNAME = path.join(BASEDIR, 'RasoASM')
    # RASO_FILENAME = path.join(RASO_DIRNAME, 'print_fiscal_{0}.ipy'.format(LANGUAGE))
    RASO_FILENAME = 'print_{0}_{1}.ipy'.format(PLP_CONTENT_TYPE, LANGUAGE)
    chdir(RASO_DIRNAME)
    print('Invoke: {0}'.format(RASO_FILENAME))
    try:
        call(['ipy', RASO_FILENAME])
        pass
    except Exception as err:
        print 'Can not print fiscal', RASO_FILENAME, 'Error:', err.code
    if PLP_JSON_DATA['operation'] == 'endshift':
        if 'version' in PLP_JSON_DATA:
            call_update(PLP_JSON_DATA['version'])

if PLP_CONTENT_TYPE == 'update':
    call_update(PLP_JSON_DATA['version'])
