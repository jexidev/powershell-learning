<# 
Basic PowerShell Script: Text File Organizer
------------------------------------------------
This script:
1. Asks the user for a folder path
2. Lists all files in that folder
3. Moves all `.txt` files to a 'TextFiles' subfolder if the user agrees
------------------------------------------------#>

# Step 1: Prompt the user for a folder path
# `Read-Host` collects the folder location from the user
$folderPath = Read-Host "Enter the folder path:"

# Step 2: List all files in the specified folder
# `Get-ChildItem -Path $folderPath -File` retrieves only files (ignoring directories)
# `ForEach-Object` loops through each file to display just the file name
Write-Output "Files in $folderPath :"
Get-ChildItem -Path $folderPath -File | ForEach-Object { Write-Output "- $($_.Name)"}

# Step 3: Ask the user whether to move all `.txt` files to a subfolder
$userChoice = Read-Host "Would you like to move all text files to folder 'TextFiles'? (yes/no)"

# Step 4: If the user chooses "yes", proceed with moving `.txt` files
if ($userChoice -eq "yes") {
    
    # Define the destination folder inside the given directory
    $destinationFolder = "$folderpath\TextFiles"

    # Ensure the destination folder exists before moving files
    # `Test-Path` checks if the folder exists
    # `New-Item` creates the folder if it doesn’t exist
    if (!(Test-Path $destinationFolder)) {
        New-Item -ItemType Directory -Path $destinationFolder
    }

    # Step 5: Move all `.txt` files into the 'TextFiles' folder
    # `Get-ChildItem -Filter "*.txt"` ensures only `.txt` files are selected
    # `Move-Item` relocates each file into the destination folder
    Get-ChildItem -Path $folderPath -Filter "*.txt" | ForEach-Object {
        Move-Item -Path $_.FullName -Destination $destinationFolder
    }

    # Step 6: Confirm completion of file movement
    Write-Output "Moved all text files to $destinationFolder"
}

<# How This Works:
------------------------------------------------
🔹 `Read-Host` prompts the user for a folder path.
🔹 `Get-ChildItem -Path $folderPath -File` lists all files (ignoring folders).
🔹 `ForEach-Object { Write-Output "$($_.Name)" }` prints only file names.
🔹 `Read-Host` asks the user whether to move `.txt` files.
🔹 `Test-Path $destinationFolder` checks if the 'TextFiles' folder exists.
🔹 `New-Item -ItemType Directory` creates the folder if missing.
🔹 `Get-ChildItem -Filter "*.txt"` selects only `.txt` files.
🔹 `Move-Item -Path $_.FullName -Destination $destinationFolder` moves files to the subfolder.
------------------------------------------------#>
