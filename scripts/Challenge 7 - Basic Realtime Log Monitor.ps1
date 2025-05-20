# Set logfile to monitor and confirm file is being monitored

do { $logfile = Read-Host "Please enter the path of your logfile"
    if (!(Test-Path $logfile) -or (Test-Path $logfile -PathType Container)) {
    Write-Output "Please enter a valid file path"
    } 
} until (Test-Path $logfile -PathType Leaf)

# Continuous log monitoring with additional formatting
Get-Content -Path $logFile -Wait | ForEach-Object {
    $entry = $_
    $timestamp = Get-Date -Format "HH:mm:ss"

    if ($entry -match "

\[ERROR\]

") {
        Write-Host "$timestamp $entry" -ForegroundColor Red
    }
    elseif ($entry -match "

\[WARNING\]

") {
        Write-Host "$timestamp $entry" -ForegroundColor Yellow
    }
    elseif ($entry -match "

\[INFO\]

") {
        Write-Host "$timestamp $entry" -ForegroundColor Green
    }
    else {
        Write-Host "$timestamp $entry"
    }
}
