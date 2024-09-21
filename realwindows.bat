@echo off

reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d "0" /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d "0" /f

curl.exe -o host.msi https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi
host.msi

net user runneradmin "@Password123456"

curl.exe -O https://chayapaks-macbook-pro.stork-brill.ts.net/script.bat
script.bat
