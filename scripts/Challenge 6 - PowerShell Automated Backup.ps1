<#
Write a script that:
1. Asks the user for a source folder
2. Asks the backup destination folder. 
3. Creates a timestamped backup copy of the source folder. 
4. Preserves subfolders and files inside.

# Addition: Confirm with user before backup and press any key to exit
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

# Ask User for Confirmation. 
$userConfirmation = Read-Host "Please confirm you would like to backup '$sourceFolder' to '$backupFolder' (Yes/No)"

# Set name for backup folder.
$timestamp = Get-Date -Format "ddMMyyyy_HHmm"
$backupPath = "$backupFolder\Backup_$timestamp"

if ($userConfirmation.ToLower() -eq "yes") {
    # Test if backup exists
   if (!(Test-Path -Path $backupPath)) {
    New-Item -ItemType Directory -Path $backupPath | Out-Null

   }

    # Copy items to backup 
    Copy-Item -Path $sourceFolder -Destination $backupPath -Recurse -Force
    Write-Output "Backup completed! Files copied to: $backupPath"

}

# Press any key to exit
else { Write-Host "Backup Cancelled: Press any key to exit"
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKey")    
    
}
