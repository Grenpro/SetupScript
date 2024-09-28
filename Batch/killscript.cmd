@echo off
call start delete.cmd

@echo off
timeout /T 10

taskkill /im cmd.exe

exit

