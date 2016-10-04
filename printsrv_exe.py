# coding: utf-8
""" Main executable for printing tickets and/or fiscal receipts;
    Also used for invoking update procedures;
    Defines data and printer types for incoming plp files
        Data is one of ['tickets', 'fiscal', 'update'];
        Printer type is either 'tickets' or 'fiscal'.
    Makes sure correct script gets invoked based on provided .plp file.

    If .plp is NOT JSON, then we take a note of it and convert the file to JSON
        - PLP_DATA_TYPE = 'tickets'

    If .plp is JSON;
        - PLP_DATA_TYPE gets read from 'info' ('tickets' | 'fiscal' | 'update')

    if PLP_DATA_TYPE == 'update'
        Execute update script and exit.

    if printingDriverVersion provided in PLP doesnot match with version in
    printsrv/package.json
        Create the update script that will resume printsrv.exe with current parameters
        Execute update script and exit.

    If printerType is set in plp data, then
        - PLP_PRINTER_TYPE is set
    else
        - PLP_PRINTER_TYPE gets the value of PLP_DATA_TYPE

    if PLP_PRINTER_TYPE == 'tickets', then
        printsrv/print_ticket.py gets executed
    else if PLP_PRINTER_TYPE == 'fiscal', then
        RasoASM/print_tickets.ipy or
        RasoASM/print_fiscal_LANG.ipy or gets executed
"""
from os import environ, path, chdir, execl
from io import open as ioOpen
from sys import argv, exit
from subprocess import call
from json import load as loadJSON, dumps as dumpsJSON
from re import match

# To convert "old-good-flat" style plp to JSON data structure
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
    if plp_json_data['info'] not in ('fiscal', 'tickets', 'update'):
        raise ValueError('"info" must be either "fiscal", "tickets" or "update" in {0}.'.format(PLP_FILENAME))
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
    PLP_JSON_DATA = read_plp_file(PLP_FILENAME)
    # Backward compatible
    PLP_JSON_DATA['info'] = 'tickets'
    PLP_JSON_FILENAME = '{0}.json'.format(PLP_FILENAME)
else:
    pass


PLP_CONTENT_TYPE = PLP_JSON_DATA['info']
PLP_PRINTER_TYPE = (PLP_JSON_DATA['printerType'] if 'printerType' in PLP_JSON_DATA else PLP_CONTENT_TYPE)

if PLP_PRINTER_TYPE == 'fiscal':
    with ioOpen(PLP_JSON_FILENAME, 'w', encoding='utf-8') as outfile:
        outfile.write(unicode(dumpsJSON(
            PLP_JSON_DATA,
            ensure_ascii=False,
            indent=4,
            separators=(',', ': '),
            sort_keys=True
        )))
    environ['plp_filename'] = PLP_JSON_FILENAME


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
    validate_fiscal_json(PLP_JSON_DATA)
    RASO_DIRNAME = path.join(BASEDIR, 'RasoASM')
    RASO_FILENAME = 'print_{0}_{1}.ipy'.format(PLP_CONTENT_TYPE, LANGUAGE)
    chdir(RASO_DIRNAME)
    print('Invoke: {0}'.format(RASO_FILENAME))
    try:
        call(['ipy', RASO_FILENAME])
        pass
    except Exception as err:
        print 'Can not print fiscal', RASO_FILENAME, 'Error:', err.code

if 'printingDriverVersion' in PLP_JSON_DATA:
    with open(path.join(BASEDIR, 'printsrv', 'package.json'), 'rU') as package_json_file:
        PACKAGE_JSON_DATA = loadJSON(package_json_file)
        if PACKAGE_JSON_DATA['version'] != PLP_JSON_DATA['printingDriverVersion']:
            call_update(PLP_JSON_DATA['printingDriverVersion'])

if PLP_CONTENT_TYPE == 'update':
    call_update(PLP_JSON_DATA['version'])
