# coding: utf-8

""" Main executable for printing tickets and/or fiscal receipts;
"""

from os import environ, path, chdir, execl, makedirs, remove, chmod
from stat import S_IWRITE
from io import open as ioOpen
from sys import argv, exit
from subprocess import call
from json import load as loadJSON, dumps as dumpsJSON
import jsonschema
from re import match
from urllib2 import urlopen, URLError, HTTPError
from zipfile import ZipFile
from distutils.version import LooseVersion
from helpers import cd

BASEDIR = path.realpath(path.dirname(argv[0]))


# Set plp_filename environment variable from passed argument
PLP_FILENAME = argv[1]
environ['plp_filename'] = path.realpath(PLP_FILENAME)


with open(path.join(BASEDIR, 'printsrv', 'jsonschema', 'plp.json'), 'rU') as schema_file:
    schema = loadJSON(schema_file)
with open(PLP_FILENAME, 'rU') as plp_data_file:
    PLP_JSON_DATA = loadJSON(plp_data_file)
try:
    print('Validating against {0}: {1}').format(path.join(BASEDIR, 'printsrv', 'jsonschema', 'plp.json'), PLP_FILENAME)
    jsonschema.validate(PLP_JSON_DATA, schema)
except jsonschema.exceptions.ValidationError as ve:
    sys.stderr.write("JSON validation ERROR\n")
    sys.stderr.write( "{0}\n".format(ve))
    raise ve

with open(path.join(BASEDIR, 'printsrv', 'package.json'), 'rU') as package_json_file:
    PACKAGE_JSON_DATA = loadJSON(package_json_file)


def dlfile(remote_filename, local_filename):
    try:
        remote_file = urlopen(remote_filename)
        print 'downloading', remote_filename, '-->', local_filename
        with open(local_filename, 'wb') as local_file:
            local_file.write(remote_file.read())

    #handle errors
    except HTTPError, err:
        print 'Can not update:', 'HTTP Error:', err.code, remote_filename
        return False
    except URLError, err:
        print 'Can not update:', 'URL Error:', err.reason, remote_filename
        return False
    except IOError, err:
        print 'Can not update:', 'IO Error:', err, local_filename
        return False

    return True


def ensure_dir(_directory):
    if not path.exists(_directory):
        makedirs(_directory)


def call_update():
    plp_current_version = LooseVersion(PACKAGE_JSON_DATA['version'])
    plp_update_to_version = LooseVersion(PLP_JSON_DATA['printingDriverVersion'])
    if plp_update_to_version == plp_current_version:
        print '\n\nAllready up to date at {0}'.format(plp_current_version)
        return
    if plp_update_to_version < LooseVersion('1.0.4'):
        print '\n\nRefusing to {2} from {0} to {1}. Anything less than 1.0.4 is just not acceptable.'.format(
            plp_current_version,
            plp_update_to_version,
            'downgrade' if plp_update_to_version < plp_current_version else 'upgrade'
        )
        return

    print '\n\n{2}grading from {0} to {1}.'.format(
        plp_current_version,
        plp_update_to_version,
        'Down' if plp_update_to_version < plp_current_version else 'Up'
    )

    REMOTE_PLEVI = 'https://github.com/Piletilevi/printsrv/releases/download/{0}/plevi_{0}.zip'.format(PLP_JSON_DATA['printingDriverVersion'])
    update_dir = path.join(BASEDIR, 'update')
    LOCAL_PLEVI = path.join(update_dir, path.basename(REMOTE_PLEVI))
    ensure_dir(update_dir)

    with cd(BASEDIR):
        with open('update.bat', 'w') as infile:
            infile.write('cd /d {0}\n'.format(update_dir))
            infile.write('for %%i in (*) do move "%%i" ..\n')
            infile.write('for /d %%i in (*) do rmdir "../%%i" /s /q\n')
            infile.write('for /d %%i in (*) do move "%%i" ..\n')
            infile.write('cd ..\n')
            infile.write('rmdir update /s /q\n')
            infile.write('printsrv.exe "{0}"\n'.format(PLP_FILENAME))
            infile.write('del update.bat\n'.format(PLP_FILENAME))

        with cd(update_dir):
            if dlfile(REMOTE_PLEVI, LOCAL_PLEVI):
                print 'Unpacking {0}'.format(LOCAL_PLEVI)
                with ZipFile(LOCAL_PLEVI, 'r') as z:
                    z.extractall(path.join(path.dirname(LOCAL_PLEVI)))
                remove(LOCAL_PLEVI)
            else:
                exit(1)

        execl('update.bat', 'update.bat')
        exit(0) # Will not reach this line, but for sake of readability.


call_update()


if PLP_JSON_DATA['fiscalData']:
    PRINTSRV_DIRNAME = path.join(BASEDIR, 'printers', 'fiscal_{0}'.format(PLP_JSON_DATA['salesPointCountry']))
    PRINTSRV_FILENAME = 'print_fiscal.ipy'
    chdir(PRINTSRV_DIRNAME)
    print('Invoke: {0}'.format(PRINTSRV_FILENAME))
    call(['ipy', PRINTSRV_FILENAME])

elif PLP_JSON_DATA['ticketData']:
    PRINTSRV_DIRNAME = path.join(BASEDIR, 'printers', 'ticket')
    PRINTSRV_FILENAME = 'print_ticket.py'
    chdir(PRINTSRV_DIRNAME)
    print('Invoke: {0}'.format(PRINTSRV_FILENAME))
    call(['python', PRINTSRV_FILENAME])
