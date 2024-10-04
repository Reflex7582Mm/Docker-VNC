@echo off

cd C:\OEM

REM activate windows :)
powershell -Command "& ([ScriptBlock]::Create((irm https://get.activated.win))) /hwid"

REM this sets the color theme to dark. works on windows 10 & windows 11
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d "0" /f
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d "0" /f

REM sets the windows 11 dark theme, i used this cmd workaround
REM because if you're on windows 10, the theme won't exist
REM and it will just show an error prompt which is interactive
REM which also blocks the next command from running
start cmd /c start "" "C:\Windows\Resources\Themes\dark.theme"

REM set DPI to 175% for grandma mode
reg add "HKCU\Control Panel\Desktop" /v LogPixels /t REG_DWORD /d 144 /f
reg add "HKCU\Control Panel\Desktop" /v Win8DpiScaling /t REG_DWORD /d 1 /f

REM install OpenSSH Server (this takes quite a few minutes)
powershell.exe -Command "Add-WindowsCapability -Online -Name OpenSSH.Server"
powershell.exe -Command "Start-Service sshd"
powershell.exe -Command "Set-Service -Name sshd -StartupType 'Automatic'"

REM chocolatey and install some cool stuff
powershell.exe -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

REM --- Did you know? VVVV  this line below took me a few days to
REM     realize there's actually a script to do this
call C:\ProgramData\chocolatey\redirects\RefreshEnv.cmd
REM ---               ^^^^

choco feature enable -n allowGlobalConfirmation
choco feature disable -n checksumFiles
choco install nano mpv yt-dlp ffmpeg googlechrome chrome-remote-desktop-host opennbs powershell-core warp

ping -n 3 127.0.0.1

shutdown /r /t 0
