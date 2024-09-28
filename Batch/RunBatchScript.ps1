$url = "https://raw.githubusercontent.com/Grenpro/SetupScript/refs/heads/main/Batch/Menu.cmd" # Your Batch script URL
$batFile = "$env:temp\MyBatchScript.bat"

irm $url -OutFile $batFile
Start-Process $batFile
