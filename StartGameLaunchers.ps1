#This script when ran will launch the following game launchers: Steam, Epic Games Launcher, Battle.net, and EA Launcher
#Version 1.1
##########################################
#This starts all three of the launchers
if((Test-Path "C:\Program Files (x86)\Steam\steam.exe") -eq $true )
{
    Start-Process -FilePath "C:\Program Files (x86)\Steam\steam.exe"
}
else
{
    Write-host "Steam dosen't appear to be installed" -ForegroundColor Yellow
}


if((Test-Path "C:\Program Files (x86)\Battle.net\Battle.net.exe") -eq $true )
{
    Start-Process -FilePath "C:\Program Files (x86)\Battle.net\Battle.net.exe"
}
else
{
    Write-host "Battle.net dosen't appear to be installed" -ForegroundColor Yellow
}


if((Test-Path "C:\Program Files\Electronic Arts\EA Desktop\EA Desktop\EALauncher.exe") -eq $true )
{
    Start-Process -FilePath "C:\Program Files\Electronic Arts\EA Desktop\EA Desktop\EALauncher.exe"
}
else
{
    Write-host "EA launcher dosen't appear to be installed" -ForegroundColor Yellow
}
##########################################