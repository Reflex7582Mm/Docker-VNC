@echo off

cd C:\OEM

powershell -Command "& ([ScriptBlock]::Create((irm https://get.activated.win))) /hwid"

reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d "0" /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d "0" /f

explorer ms-settings:display
ping -n 2 127.0.0.1 > nul

SET TempVBSFile=%tmp%\~tmpSendKeysTemp.vbs
IF EXIST "%TempVBSFile%" DEL /F /Q "%TempVBSFile%"
ECHO Set WshShell = WScript.CreateObject("WScript.Shell") >>"%TempVBSFile%"
ECHO Wscript.Sleep 500                                    >>"%TempVBSFile%"
ECHO WshShell.SendKeys "{TAB 2}{DOWN 2}"                  >>"%TempVBSFile%"
ECHO Wscript.Sleep 500                                    >>"%TempVBSFile%"
ECHO WshShell.SendKeys "%%{F4}"                           >>"%TempVBSFile%"

cscript //nologo "%TempVBSFile%"

curl.exe -O https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi
chromeremotedesktophost.msi

curl.exe -O https://ninite.com/chrome/ninite.exe
ninite.exe

logoff
