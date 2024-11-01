@echo off
echo Installing Google Chrome and Mozilla Firefox...

winget install --id Google.Chrome -e --silent --accept-package-agreements --accept-source-agreements
winget install --id Mozilla.Firefox -e --silent --accept-package-agreements --accept-source-agreements

echo Installation complete.
exit
