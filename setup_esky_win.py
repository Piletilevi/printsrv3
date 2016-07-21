import os, sys, time
from esky.bdist_esky import Executable
from distutils.core import setup
from glob import glob
import version

if sys.platform in ['win32','cygwin','win64']:

#    data_files = [glob(r'.\install_files\*.*'),("img","install_files\example.gif"),("layouts","install_files\for_test.pla")] #install_files
    data_files = [
        ("", [r'.\install_files\mfc71.dll']),
        ("", [r'.\install_files\setup_lv.ini']),
        ("", [r'.\install_files\setup_ee.ini']),
        ("", [r'.\install_files\setup_by.ini']),
        ("", [r'.\install_files\setup_ru.ini']),
        ("", [r'.\install_files\setup_ru_OK_1.ini']),
        ("", [r'.\install_files\setup_ru_OK_2.ini']),
        ("", [r'.\install_files\setup_ru_OK_3.ini']),		
		("", [r'.\install_files\logger.ini']),
        ("", [r'.\install_files\CHANGELOG.txt']),      
        ("", [r'.\install_files\README.txt']),
        
        ("", glob(r'.\install_files\*.ttf')),
              
#        ("", [r'.\version.py']),
        ("layouts", [r'.\install_files\many_layouts_test.plp']),
        ("img", [r'.\install_files\example.gif'])]

    #  We can customuse the executable's creation by passing an instance
    #  of Executable() instead of just the script name.
    printsrv = Executable("printsrv.py",
                        #  give our app the standard Python icon
                        icon=os.path.join(sys.prefix,"DLLs","py.ico"),
                        #  we could make the app gui-only by setting this to True
                        gui_only=True,
                        #  any other keyword args would be passed on to py2exe
                        )

    setup(
      data_files=data_files,
      name = "printsrv-app",
      version = version.VERSION,
      scripts = [printsrv],
      options = {"bdist_esky":{
                 #  forcibly include some other modules
                 "includes": ["win32ui", "win32gui", "win32con", "qrcode"],
                 #  forcibly exclude some other modules
                 "excludes": ["pydoc"],
                 #  force esky to freeze the app using py2exe
                 "freezer_module": "py2exe",
                 #  tweak the options used by py2exe
                 # DO NOT CHANGE bundle_files to 1 as this will break
                 "freezer_options": {"bundle_files":3,"compressed":True},
              }}
    )
