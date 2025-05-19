<#
Write a script that:
1. Asks the user for a folder path.
2. Checks if the folder exists and handles input errors.
3. Lists all subfolders and files.
4. Asks if they want to delete empty subfolders.
5. Identifies empty subfolders and removes them if the user confirms.
#>

# Step 1: Request a valid folder path from the user
do { 
    $userFolder = Read-Host "Enter a valid folder path for cleaning" # Ask user for folder
    if (!(Test-Path -Path $userFolder)) {
        Write-Output "Error! The folder does not exist. Please enter a valid path." # Check if folder exists
    } 

} until (Test-Path -Path $userFolder) # Loops until valid folder input is given

# Step 2: Display all files within the chosen directory
Write-Host "Files:" -BackgroundColor White -ForegroundColor Blue
Get-ChildItem -Path $userFolder -File | ForEach-Object { Write-Host "$($_.Name) - $($_.Extension)" }

# Step 3: Display all subfolders within the chosen directory
Write-Host "Subfolders:" -BackgroundColor White -ForegroundColor Blue
Get-ChildItem -Path $userFolder -Directory | ForEach-Object { Write-Host "$($_.Name)" }

# Step 4: Ask if the user wants to delete empty subfolders
$userChoice = Read-Host "Would you like to delete any empty subfolders? (Yes/No)"

# Step 5: Identify and remove empty subfolders
if ($userChoice.ToLower() -eq "yes") {
    Get-ChildItem -Path $userFolder -Directory | ForEach-Object {
        if ((Get-ChildItem -Path $_.FullName | Measure-Object).Count -eq 0) { # Check if folder is empty
            Remove-Item -Path $_.FullName -Force # Remove empty subfolder
            Write-Output "Deleted empty folder: $($_.Name)" # Output confirmation message
        }
    }
}