# printsrv
Ticket printer driver  
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/fd513dfbfcb645b1ac43bc381b4b5482)](https://www.codacy.com/app/mihkel-putrinsh/cardsrv?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Piletilevi/cardsrv&amp;utm_campaign=Badge_Grade)


For fastest delivery of driver code we require python 2.7.12 and ironPython 2.7.5 preinstalled.

## Prerequisites

**!NB**
> Make sure that in Python installer, on **Customize Python** screen, You must select
**[Will be installed on local hard drive]** for **[Add python.exe to path]**

- download, extract, and install [python-2.7.12](https://github.com/Piletilevi/printsrv/files/391929/python-2.7.12.zip)  
- download, extract, and install [IronPython-2.7.5](https://github.com/Piletilevi/printsrv/files/391931/IronPython-2.7.5.zip)  
- download, extract, and install [PIL-1.1.7.win32-py2.7](https://github.com/Piletilevi/printsrv/files/391901/PIL-1.1.7.win32-py2.7.zip)  
- download, extract, and install [pywin32-220.win32-py2.7](https://github.com/Piletilevi/printsrv/files/391897/pywin32-220.win32-py2.7.zip)


### Drivers

- Download ticket printer drivers [printsrv 0.2.0.zip](https://github.com/Piletilevi/printsrv/files/391887/printsrv.0.2.0.zip)
- Unpack the contents to C:\plevi folder  
```
C:\plevi\printsrv  
C:\plevi\RasoASM  
```
- execute `C:\plevi\printsrv\install.bat`  


### Configuration

- cmd -> PATH %PATH%;%programfiles%\IronPython 2.7
- register .plp files in Windows to be opened automatically with `C:\plevi\printsrv.exe`  
- check `C:\plevi\persistent.ini`
- check `C:\plevi\setup_lt.ini`
- forgive me for tons of unnecessary code and files - still cleaning up

### Special note

Please make sure, that connected wires are connected in same order over all installations.
Also make sure port mapping is identical everywhere.  

Even better
- create a document, where required wiring and port mapping is described and every time someone drives to point of sale to install the printers, give these instructions along.  
- label the wires. get a permanent marker or buy labeling machine
- take a photo of correctly connected wires at every POS

Thank me later.  
M-O-O-R
