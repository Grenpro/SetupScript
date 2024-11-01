@echo off
echo Installing Google Chrome and Mozilla Firefox...

winget install --id Google.Chrome -e --silent
winget install --id Mozilla.Firefox -e --silent

echo Installation complete.
exit
