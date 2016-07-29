# coding: utf-8

from distutils.core import setup
import py2exe

console = [
    {
        "script": "printsrv_exe.py",
        "icon_resources": [(0, "favicon.ico")],
        "dest_base" : "printsrv"
    }]

setup(console = console)

# run
# build_printsrv_exe.py py2exe
