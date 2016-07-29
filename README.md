# printsrv
Ticket printer driver  
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/fd513dfbfcb645b1ac43bc381b4b5482)](https://www.codacy.com/app/mihkel-putrinsh/cardsrv?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Piletilevi/cardsrv&amp;utm_campaign=Badge_Grade)


For fastest delivery of driver code we require python 2.7.12 and ironPython 2.7.5 preinstalled.

## Prerequisites

- https://www.python.org/downloads/release/python-2712/
- http://ironpython.net/download/

Also You have to add ironPython manually to windows PATH
do something like
```
> PATH %PATH%;c:\Program Files (x86)\IronPython 2.7
```

### Required modules:

- upgrade pip if needed  
  `python -m pip install --upgrade pip`
  > currently **8.1.2**

- install FontName from https://pypi.python.org/pypi/fontname  
  `pip install fontname`
  > currently **0.2.0**

- install qrcode from https://pypi.python.org/pypi/qrcode  
  `pip install qrcode`
  > currently **5.3**

- install github API (v3) from https://github.com/sigmavirus24/github3.py  
  `pip install github3`
  > currently **1.0.0a4**

- install PIL from http://www.pythonware.com/products/pil/  
  > currently **1.1.7**

- install PythonWin from https://sourceforge.net/projects/pywin32/files/  
  > currently **Build 220**

- install wmi from https://pypi.python.org/pypi/WMI  
  `pip install wmi`
  > currently **1.4.9**


### Drivers

- Download ticket printer driver from  
    https://github.com/Piletilevi/printsrv

- Download Raso ASM driver from  
    https://github.com/Piletilevi/RasoASM

- Put these under C:\plevi
    ```
    C:\plevi\printsrv
    C:\plevi\RasoASM
    ```

- execute `C:\plevi\printsrv\install.bat`


### Configuration

- register .plp files to open with `C:\plevi\printsrv.exe`  
- check persistent.ini
- check setup_<lang>.ini
- forgive me for tons of unnecessary code and files - cleaning up right now

### Special note

Please make sure, that connected wires are connected in same order over all installations.
Also make sure port mapping is identical everywhere.  

Even better
- create a document, where required wiring and port mapping is described and every time someone drives to point of sale to install the printers, give these instructions along.  
- label the wires. get a permanent marker or buy labeling machine
- take a photo of correctly connected wires at every POS

Thank me later.  
M-O-O-R
