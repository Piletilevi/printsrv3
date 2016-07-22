# cardsrv
Ticket printer driver

## Setup
- install latest python from 2.x.x series https://www.python.org/downloads/  
  currently **2.7.12**

- install PIL from http://www.pythonware.com/products/pil/  
  currently **1.1.7**

- install PythonWin from https://sourceforge.net/projects/pywin32/files/  
  currently **Build 220**

- install py2exe from http://sourceforge.net/projects/py2exe/files/  
  currently **0.6.9**

- install wmi from https://pypi.python.org/pypi/WMI  
  currently **1.4.9**

- upgrade pip if needed  
  > python -m pip install --upgrade pip  
  currently **8.1.2**

- install esky from https://github.com/cloudmatrix/esky/  
  > pip install esky
  currently **0.9.9**

- install latest Nullsoft Scriptable Install System from http://nsis.sourceforge.net/Download  
  currently **2.51**

- install FontName from https://pypi.python.org/pypi/fontname 
  > pip install fontname
  currently **0.2.0**

- install qrcode from https://pypi.python.org/pypi/qrcode
  > pip install qrcode
  currently **5.3**


Pip packages should look like
> pip list
esky (0.9.9)
fontname (0.2.0)
freetype-py (1.0.2)
PIL (1.1.7)
pip (8.1.2)
py2exe (0.6.9)
pywin32 (220)
qrcode (5.3)
setuptools (20.10.1)
six (1.10.0)
WMI (1.4.9)

---

- to build run compile.bat or compile\_console\_esky.bat
- to package run make\_nsis\_esky.bat

deprecated. does not set VER variable. - right click on printsrv.nsi and choose "Compile NSIS script"
