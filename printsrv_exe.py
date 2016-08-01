# coding: utf-8
""" Main executable for printing tickets and/or fiscal receipts
    Also used for invoking update procedures
    Makes sure correct script gets invoked based on provided .plp file
    If .plp is NOT JSON, then it gets forvarded to printsrv.py;
    If .plp is JSON; and info == 'fiscal', then RasoASM gets invoked;
    If .plp is JSON; and info == 'update', then update script gets invoked
"""
from os import environ, path, chdir
from sys import argv
from subprocess import call
from json import load as loadJSON

PERS_INI_FILE = 'C:\plevi\persistent.ini'
LANGUAGE = None
with open(PERS_INI_FILE) as f:
	for l in f:
		if (re.match("my_id", l)):
			LANGUAGE = l.split("=")[1].strip().split("_")[0]
if (not LANGUAGE):
    raise Exception('Could not detect language from {0}.'.format(PERS_INI_FILE))
environ['language'] = LANGUAGE


PLP_FILENAME = argv[1]
environ['plp_filename'] = path.realpath(PLP_FILENAME)


# Detect plp file type.
# If valid JSON, read file type from "info" field, otherwise assume it's for a ticket
try:
    with open(PLP_FILENAME, "rU") as plp_data_file:
        PLP_JSON_DATA = loadJSON(plp_data_file)
except Exception as e:
    PLP_FILE_TYPE = "ticket"
else:
    PLP_FILE_TYPE = PLP_JSON_DATA["info"]


if (PLP_FILE_TYPE == "ticket"):
    PRINTSRV_DIRNAME = path.join(path.dirname(argv[0]), 'printsrv')
    PRINTSRV_FILENAME = path.join(PRINTSRV_DIRNAME, 'printsrv.py')
    chdir(PRINTSRV_DIRNAME)
    call(['python', PRINTSRV_FILENAME])
elif (PLP_FILE_TYPE == "fiscal"):
    appexe = os.path.abspath(os.path.join("..", "RasoASM", "fiscal.py"))
    logger.info("Invoke: {0}".format(appexe))
    os.execlp("python", "python", appexe)
