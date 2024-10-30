@echo off
color 0A

echo Please wait...

timeout /T 120

powershell -executionpolicy remotesigned shortcuts2.ps1

exit





