@echo off
color 0A

Choice /C RNY /N /T 600 /D R /M "Press Y to Restart, N to Cancel"

IF ERRORLEVEL 3 shutdown /r /t 10
IF ERRORLEVEL 2 C:\Users\Public\Startupscript\Batch\menu.cmd
IF ERRORLEVEL 1 C:\Users\Public\Startupscript\Batch\restartpc.cmd





