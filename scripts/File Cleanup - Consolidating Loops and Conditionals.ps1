$maxDays = 30

$folder = Read-Host "Enter a folder to be cleaned"

if (!(Test-Path $folder)) {
    Write-Host "Error! Folder not found. Please enter correct path"
}
elseif ((Get-ChildItem -Path $folder).Count -eq 0) {
    Write-Host "Folder is empty, Please enter another path"
}
else {
    Write-Host "Scanning files in $folder..."

    # Loop through each file
    foreach ($file in Get-ChildItem -Path $folder) {
        $fileAge = (Get-Date) - $file.LastWriteTime

        # Delete files older than 30 days
        while ($fileAge.Days -gt $maxDays) {
            Write-Host "Deleting old file: $($file.Name)"
            Remove-Item $file -Force
            break
        }
    }
}


  
    