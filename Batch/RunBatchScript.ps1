# Temporarily set execution policy for this process only.
# This avoids permanently changing machine settings and doesn't require admin rights.
try {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force -ErrorAction Stop
} catch {
    Write-Warning "Failed to set execution policy. If the script fails, run it from a terminal using:"
    Write-Warning "powershell.exe -ExecutionPolicy Bypass -File .\interactive-setup.ps1"
}

# --- Script Setup ---

# Define repository URL and local paths
$repoUrl = "https://github.com/Grenpro/SetupScript/archive/refs/heads/main.zip"
$tempFolder = Join-Path $env:TEMP "SetupScript" # Use Join-Path for robustness
$zipPath = Join-Path $tempFolder "SetupScript.zip"

# This special variable gets the full path of the current script, so we can delete it later
$thisScriptPath = $PSCommandPath 

# --- Main Logic ---
try {
    # Ensure a clean temp folder exists
    if (Test-Path -Path $tempFolder) {
        Remove-Item -Recurse -Force $tempFolder
    }
    New-Item -ItemType Directory -Path $tempFolder | Out-Null

    # Download the ZIP file
    Write-Host "Downloading setup files..." -ForegroundColor Green
    Invoke-WebRequest -Uri $repoUrl -OutFile $zipPath

    # Extract the ZIP
    Write-Host "Extracting files..." -ForegroundColor Green
    Expand-Archive -Path $zipPath -DestinationPath $tempFolder -Force

    # Define the path to the batch script
    $menuScript = Join-Path $tempFolder "SetupScript-main\Batch\Menu.cmd"
    if (!(Test-Path $menuScript)) {
        throw "ERROR: Menu.cmd was not found after extraction. Aborting."
    }

    # --- Run the Interactive Menu ---
    Write-Host "Starting the menu. This script will wait for you to close the menu window." -ForegroundColor Yellow
    Write-Host "When you are finished with the menu, simply close its window to continue." -ForegroundColor Yellow
    
    # Start the process and -Wait for it to close completely.
    Start-Process -FilePath $menuScript -Wait

    # --- The script will only continue from here AFTER Menu.cmd has been closed ---
    
    Write-Host "`nMenu has been closed." -ForegroundColor Green
    
    # Prompt the user for cleanup action
    $choice = Read-Host "Do you want to clean up all downloaded files and this script? (Y/N)"

    if ($choice -eq 'y') {
        # --- Cleanup and Self-Destruction ---
        Write-Host "Cleaning up downloaded files..."
        Remove-Item -Recurse -Force $tempFolder

        Write-Host "Staging self-destruction of this script. Goodbye!"
        
        # This starts a new, hidden command prompt.
        # It waits 3 seconds (ping), then deletes this script file.
        # By that time, this PowerShell process will have closed.
        $command = "ping 127.0.0.1 -n 4 > nul & del `"$thisScriptPath`""
        Start-Process cmd.exe -ArgumentList "/c $command" -WindowStyle Hidden
    
    } else {
        Write-Host "Cleanup skipped. The files are located in:" -ForegroundColor Yellow
        Write-Host "$tempFolder" -ForegroundColor Cyan
        Write-Host "You can delete that folder and this script manually when you are done." -ForegroundColor Yellow
    }

} catch {
    # If any part of the script fails, write the error and stop.
    Write-Error "An error occurred: $_"
    # Even on error, we can offer to clean up the partial mess
    if (Test-Path -Path $tempFolder) {
        Write-Warning "Attempting to clean up temporary folder due to error..."
        Remove-Item -Recurse -Force $tempFolder
    }
    Read-Host "Press Enter to exit."
}
