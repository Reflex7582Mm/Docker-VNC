@echo off

cd C:\OEM

powershell -Command "& ([ScriptBlock]::Create((irm https://get.activated.win))) /hwid"

curl.exe -O https://ninite.com/chrome/ninite.exe
ninite.exe
