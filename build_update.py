# coding: utf-8

from distutils.core import setup
import py2exe

OPTIONS = [
    {
        "script": "update.py",
        "dest_base": "update"
    }]

setup(
    options = {'py2exe': {'bundle_files': 1}},
    zipfile = None,
    console = OPTIONS
)

# run
# build_update.py py2exe
