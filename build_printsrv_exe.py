# coding: utf-8

from distutils.core import setup
# import py2exe

CONSOLE = [
    {
        "script": "printsrv_exe.py",
        "icon_resources": [(0, "favicon.ico")],
        "dest_base" : "printsrv"
    }]

setup(console = CONSOLE)

# run
# build_printsrv_exe.py py2exe
