# coding: utf-8

from distutils.core import setup
import py2exe

OPTIONS = [
    {
        "script": "printsrv_exe.py",
        "dest_base": "printsrv"
    }]

setup(
    options = {'py2exe': {'bundle_files': 1}},
    zipfile = None,
    console = OPTIONS
)

# run
# build_printsrv_exe.py py2exe
