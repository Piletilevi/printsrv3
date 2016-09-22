# printsrv
Ticket printer driver  
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/fd513dfbfcb645b1ac43bc381b4b5482)](https://www.codacy.com/app/mihkel-putrinsh/cardsrv?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Piletilevi/cardsrv&amp;utm_campaign=Badge_Grade)

### Contents:

- [Prerequisites checklist](https://github.com/Piletilevi/printsrv/blob/master/README.md#prerequisites-checklist)
- [Drivers](https://github.com/Piletilevi/printsrv/blob/master/README.md#drivers)
- [Check](https://github.com/Piletilevi/printsrv/blob/master/README.md#check)
- [Configuration](https://github.com/Piletilevi/printsrv/blob/master/README.md#donfiguration)
- [Special note](https://github.com/Piletilevi/printsrv/blob/master/README.md#special-note)
- [Manual updating](https://github.com/Piletilevi/printsrv/blob/master/README.md#manual-updating)


### Prerequisites checklist:

1. Remember that in Python installer in step 2.,  
   on **Customize Python** screen,  
   You must select **[Will be installed on local hard drive]** for **[Add python.exe to path]**
2. download, extract, and install [python-2.7.12](https://github.com/Piletilevi/printsrv/files/391929/python-2.7.12.zip)  
3. download, extract, and install [PIL-1.1.7.win32-py2.7](https://github.com/Piletilevi/printsrv/files/391901/PIL-1.1.7.win32-py2.7.zip)  
4. download, extract, and install [pywin32-220.win32-py2.7](https://github.com/Piletilevi/printsrv/files/391897/pywin32-220.win32-py2.7.zip)


### Drivers

1. Download ticket printer drivers [plevi-1.0.1.zip](https://github.com/Piletilevi/printsrv/releases/download/1.0.1/plevi_1.0.1.zip)
2. Unpack the contents into C:\plevi folder
3. Execute `C:\plevi\install.bat`


### Check

Open new command window and verify pip modules with
   `> pip list`
   Output should look like
   > fontname (0.2.0)  
   freetype-py (1.0.2)  
   PIL (1.1.7)  
   pip (8.1.2)  
   pywin32 (220)  
   qrcode (5.3)  
   requests (2.10.0)  
   setuptools (20.10.1)  
   six (1.10.0)  
   WMI (1.4.9)  

   If this command fails, then you probably forgot to check the **[Add python.exe to path]** parameter in Python installer.

### Configuration

1. register .plp files in Windows to be opened automatically with `C:\plevi\printsrv.exe`  
2. Salespoint ID must be unique and written to `C:\plevi\persistent.ini` file with syntax 'LT_/salespoint_name/'
  example: my_id = LT_kauno_maxima_01
3. please make sure, that the ticket printer name in `C:\plevi\persistent.ini` and `C:\plevi\setup_lt.ini` is the same, as in Windows (Devices and printers) and page size in printer settings is 'Letter'
4. make a test sale of ticket with successful transaction confirmation - then also the receipt is printed


### Special note

Please make sure, that wires are connected in same order over all installations.
Also make sure port mapping is identical everywhere.  

Even better
- create a document, where required wiring and port mapping is described and every time someone drives to point of sale to install the printers, give these instructions along.  
- label the wires. get a permanent marker or buy labeling machine
- take a photo of correctly connected wires at every POS

Thank us later.  
M-O-O-R


### Manual updating

To manually update existing drivers:  

1. Update version name in `C:\plevi\printsrv\update.plp`;
2. Execute `C:\plevi\printsrv\update.plp`.

