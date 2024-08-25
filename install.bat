@echo off

powershell -Command "& ([ScriptBlock]::Create((irm https://get.activated.win))) /hwid"
