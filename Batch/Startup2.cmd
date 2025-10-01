@echo off
color 1F

@echo off
echo Please Wait...

:repeat
timeout 3 > nul
ping www.microsoft.com || goto :repeat

echo Connection Successful... Please Wait...

@echo off
timeout 3 > nul

echo Starting Windows Update Service...

cd "C:\TempSetup"

timeout /T 3

call start powershell -executionpolicy remotesigned ..\Winupd\PS_WinUpdate.ps1

call start "C:\TempSetup\SetupScript-main\Batch\Menu.cmd" 

call start powershell -executionpolicy remotesigned "C:\TempSetup\SetupScript-main\Batch\chromedefault.ps1


exit

