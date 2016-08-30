move dist\* ..\
move persistent.ini ..\
move setup_*.ini ..\

PATH %PATH%;%programfiles%\IronPython 2.7

python -m pip install --upgrade pip
pip install fontname
pip install qrcode
pip install --pre github3.py --upgrade
pip install wmi

fonts/code128.ttf
fonts/datamatrix.ttf
fonts/ean13.ttf
fonts/pdf417.ttf

del install.bat
