@echo off

cd C:\OEM

powershell -Command "& ([ScriptBlock]::Create((irm https://get.activated.win))) /hwid"

REM this sets the color to dark. works on windows 10 & windows 11
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d "0" /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d "0" /f

REM sets the windows 11 dark theme
start "" "C:\Windows\Resources\Themes\dark.theme"

reg add "HKCU\Control Panel\Desktop" /v LogPixels /t REG_DWORD /d 144 /f
reg add "HKCU\Control Panel\Desktop" /v Win8DpiScaling /t REG_DWORD /d 1 /f

curl.exe -O https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi
chromeremotedesktophost.msi

curl.exe -O https://ninite.com/chrome/ninite.exe

curl.exe -O https://raw.githubusercontent.com/cramaboule/Silent-Ninite/main/ninite-silent.exe
ninite-silent.exe

:checkloop

tasklist | findstr /i ninite.exe
if errorlevel 0 (shutdown /r /t 0) else (ping -n 1 127.0.0.1 > nul)

goto checkloop
