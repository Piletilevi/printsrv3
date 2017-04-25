python -m pip install --upgrade pip
pip install fontname
pip install jsonschema
pip install qrcode
pip install wmi
pip install requests
pip install xmltodict
pip install pyyaml

@echo off

fonts\code128.ttf
fonts\datamatrix.ttf
fonts\ean13.ttf
fonts\pdf417.ttf


Call :YesNoBox "Copy persistent.ini?"
if "%YesNo%"=="6" (
copy /y persistent.ini ..
)

REM Call :YesNoBox "Scooby happy?"

del install.bat
exit /b


:YesNoBox
REM returns 6 = Yes, 7 = No. Type=4 = Yes/No
set YesNo=
set MsgType=4
set heading=%~2
set message=%~1
echo wscript.echo msgbox(WScript.Arguments(0),%MsgType%,WScript.Arguments(1)) >"%temp%\input.vbs"
for /f "tokens=* delims=" %%a in ('cscript //nologo "%temp%\input.vbs" "%message%" "%heading%"') do set YesNo=%%a
