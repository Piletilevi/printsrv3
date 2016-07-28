For fastest delivery of driver code we require python 2.7.12 and ironPython 2.7.5 preinstalled.

## Prerequisites

- https://www.python.org/downloads/release/python-2712/
- http://ironpython.net/download/

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


### Drivers

- Download ticket printer driver from  
  https://github.com/Piletilevi/printsrv

- Download Raso ASM driver from  
  https://github.com/Piletilevi/RasoASM

I suggest You put these under same parent folder, i.e.
```
C:\...\...\drivers\printsrv
C:\...\...\drivers\RasoASM
```

### Configuration

- register .plp files to open with `python printsrv.py`  
- check persistent.ini
- check setup_<lang>.ini
- ignore README.md (its currently mostly for developers)
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
