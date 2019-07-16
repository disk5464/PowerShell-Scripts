#This script will download a given database backup file
#This is the extended version
#A big part of this was taken from here https://blog.jourdant.me/post/3-ways-to-download-files-with-powershell
#Last modified 7/15/19
########################################
#In order to avoid a SSL/TSL error you need to use TLSv1.2
#See: https://virtualbrakeman.wordpress.com/2016/03/20/powershell-could-not-create-ssltls-secure-channel/
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;
########################################
#This sets up a function for the menu
function Show-Menu
{
    param (
        [string]$Title = 'Database Downloader v2.0'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' for the world importers Database."
    Write-Host "2: Press '2' for the Adventure works 2017 Database."
    Write-Host "3: Press '3' for the Adventure works 2016 Database."
    Write-Host "3: Press '4' for the Adventure works 2012 Database."
    Write-Host "3: Press '5' to enter your own Database."
    Write-Host "Q: Press 'Q' to quit."
}
########################################
#You could use the github cmdlet but doing it this way will lety you easily subtitute the built in uirl for a different one
$url = ""
Show-Menu -Title 'Database Downloader v2.0'
$selection = Read-host "What database do you want to download?"
 switch ($selection)
 {
    '1' {
    'You chose the world importers Database'
    $url = ""
    Write-Host "================================="
    } 
    '2' {
    'You chose the Adventure works 2017 Database'
    $url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2017.bak"
    Write-Host "================================="
    } 
    '3' {
    'You chose the Adventure works 2016 Database'
    $url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2016.bak"
    Write-Host "================================="
    } 
    '4'{
    'You chose the Adventure works 2012 Database'
    $url = "https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2012.bak"
    Write-Host "================================="
    }
    '5'{
    'You chose to enter your own database'
    $url = Read-Host -Prompt "Enter the full url to the database you want to download."
    Write-Host "================================="
    }
    'q' {
    return
    }
 }
########################################
#Next request the path to which the database will be saved and put it into a variable.
$Path = ""
$Path = Read-host -Prompt "Where do you want to save the database? (Do not include \ at the end)"

#This checks for a path and if there is none, adds in C:\Temp as a default
    if ($Path -eq "")
    {
        $Path = "C:\Temp"
    }
########################################
#This checks for a specified file name and if there is non, it adds one. It also adds on the .bak extension
$FileName = Read-Host "What do you want to name this database file? (Do not include .bak at the end)"
    if ($FileName -eq "")
    {
        $FileName = "\NewDatabase.bak"
    }
    else
    {
        $FileName = "\" + $FileName + ".bak"
    }
########################################
#This part puts the variable together with the database name.
$output = $Path + $FileName
########################################
#Create a new webClient object that will go out and get the database and save it to the specified file path with the specified file name
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
########################################
#Finally this will open File Explorer to where the database was downloaded to
Start -FilePath $Path
########################################
Write-Host "Download Complete"

