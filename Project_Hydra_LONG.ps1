#Welcome to project hydra. This script aims to bind all the SQL scripts together and make oine easy to use script
#Last modified 7/19/19
########################################
#This sets up a function for the menu
function Show-Menu
{
    param (
        [string]$Title = 'SQL Script Main Menu'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' to download a database."
    Write-Host "2: Press '2' to restore a database from a .bak."
    Write-Host "3: Press '3' to copy files from one folder to another."
    Write-Host "3: Press '4' to retire a database."
    Write-Host "3: Press '5' to enter your own Database."
    Write-Host "Q: Press 'Q' to quit."
    Write-Host ""
    Write-Host "Please ensure powershell is in the same directory as all of the necessary scripts"
}
########################################
#This part will present the user with the options and allwow them to select theiur choice
Show-Menu -Title 'Welcome to the main menu'
$selection = Read-Host "What would you like to do today?"
Write-Host "=========================================================="
Write-Host "=========================================================="
switch ($selection)
{
    '1'
    {
        #This part gets the scrupt that will be used along with the current directory and checks to make sure it is in the same location
        $currentlocation = Get-location
        $TestFile = "\DownloadDatabaseLONG.ps1"
        $FinalTestLocation = $currentlocation.ToString() + $TestFile
        $TestResults = Test-Path $FinalTestLocation

        if($TestResults -eq $true)
        {
            Invoke-Expression -Command $FinalTestLocation
        }

        if($TestResults -eq $false)
        {
            Write-host "The required file could not be found. Make sure that powershell is in the right directory and try again"
        }
    }

    '2'
    {
        #This part gets the scrupt that will be used along with the current directory and checks to make sure it is in the same location
        $currentlocation = Get-location
        $TestFile = "\Install_Database_with_Script_LONG.ps1"
        $FinalTestLocation = $currentlocation.ToString() + $TestFile
        $TestResults = Test-Path $FinalTestLocation

        if($TestResults -eq $true)
        {
            Invoke-Expression -Command $FinalTestLocation
        }

        if($TestResults -eq $false)
        {
            Write-host "The required file could not be found. Make sure that powershell is in the right directory and try again"
        }
    }
    
    '3'
    {
        #This part gets the scrupt that will be used along with the current directory and checks to make sure it is in the same location
        $currentlocation = Get-location
        $TestFile = "\Copy_Files_LONG.ps1"
        $FinalTestLocation = $currentlocation.ToString() + $TestFile
        $TestResults = Test-Path $FinalTestLocation

        if($TestResults -eq $true)
        {
            Invoke-Expression -Command $FinalTestLocation
        }

        if($TestResults -eq $false)
        {
            Write-host "The required file could not be found. Make sure that powershell is in the right directory and try again"
        }
    }

   '4'
    {
        #This part gets the scrupt that will be used along with the current directory and checks to make sure it is in the same location
        $currentlocation = Get-location
        $TestFile = "\Retire_Database_LONG.ps1"
        $FinalTestLocation = $currentlocation.ToString() + $TestFile
        $TestResults = Test-Path $FinalTestLocation

        if($TestResults -eq $true)
        {
            Invoke-Expression -Command $FinalTestLocation
        }

        if($TestResults -eq $false)
        {
            Write-host "The required file could not be found. Make sure that powershell is in the right directory and try again"
        }
    }

    'q'
    {
        return
    }











}





