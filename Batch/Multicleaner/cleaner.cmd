echo System file check complete.

echo Running disk cleanup, please wait...
echo Running Disk Cleanup... >> "%LOGFILE%"

rem Run Disk Cleanup silently
cleanmgr.exe /sagerun:1
echo Disk cleanup completed. >> "%LOGFILE%"

echo Disk cleanup complete.