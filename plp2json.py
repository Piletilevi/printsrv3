from os import environ, path, chdir
import codecs
from json import load as loadJSON, dumps as dumpsJSON, dump as dumpJSON
from io import open

PLP_FILENAME = environ['plp_filename']

def read_param(line):
    line = line.strip()
    if len(line) == 0:
        return False

    if line[:6] == 'BEGIN ':
        return ('BEGIN', line)
    elif line[:4] == 'END ':
        return ('END', line)

    message = 'Cannot parse parameter from line [%s]' % line
    param = line.split('=')
    if len(param) != 2:
        logger.warning(message)
        return False
    if len(param[0]) == 0:
        logger.warning(message)
        return False
    return param

def read_plp_file(plp_filename):

    plp_data = { 'documents': [] }
    head_ref = plp_data
    with open(plp_filename, 'r', encoding='utf-8') as infile:
        for line in infile:
            param = read_param(line)
            if not param:
                continue
            param_key, param_val = param
            if param_val == '':
                continue

            if param_key == 'BEGIN':
                print 'start new document'
                plp_data['documents'].append({})
                head_ref = plp_data['documents'][len(plp_data['documents'])-1]

            elif param_key == 'END':
                head_ref = plp_data

            else:
                head_ref[param_key] = param_val
    print dumpsJSON(plp_data, indent=4, ensure_ascii=False, separators=(',', ': '))
    with open('{0}.json'.format(plp_filename), 'w', encoding='utf-8') as outfile:
        outfile.write(unicode(dumpsJSON(plp_data, ensure_ascii=False, indent=4, separators=(',', ': '), sort_keys=True)))

read_plp_file(PLP_FILENAME)
