@echo off

cd C:\OEM

powershell -Command "& ([ScriptBlock]::Create((irm https://get.activated.win))) /hwid"

reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d "0" /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d "0" /f

curl.exe -O https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi
chromeremotedesktophost.msi

curl.exe -O https://ninite.com/chrome/ninite.exe
ninite.exe
