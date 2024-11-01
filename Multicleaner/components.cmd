echo Removing unused Windows components...
echo Removing unused Windows components... >> "%LOGFILE%"
dism.exe /online /disable-feature /featurename:Printing-Foundation-InternetPrinting-Client /norestart
echo Unused components removed. >> "%LOGFILE%"