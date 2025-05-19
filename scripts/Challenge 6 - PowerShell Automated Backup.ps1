<#
Write a script that:
1. Asks the user for a source folder
2. Asks the backup destination folder. 
3. Creates a timestamped backup copy of the source folder. 
4. Preserves subfolders and files inside.

#>

# Step 1 - Ask the user for source folder
do { $sourceFolder = Read-Host "Enter the folder to back up"
   if (!(Test-Path -Path $sourceFolder)) {
    Write-Output "Error! Please enter a valid source folder path"
   }

} until (Test-Path -Path $sourceFolder)

# Step 2 - Ask for the backup folder
do { $backupFolder = Read-Host "Enter the backup destination Folder"
    if (!(Test-Path -Path $backupFolder)) {
        Write-Output "Error! Please enter a valid backup folder"
    }

} until (Test-Path -Path $backupFolder)

# Step 3 - Create Backup Folder

$timestamp = Get-Date -Format "ddMMyyyy_HHmm"
$backupPath = "$backupFolder\Backup_$timestamp"

# Test if backup exists

if (!(Test-Path -Path $backupPath)) {
    New-Item -ItemType Directory -Path $backupPath
}

#Copy items to backup 

Copy-Item -Path $sourceFolder -Destination $backupPath -Recurse
Write-Output "Backup completed! Files copied to: $backupPath"