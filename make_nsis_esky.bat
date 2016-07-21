set /p Build=<version.py
echo %Build%

set VERSION=%Build:~11,-1%
echo %VERSION%

"c:\Program Files (x86)\NSIS\makensis.exe" /DVER=%VERSION% printsrv_esky.nsi