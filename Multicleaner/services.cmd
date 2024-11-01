echo Resetting Windows update components, please wait...
echo Resetting Windows Update components... >> "%LOGFILE%"

rem Reset Windows Update components
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
ren C:\Windows\System32\catroot2 catroot2.old
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
echo Windows update component reset complete. >> "%LOGFILE%"