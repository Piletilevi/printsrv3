; printsrv.nsi
;
; NSIS installer script to install carsrv printer
;!include WinMessages.nsh
!include FontName.nsh
!include FontReg.nsh
!include WinMessages.nsh
!include MUI2.nsh

;--------------------------------
Section ""
!searchparse /file version.py `VERSION = '` VER_TMP
!searchreplace VER1 ${VER_TMP} "'" ""

DetailPrint ${VER1}
SectionEnd

; The name of the installer
Name "printsrv installer"

; The file to write
OutFile "printsrv-app-${VER}.win32.exe"

; The default installation directory
InstallDir "C:\plevi"

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\printsrv" "Install_Dir"

; Request application privileges for Windows Vista
RequestExecutionLevel admin


;--------------------------------

; Pages

;Page directory
;Page instfiles
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES

;UninstPage uninstConfirm
;UninstPage instfiles
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
;--------------------------------

; The stuff to install
Section "" ;No components page, name is not important

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
;  File "install_files\setup.ini"
;  File "install_files\README.txt"
;  File "install_files\CHANGELOG.txt"
;  File "install_files\mfc71.dll"
;  File "install_files\code25I.ttf"
;  File "install_files\code39.ttf"
;  File "install_files\code128.ttf"
	SetOverwrite off
	File "install_files\persistent.ini"
	SetOverwrite on
	
	File "dist\*.*"

	#Simple unpack
	nsUnzip::Extract "printsrv-app-${VER}.win32.zip" /d=./ /END
	Pop $0
	
	Delete $INSTDIR\printsrv-app-${VER}.win32.zip
;	MessageBox MB_OK "Simple unpack.$\nResult: $0"
	
;  SetOutPath $INSTDIR\img
;  File "install_files\example.gif"
;  SetOutPath $INSTDIR\layouts
;  File "install_files\for_test.pla"
  
  SetOutPath $INSTDIR
  
  
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\printsrv "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\printsrv" "DisplayName" "printsrv"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\printsrv" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\printsrv" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\printsrv" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
  
;  System::Call "GDI32::AddFontResourceA(t) i ('$INSTDIR\code25I.ttf') .s"
;  Pop $0
;  System::Call "GDI32::AddFontResourceA(t) i ('$INSTDIR\code39.ttf') .s"
;  Pop $0
;  System::Call "GDI32::AddFontResourceA(t) i ('$INSTDIR\code128.ttf') .s"
;  Pop $0
  
  # $0 is zero if the function failed
;  SendMessage ${HWND_BROADCAST} ${WM_FONTCHANGE} 0 0

;  !insertmacro FontName "$INSTDIR\code25I.ttf"
;  !insertmacro FontNameVer
;  !insertmacro FontName "$INSTDIR\code39.ttf"
;  !insertmacro FontNameVer  
;  !insertmacro FontName "$INSTDIR\code128.ttf"
;  !insertmacro FontNameVer  
  
  StrCpy $FONT_DIR $FONTS
  !insertmacro InstallTTFFont "install_files\code25I.ttf"
  !insertmacro InstallTTFFont "install_files\code39.ttf"
  !insertmacro InstallTTFFont "install_files\code128.ttf"
  SendMessage ${HWND_BROADCAST} ${WM_FONTCHANGE} 0 0 /TIMEOUT=5000
  
SectionEnd ; end the section

;--------------------------------

; Uninstaller

Section "Uninstall"
  
;  !insertmacro RemoveTTFFont "$INSTDIR\code25I.ttf"
;  !insertmacro RemoveTTFFont "$INSTDIR\code39.ttf"
;  !insertmacro RemoveTTFFont "$INSTDIR\code128.ttf"  
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\printsrv"
  DeleteRegKey HKLM SOFTWARE\printsrv

  
  Delete "$INSTDIR\updates\downloads\*.*"
  RMDir "$INSTDIR\updates\downloads"
  Delete "$INSTDIR\updates\ready\*.*"
  RMDir "$INSTDIR\updates\ready"
  Delete "$INSTDIR\updates\unpack\*.*"
  RMDir "$INSTDIR\updates\unpack"
  RMDir "$INSTDIR\updates"
  
  Delete "$INSTDIR\appdata\updates\downloads\*.*"
  RMDir "$INSTDIR\appdata\updates\downloads"
  Delete "$INSTDIR\appdata\updates\ready\*.*"
  RMDir "$INSTDIR\appdata\updates\ready"
  Delete "$INSTDIR\appdata\updates\unpack\*.*"
  RMDir "$INSTDIR\appdata\updates\unpack"
  RMDir "$INSTDIR\appdata\updates"
  
  
  
  Delete "$INSTDIR\printsrv-app-${VER}.win32\*.*"
  Delete "$INSTDIR\printsrv-app-${VER}.win32\img\*.*"
  RMDir "$INSTDIR\printsrv-app-${VER}.win32\img"
  Delete "$INSTDIR\printsrv-app-${VER}.win32\layouts\*.*"
  RMDir "$INSTDIR\printsrv-app-${VER}.win32\layouts"
  Delete "$INSTDIR\printsrv-app-${VER}.win32\esky-files\*.*"
  RMDir "$INSTDIR\printsrv-app-${VER}.win32\esky-files"
  RMDir "$INSTDIR\printsrv-app-${VER}.win32"
  
  #Delete "$INSTDIR\appdata\printsrv-app-*.win32\*.*"
  #Delete "$INSTDIR\appdata\printsrv-app-*.win32\img\*.*"
  #RMDir "$INSTDIR\appdata\printsrv-app-*.win32\img"
  #Delete "$INSTDIR\appdata\printsrv-app-*.win32\layouts\*.*"
  #RMDir "$INSTDIR\appdata\printsrv-app-*.win32\layouts"
  #Delete "$INSTDIR\appdata\printsrv-app-*.win32\esky-files\*.*"
  #RMDir "$INSTDIR\appdata\printsrv-app-*.win32\esky-files"
  #RMDir "$INSTDIR\appdata\printsrv-app-*.win32"
  
  RMDir /r "$INSTDIR\appdata"
  
  Delete "$INSTDIR\python*.dll"
  Delete "$INSTDIR\printsrv.exe"
  Delete "$INSTDIR\uninstall.exe"
  
  ; Remove files and uninstaller
  ;Delete $INSTDIR\*.*

  ; Remove directories used
  RMDir "$INSTDIR"

SectionEnd