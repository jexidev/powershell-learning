<#
Write a script that:
1. Asks the user for a folder path.
2. Lists all the files in a folder.
3. Sorts files into subfolders based on their file type. 
#>

do  {
    # Ask for folder path
    $sortFolder = Read-Host "Enter the folder you need to sort ?"
    
    # Check if folder exists and handle input error
    if (!(Test-Path -Path $sortFolder)) {
        Write-Output "Error: The folder '$sortFolder' does not exist. Please Enter a valid path."

    }
    
} until (Test-Path -Path $sortFolder) # Loops until a valid folder input

# Retrieve items from a given folder and display only given parameters
Get-ChildItem -Path $sortFolder -File | ForEach-Object {Write-Output "$($_.Name) - $($_.Extension)"}

# Ask user if they want files organising per extension
$userChoice = Read-Host "Do you want to sort these items based on their extension? (Yes/No)"

# Handle user choice to accept lowercase, upper, or variation
if ($userChoice.ToLower() -eq "yes") {
    # Get files within the folder and cycle through each item
    Get-ChildItem -Path $sortFolder -File | ForEach-Object {
        $extension = $_.Extension # Give definition to extension
        $folderName = $extension -replace "\.", "" # Remove the . from .extension
        $destinationFolder = "$sortFolder\$folderName" # Tells pwsh what the destination folder will be

        if (!(Test-Path -Path $destinationFolder)) { # Check to see if the folder exists already
            New-Item -ItemType Directory -Path $destinationFolder # Create the folder if it doesn't
        }

        # Move the file
        Move-Item -Path $_.FullName -Destination $destinationFolder
        Write-Output "Moved $($_.Name) to $destinationFolder" # Write output for each file moved
    }
}
