net stop wuauserv
rd /s /q "C:\Windows\SoftwareDistribution\Download"
net start wuauserv
exit
