<#
Write a script that:
1. Asks the user for a folder path
2. Checks if the folder exists and handles input errors. 
3. Lists all subfolders. 
4. Asks if they want to delete empty folders.
#>

do { 
    $userFolder = Read-Host "Enter a valid folder path for cleaning" # Ask user for folder
    if (!(Test-Path -Path $userFolder)) {
        Write-Output "Error! The folder does not exist. Please enter a valid path." # Check if folder exists
  
    } 

} until (Test-Path -Path $userFolder) # Loops until valid folder

Write-Host "Files:" -BackgroundColor white -ForegroundColor blue
Get-ChildItem -Path $userFolder -File | ForEach-Object { "$($_.Name) - $($_.Extension)"}
Write-Host "Subfolders:" -BackgroundColor white -ForegroundColor blue
Get-ChildItem -Path $userFolder -Directory | ForEach-Object {"$($_.Name)"}

$userChoice = Read-Host "Would you like to delete any empty subfolders? (Yes/No)"

if ($userChoice.ToLower() -eq "yes") {
    Get-ChildItem -Path $userFolder -Directory | ForEach-Object {
        if ((Get-ChildItem -Path $_.FullName | Measure-Object).Count -eq 0) {
            Remove-Item -Path $_.FullName -Force
            Write-Output "Deleted empty folder: $($_.Name)"
        }
    }
    
}