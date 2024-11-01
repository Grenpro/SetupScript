echo Clearing all but the most recent system restore point...
echo Clearing system restore points... >> "%LOGFILE%"
vssadmin delete shadows /for=c: /oldest
echo System restore points cleaned. >> "%LOGFILE%"