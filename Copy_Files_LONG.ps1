#This script goes to a folder and copys it's contents an then pastes it to another directory
#It will copu the files and past it directly into the destination folder, not a new folder within the destination folder.
#Finally there is a copy of this script that will do this p[rocess automatically
#Last modified 7/15/19
#######################
#This gets the source directory adn checks for a path. It also allows the user to quit

Write-Host "================== Copy folder contents v1.3 =================="
$sourceDirecrtory = ""
$sourceDirecrtory = Read-Host "Welcome to the copy program. Which folder do you want to copy? (Do not include a \ at the end of the file path)"

if($sourceDirecrtory -eq "q")
{
    return
}
While($sourceDirecrtory -eq "")
{
    Write-Host "==========================================="
    $sourceDirecrtory = Read-Host "No file path detected. Try again (Or press q to quit)"

    if ($sourceDirecrtory -eq "q")
    {
        return
    }
}
$sourceDirecrtory = $sourceDirecrtory + "\*"
#######################
#RThis gets the destination and checkls for a path. It also allows the user to quit
$DestinationDirectory = Read-Host -Prompt "Where do you want to save the contents to?"


if($DestinationDirectory -eq "q")
{
    return
}
While($DestinationDirectory -eq "")
{
    Write-Host "==========================================="
    $DestinationDirectory = Read-Host "No file path detected. Try again (Or press q to quit)"

    if ($DestinationDirectory -eq "q")
    {
        return
    }
}
#######################
#This part does the actual copy
Write-Host "==========================================="

try
    {
        Write-Host "Depending on the size of the folder this may take a while..."
        Copy-Item $sourceDirecrtory -Destination $DestinationDirectory -Recurse -Force -ErrorAction Stop

    }

catch [System.management.Automation.ItemNotFoundException]
    {
        Write-Host "COULD NOT FIND ONE OF THE FILE PATHS> CHECK YOUR SPELLING AND TRY AGAIN" -ForegroundColor Red -BackgroundColor Black
        return 
    }
#######################
#This opens the file directory
Start -FilePath $DestinationDirectory
Write-Host "Copy Complete"



