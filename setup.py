#!/usr/bin/python3
# -*- coding: utf-8 -*-

import sys
from cx_Freeze import setup, Executable

# Dependencies are automatically detected, but it might need fine tuning.
build_exe_options = {
    "packages": ["os"]
}

# GUI applications require a different base on Windows (the default is for a
# console application).
base = None
if sys.platform == "win32":
    base = "Win32GUI"

setup(  name = "printsrv",
        version = "3.0.0",
        description = "Piletirevi Printing Service",
        options = {"build_exe": build_exe_options},
        executables = [Executable("printsrv_exe.py", base="win32gui")])
