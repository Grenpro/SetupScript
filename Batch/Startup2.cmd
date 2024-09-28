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

timeout /T 3

call start powershell -executionpolicy remotesigned C:\Users\Public\Startupscript\Winupd\PS_WinUpdate.ps1

call start C:\Users\Public\Startupscript\Batch\Retimer.cmd 


exit