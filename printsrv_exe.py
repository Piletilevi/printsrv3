# coding: utf-8

from os import environ, path, chdir
from sys import argv
from subprocess import call

printsrv_dirname = path.join(path.dirname(argv[0]), '..')
printsrv_filename = path.join(printsrv_dirname, 'printsrv.py')

plp_filename = argv[1]
environ['plp_filename'] = path.realpath(plp_filename)

chdir(printsrv_dirname)
call(['python', printsrv_filename])
