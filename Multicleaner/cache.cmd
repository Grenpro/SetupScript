echo Clearing Windows Update cache...
echo Clearing Windows Update cache... >> "%LOGFILE%"
net stop wuauserv
rd /s /q "C:\Windows\SoftwareDistribution\Download"
net start wuauserv
echo Windows Update cache cleared. >> "%LOGFILE%"