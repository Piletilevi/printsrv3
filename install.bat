move dist\* ..\
move persistent.ini ..\
move setup_*.ini ..\

PATH %PATH%;%programfiles%\IronPython 2.7

python -m pip install --upgrade pip
pip install fontname
pip install qrcode
pip install github3.py
pip install wmi

del install.bat
