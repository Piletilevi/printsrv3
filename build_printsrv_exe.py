# coding: utf-8

from distutils.core import setup
import py2exe as build_exe
import os, jsonschema

# from py2exe.build_exe import py2exe as build_exe

class JsonSchemaCollector(build_exe):
    """
       This class Adds jsonschema files draft3.json and draft4.json to
       the list of compiled files so it will be included in the zipfile.
    """

    def copy_extensions(self, extensions):
        build_exe.copy_extensions(self, extensions)

        # Define the data path where the files reside.
        data_path = os.path.join(jsonschema.__path__[0], 'schemas')

        # Create the subdir where the json files are collected.
        media = os.path.join('jsonschema', 'schemas')
        full = os.path.join(self.collect_dir, media)
        self.mkpath(full)

        # Copy the json files to the collection dir. Also add the copied file
        # to the list of compiled files so it will be included in the zipfile.
        for name in os.listdir(data_path):
            file_name = os.path.join(data_path, name)
            self.copy_file(file_name, os.path.join(full, name))
            self.compiled_files.append(os.path.join(media, name))

OPTIONS = [
    {
        "script": "printsrv_exe.py",
        "dest_base": "printsrv"
    }]

setup(
	# cmdclass={"py2exe": JsonSchemaCollector},
    options = {'py2exe': {'bundle_files': 3}},
    zipfile = 'printsrv-lib.zip',
    console = OPTIONS
)

# run
# python build_printsrv_exe.py py2exe
