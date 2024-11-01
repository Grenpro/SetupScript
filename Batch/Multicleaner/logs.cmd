echo Clearing event logs...
echo Clearing event logs... >> "%LOGFILE%"
for /F "tokens=*" %%G in ('wevtutil el') DO (
    wevtutil cl "%%G"
)
echo Event logs cleared. >> "%LOGFILE%"