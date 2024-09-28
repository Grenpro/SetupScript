@echo off

taskkill /im elkjop.exe

timeout /T 5

@RD /s /q C:\Program Files\Elkjøp Cloud

exit

