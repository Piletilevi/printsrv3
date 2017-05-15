from distutils.core import setup
import sys, py2exe

sys.argv.append('py2exe')

OPTIONS = [
    {
        "script": "printsrv.py",
        "dest_base": "printsrv"
    }
]

setup(
	# cmdclass={"py2exe": JsonSchemaCollector},
    options = {
        'py2exe': {
            'bundle_files': 3,
            'includes': ['requests', 'xmltodict', 'json', 'yaml', 'time'
                        , 'urllib3', 'win32com', 'posxml', 'win32ui', 'win32gui'
                        , 'win32print', 'ctypes', 'queue'],
            'excludes': ['tkinter'],
        }
    },
    zipfile = None, #'printsrv-lib.zip',
    console = OPTIONS,
    data_files = [
        ( 'config', [ 'config\\layout.yaml'
                     , 'config\\posxml_responses.yaml'
                     , 'config\\fiscal_reply.yaml'
                     , 'config\\ECRModes.yaml'
                     , 'config\\feedbackTemplate.json'
                     ]
        ),
        ( '.', ['package.json'] ),
        ( 'img', [] )
    ],
)
