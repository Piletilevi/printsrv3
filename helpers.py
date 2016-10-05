from os import environ, path, getcwd, chdir
from io import open


class cd:
    """Context manager for changing the current working directory"""
    def __init__(self, newPath):
        self.newPath = path.expanduser(newPath)

    def __enter__(self):
        self.savedPath = getcwd()
        chdir(self.newPath)

    def __exit__(self, etype, value, traceback):
        chdir(self.savedPath)


def read_param(line):
    line = line.strip()
    if len(line) == 0:
        return False

    if line[:6] == 'BEGIN ':
        return ('BEGIN', line)
    elif line[:4] == 'END ':
        return ('END', line)

    message = 'Cannot parse parameter from line [%s]' % line
    param = []
    for part in line.split('='):
        param.append(part.strip())
    if len(param) != 2:
        logger.warning(message)
        return False
    if len(param[0]) == 0:
        logger.warning(message)
        return False
    return param

def read_plp_file(plp_filename):
    plp_json_data = { 'documents': [] }
    head_ref = plp_json_data
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
                plp_json_data['documents'].append({})
                head_ref = plp_json_data['documents'][len(plp_json_data['documents'])-1]

            elif param_key == 'END':
                head_ref = plp_json_data

            else:
                head_ref[param_key] = param_val
    return plp_json_data
