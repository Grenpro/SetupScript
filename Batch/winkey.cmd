@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
SET count=1
FOR /F "tokens=* USEBACKQ" %%F IN (`wmic path SoftwareLicensingService get OA3xOriginalProductKey`) DO (
  SET var!count!=%%F
  SET /a count=!count!+1
)
ECHO %var1%
ECHO %var2% | clip
ECHO %var3%

@echo off
cscript C:\windows\system32\slmgr.vbs /ipk %var2%

@echo off
cscript C:\windows\system32\slmgr.vbs /skms kms.xspace.in

@echo off
cscript C:\windows\system32\slmgr.vbs /ato 

ENDLOCAL


exit